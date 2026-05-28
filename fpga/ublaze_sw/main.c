/******************************************************************************
*
* Copyright (C) 2020 - 2021 IAEA.  All rights reserved.
*
******************************************************************************/


//xilinx declarations
#include "xil_types.h"
#include "xparameters.h"		//Contains the address and configurations of need for the system
#include "xstatus.h"			//Contains the status definitions used
#include "platform.h"			//Declarations for the MicroBlaze
#include <string.h>
#include "xuartlite.h"
#include "xuartlite_l.h"
#include <stdbool.h>
//custom declarations
#include "define.h"

#include "uart.h"
#include "xiic.h"
#include "ip_scope.h"
//#include "invert_and_offset.h"
#include "dpp_iface.h"
#include "xbram.h"
#include "intc.h"
#include "registers.h"
#include "util.h"
#include "iic.h"
//#include "fifotest.h"
//#include "fifo.h"
//#include "xil_sleepcommon.c"
//#include "sleep.h"

// define/undef to compile for a specific board
#undef AD5693 //define for a board that have software adjustment of the Fine gain only (all previous versions)
#define AD5697 //define for a board that have software adjustment of the Fine and Coarse gain (last version of the PMT)
#undef AD5697_EXT_REF
#undef PMT
#define SiPM

static XUartLite UartLite0;		/* Instance of the UartLite Device */
static XUartLite UartLite1;		/* Instance of the UartLite Device */
static u32 ReadDataFromAD5697(int address, u8 channel);
static u32 ReadDataFromAD5693_MCP3425(int address);
static int WriteCommandToAD5697(int address, int command, u8 channel, u32 Data);
static int WriteCommandToAD5693(int address, int command, u32 Data);

#include "main.h"

int main()
{
	InitSoPC();

	while(1)
	{
		if (XUartLite_IsReceiveEmpty(ctx0.pUartLite->RegBaseAddress) == FALSE)
		{
			DoHostTasksEx(&ctx0, true);
		}
		else if (XUartLite_IsReceiveEmpty(ctx1.pUartLite->RegBaseAddress) == FALSE)
		{
			DoHostTasksEx(&ctx1, true);
		}
	}
	cleanup_platform();
	return 0;
}

void handle_ascii_command(UART_Context *pctx)
{
	int cmdID;

	cmdID = GetCommandId(pctx->buffer);

	switch (cmdID)
	{
     case CMD_SET_PARAMETERS: 	//"$SP": Set Parameters
        DoCommand003(pctx);
		break;
     case CMD_LOAD_SCOPE:		//"$LS" Load Scope ( PS Scope -> Host; PS Scope is flushed automatically in interrupt mode)
        DoCommand004(pctx);
		break;
	 case  CMD_READ_SPECTRUM:	//"$RM": Read Spectrum ( PS DRAM - host)
		DoCommand006(pctx);
		break;
	 case CMD_ACQ_START_STOP:	//"$AQ": Acquisition Start/Stop
		DoCommand007(pctx);
		break;
	 case CMD_READ_TIMERS:
		DoCommand009(pctx);		//"$RT": Read Timers
		break;
	 case CMD_CLEAR_SPECTRUM:
		DoCommand010(pctx);		//"$CS": Clear Spectrum
		break;
	 case CMD_GET_PARAMETERS:
		DoCommand011(pctx);		//"$GP": Get Parameters
		break;
     case CMD_GET_VERSION:		//$GV: Get Version
    	DoCommand018(pctx);
    	break;
     case CMD_KEEP_ALIVE:		//~~~: Keep Alive
    	DoCommand019(pctx);
    	break;
     case CMD_GET_SERIAL_NUM:	//SN read serial number
    	DoCommand020(pctx);
    	break;
     case CMD_SET_SERIAL_NUM:	//SS set serial number
    	DoCommand021(pctx);
    	break;

     default:
		SendError(pctx->pUartLite, ERROR_INVALID_COMMAND);
		break;
	}
}

void InitSoPC()
{
	InitPS();
	InitPL();
}

void InitPS()
{

	init_platform();

	//**************************************************
	//	initialize UART controllers
	//**************************************************
	UartLiteInit(XPAR_UARTLITE_0_DEVICE_ID, &UartLite0);
	UartLiteInit(XPAR_UARTLITE_1_DEVICE_ID, &UartLite1);
	ctx0.pUartLite = &UartLite0;
	ctx1.pUartLite = &UartLite1;

	//**************************************************
	//	initialize IIC controller (must be before interrupt controller)
	//**************************************************
	Iic_Init(XPAR_IIC_0_DEVICE_ID);

	//**************************************************
	//	initialize interrupt controller
	//**************************************************
	IntcPSInit((u16)XPAR_INTC_0_DEVICE_ID);
	IntcEnableInterrupt(XPAR_INTC_0_DEVICE_ID);

	//PMT and SIPM platforms have VGA Amplifier
	SetAmplifierDacReferenceVoltage();

	//PMT platform has HV
	#ifdef PMT
	SetHvDacReferenceVoltage();
	#endif
}

