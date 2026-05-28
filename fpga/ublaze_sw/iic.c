/*
 * iic.c
 *
 *  Created on: May 22, 2023
 *      Author: Mladen
 */

#include "xparameters.h"
#include "xiic.h"
//#include "xiic_i.h"
#include "define.h"
#include "iic.h"
#include "sleep.h"

// source code is taken from: xiic_repeated_start_example.c and xiic_eeprom_example.c
// https://github.com/Xilinx/embeddedsw/blob/master/XilinxProcessorIPLib/drivers/iic/examples/xiic_repeated_start_example.c
//

XIic Iic;		/* Instance of the Xlic Device */

static void SendHandler(XIic *InstancePtr);
static void ReceiveHandler(XIic *InstancePtr);
static void StatusHandler(XIic *InstancePtr, int Event);
static void PrepareBusInTransmitMode();
static void SendAddressInTransmitMode();
static void PrepareBusInReceiveMode();
static void SendAddressInReceiveMode();
static void SendData (u8 * buffer_to_send, int byte_to_send);
static void SendDataRepeatedStart (u8 * buffer_to_send, int byte_to_send);
static int SendSuccesfullyCompleted(u32 wait_time);

volatile u8 TransmitCompleted;	/* Flag to check completion of Transmission */
volatile u8 ReceiveComplete;	/* Flag to check completion of Reception */
volatile u8 BusNotBusy;

int Iic_Init(u16 DeviceId)
{
	int Status;
	static int Initialized = FALSE;
	XIic_Config *ConfigPtr;	/* Pointer to configuration data */

	if (!Initialized)
	{
		Initialized = TRUE;

		/*
		 * Initialize the IIC driver so that it is ready to use.
		 */
		ConfigPtr = XIic_LookupConfig(DeviceId);
		if (ConfigPtr == NULL) {
			return XST_FAILURE;
		}

		Status = XIic_CfgInitialize(&Iic, ConfigPtr,
						ConfigPtr->BaseAddress);
		if (Status != XST_SUCCESS) {
			return XST_FAILURE;
		}

		//Interrupt System is initialized elsewhere

	}

	return XST_SUCCESS;
}

void Iic_SetAddress(int Address)
{
	XIic_SetAddress(&Iic, XII_ADDR_TO_SEND_TYPE, Address);
}

void Iic_SetupInterruptHandlers()
{
	XIic_SetSendHandler(&Iic, &Iic, (XIic_Handler) SendHandler);
	XIic_SetRecvHandler(&Iic, &Iic, (XIic_Handler) ReceiveHandler);
	XIic_SetStatusHandler(&Iic, &Iic, (XIic_StatusHandler) StatusHandler);
}

//
// AXI IIC Bus Interface v2.0
// LogiCORE IP Product Guide
// Vivado Design Suite PG090 October 5, 2016, page 37
// https://docs.amd.com/v/u/2.0-English/pg090-axi-iic
//
// Note: function writes up to 15 bytes (byte_to_send must be 15 or less)
//
int Iic_DynamicSendBytes (u8 * buffer_to_send, int byte_to_send)
{
	u32 wait_time;
	int trials = 3;

again:

	if (trials == 0) return 0;
	trials--;

	PrepareBusInTransmitMode();
	SendAddressInTransmitMode();

	if(byte_to_send != 0)
	{
		SendData(buffer_to_send, byte_to_send);
	}

	//time to send address + N bytes is
	//T = 10usec*9*(N+1), 9th bit is ACK (10usec is period of I2C clock)
	wait_time = (byte_to_send + 1) *90 + 1000;
	usleep(wait_time);

	if(SendSuccesfullyCompleted(wait_time))
		return 1;
	else
		goto again;

	return 1;
}

