/*
 * intc.h
 *
 *  Created on: Oct 21, 2019
 *      Author: boss
 */

#ifndef SRC_INTC_H_
#define SRC_INTC_H_


#include "xintc.h"					//Contains the API for using the AxI interrupt controller


//
// methods defined in this module
//
int IntcPSInit(u16 DeviceId);
void IntcDisableInterrupt(u32 IntId);
void IntcEnableInterrupt(u32 IntId);
int IntcIsWaveformReady();

#endif /* SRC_INTC_H_ */