void InitPL()
{
	XBram_Config *XBram_ConfigPtr;

	//**************************************************
	//	initialize IP Formatter
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_FORMATTER_IP,PRM_TABLE_END_FORMATTER_IP);


	//**************************************************
	//	initialize IP Scope mux
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_SCOPE_MUX_IP,PRM_TABLE_END_SCOPE_MUX_IP);

	//**************************************************
	//	initialize IP Scope
	//**************************************************
	ip_scope_Initialize(&IpScope, XPAR_IP_SCOPE_0_DEVICE_ID);
	memcpy(IpScope.Config.prm, &prm_table[PRM_TABLE_START_SCOPE], PRM_TABLE_CNT_SCOPE<<2);
	ip_scope_WriteLogic(&IpScope);

	//**************************************************
	//	initialize IP Invert and Offset
	//**************************************************
	//Xil_Out32(INVERT_OFFSET_REG0, prm_table[PRM_TABLE_START_INVERT_OFFSET]);

	//**************************************************
	//	initialize IP Shaper Slow
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_SHAPER_SLOW_IP,PRM_TABLE_END_SHAPER_SLOW_IP);

	//**************************************************
	//	initialize IP Peak Detector Slow
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_PKD_SLOW_IP,PRM_TABLE_END_PKD_SLOW_IP);

	//**************************************************
	//	initialize IP BRAM Controller
	//**************************************************
	XBram_ConfigPtr = XBram_LookupConfig(XPAR_BRAM_0_DEVICE_ID);
	XBram_CfgInitialize(&Bram, XBram_ConfigPtr, XBram_ConfigPtr->CtrlBaseAddress);

	//**************************************************
	//	initialize IP Shaper Fast
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_SHAPER_FAST_IP,PRM_TABLE_END_SHAPER_FAST_IP);

	//**************************************************
	//	initialize IP Peak Detector Fast
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_PKD_FAST_IP,PRM_TABLE_END_PKD_FAST_IP);

	//**************************************************
	//	initialize IP Timers
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_TIMERS_WR_IP,PRM_TABLE_END_TIMERS_WR_IP);
	//Xil_Out32(TIMER_REGISTER4, prm_table[PRM_TABLE_START_TIMERS+0+4]); //first 4 are read only
	//Xil_Out32(TIMER_REGISTER5, prm_table[PRM_TABLE_START_TIMERS+1+4]);

	//**************************************************
	//	initialize BLR Slow
	//**************************************************
	//ip_blr_Initialize(&ip_blrSlow, XPAR_DPP_0_PULSE_CONDITIONING_SLOW_IP_BLR_0_DEVICE_ID);
	dpp_write_registers(PRM_TABLE_START_BLR_SLOW_IP,PRM_TABLE_END_BLR_SLOW_IP);


	//**************************************************
	//	initialize BLR Fast
	//**************************************************
	//ip_blr_fast_Initialize(&ip_blrFast, XPAR_DPP_0_PULSE_CONDITIONING_FAST_IP_BLR_FAST_0_DEVICE_ID);
	dpp_write_registers(PRM_TABLE_START_BLR_FAST_IP,PRM_TABLE_END_BLR_FAST_IP);


	//**************************************************
	//	initialize PUR
	//**************************************************
	dpp_write_registers(PRM_TABLE_START_PUR_IP,PRM_TABLE_END_PUR_IP);

	//**************************************************
	//initialize FIFO for ROI
	//**************************************************
	//FifoReset();
}

int GetCommandId(u8 *u8Buffer)
{
   int i;
   char szCmdId[4];

   //Keep alive
   if(u8Buffer[0] == '~' && u8Buffer[1] == '~') return 19;

   for(i=0; i<3; i++)
   {
	   szCmdId[i] = u8Buffer[i];
   }
   szCmdId[3]='\0';

   for(i=0;i<CMD_CNT;i++)
   {
	  if(strcmp(szCmdId, m_szCmdId[i]) == 0) return (i+1);
   }
   return -1;
}


