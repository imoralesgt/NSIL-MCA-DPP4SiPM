#ifndef IP_SCOPE__H
#define IP_SCOPE__H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#include "ip_scope_hw.h"

/**************************** Type Definitions ******************************/
#define IP_SCOPE_PRM_CNT 					10
#define IP_SCOPE_PRM_INDEX_TCLK 			0
#define IP_SCOPE_PRM_INDEX_BRAM_SIZE 		1
#define IP_SCOPE_PRM_INDEX_THRESHOLD 		2
#define IP_SCOPE_PRM_INDEX_DELAY	 		3
#define IP_SCOPE_PRM_INDEX_ENABLE	 		4
#define IP_SCOPE_PRM_INDEX_CLEAR	 		5
#define IP_SCOPE_PRM_INDEX_FULL		 		6
#define IP_SCOPE_PRM_INDEX_DOWN_SAMPLE_RATE 7
#define IP_SCOPE_PRM_INDEX_SAMPLE_MODE 		8
#define IP_SCOPE_PRM_INDEX_TRIGGER_MODE		9

typedef struct
{
    u16 DeviceId;
    u32 BaseAddress;

//***************************************************
// user defined parameters
//***************************************************
//    prm[0] Tclk;				//clock period
//    prm[1] bram_size; 		//size in 32 bit words	
//    prm[2] threshold;			//trigger threshold
//    prm[3] delay;				//tigger delay in microsec
//    prm[4] enable;			//enable flag
//    prm[5] clear;				//clear flag
//    prm[6] full;				//fifo full flag
//    prm[7] down_sample_rate;	//down sample rate 
//    prm[8] sample_mode;		//sample mode
//    prm[9] trigger_mode		//trigger mode
	u32 prm[IP_SCOPE_PRM_CNT];
	
} ip_scope_Config;

/**
* The ip_scope driver instance data. The user is required to
* allocate a variable of this type for every ip_scope device in the system.
* A pointer to a variable of this type is then passed to the driver
* API functions.
*/
typedef struct {
	ip_scope_Config Config;
    u32 IsReady;
} ip_scope;

/***************** Macros (Inline Functions) Definitions *********************/

#define ip_scope_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define ip_scope_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))

/************************** Function Prototypes *****************************/
int ip_scope_Initialize(ip_scope *InstancePtr, u16 DeviceId);
ip_scope_Config* ip_scope_LookupConfig(u16 DeviceId);
int ip_scope_CfgInitialize(ip_scope *InstancePtr, ip_scope_Config *ConfigPtr);

void ip_scope_WriteLogic(ip_scope *scope);
void ip_scope_ReadLogic(ip_scope *scope);

void ip_scope_Acq(ip_scope *scope, int enable);
void ip_scope_WaveformAccepted(ip_scope *scope);
void ip_scope_ReadWaveform(ip_scope *scope, unsigned int *wave_data);

#ifdef __cplusplus
}
#endif

#endif