int Iic_DynamicSendBytesRepeatedStart (u8 * buffer_to_send, int byte_to_send)
{
	u32 wait_time;
	int trials = 3;

again:

	if (trials == 0) return 0;
	trials--;

	PrepareBusInTransmitMode();
	SendAddressInTransmitMode();
	SendDataRepeatedStart(buffer_to_send, byte_to_send);

	//time to send address + N bytes is
	//T = 10usec*9*(N+1), 9th bit is ACK
	wait_time = (byte_to_send + 1)*90 + 1000;
	usleep(wait_time);

	if(SendSuccesfullyCompleted(wait_time))
		return 1;
	else
		goto again;

	return 1;
}

void PrepareBusInTransmitMode()
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 sr_reg, cr_reg;

	//
	// code to clean bus
	//
	// disable
	cr_reg = 0;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	cr_reg);
	usleep(10);
	// enable
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	cr_reg);
	usleep(10);
	// reset TX_FIFO
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK | XIIC_CR_TX_FIFO_RESET_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	cr_reg);
	usleep(10);
	// clear reset TX_FIFO
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	0);
	usleep(10);

	//empty RX_FIFO_FULL by reading 16 times
	for(int i=0;i<16;i++)
	{
		Xil_In32(IIC_BASEADDR + XIIC_DRR_REG_OFFSET);
	}
	usleep(10);

	//clear RX_FIFO_FULL flag
	Clear_ReceiveFifoFull();
	usleep(10);

	// disable, clear reset
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	0);
	usleep(10);

	//Check bus not busy by reading the Status register
	sr_reg = Xil_In32(IIC_BASEADDR + XIIC_SR_REG_OFFSET);
	if ((sr_reg & XIIC_SR_BUS_BUSY_MASK) == XIIC_SR_BUS_BUSY_MASK)
	{
		usleep(1000);
	}

	// enable IIC, set MSMS -> 0, Transmit mode
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK | XIIC_CR_DIR_IS_TX_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET),	cr_reg);
}

void SendAddressInTransmitMode()
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 daddr;

	//set start bit, device address, write access to the TX_FIFO
	daddr =  XIIC_TX_DYN_START_MASK | XIIC_WRITE_OPERATION | ((Iic.AddrOfSlave << 1) & 0xFE);
	Xil_Out32((IIC_BASEADDR + XIIC_DTR_REG_OFFSET), daddr);
}

void SendData (u8 * buffer_to_send, int byte_to_send)
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 wdata;
	int i, imax;

	//loop
	imax = byte_to_send - 1;
	for (i = 0; i<= imax; i++) {
		if(i < imax)
			wdata = (u32) (							buffer_to_send[i] &  0xFF);
		else
			wdata = (u32) (XIIC_TX_DYN_STOP_MASK | (buffer_to_send[i] &  0xFF));
		//write data to FIFO
		Xil_Out32((IIC_BASEADDR + XIIC_DTR_REG_OFFSET), wdata);
	}
}

void SendDataRepeatedStart (u8 * buffer_to_send, int byte_to_send)
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 wdata;
	int i;

	//loop
	for (i = 0; i< byte_to_send; i++) {
		wdata = (u32) (buffer_to_send[i] &  0xFF);
		//write data to FIFO
		Xil_Out32((IIC_BASEADDR + XIIC_DTR_REG_OFFSET), wdata);
	}
}

int SendSuccesfullyCompleted(u32 wait_time)
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 sr_reg, isr_reg;

	//check if fifo is empty or error
	while(1) {
		sr_reg = Xil_In32(IIC_BASEADDR + XIIC_SR_REG_OFFSET);
		isr_reg = Xil_In32(IIC_BASEADDR + XIIC_IISR_OFFSET);

		//case 1: transmission error: reset and try again
		if 	(((isr_reg & XIIC_INTR_TX_ERROR_MASK) == XIIC_INTR_TX_ERROR_MASK))
		{
			//disable
			Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	0);
			Xil_Out32((IIC_BASEADDR + XIIC_RESETR_OFFSET), 0xA);
			return 0;
		}

		if 	((sr_reg & XIIC_SR_TX_FIFO_EMPTY_MASK) == 0)
		{
			usleep(wait_time);
			//check again if buffer is empty (bytes sent)
			sr_reg = Xil_In32(IIC_BASEADDR + XIIC_SR_REG_OFFSET);
			if 	((sr_reg & XIIC_SR_TX_FIFO_EMPTY_MASK) == 0) {
				//if buffer is still not empty (bytes sent) then try again to send from scratch
				return 0;
			}
			//FIFO empty after additional waiting time: return
			return 1;
		}
		else
		{
			//case 2b: "TX FIFO empty": return
			return 1;
		}
	}
	return 1;
}