//
// CMD003: $SP = Set parameters
// command parameters: param_group_id, p1, p2, ... pn
//
void DoCommand003(UART_Context *pctx)
{
	int iParam;
	char szParameter[32];
	u32 u32Data;

	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;

	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0) goto failed;
	iParam = atoi32(szParameter);
	switch(iParam)
	{
		case 1://Shaper Slow parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_SHAPER_SLOW, PRM_TABLE_CNT_SHAPER_SLOW) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_SHAPER_SLOW_IP,PRM_TABLE_END_SHAPER_SLOW_IP);
			break;
		case 2: //Peak Detector Slow parameters
			DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_PKD_SLOW_FLAGS], 1);; //reset
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_PKD_SLOW, PRM_TABLE_CNT_PKD_SLOW) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_PKD_SLOW_IP,PRM_TABLE_END_PKD_SLOW_IP);
			break;
		case 3://Scope parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, IpScope.Config.prm, IP_SCOPE_PRM_CNT) == 0) goto failed;
			ip_scope_WriteLogic(&IpScope);
			memcpy(&prm_table[PRM_TABLE_START_SCOPE], IpScope.Config.prm, IP_SCOPE_PRM_CNT<<2);
			break;
		case 4://Timers parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_TIMERS_WR_IP, PRM_TABLE_CNT_TIMERS_WR_IP) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_TIMERS_WR_IP,PRM_TABLE_END_TIMERS_WR_IP);
			break;
		case 5://BLR Slow parameters
			DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_BLR_SLOW_FLAGS], 1);; //reset
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_BLR_SLOW, PRM_TABLE_CNT_BLR_SLOW) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_BLR_SLOW_IP,PRM_TABLE_END_BLR_SLOW_IP);
			break;
		case 6://Scope mux parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_SCOPE_MUX, PRM_TABLE_CNT_SCOPE_MUX) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_SCOPE_MUX_IP,PRM_TABLE_END_SCOPE_MUX_IP);
			break;
		case 8://Formatter parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_FORMATTER, PRM_TABLE_CNT_FORMATTER) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_FORMATTER_IP,PRM_TABLE_END_FORMATTER_IP);
			break;
		case 9://Shaper Fast parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_SHAPER_FAST, PRM_TABLE_CNT_SHAPER_FAST) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_SHAPER_FAST_IP,PRM_TABLE_END_SHAPER_FAST_IP);
			 break;
		case 10://BLR Fast parameters
			DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_BLR_FAST_FLAGS],1); //reset
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_BLR_FAST, PRM_TABLE_CNT_BLR_FAST) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_BLR_FAST_IP,PRM_TABLE_END_BLR_FAST_IP);
			break;
		case 12://Peak Detector Fast parameters
			DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_PKD_FAST_FLAGS], 1);; //reset
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_PKD_FAST, PRM_TABLE_CNT_PKD_FAST) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_PKD_FAST_IP,PRM_TABLE_END_PKD_FAST_IP);
			 break;
		case 13://PileUp Rejector parameters
			if(GetCommandParamaterArray(u8Command, uiCommandSize, prm_table + PRM_TABLE_START_PUR, PRM_TABLE_CNT_PUR) == 0) goto failed;
			dpp_write_registers(PRM_TABLE_START_PUR_IP,PRM_TABLE_END_PUR_IP);
			break;
		case 14:// High Voltage
			if( GetCommandParameter(u8Command,uiCommandSize,2,szParameter) == 0) goto failed;
			u32Data = atou32(szParameter);
			SetHighVoltage(u32Data);
			break;
		case 15:// Amplifier gain parameters
			if( GetCommandParameter(u8Command,uiCommandSize,2,szParameter) == 0) goto failed;
			u32Data = atou32(szParameter);
			SetAmplifierGainFine(u32Data);
			if( GetCommandParameter(u8Command,uiCommandSize,3,szParameter) == 0) goto failed;
			u32Data = atou32(szParameter);
			SetAmplifierGainCoarse(u32Data);
			break;
		default:
			goto failed;
			break;
	}
	//reply: header and footer
	strcpy(u8Replay,"!SP\n\r");
	//reply: send
	UartLiteSendReply(pUartLite, u8Replay,5);

	return;
failed:
	SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
}

//
// CMD004: $LS = Load data from scope (same as Read but using interrupt)
// command parameter: channel ID (integer value 1 or 2)
//
void DoCommand004(UART_Context *pctx)
{
	if(IntcIsWaveformReady()==0)
	{
	//SendError(ERROR_SCOPE_DATA_NOT_READY);
	//return;
	}

	//reply: header (limited to 4 bytes)
	strcpy(u8Replay,"!L\n\r");

	//reply: data
	u32 *data = (u32 *) (u8Replay + 4);
	ip_scope_ReadWaveform(&IpScope,data);

	//reply: send
	UartLiteSendReply(pctx->pUartLite, u8Replay, MEMORY_TX_BUFFER_SIZE);

	//clear scope and enable interrupt
	ip_scope_WaveformAccepted(&IpScope);
	IntcEnableInterrupt( XPAR_PS_MB_0_AXI_INTC_0_DPP_0_SCOPE_IP_SCOPE_0_FULL_INTR);
}

//
// CMD006: $RM = Get data from spectrum
//
void DoCommand006(UART_Context *pctx)
{
	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;
	char szParameter[32];
	int i, iParam;
	u32 addr;

	//reply: header (limited to 4 bytes)
	strcpy(u8Replay,"!R\n\r");

	//reply: data
	u32 *data = (u32 *) (u8Replay + 4);

	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0) goto failed;

	iParam = atoi32(szParameter);
	switch(iParam)
	{
		case 0:
		case 1:
		case 2:
		case 3:
			for(i=0; i< BRAM_SPECTRUM_SIZE;i++)
			{
				addr = XPAR_BRAM_0_BASEADDR+4*i;
				data[i]= Xil_In32(addr);
			}
   	     break;
   	  default:
			goto failed;
			break;
         }

	//reply: send
	UartLiteSendReply(pUartLite, u8Replay, MEMORY_TX_BUFFER_SIZE);
	return;
failed:
	SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
	return;
   }

