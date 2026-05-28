/*
 * iic.h
 *
 *  Created on: May 22, 2023
 *      Author: Mladen
 */

#ifndef SRC_IIC_H_
#define SRC_IIC_H_

void *Iic_GetCallbackRef();
int Iic_Init(u16 DeviceId);
void Iic_SetupInterruptHandlers();
int Iic_SendBytes (u8 * buffer_to_send, int byte_to_send);
int Iic_DynamicSendBytes (u8 * buffer_to_send, int byte_to_send);
int Iic_DynamicSendBytesRepeatedStart (u8 * buffer_to_send, int byte_to_send);
int Iic_SendBytesRepeatedStart (u8 * buffer_to_send, int byte_to_send);
int Iic_RecvBytes (u8 *buffer_to_recv, int byte_to_recv);
int Iic_DynamicRecvBytes (u8 *buffer_to_recv, int byte_to_recv);
int Iic_RecvBytesRepeatedStart (u8 *buffer_to_recv, int byte_to_recv);
void Iic_SetAddress(int Address);
int Iic_Start();
int Iic_Stop();

#endif /* SRC_IIC_H_ */
