#ifndef DPP_IFACE_H
#define DPP_IFACE_H

#include "xil_types.h"
#include "xil_io.h"
#include "xparameters.h"

// Example Register Offsets
#define DPP_IFACE_REG0_OFFSET 0
#define DPP_IFACE_REG1_OFFSET 4

// Standard Write/Read Macros
#define DPP_IFACE_mWriteReg(BaseAddress, RegOffset, Data) \
  	Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))

#define DPP_IFACE_mReadReg(BaseAddress, RegOffset) \
  	Xil_In32((BaseAddress) + (RegOffset))

#endif