//
// CMD007: $AQ = Acquisition start/stop
//
void DoCommand007(UART_Context *pctx)
{
	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;

	char szParameter[32];
	int iParam;
	int u32RegData;

	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0)
	{
		SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
		return;
	}

	iParam = atoi32(szParameter);
	switch(iParam)
	{
	  //stop acquisition manually
	  case 2:
		 //stop scope
		 ip_scope_Acq(&IpScope,0);
		 IntcDisableInterrupt( XPAR_PS_MB_0_AXI_INTC_0_DPP_0_SCOPE_IP_SCOPE_0_FULL_INTR);
		 //stop MCA - its is stopped by setting bit 0 and bit 1 of timers register #5
		 // step 1: read register #5
		 //u32RegData = Xil_In32(TIMER_REGISTER5);
		 u32RegData = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG]);
		 // step 2: set b1b0 = 00, only first 11 bits are used
		 u32RegData &= ~(TIMER_MANUAL_START | TIMER_AUTO_START);
		 //Xil_Out32(TIMER_REGISTER5, u32RegData);
		 DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG],u32RegData);
		 break;

	  //start acquisition manually
	  case 1:
		 //clean BRAM
		 ClearPlSpectrum(XPAR_BRAM_0_BASEADDR+4*BRAM_SPECTRUM_SIZE);
		 ClearPlSpectrum(XPAR_BRAM_0_BASEADDR);
		 //reset FIFO
		 //FifoReset();

		 //start scope
		 ip_scope_Acq(&IpScope,1);
		 ip_scope_WaveformAccepted(&IpScope);
		 IntcEnableInterrupt( XPAR_PS_MB_0_AXI_INTC_0_DPP_0_SCOPE_IP_SCOPE_0_FULL_INTR);

		 //start MCA - its is started by setting bit 1 and bit 2 of timers register #5
		 // step 1: read register #5
		 //u32RegData = Xil_In32(TIMER_REGISTER5);
		 u32RegData = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG]);
		 // step 2: set b2b1 = 01, only first 11 bits are used
		 u32RegData &= ~(TIMER_MANUAL_START | TIMER_AUTO_START);
		 u32RegData |= TIMER_MANUAL_START;
		 //Xil_Out32(TIMER_REGISTER5, u32RegData);
		 DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG],u32RegData);
		 break;

	  //start auto measurement
	  case 0:
		  //clean BRAM
		  ClearPlSpectrum(XPAR_BRAM_0_BASEADDR+4*BRAM_SPECTRUM_SIZE);
		  ClearPlSpectrum(XPAR_BRAM_0_BASEADDR);
		  //reset FIFO
		  //FifoReset();

		 //start scope
		 ip_scope_Acq(&IpScope,1);
		 ip_scope_WaveformAccepted(&IpScope);
		 IntcEnableInterrupt( XPAR_PS_MB_0_AXI_INTC_0_DPP_0_SCOPE_IP_SCOPE_0_FULL_INTR);

		 //start MCA - its is started by setting bit 1 and bit 2 of timers register #5
		 // step 1: read register #5
		 //u32RegData = Xil_In32(TIMER_REGISTER5);
		 u32RegData = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG]);
		 // step 2: set b2b1 = 10, only first 11 bits are used
		 u32RegData &= ~(TIMER_MANUAL_START | TIMER_AUTO_START);
		 u32RegData |= TIMER_AUTO_START;
		 //Xil_Out32(TIMER_REGISTER5, u32RegData);
		 DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG],u32RegData);
		 break;

		//clear all timers
	case 4:
		//set bits 9,10,11 of the register 5 to 1 and then to 0
		//step 1: set bits 9,10,11 to 1
		//u32RegData = Xil_In32( TIMER_REGISTER5);
		u32RegData = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG]);
		u32RegData|= (TIMERC_CLEARED |TIMERB_CLEARED | TIMERA_CLEARED);
		//Xil_Out32(TIMER_REGISTER5, u32RegData);
		DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG],u32RegData);
		//step 2: set bits 9,10,11 to 0
		u32RegData&= ~(TIMERC_CLEARED |TIMERB_CLEARED | TIMERA_CLEARED);
		//Xil_Out32(TIMER_REGISTER5, u32RegData);
		DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[PRM_TABLE_TIMERS_CONTROL_REG],u32RegData);
		break;

	default:
		 goto failed;
		 break;
	}
	//reply: header and footer
	strcpy(u8Replay,"!AQ\n\r");
	//reply: send
	UartLiteSendReply(pUartLite, u8Replay,5);
	return;

failed:
   SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
   }


//
// CMD009: $RT = read from a Timers' register
// command parameter1: register ID (zero based index or -1)
//
void DoCommand009(UART_Context *pctx)
{
	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;
	char szParameter[32];
	int iLen, i32RegId;
	u32 addr, u32RegData, u32RegDataArray[6];
	u8 *u8Replay_appx;

	//reply: header
	strcpy(u8Replay,"!RT ");

	//reply: data
	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0) goto failed;
	i32RegId = atoi32(szParameter);
	if(i32RegId == -1)    //read all
	{
		//addr = TIMER_REGISTER0;
		addr = prm_addr_table[PRM_TABLE_START_TIMERS_IP];
		for(int i=0;i<6;i++)
		{
			u32RegDataArray[i] = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, addr); //Xil_In32(addr);
			addr += 4;
		}
		iLen = u32atoa(u32RegDataArray, 6, (char*)u8Replay+4);	//append to "!RT "
	}
	else    //read one
	{
		//addr = TIMER_REGISTER0 + (u32)(i32RegId*4);
		addr = (u32)(i32RegId*4);
		u32RegData = DPP_IFACE_mReadReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, addr);//Xil_In32(addr);
		iLen = u32toa(u32RegData, (char*)u8Replay+4);	//append to "!RT "
	}

	//reply: footer
	strcpy(u8Replay+iLen+4,"\n\r");

	//reply: send
	iLen = strlen((char*)u8Replay);
	UartLiteSendReply(pUartLite, u8Replay, iLen);
	return;

failed:
   SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
   return;
   }

//
// CMD010: $CS = Clear Spectrum, alternative $AQ 3
// command parameter1: segment ID
//
void DoCommand010(UART_Context *pctx)
{
	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;
	char szParameter[32];
	int iParam;

	//get segment
	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0) goto failed;
	iParam = atoi32(szParameter);
	//TBD: add segment
	ClearPlSpectrum(XPAR_BRAM_0_BASEADDR);

	//reply: header
	strcpy(u8Replay,"!CS\n\r");

	//reply: send
	UartLiteSendReply(pUartLite, u8Replay,5);
	return;