//
// AXI IIC Bus Interface v2.0
// LogiCORE IP Product Guide
// Vivado Design Suite PG090 October 5, 2016, page 37
// https://docs.amd.com/v/u/2.0-English/pg090-axi-iic
//
// Note: the functions reads up to 16 bytes
//
int Iic_DynamicRecvBytes (u8 *buffer_to_recv, int byte_to_recv)
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 rdata, isr_reg, cr_reg;
	int i, imax;
	#define XIIC_INTR_RX_COMPLETED	0x00000002
	imax = byte_to_recv - 1;
	u32 counter=0;

	PrepareBusInReceiveMode(byte_to_recv);
	SendAddressInReceiveMode();

	//
	// read byte_to_recv - 1 bytes
	//
	//wait RX_FIFO is full (number of received bytes == byte_to_recv - 1)
	counter=0;
	while(1)
	{
		isr_reg = Xil_In32(IIC_BASEADDR + XIIC_IISR_OFFSET);
		//data received: break
		if 	(((isr_reg & XIIC_INTR_RX_FULL_MASK) == XIIC_INTR_RX_FULL_MASK))
		{
			break;
		}
		//timeout estimation: 200 ns loop@100MHz == 2usec/while loop
		//an AXI bus timer should be added to count properly
		counter++;
		if(counter > 10000)
		{
			return 0;	//20 msec
		}
	}

	// read bytes (except last byte)

	for (i = 0; i< imax; i++)
	{
		rdata = Xil_In32(IIC_BASEADDR + XIIC_DRR_REG_OFFSET);
		buffer_to_recv[i] = (u8) (rdata & 0xFF);
	}

	//clear RX_FIFO_FULL flag
	Clear_ReceiveFifoFull();

	//
	//read last byte
	//

	//Set the RX_FIFO depth RX_FIFO_PIRQ = 1.
	Xil_Out32(IIC_BASEADDR + XIIC_RFD_REG_OFFSET, 1);

	//set Acknowledge bit to 1
	cr_reg = Xil_In32(IIC_BASEADDR + XIIC_CR_REG_OFFSET);
	cr_reg |= XIIC_CR_NO_ACK_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), cr_reg);

	//wait to receive last byte with ACK bit = 1, and generate STOP
	counter = 0;
	while(1) {
		isr_reg = Xil_In32(IIC_BASEADDR + XIIC_IISR_OFFSET);
		if 	(((isr_reg & XIIC_INTR_RX_FULL_MASK) == XIIC_INTR_RX_FULL_MASK))
		{
			//generate stop MSMS=1 -> MSMS=0 transition
			cr_reg = XIIC_CR_ENABLE_DEVICE_MASK;
			Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET),	cr_reg);
			break;
		}
		//timeout estimation: 200 ns loop@100MHz == 2usec/while loop
		//an AXI bus timer should be added to count properly
		counter++;
		if(counter > 10000)
		{
			return 0;	//20 msec
		}
	}
	//read last byte
	rdata = Xil_In32(IIC_BASEADDR + XIIC_DRR_REG_OFFSET);
	buffer_to_recv[imax] = (u8) (rdata & 0xFF);

	//clear RX_FIFO_FULL flag
	Clear_ReceiveFifoFull();

	return 1;
}

void PrepareBusInReceiveMode(int byte_to_recv)
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 cr_reg;

	// reset tx_fifo
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK | XIIC_CR_TX_FIFO_RESET_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	cr_reg);
	usleep(10);

	// clear reset
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET), 	0);
	usleep(10);

	//do not clear RX_FIFO_FULL flag

	// Set the RX_FIFO depth RX_FIFO_PIRQ = 0x0F.
	Xil_Out32(IIC_BASEADDR + XIIC_RFD_REG_OFFSET, byte_to_recv - 1);
	usleep(10);
}

