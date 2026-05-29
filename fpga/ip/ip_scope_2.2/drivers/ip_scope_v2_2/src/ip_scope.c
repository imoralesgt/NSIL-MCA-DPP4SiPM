#include "ip_scope.h"


int ip_scope_CfgInitialize(ip_scope *InstancePtr, ip_scope_Config *ConfigPtr)
{
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

	/* Clear instance memory and make copy of configuration*/
	memset(InstancePtr, 0, sizeof(ip_scope));
	memcpy(&InstancePtr->Config, ConfigPtr, sizeof(ip_scope_Config));

    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;
 	
    return XST_SUCCESS;
}

static u32 ip_scope_offset[IP_SCOPE_PRM_CNT] =
{
	0								, //Tclk
	0								, //bram_size
	(IP_SCOPE_R4_THRESHOLD)			, //threshold
	(IP_SCOPE_R6_DELAY)				, //delay
	(IP_SCOPE_R5_ENABLE)			, //enable
	(IP_SCOPE_R7_CLEAR)				, //clear
	(IP_SCOPE_R8_FULL) 		  		, //full
	(IP_SCOPE_R9_DOWN_SAMPLE_RATE)	, //down_sample_rate
	(IP_SCOPE_R10_SAMPLE_MODE) 		, //sample_mode
	(IP_SCOPE_R11_TRIGGER_MODE)		  //trigger_mode
	
};

// register read/write access
// bit 0: 1=Readable 0=not readable
// bit 1: 1=writable 0=not writable
static int ip_scope_rw[IP_SCOPE_PRM_CNT] =
{
	0,	//Tclk
	0,	//bram_size
	3,	//threahold
	3,	//delay
	3,	//enable
	3,	//clear
	1,	//full
	3,	//down_sample_rate
	3,	//sample_mode
	3	//trigger_mode
};

//
// read from registers
//
void ip_scope_ReadLogic(ip_scope *scope)
{
	u32 baseaddr;
	u32 *prm;
	int i, r;

	baseaddr = scope->Config.BaseAddress;
	prm = scope->Config.prm;
	
	for(i=0;i<IP_SCOPE_PRM_CNT;i++)
	{
		//read parameter from Logic if parameter is readable
		r = (ip_scope_rw[i] & 1);
		if ( r != 1) continue;
		//u32 *addr = baseaddr + ip_scope_offset[i];
		//prm[i] = *( (volatile u32*)(addr) );
		prm[i] = ip_scope_ReadReg(baseaddr, ip_scope_offset[i]);
	}
}

//
// write to registers
//
void ip_scope_WriteLogic(ip_scope *scope)
{
	u32 baseaddr;
	u32 *prm;
	int i, r;

	baseaddr = scope->Config.BaseAddress;
	prm = scope->Config.prm;
	
	for(i=0;i<IP_SCOPE_PRM_CNT;i++)
	{
		//write parameter to the Logic if parameter is writable
		r = (ip_scope_rw[i] & 2);
		if ( r != 2) continue;
		//u32 *addr = baseaddr + ip_scope_offset[i];
		//*( (volatile u32*)(addr) ) = prm[i];
		ip_scope_WriteReg(baseaddr, ip_scope_offset[i], prm[i]);
	}
}

void ip_scope_Acq(ip_scope *scope, int enable)
{
	int status;
	u32 baseaddr = scope->Config.BaseAddress;

	//start
	if(enable == 1)
	{
		//disable fifo controller:
		//it will set flag "full" to 0 and reset address to 0
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) ) ) = 0;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R5_ENABLE), 0);

		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R5_ENABLE));

		//set "clear" flag to 1
		//*(volatile u32*)(baseaddr + (IP_SCOPE_R7_CLEAR)) = 1;
		ip_scope_WaveformAccepted(scope);

		//enable fifo controller
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) ) ) = 1;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R5_ENABLE), 1);
		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R5_ENABLE));
	}
	//stop
	else
	{
		//disable fifo controller
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) ) ) = 0;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R5_ENABLE), 0);
		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R5_ENABLE) )	);
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R5_ENABLE));
	}
}

void ip_scope_WaveformAccepted(ip_scope *scope)
{
	int status;
	u32 baseaddr = scope->Config.BaseAddress;
	
	// clear flag must go low and than high
	//
	//set clear flag to 0
	while(1)
	{
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) ) ) = 0;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R7_CLEAR), 0);
		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R7_CLEAR));
		if(status == 0) break;
	}

	//set clear flag to 1
	while(1)
	{
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) ) ) = 1;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R7_CLEAR), 1);
		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) )	);
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R7_CLEAR));
		if(status == 1) break;
	}
	//set clear flag to 0
	while(1)
	{
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) ) ) = 0;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R7_CLEAR), 0);
		status = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R7_CLEAR) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R7_CLEAR));
		if(status == 0) break;
	}
}

void ip_scope_ReadWaveform(ip_scope *scope, unsigned int *wave_data)
{
	int i, size;
	u32 baseaddr = scope->Config.BaseAddress;
	size = scope->Config.prm[IP_SCOPE_PRM_INDEX_BRAM_SIZE];

	//read enable
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R2_WEA	) ) ) = 0;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R2_WEA), 0);

	for(i=0; i< size;i++)
	{
		//write address
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R1_ADDRA) ) ) = i;
		ip_scope_WriteReg(baseaddr, (IP_SCOPE_R1_ADDRA), i);

		//read data
		wave_data[i] = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R12_DOUTA) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R12_DOUTA));
	}
}

int ip_scope_IsWaveformReady(ip_scope *scope)
{
	u32 baseaddr = scope->Config.BaseAddress;
	int ready;

		ready = 
		//*( (volatile u32*) ( baseaddr + (IP_SCOPE_R8_FULL	) ) );
		ip_scope_ReadReg(baseaddr, (IP_SCOPE_R8_FULL));
	
	return (ready);
}