failed:
	SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
	return;
}


//
// CMD011: $GP = Get parameters
// command parameters: param_group_id, p1, p2, ... pn
//
void DoCommand011(UART_Context *pctx)
{
	XUartLite *pUartLite = pctx->pUartLite;
	u8 *u8Command = pctx->buffer;
	unsigned int uiCommandSize = pctx->len;
	int iParam, iLen;
	char szParameter[32];

	//reply: header
	strcpy(u8Replay,"!GP ");

	//reply: data
	if( GetCommandParameter(u8Command,uiCommandSize,1,szParameter) == 0) goto failed;
	iParam = atoi32(szParameter);
	switch(iParam)
	{
		case 1: //Shaper slow parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_SHAPER_SLOW;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_SHAPER_SLOW, (char*)u8Replay+4);
		}
		break;
		case 2: //Peak Detector Slow parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_PKD_SLOW;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_PKD_SLOW, (char*)u8Replay+4);
		}
		break;
		case 3: //Scope parameters
		{
			u32 *prm = IpScope.Config.prm;
			iLen = u32atoa(prm, IP_SCOPE_PRM_CNT, (char*)u8Replay+4);
		}
		break;
		case 4: //Timers parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_TIMERS;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_TIMERS, (char*)u8Replay+4);
		}
		break;
		case 5: //BLR Slow parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_BLR_SLOW;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_BLR_SLOW, (char*)u8Replay+4);
		}
		break;
		case 6: //scope mux parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_SCOPE_MUX;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_SCOPE_MUX, (char*)u8Replay+4);
		}
		break;
		case 8: //Formatter parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_FORMATTER;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_FORMATTER, (char*)u8Replay+4);
		}
		break;
		case 9: //Shaper Fast parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_SHAPER_FAST;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_SHAPER_FAST, (char*)u8Replay+4);
		}
		break;
		case 10://BLR Fast parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_BLR_FAST;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_BLR_FAST, (char*)u8Replay+4);
		}
			break;
		case 12: //IP Peak Detector FAST
		{
			 u32 *prm = prm_table + PRM_TABLE_START_PKD_FAST;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_PKD_FAST, (char*)u8Replay+4);
		}
		break;
		case 13: //PUR parameters
		{
			 u32 *prm = prm_table + PRM_TABLE_START_PUR;
			 iLen = u32atoa(prm, PRM_TABLE_CNT_PUR, (char*)u8Replay+4);
		}
		break;
		case 14: //High Voltage
		{
			u32 u32RegData;

			u32RegData = GetHighVoltage();
			iLen = u32toa(u32RegData, (char*)u8Replay+4);
		}
		break;
		case 15: //Amplifier gain fine, Coarse
		{
			u32 u32RegData[2];
			u32RegData[0] = GetAmplifierGainFine();
			u32RegData[1] = GetAmplifierGainCoarse();
			iLen = u32atoa(u32RegData, 2, (char*)u8Replay+4);
		}
		break;

		default:
			goto failed;
			break;
	}

	//reply: footer
	strcpy(u8Replay+iLen+4,"\n\r");

	//replay: send
	iLen = (int) strlen((char *) u8Replay);
	UartLiteSendReply(pUartLite, u8Replay,iLen);
	return;

failed:
	SendError(pUartLite, ERROR_INVALID_COMMAND_PARAMETER);
	return;
   }


//
// CMD018: $GV =
//  no parameters, Get firmware version
//
void DoCommand018(UART_Context *pctx)
{
	//reply: header and footer
	strcpy(u8Replay,"!GV 1.0\n\r");
	//reply: send
	UartLiteSendReply(pctx->pUartLite, u8Replay, 9);
	return;
}

//
// CMD019: ~~
//  no parameters, KeepAlive
//
void DoCommand019(UART_Context *pctx)
{
	//reply: header and footer
	strcpy(u8Replay,"~~~\n");
	//reply: send
	UartLiteSendReply(pctx->pUartLite, u8Replay, 4);
	return;
}

//
// CMD020: $SN
//  no parameters, Get firmware version
//
void DoCommand020(UART_Context *pctx)
{
	//reply: header and footer
	strcpy(u8Replay,"!SN 210328B7E67AB\n\r");
	//reply: send
	UartLiteSendReply(pctx->pUartLite, u8Replay, 19);
	return;
}

//
// CMD021: $SS
//  1 parameters, set firmware version
//  not implemented for boards without EEPROM
//
void DoCommand021(UART_Context *pctx)
{
	//reply: header and footer
	strcpy(u8Replay,"!SS\n\r");
	//reply: send
	UartLiteSendReply(pctx->pUartLite, u8Replay, 5);
	return;
   }

//
// PMT platform has HV module CA12P-5
// HV is set by AD5693 DAC
//
// Set high voltage HV output value CA12P-5
// HV = 1250 * (VDAC/2.048),  2.048V is CA12P-5 internal Voltage reference
// VDAC is output voltage from AD5693 DAC at I2C address 1001110=0x4E
// The AD5693 is connected to VREF=2.048 (LM4132)
// VDAC = 2.048 * D/65536
// HV = 1250 * D/65536
// D = 41943 => HV = 800 V
// parameter = D
//
int SetHighVoltage(u32 u32Data)
{
	u8 u[6];
	int ret;

	//set data into table;
	prm_table[PRM_TABLE_START_HV + IP_HV_PRM_INDEX_SET] =  u32Data;    	//set HV

	ret = WriteCommandToAD5693(0x4E, 3, u32Data);

	return ret;
}