void SendAddressInReceiveMode()
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 daddr, cr_reg;

	// set start bit, device address, read access to the TX_FIFO
	daddr =  XIIC_READ_OPERATION | ((Iic.AddrOfSlave << 1) & 0xFE);
	Xil_Out32((IIC_BASEADDR + XIIC_DTR_REG_OFFSET), daddr);

	// set MSMS -> 1 to generate start
	cr_reg = XIIC_CR_ENABLE_DEVICE_MASK | XIIC_CR_MSMS_MASK ;
	Xil_Out32((IIC_BASEADDR + XIIC_CR_REG_OFFSET),	cr_reg);
}

/*****************************************************************************/
/**
* This Send handler is called asynchronously from an interrupt context and
* indicates that data in the specified buffer has been sent.
*
* @param	InstancePtr is a pointer to the IIC driver instance for which
* 		the handler is being called for.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void SendHandler(XIic *InstancePtr)
{
	TransmitCompleted = 1;
}

/*****************************************************************************/
/**
* This Receive handler is called asynchronously from an interrupt context and
* indicates that data in the specified buffer has been Received.
*
* @param	InstancePtr is a pointer to the IIC driver instance for which
* 		the handler is being called for.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void ReceiveHandler(XIic *InstancePtr)
{
	ReceiveComplete = 0;
}

/*****************************************************************************/
/**
* This Status handler is called asynchronously from an interrupt
* context and indicates the events that have occurred.
*
* @param	InstancePtr is a pointer to the IIC driver instance for which
*		the handler is being called for.
* @param	Event indicates the condition that has occurred.
*
* @return	None.
*
* @note		None.
*
******************************************************************************/
static void StatusHandler(XIic *InstancePtr, int Event)
{
	if (Event == XII_ARB_LOST_EVENT) {
		//XIic_WriteReg(InstancePtr->BaseAddress, XIIC_CR_REG_OFFSET, XIIC_CR_ENABLE_DEVICE_MASK);
		//XIic_WriteIisr(InstancePtr->BaseAddress, XIIC_INTR_BNB_MASK);
		//XIic_WriteIier(InstancePtr->BaseAddress, XIIC_INTR_BNB_MASK);
		//InstancePtr->BNBOnly = TRUE;

		return;
	}
	if (Event & XII_BUS_NOT_BUSY_EVENT) {
		//XIic_WriteReg(InstancePtr->BaseAddress, XIIC_CR_REG_OFFSET,0x0);
		//BusNotBusy = 1;

		return ;
	}
	if (Event & XII_SLAVE_NO_ACK_EVENT) {
		return;
	}
	if (Event &  (XIIC_INTR_TX_ERROR_MASK | XIIC_INTR_ARB_LOST_MASK |
			  XIIC_INTR_BNB_MASK)) {
		return;
	}

	if (Event & XIIC_INTR_TX_EMPTY_MASK) {
		return;
	}
}

int Clear_ReceiveFifoFull()
{
	u32 IIC_BASEADDR = Iic.BaseAddress;
	u32 isr_reg;

	//clear RX_FIFO_FULL
	isr_reg = Xil_In32(IIC_BASEADDR + XIIC_IISR_OFFSET);
	if(isr_reg & XIIC_INTR_RX_FULL_MASK)
	{
		Xil_Out32(IIC_BASEADDR + XIIC_IISR_OFFSET, XIIC_INTR_RX_FULL_MASK);
	}
	return 1;
}


/*
 * Start the IIC device.
 */
int Iic_Start()
{
	int Status;

	Status = XIic_Start(&Iic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}

void *Iic_GetCallbackRef()
{
	return (void *)&Iic;
}

/*
 * Stop the IIC device.
 */
int Iic_Stop()
{
	int Status;

	Status = XIic_Stop(&Iic);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	return XST_SUCCESS;
}





