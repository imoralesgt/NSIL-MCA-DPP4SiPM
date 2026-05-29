/*
 * uart.h
 *
 *  Created on: Nov 13, 2019
 *      Author: M.Bogovac
 */

#ifndef SRC_UART_H_
#define SRC_UART_H_

//
// methods defined in this modules
//
int UartLiteInit(u16 DeviceId, XUartLite *pUartLite);
int UartLiteSendReply(XUartLite *pUartLite, u8 *szReplay, unsigned int uiReplayCount);
int UartLiteReceiveCommand(XUartLite *pUartLite, u8 *szCommand, unsigned int *uiReceivedCount, unsigned int uiMaxCount);

#endif /* SRC_UART_H_ */