//
// AD5693 is used to generate voltage to control HV module
//
int SetHvDacReferenceVoltage()
{
	int ret;

	ret = WriteCommandToAD5693(0x4E, 4, 0);

	return ret;
}


//
// HV is measured by using MCP3425 ADC
//
// Get high voltage HV output value CA12P-5
// HV = 1250 * (VMON/2.048)  2.048V is CA12P-5 internal Voltage reference
// VMON is measured by MCP3425 which has I2C address 1101000=0x68
// VMON = (ADC_DATA*2.048)/(MAX_CODE+1)
// HV = 1250 * ADC_DATA/(MAX_CODE+1),
// in the current version of the firmware MAX_CODE is 2047
// it can be changed to 32767 by changing default ADC resolution from 12 bit to 16 bit
// parameter = none
// function returns ADC_DATA. To convert to HV use above formula for HV
// MCP3425 supports Repeated start
u32 GetHighVoltage()
{
	u32 adc_data;

	//MCP3425 operates in the Continuous Conversion Mode: to get data we need to perform read operation
	//When the Master sends a read command (R/W = 1) the MCP3425 outputs:
	//the conversion data bytes and configuration byte
	//read data: high byte (adc_data_hi), lower byte (adc_data_lo), config byte
	adc_data = ReadDataFromAD5693_MCP3425(0x68);

	//store value into prm_table;
	prm_table[PRM_TABLE_START_HV + IP_HV_PRM_INDEX_GET] = adc_data;

	return adc_data;
}

// Set amplifier fine gain voltage VMAG with using AD5693 DAC at address 1001100=0x4C on board with manual Coarse gain
// Set amplifier fine gain voltage VMAG with using AD5697 DAC at address 0x0D on board with digital Coarse gain
// no parameters
//
int SetAmplifierGainFine(u32 u32Data)
{
	int ret = 0;

	prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_FINE_SET] = u32Data;   //set gain
	prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_FINE_GET] = u32Data;   //get gain,
#ifdef AD5693
	ret = WriteCommandToAD5693(0x4C, 3, u32Data);
#endif
#ifdef AD5697
	ret = WriteCommandToAD5697(0x0D, 3, (u8)'A', u32Data);
#endif
	return ret;
}

int SetAmplifierGainCoarse(u32 u32Data)
{
	int ret = 0;

	prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_COARSE_SET] = u32Data;   //set gain
	prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_COARSE_GET] = u32Data;   //get gain,
#ifdef AD5697
	ret = WriteCommandToAD5697(0x0D, 3, (u8)'B', u32Data);
#endif
	return ret;
}


u32 ReadDataFromAD5693_MCP3425(int address)
{
	u8 u[2];
	u32 DataIn;
	int trials = 4;

	Iic_SetAddress(address);
again:
	trials--;
	if(trials == 0) return 0;
	if(Iic_DynamicSendBytes(u,0) == 0) goto again;
	if(Iic_DynamicRecvBytes(u,2) == 0) goto again;
	DataIn = (u32) (u[0] << 8)+(u[1]);

	return DataIn;
}


int WriteCommandToAD5693(int address, int command, u32 Data)
{
	u8 u[3];
	int ret;

	switch (command)
	{
		//Write DAC and input registers.
		case 3:
			//send command #3 "write DAC and input registers",
			//send HEX 3x high byte low_byte  (x=do not care)
			u[0] = 0x30;
			u[1] = (u8) ((Data & 0xffff) >> 8);
			u[2] = (u8) ((Data & 0x00ff)     );
			break;

		//Write control register.
		case 4:
			//1. send command #4 "write control register" to disable internal REF:
			//--D15--D14--D13--D12-- --D11--D10--D9--D8...D7--D6--D5--D4  D3--D2--D1--D0
			//Reset--PD1--PD2--REF-- --GAIN- 0 ..0 --          all 0          all 0
			//default bits: Reset=0 (do not reset), PD1=0, PD2=0, (normal mode)  REF = 1 (external ref)
			//default bits  Gain = 0 (range = 0V to VREF)
			//D15D14D13D12 D11D10D9D8 =0001 0000 = 0x10 = u[1] = high byte
			//D7 D6 D5 D4  D3 D2 D1D0 =0000 0000 = 0x00 = u[2] = low byte
			//
			//send hex: 4x 10 00 (x=don't care)
			u[0] = 0x40; //command byte (send first)
			u[1] = 0x10; //high byte (send second)
			u[2] = 0x00; //low byte	(send last)
			break;
	}
	Iic_SetAddress(address);
	ret = Iic_DynamicSendBytes(u,3);

	return ret;
}

#ifdef AD5697

u32 ReadDataFromAD5697(int address, u8 channel)
{
	u8 u[2];
	u32 DataIn;
	int trials = 4;

	if(channel == (u8)'A')
		u[0] = 0x1;
	else
		u[0] = 0x8;
	Iic_SetAddress(address);
again:
	trials--;
	if(trials == 0) return 0;
	if(Iic_DynamicSendBytesRepeatedStart(u,1) == 0) goto again;
	if(Iic_DynamicRecvBytes(u,2) == 0) goto again;
	DataIn = (u[0] << 4)+(u[1] >> 4);

	return DataIn;
}

