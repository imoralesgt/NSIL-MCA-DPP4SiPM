/*
 * uart.c
 *
 *  Created on: Nov 13, 2019
 *      Author: M.Bogovac
 */
#include "xparameters.h"
#include "xuartlite.h"
#include "xuartlite_l.h"
#include "xil_printf.h"
#include "define.h"
#include "uart.h"
#include <stdbool.h>


int UartLiteInit(u16 DeviceId, XUartLite *pUartLite)
   {
   int Status;

   Status = XUartLite_Initialize(pUartLite, DeviceId);
   if (Status != XST_SUCCESS)
      {
	  return XST_FAILURE;
	  }

   /*
	* Perform a self-test to ensure that the hardware was built correctly.
	*/
   Status = XUartLite_SelfTest(pUartLite);
   if (Status != XST_SUCCESS)
      {
	  return XST_FAILURE;
	  }

   return XST_SUCCESS;
   }

int UartLiteSendReply(XUartLite *pUartLite, u8 *szReplay, unsigned int uiReplayCount)
   {
   unsigned int uiSentCountTotal = 0;
   unsigned int uiSentCount, uiRestCount;

   /*
    * Block sending the buffer.
    */
again:
   //wait until sending finished
   while(XUartLite_IsSending(pUartLite)==TRUE) {;}

   uiRestCount = uiReplayCount - uiSentCountTotal;
   uiSentCount = XUartLite_Send(pUartLite, szReplay+uiSentCountTotal, uiRestCount);
   uiSentCountTotal += uiSentCount;

   if (uiSentCountTotal == uiReplayCount)
      {
	  return XST_SUCCESS;
	  }
   goto again;

   }

//
// Receive Command
// function is blocked until '\r' character is received
//
int UartLiteReceiveCommand(XUartLite *pUartLite, u8 *szBuffer, unsigned int *uiReceivedCount, unsigned int uiMaxCount)
{
   //u32 CsrRegister;
   u8  data;
   unsigned int ReceivedCount = 0;

   *uiReceivedCount = ReceivedCount;
   /*
    * Receive the number of bytes which is transfered.
	* Data may be received in fifo with some delay hence we continuously
	* check the receive fifo for valid data and update the receive buffer
	* accordingly.
	*/
   while(1)
   {
		//wait until there is data
		while (XUartLite_IsReceiveEmpty(pUartLite->RegBaseAddress)) {;}
		//read data
		data = XUartLite_ReadReg(pUartLite->RegBaseAddress, XUL_RX_FIFO_OFFSET);

		//return if buffer overflow
		if(ReceivedCount == uiMaxCount)
		{
			return XST_FAILURE;
		}

		//take data
		szBuffer[ReceivedCount++] = data;
		*uiReceivedCount = ReceivedCount;

		//return if event character
		if(data == EV_RXFLAG)
		{
			return XST_SUCCESS;
		}
	}
}


bool UartLiteDataReady(XUartLite *pUartLite)
{
	if(XUartLite_IsReceiveEmpty(pUartLite->RegBaseAddress))
		return false;
	else
		return true;
}


uint8_t UartLiteRead(XUartLite *pUartLite)
{
	return ((uint8_t) XUartLite_ReadReg(pUartLite->RegBaseAddress, XUL_RX_FIFO_OFFSET));
}