int WriteCommandToAD5697(int address, int command, u8 channel, u32 Data)
{
	u8 u[3];
	int ret;

	switch (command) {

		//Write to and update DAC Channel 'channel'
		case 3:

			if(channel == (u8)'A')
				// send command 0011: "write to and update DAC A",
				// send HEX 31 high byte low_byte  (x=do not care)
				// write to and update DAC A: command bits
				// DB23=0;DB22=0;DB21=1;DB20=1;
				// write to and update DAC A: command bits = 3
				// write to and update DAC A: address bits
				// DB19=0;DB18=X;DB17=X;DB16=1;
				// write to and update DAC A: address bits = 1
				// write to and update DAC A: command byte DB23...DB16 = u[0] = 31
				u[0] = 0x31;
			else
				//send command #3 "write to and update DAC B",
				//send HEX 38 high byte low_byte  (x=do not care)
				u[0] = 0x38;

			u[1] = (u8) ((Data & 0x0ff0) >> 4);  //take bits 4 to 12
			u[2] = (u8) ((Data & 0x000f) << 4);	//take bits 1 to 4 and shift them for 4 bits left

		break;

		//setting up the internal reference
		case 7:
			//DB23-DB22-DB21-DB20|DB19-DB18-DB17-DB16|DB15-DB14-DB13-DB12-DB11-DB10-DB9-DB8|DB7-DB6-DB5-DB4-DB3-DB2-DB1-DB0|
			//--C3---C2---C1---C0|DACB---0---0---DACA|-D11--D10--D9---D8---D7---D6---D5--D4|-D3--D2--D1--D0--X---X---X---X-|
			//       command     |      address      |               DAC data              |             DAC data          |
		    //               command byte            |         data high byte              |           Data low byte       |
			//
			//
			//1. send command 0111 to disable internal REF:
			//
			// internal reference setup: command bits
			// DB23=0;DB22=1;DB21=1;DB20=1;
			// DB23...DB20 = 7
			// internal reference setup: address bits
			// DB19=X;DB18=X;DB17=XDB16=X;
			// DB19...DB16 = X
			// internal reference setup: command byte DB23...DB16 = u[0] = 7x
			// internal reference setup: data high byte
			// D11 to D4 = X = Don't care =
			// internal reference setup: data high byte = u[0] = xx
			// internal reference setup: data low byte
			// DB7=X;DB6=X;DB5=X=Don't care;DB4=1 = 0x01
			// internal reference setup: data low byte = u[2] = x1

			//70 xx x1 (x=don't care)
			u[0] = 0x70;	//command byte = 7x (0 selected for x = don't care)
			u[1] = 0x00;	//data high byte = xx (0 selected for x = don't care)
#ifdef AD5697_EXT_REF
			u[2] = 0x01;	//data low byte (1=external reference off  0=internal reference on:0=newest version)
#else
			u[2] = 0x00;	//data low byte (1=external reference off  0=internal reference on:0=newest version)
#endif
			break;

		default:
			return 0;
	}
	Iic_SetAddress(address);
	ret = Iic_DynamicSendBytes(u,3);

	//read back ()
	//if(command ==3) {
	//	DataIn = ReadDataFromAD5697(address, channel);
	//}

	return ret;
}
#endif

int SetAmplifierDacReferenceVoltage()
{
	int ret;

#ifdef AD5693
	ret = WriteCommandToAD5693(0x4C, 0x4, 0);
#endif
#ifdef AD5697
	ret = WriteCommandToAD5697(0x0D, 0x7, 0, 0);
#endif
	return ret;
}

//
// no parameters
//
u32 GetAmplifierGainFine()
{
	//u32 Data;

#ifdef AD5693
	//we have problem reading I2C
	//Data = ReadDataFromAD5693_MCP3425(0x4C);
#endif

#ifdef AD5697
	//we have problem reading I2C
	//Data = ReadDataFromAD5697(0x0D, (u8)'A');
#endif
	//return Data;
	return prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_FINE_SET];  //get gain
}

//
// no parameters
//
u32 GetAmplifierGainCoarse()
{
	//u32 Data;
#ifdef AD5693
	//version with AD5693 does not have software adjustable coarse gain
	//Data = prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_COARSE_SET];
#endif
#ifdef AD5697
	//we have problem reading I2C
	//Data = ReadDataFromAD5697(0x0D, (u8)'B');
#endif
	//return Data;
	return prm_table[PRM_TABLE_START_AMP + IP_AMP_PRM_INDEX_GAIN_COARSE_SET];
}

//
// Parses for command parameter
// if parameter is first then iParametrId = 1
// if parameter is second then iParameter = 2 etc
// on return the szParameter contains the command parameter as string (null terminated)
//
int GetCommandParameter(u8 *u8Command, unsigned int uiCommandSize, int iParameterId, char *szParameter)
{
	char *c1,*c2,*cc;
	int i=0;
	char szCommand[MEMORY_RX_BUFFER_SIZE];

	memcpy(szCommand,u8Command,uiCommandSize);
	szCommand[uiCommandSize]='\0';

	cc = szCommand;

	//look for i-th occurrences of space character '' i=iParametrId
	while(1)
	{
		i++;
		c1 = strchr(cc,' ');
		if(c1 == NULL) return 0;
		cc = c1 + 1;
		if(i == iParameterId) break;
	}

	//look for the next ' '
	c2 = strchr(cc,' ');
	if(c2)
	{
		*c2 = '\0';
		strcpy(szParameter,cc);
		return 1;
	}

	//look for the '\n'
	c2 = strchr(cc,'\n');
	if(c2)
	{
		*c2 = '\0';
		strcpy(szParameter,cc);
		return 1;
	}

	//look for the '\r'
	c2 = strchr(cc,'\r');
	if(c2)
	{
		*c2 = '\0';
		strcpy(szParameter,cc);
		return 1;
	}

	return 0;
}

//
// assuming iError in the interval [0, 99]
//
void SendError(XUartLite *pUartLite, int iErrorId)
{
	char c1,c2;

	strcpy(u8Replay,"!ERROR:__\n\r");
	c1 = (char) (0x30 + iErrorId/10);
	c2 = (char) (0x30 + iErrorId%10);

	u8Replay[7] = c1;
	u8Replay[8] = c2;

	UartLiteSendReply(pUartLite, u8Replay, 11);
}

void ClearPlSpectrum(u32  base_addr)
{
	u32 addr;
	int i;
	for(i=0; i< BRAM_SPECTRUM_SIZE;i++) //lower half
	{
		addr = base_addr+4*i;
		Xil_Out32(addr,0);
	}
}

int GetCommandParamaterArray(u8 *u8Command, unsigned int uiCommandSize, u32 *prmArray, int prmCnt)
{
	int j=2;
	char szParameter[32];

	for(int i=0;i<prmCnt;i++,j++)
	{
		if( GetCommandParameter(u8Command,uiCommandSize,j,szParameter) == 0) return 0;
		prmArray[i] = atou32(szParameter);
	}
	return 1;
}

void dpp_write_registers(int index_start, int index_end)
{
	int index;
	for(index=index_start;index<=index_end;index++)
	{
		DPP_IFACE_mWriteReg(XPAR_DPP_0_DPP_IFACE_0_S_AXI_BASEADDR, prm_addr_table[index], prm_table[index]);
	}
}


void DoHostTasks(UART_Context *pctx)
{
   unsigned int uiReceivedCount;

	if(UartLiteReceiveCommand(pctx->pUartLite, pctx->buffer, &uiReceivedCount, MEMORY_RX_BUFFER_SIZE) == XST_SUCCESS)
	{
		pctx->len = uiReceivedCount;
		handle_ascii_command(pctx);
	}
}

void DoHostTasksEx(UART_Context *ctx, bool ready)
{
	u8 c;
	//uint32_t now = HAL_GetTick(); // Use your system's ms timer
	//if (ctx->state != MODE_IDLE && (now - ctx->last_byte_time > TIMEOUT_MS))
	//{
	//	ctx->state = MODE_IDLE;
	//}
	if (!ready) return;
	//ctx->last_byte_time = now;

	c = XUartLite_ReadReg(ctx->pUartLite->RegBaseAddress, XUL_RX_FIFO_OFFSET);

	switch (ctx->state)
	{
		case MODE_IDLE:
			if (c == SYNC_BIN)
			{
				ctx->state = BIN_ID;
			}
			else if (c == SYNC_ASC)
			{
				ctx->state = ASC_CMD1;
				ctx->buffer[0] = (char) c;
				ctx->idx = 1;
			}
			break;

		/* --- BINARY PROTOCOL BRANCH --- */
		case BIN_ID:
			ctx->id = c;
			ctx->state = BIN_LEN_MSB;
			break;

		case BIN_LEN_MSB:
			ctx->len = ((uint16_t) c) << 8;
			ctx->state = BIN_LEN_LSB;
			break;

		case BIN_LEN_LSB:
			ctx->len += (uint16_t) c;
			ctx->idx = 0;
			ctx->state = (c > 0) ? BIN_DATA : BIN_CRC1;
			break;

		case BIN_DATA:
			ctx->buffer[ctx->idx++] = c;
			if (ctx->idx >= ctx->len) ctx->state = BIN_CRC1;
			break;

		case BIN_CRC1:
			ctx->crc_calc = (uint16_t)c << 8;
			ctx->state = BIN_CRC2;
			break;

		case BIN_CRC2:
			ctx->crc_calc |= c;
			// Verify header + payload
			//uint8_t head[3] = { SYNC_BIN, ctx->id, ctx->len };
			//uint16_t v = fast_crc16(head, 3);
			// This is a simplified CRC check; for production,
			// run CRC over the whole buffer for better speed.
			//handle_binary(port, ctx->id, ctx->buffer, ctx->len);
			ctx->state = MODE_IDLE;
			break;

		/* --- ASCII PROTOCOL BRANCH --- */
		case ASC_CMD1:
			ctx->cmd[0] = c;
			ctx->buffer[1] = c;
			ctx->idx = 2;
			ctx->state = ASC_CMD2;
			break;

		case ASC_CMD2:
			ctx->cmd[1] = c;
			ctx->cmd[2] = '\0';
			ctx->buffer[2] = c;
			ctx->idx = 3;
			ctx->state = ASC_PAYLOAD;
			break;

		case ASC_PAYLOAD:
			if (c == '\r')	//last character
			{
				ctx->buffer[ctx->idx] = '\r';
				ctx->idx = ctx->idx + 1;
				ctx->buffer[ctx->idx] = '\0';
				ctx->len = ctx->idx;
				handle_ascii_command(ctx);
				ctx->state = MODE_IDLE;
			}
			else if (ctx->idx < MAX_BUF-1)
			{
				ctx->buffer[ctx->idx] = c;
				ctx->idx = ctx->idx + 1;
			}
			break;
	}
}
