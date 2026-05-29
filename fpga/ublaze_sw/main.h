/*
 * main.h
 *
 *  Created on: Oct 21, 2019
 *      Author: M. Bogovac
 */

#ifndef SRC_MAIN_H_
#define SRC_MAIN_H_

#define DPP_REGISTERS_S00_AXI_SLV_REG0_OFFSET 0
#define DPP_REGISTERS_S00_AXI_SLV_REG1_OFFSET 4
#define DPP_REGISTERS_S00_AXI_SLV_REG2_OFFSET 8
#define DPP_REGISTERS_S00_AXI_SLV_REG3_OFFSET 12
#define DPP_REGISTERS_S00_AXI_SLV_REG4_OFFSET 16
#define DPP_REGISTERS_S00_AXI_SLV_REG5_OFFSET 20
#define DPP_REGISTERS_S00_AXI_SLV_REG6_OFFSET 24
#define DPP_REGISTERS_S00_AXI_SLV_REG7_OFFSET 28
#define DPP_REGISTERS_S00_AXI_SLV_REG8_OFFSET 32
#define DPP_REGISTERS_S00_AXI_SLV_REG9_OFFSET 36
#define DPP_REGISTERS_S00_AXI_SLV_REG10_OFFSET 40
#define DPP_REGISTERS_S00_AXI_SLV_REG11_OFFSET 44
#define DPP_REGISTERS_S00_AXI_SLV_REG12_OFFSET 48
#define DPP_REGISTERS_S00_AXI_SLV_REG13_OFFSET 52
#define DPP_REGISTERS_S00_AXI_SLV_REG14_OFFSET 56
#define DPP_REGISTERS_S00_AXI_SLV_REG15_OFFSET 60
#define DPP_REGISTERS_S00_AXI_SLV_REG16_OFFSET 64
#define DPP_REGISTERS_S00_AXI_SLV_REG17_OFFSET 68
#define DPP_REGISTERS_S00_AXI_SLV_REG18_OFFSET 72
#define DPP_REGISTERS_S00_AXI_SLV_REG19_OFFSET 76
#define DPP_REGISTERS_S00_AXI_SLV_REG20_OFFSET 80
#define DPP_REGISTERS_S00_AXI_SLV_REG21_OFFSET 84
#define DPP_REGISTERS_S00_AXI_SLV_REG22_OFFSET 88
#define DPP_REGISTERS_S00_AXI_SLV_REG23_OFFSET 92
#define DPP_REGISTERS_S00_AXI_SLV_REG24_OFFSET 96
#define DPP_REGISTERS_S00_AXI_SLV_REG25_OFFSET 100
#define DPP_REGISTERS_S00_AXI_SLV_REG26_OFFSET 104
#define DPP_REGISTERS_S00_AXI_SLV_REG27_OFFSET 108
#define DPP_REGISTERS_S00_AXI_SLV_REG28_OFFSET 112
#define DPP_REGISTERS_S00_AXI_SLV_REG29_OFFSET 116
#define DPP_REGISTERS_S00_AXI_SLV_REG30_OFFSET 120
#define DPP_REGISTERS_S00_AXI_SLV_REG31_OFFSET 124
#define DPP_REGISTERS_S00_AXI_SLV_REG32_OFFSET 128
#define DPP_REGISTERS_S00_AXI_SLV_REG33_OFFSET 132
#define DPP_REGISTERS_S00_AXI_SLV_REG34_OFFSET 136
#define DPP_REGISTERS_S00_AXI_SLV_REG35_OFFSET 140
#define DPP_REGISTERS_S00_AXI_SLV_REG36_OFFSET 144
#define DPP_REGISTERS_S00_AXI_SLV_REG37_OFFSET 148
#define DPP_REGISTERS_S00_AXI_SLV_REG38_OFFSET 152
#define DPP_REGISTERS_S00_AXI_SLV_REG39_OFFSET 156
#define DPP_REGISTERS_S00_AXI_SLV_REG40_OFFSET 160
#define DPP_REGISTERS_S00_AXI_SLV_REG41_OFFSET 164
#define DPP_REGISTERS_S00_AXI_SLV_REG42_OFFSET 168
#define DPP_REGISTERS_S00_AXI_SLV_REG43_OFFSET 172
#define DPP_REGISTERS_S00_AXI_SLV_REG44_OFFSET 176
#define DPP_REGISTERS_S00_AXI_SLV_REG45_OFFSET 180
#define DPP_REGISTERS_S00_AXI_SLV_REG46_OFFSET 184
#define DPP_REGISTERS_S00_AXI_SLV_REG47_OFFSET 188
#define DPP_REGISTERS_S00_AXI_SLV_REG48_OFFSET 192
#define DPP_REGISTERS_S00_AXI_SLV_REG49_OFFSET 196
#define DPP_REGISTERS_S00_AXI_SLV_REG50_OFFSET 200
#define DPP_REGISTERS_S00_AXI_SLV_REG51_OFFSET 204
#define DPP_REGISTERS_S00_AXI_SLV_REG52_OFFSET 208
#define DPP_REGISTERS_S00_AXI_SLV_REG53_OFFSET 212
#define DPP_REGISTERS_S00_AXI_SLV_REG54_OFFSET 216
#define DPP_REGISTERS_S00_AXI_SLV_REG55_OFFSET 220
#define DPP_REGISTERS_S00_AXI_SLV_REG56_OFFSET 224
#define DPP_REGISTERS_S00_AXI_SLV_REG57_OFFSET 228
#define DPP_REGISTERS_S00_AXI_SLV_REG58_OFFSET 232
#define DPP_REGISTERS_S00_AXI_SLV_REG59_OFFSET 236
#define DPP_REGISTERS_S00_AXI_SLV_REG60_OFFSET 240
#define DPP_REGISTERS_S00_AXI_SLV_REG61_OFFSET 244
#define DPP_REGISTERS_S00_AXI_SLV_REG62_OFFSET 248
#define DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET 252

typedef enum { PORT_1, PORT_2 } uart_id_t;
typedef enum { MODE_IDLE, BIN_ID, BIN_LEN_MSB, BIN_LEN_LSB, BIN_DATA, BIN_CRC1, BIN_CRC2, ASC_CMD1, ASC_CMD2, ASC_PAYLOAD} proto_state_t;

/* --- DATA STRUCTURES --- */
typedef struct
{
	XUartLite 		*pUartLite;
	proto_state_t 	state;
	u8 				buffer[MAX_BUF];
	char 			cmd[3]; // 2 chars + null
	u8 				id;
	unsigned int 	idx;
	unsigned int	len;
	uint16_t		crc_calc;
	unsigned int	last_byte_time;
} UART_Context;

void InitSoPC();
void InitPS();
void InitPL();

int GetCommandId(u8 *u8Buffer);
int GetCommandParameter(u8 *u8Command, unsigned int uiCommandSize, int iParameterId, char *szParameter);
int GetCommandParamaterArray(u8 *u8Command, unsigned int uiCommandSize, u32 *prmArray, int prmCnt);

void SendError(XUartLite *pUartLite, int iError);
void DoHostTasks(UART_Context *pctx);
void DoHostTasksEx(UART_Context *pctx, bool ready);

void DoCommand001(UART_Context *pctx);
void DoCommand002(UART_Context *pctx);
void DoCommand003(UART_Context *pctx);
void DoCommand004(UART_Context *pctx);
void DoCommand005(UART_Context *pctx);
void DoCommand006(UART_Context *pctx);
void DoCommand007(UART_Context *pctx);
void DoCommand008(UART_Context *pctx);
void DoCommand009(UART_Context *pctx);
void DoCommand010(UART_Context *pctx);
void DoCommand011(UART_Context *pctx);
void DoCommand012(UART_Context *pctx);
void DoCommand013(UART_Context *pctx);
void DoCommand014(UART_Context *pctx);
void DoCommand015(UART_Context *pctx);
void DoCommand018(UART_Context *pctx);
void DoCommand019(UART_Context *pctx);
void DoCommand020(UART_Context *pctx);
void DoCommand021(UART_Context *pctx);

static int SetHighVoltage(u32 u32Data);
static int SetAmplifierGainFine(u32 u32Data);
static int SetAmplifierGainCoarse(u32 u32Data);
static int SetAmplifierDacReferenceVoltage();
static int SetHvDacReferenceVoltage();
static u32 GetHighVoltage();
static u32 GetAmplifierGainFine();
static u32 GetAmplifierGainCoarse();
static void dpp_write_registers(int index_start, int index_end);
static void handle_ascii_command(UART_Context *pctx);

//
// variables defined in this module
//
//u8 u8Command[MEMORY_RX_BUFFER_SIZE];
u8 u8Replay[UART_TX_BUFFER_SIZE];

char *m_szCmdId[CMD_CNT]={"$FS", "$RS", "$SP", "$LS", "$FM", "$RM", "$AQ", "$WT", "$RT", "$CS", "$GP", "$GR", "$SR", "$VR", "$RL", "$ST", "$GT","$GV","$~~","$SN","$SS"};

UART_Context ctx0 = { .state = MODE_IDLE };
UART_Context ctx1 = { .state = MODE_IDLE };

ip_scope IpScope;
XBram Bram;

void ClearPlSpectrum(u32  base_addr);

#define PRM_TABLE_START_SHAPER_SLOW 	0
#define PRM_TABLE_END_SHAPER_SLOW 		16
#define PRM_TABLE_CNT_SHAPER_SLOW 		17
#define PRM_TABLE_START_SHAPER_SLOW_IP 	6
#define PRM_TABLE_END_SHAPER_SLOW_IP 	16
#define PRM_TABLE_CNT_SHAPER_SLOW_IP 	11

#define PRM_TABLE_START_PKD_SLOW 		17
#define PRM_TABLE_END_PKD_SLOW 			22
#define PRM_TABLE_CNT_PKD_SLOW 			6
#define PRM_TABLE_START_PKD_SLOW_IP 	18
#define PRM_TABLE_END_PKD_SLOW_IP 		22
#define PRM_TABLE_CNT_PKD_SLOW_IP 		5
#define PRM_TABLE_PKD_SLOW_FLAGS		22

#define PRM_TABLE_START_SCOPE 			23
#define PRM_TABLE_END_SCOPE 			32
#define PRM_TABLE_CNT_SCOPE 			10
#define PRM_TABLE_START_SCOPE_IP 		24
#define PRM_TABLE_END_SCOPE_IP 			32
#define PRM_TABLE_CNT_SCOPE_IP 			9

#define PRM_TABLE_START_TIMERS 			33
#define PRM_TABLE_END_TIMERS 			38
#define PRM_TABLE_CNT_TIMERS 			6
#define PRM_TABLE_START_TIMERS_IP 		33
#define PRM_TABLE_END_TIMERS_IP 		38
#define PRM_TABLE_START_TIMERS_WR_IP	37
#define PRM_TABLE_END_TIMERS_WR_IP		38
#define PRM_TABLE_CNT_TIMERS_IP 		6
#define PRM_TABLE_CNT_TIMERS_WR_IP		2
#define PRM_TABLE_TIMERS_CONTROL_REG	38

#define PRM_TABLE_START_BLR_SLOW 		39
#define PRM_TABLE_END_BLR_SLOW 			45
#define PRM_TABLE_CNT_BLR_SLOW 			7
#define PRM_TABLE_START_BLR_SLOW_IP 	39
#define PRM_TABLE_END_BLR_SLOW_IP 		45
#define PRM_TABLE_CNT_BLR_SLOW_IP 		7
#define PRM_TABLE_BLR_SLOW_FLAGS		40


#define PRM_TABLE_START_SCOPE_MUX 		46
#define PRM_TABLE_END_SCOPE_MUX 		46
#define PRM_TABLE_CNT_SCOPE_MUX 		1
#define PRM_TABLE_START_SCOPE_MUX_IP 	46
#define PRM_TABLE_END_SCOPE_MUX_IP 		46
#define PRM_TABLE_CNT_SCOPE_MUX_IP 		1

#define PRM_TABLE_START_DCS_SLOW 		47	//obsolete (not used)
#define PRM_TABLE_END_DCS_SLOW 			49	//obsolete (not used)
#define PRM_TABLE_CNT_DCS_SLOW 			3	//obsolete (not used)

#define PRM_TABLE_START_FORMATTER 		50
#define PRM_TABLE_END_FORMATTER 		51
#define PRM_TABLE_CNT_FORMATTER 		2
#define PRM_TABLE_START_FORMATTER_IP 	50
#define PRM_TABLE_END_FORMATTER_IP		51
#define PRM_TABLE_CNT_FORMATTER_IP		2


#define PRM_TABLE_START_SHAPER_FAST 	52
#define PRM_TABLE_END_SHAPER_FAST 		68
#define PRM_TABLE_CNT_SHAPER_FAST 		17
#define PRM_TABLE_START_SHAPER_FAST_IP 	58
#define PRM_TABLE_END_SHAPER_FAST_IP	68
#define PRM_TABLE_CNT_SHAPER_FAST_IP	11

#define PRM_TABLE_START_BLR_FAST 		69
#define PRM_TABLE_END_BLR_FAST 			73
#define PRM_TABLE_CNT_BLR_FAST 			5
#define PRM_TABLE_START_BLR_FAST_IP 	69
#define PRM_TABLE_END_BLR_FAST_IP 		73
#define PRM_TABLE_CNT_BLR_FAST_IP 		5
#define PRM_TABLE_BLR_FAST_FLAGS		70

#define PRM_TABLE_START_DCS_FAST 		74	//obsolete (not used)
#define PRM_TABLE_END_DCS_FAST 			76	//obsolete (not used)
#define PRM_TABLE_CNT_DCS_FAST 			3	//obsolete (not used)

#define PRM_TABLE_START_PKD_FAST 		77
#define PRM_TABLE_END_PKD_FAST 			82
#define PRM_TABLE_CNT_PKD_FAST 			6
#define PRM_TABLE_START_PKD_FAST_IP 	78
#define PRM_TABLE_END_PKD_FAST_IP 		82
#define PRM_TABLE_CNT_PKD_FAST_IP 		5
#define PRM_TABLE_PKD_FAST_FLAGS		82

#define PRM_TABLE_START_PUR 			83
#define PRM_TABLE_END_PUR 				85
#define PRM_TABLE_CNT_PUR 				3
#define PRM_TABLE_START_PUR_IP 			83
#define PRM_TABLE_END_PUR_IP 			85
#define PRM_TABLE_CNT_PUR_IP	 		3

#define PRM_TABLE_START_HV	 			86
#define PRM_TABLE_END_HV 				87
#define PRM_TABLE_CNT_HV 				2
#define IP_HV_PRM_INDEX_SET				0
#define IP_HV_PRM_INDEX_GET				1

#define PRM_TABLE_START_AMP	 			88
#define PRM_TABLE_END_AMP 				91
#define PRM_TABLE_CNT_AMP 				4
#define IP_AMP_PRM_INDEX_GAIN_FINE_SET			0
#define IP_AMP_PRM_INDEX_GAIN_FINE_GET			1
#define IP_AMP_PRM_INDEX_GAIN_COARSE_SET		2
#define IP_AMP_PRM_INDEX_GAIN_COARSE_GET		3

#define PRM_TABLE_SIZE 					92
u32 prm_table[PRM_TABLE_SIZE] =
{
	////////////////////////
	// Shaper slow: 17 parameters = 11 IP core + 6
	// $SP 1
	////////////////////////
/* 0-REGXX*/	20,			//Tclk: 			clock period time in nsec
/* 1-REGXX*/	220,		//Taur:				rise time of exponential input signal in nsec
/* 2-REGXX*/	1145,		//Taud:				decay time of exponential input signal in nsec
/* 3-REGXX*/	3000,		//Taupk:			trapezoid filter: peaking time in nsec
/* 4-REGXX*/	0,			//Taupk_top:		trapezoid flat top in nsec
/* 5-REGXX*/	33554432,	//gain;				gain at output of the filter
/* 6-reg_out_1-REG0*/		32973417, 	//b10: 				(exp(-Tclk/Taud,24,24);
/* 7-reg_out_2-REG1*/		1747,		//na_inv			(Tclk/Taupk,26,25)
/* 8-reg_out_3-REG2*/		147,		//na				Taupk/Tclk (10.0)
/* 9-reg_out_4-REG3*/		147,		//nb				(Taupk+taupk_top)/Tclk (10.0)
/*10-reg_out_5-REG4*/		16200338,	//U(1,32,24);		b20
/*11-reg_out_6-REG5*/		52921,		//U(1,14,13);		dc_offset_1
/*12-reg_out_7-REG6*/		30628364,	//U(0,25,25);		b2
/*13-reg_out_8-REG7*/		32090912,	//U(0,25,24);		b1
/*14-reg_out_9-REG8*/		33554334,	//U(0,25,25);		aa20
/*15-reg_out_10-REG9*/		0,			//U(0,32,0);		flags
/*16-reg_out_11-REG10*/		0,			//U(1,23,13);		dc_offset_2

	////////////////////////
	// Peak detector slow: 6 parameters = 1 APP + 5 IP core
	// $SP 2
	////////////////////////
/*17-REGXX*/	20,			//Tclk: 			clock period time in nsec
/*18-reg_out_19-REG18*/	135,		//blanking_time
/*19-reg_out_20-REG19*/	65,			//time_over_thrashold
/*20-reg_out_21-REG20*/	245,		//x_min 			= (0.01,16,14);
/*21-reg_out_22-REG21*/	32601,		//x_max 			= (1.99,16,14);
/*22-reg_out_23-REG22*/	1,			//flags 			= 1;

	////////////////////////
	// Scope: 10 parameters
	// $SP 3
	////////////////////////
/*23*/	20,			//Tclk: 			clock period time in nsec

/*24*/	2048,		//bram_size:		scope size
/*25*/	655,		//(-1,16,14);		threshold 1638 == 0.1, 49152 == -1
/*26*/	1000,		//delay				delay in clocks
/*27*/	1,			//enable			enable
/*28*/	1,			//clear
/*29*/	1,			//full
/*30*/	4,			//down_sample_rate	down sample rate
/*31*/	21, 			//sample_mode		sample mode
/*32*/	0, 			//trigger_mode		trigger mode

	////////////////////////
	// Timers: 2 parameters writing, 6 parameters reading
	// $SP 4
	////////////////////////
/*33-reg_out_48-REG47*/	0,			//timer A count		register 0: read only
/*34-reg_out_49-REG48*/	0,			//timer B count		register 1: read only
/*35-reg_out_50-REG49*/	0,			//timer C count		register 2: read only
/*36-reg_out_51-REG50*/	0,			//					register 3: b0=timers_enabled, b1=read only
/*37-reg_out_52-REG51*/	10000000,	//preset			register 4: r/w
/*38-reg_out_53-REG52*/	176,		//ctrl bits 		register 5: r/w: b01:start/stop; b234: timers a,b,c measure LT or RT; b567: enable/disable timers a,b,c

	////////////////////////
	// BLR slow: 7 parameters
	// $SP 5
	////////////////////////
/*39-reg_out_12-REG11*/	64717, 			//threshold (threshold high, threshold low)
/*40-reg_out_13-REG12*/	10,				//flags 	bit_0: rst, bit_1..2: blr speed
/*41-reg_out_14-REG13*/	768,			//threshold_gain
/*42-reg_out_15-REG14*/	1970476,		//preset
/*43-reg_out_16-REG15*/	8589,			//b0
/*44-reg_out_17-REG16*/	4294967123,		//a1
/*45-reg_out_18-REG17*/	12800,			//threshold_low_gain

	////////////////////////
	// Scope mux: 1 parameter
	// $SP 6
	////////////////////////
/*46-reg_out_54-REG53*/	19,

	////////////////////////
	// DCS slow: 3 parameters - obsolete
	// $SP 7
	////////////////////////
/*47*/	245, 		//threshold high
/*48*/	64717,		//threshold low
/*49*/	47,			//enable, shift		bit 6 = enable (bit 5, bit 4, bit 3, bit 2, bit 1) - shift

	////////////////////////
	// Formatter 2 parameter
	// $SP 8
	////////////////////////
/*50-reg_out_55-REG54*/	52921, 		//dc_offset		offset = bit 0 to 15
/*51-reg_out_56-REG55*/	2,			//bit0:invert=1;bit12:no average="00",average 2="01",average 4="10";average 8="11"
	////////////////////////
	// Shaper fast: 17 parameters = 11 IP core + 6
	// $SP 9
	////////////////////////
/*52-REGXX*/	20,			//Tclk: 			clock period time in nsec
/*53-REGXX*/	220,		//Taur:				rise time of exponential input signal in nsec
/*54-REGXX*/	1145,		//Taud:				decay time of exponential input signal in nsec
/*55-REGXX*/	200,		//Taupk:			trapezoid filter: peaking time in nsec
/*56-REGXX*/	0,			//Taupk_top:		trapezoid flat top in nsec
/*57-REGXX*/	33554432,	//gain;				gain at output of the filter

/*58-reg_out_24-REG23*/	32973417, 	//b10: 				(exp(-Tclk/Taud,24,24);
/*59-reg_out_25-REG24*/	26214,		//na_inv			(Tclk/Taupk,26,25)
/*60-reg_out_26-REG25*/	7,			//na				Taupk/Tclk (10.0)
/*61-reg_out_27-REG26*/	7,			//nb				(Taupk+taupk_top)/Tclk (10.0)
/*62-reg_out_28-REG27*/	16443768,	//U(1,32,24);		b20
/*63-reg_out_29-REG28*/	52921,		//U(1,14,13);		dc_offset_1
/*64-reg_out_30-REG29*/	0,			//U(0,25,25);		b2
/*65-reg_out_31-REG30*/	15319287,	//U(0,25,24);		b1
/*66-reg_out_32-REG31*/	0,			//U(0,25,25);		aa20
/*67-reg_out_33-REG32*/	0,			//U(0,32,0);		flags
/*68-reg_out_34-REG33*/	0,			//U(1,23,13);		dc_offset_2

	////////////////////////
	// BLR fast: 5 parameters
	// $SP 10
	////////////////////////
/*69-reg_out_35-REG34*/	64717,			//threshold (threshold high, threshold low)
/*70-reg_out_36-REG35*/	0,				//flags 	bit_0: rst=1, bit_1..2: blr speed
/*71-reg_out_37-REG36*/ 1536,			//threshold_gain
/*72-reg_out_38-REG37*/	85899,			//b0
/*73-reg_out_39-REG38*/	4294965577,		//a1

	////////////////////////
	// DCS fast: 3 parameters - obsolete
	// $SP 11
	////////////////////////
/*74*/	245, 		//threshold high
/*75*/	64717,		//threshold low
/*76*/	47,			//enable, shift		bit 6 = enable (bit 5, bit 4, bit 3, bit 2, bit 1) - shift

	////////////////////////
	// Peak detector fast: 6 parameters: 1 APP + 5 IP core
	// $SP 12
	////////////////////////
/*77-REGXX*/			20,			//Tclk: 			clock period time in nsec
/*78-reg_out_40-REG39*/	135,		//blanking_time 	(int) ((0.1*IpShaper.ConfigPtr->Taupk+IpShaper.ConfigPtr->Taupk_top)/(double)IpShaper.ConfigPtr->Tclk);		//trapezoid filter: peaking time in sec
/*79-reg_out_41-REG40*/	65,			//time_over_threshold		= (0.005,16,14);;
/*80-reg_out_42-REG41*/	65,			//x_min 			= (0.01,16,14);
/*81-reg_out_43-REG42*/	32601,		//x_max 			= (1.99,16,14);
/*82-reg_out_44-REG43*/	1,			//flags 			= 1;

	////////////////////////
	// PUR: 3 parameters
	// $SP 13
	////////////////////////
/*83-reg_out_45-REG44*/	225,
/*84-reg_out_46-REG45*/	1,
/*85-reg_out_47-REG46*/	20,

	////////////////////////
	// HV: 2 parameters
	// $SP 14
	////////////////////////
/*86*/	44564,		//set 850V  	VAL = ((850 * 65536) / 1250. + 0.5)	(VAL is set with 16 bit DAC);
/*87*/	2785,		//get HV		HV  = (1250.0 * VAL) / 4096.0		(VAL is measured with 12 bit ADC);

	////////////////////////
	// AMP
	// $SP 15 4 parameters
	////////////////////////
/*88*/	9930,		//fine gain  = 1		AD5693: VAL = (int) ((gain * 65536.0)/6.6 + 0.5), AD5697: VAL = (int) ((gain * 4096.0)/3.3 + 0.5)
/*89*/	9930,		//fine gain reading
/*90*/	9930,		//coarse gain  = 1		VAL = (int) ((gain * 4096.0)/3.3 + 0.5)
/*91*/	9930		//coarse gain reading

};


u32 prm_addr_table[PRM_TABLE_SIZE] =
{
////////////////////////
// Shaper slow: 17 parameters = 6 APP + 11 IP core
// $SP 1
////////////////////////
/*00-REGXX*/		0,			//Tclk: 			clock period time in nsec
/*01-REGXX*/		0,			//Taur:				rise time of exponential input signal in nsec
/*02-REGXX*/		0,			//Taud:				decay time of exponential input signal in nsec
/*03-REGXX*/		0,			//Taupk:			trapezoid filter: peaking time in nsec
/*04-REGXX*/		0,			//Taupk_top:		trapezoid flat top in nsec
/*05-REGXX*/		0,			//gain;				gain at output of the filter

/*06-reg_out_1-REG0*/		DPP_REGISTERS_S00_AXI_SLV_REG0_OFFSET, 			//b10: 				(exp(-Tclk/Taud,24,24);
/*07-reg_out_2-REG1*/		DPP_REGISTERS_S00_AXI_SLV_REG1_OFFSET,			//na_inv			(Tclk/Taupk,26,25)
/*08-reg_out_3-REG2*/		DPP_REGISTERS_S00_AXI_SLV_REG2_OFFSET,			//na				Taupk/Tclk (10.0)
/*09-reg_out_4-REG3*/		DPP_REGISTERS_S00_AXI_SLV_REG3_OFFSET,			//nb				(Taupk+taupk_top)/Tclk (10.0)
/*10-reg_out_5-REG4*/		DPP_REGISTERS_S00_AXI_SLV_REG4_OFFSET,			//U(1,32,24);		b20
/*11-reg_out_6-REG5*/		DPP_REGISTERS_S00_AXI_SLV_REG5_OFFSET,			//U(1,14,13);		dc_offset_1
/*12-reg_out_7-REG6*/		DPP_REGISTERS_S00_AXI_SLV_REG6_OFFSET,			//U(0,25,25);		b2
/*13-reg_out_8-REG7*/		DPP_REGISTERS_S00_AXI_SLV_REG7_OFFSET,			//U(0,25,24);		b1
/*14-reg_out_9-REG8*/		DPP_REGISTERS_S00_AXI_SLV_REG8_OFFSET,			//U(0,25,25);		aa20
/*15-reg_out_10-REG9*/		DPP_REGISTERS_S00_AXI_SLV_REG9_OFFSET,			//U(0,32,0);		flags
/*16-reg_out_11-REG10*/		DPP_REGISTERS_S00_AXI_SLV_REG10_OFFSET,			//U(1,23,13);		dc_offset_2

////////////////////////
// Peak detector slow: 1 APP + 5 IP core
// $SP 2
////////////////////////
/*17-REGXX*/		0,											//Tclk: clock period time in nsec
/*18-reg_out_19-REG18*/		DPP_REGISTERS_S00_AXI_SLV_REG18_OFFSET,		//x_delay = (int) ((0.1*IpShaper.ConfigPtr->Taupk+IpShaper.ConfigPtr->Taupk_top)/(double)IpShaper.ConfigPtr->Tclk);		//trapezoid filter: peaking time in sec
/*19-reg_out_20-REG19*/		DPP_REGISTERS_S00_AXI_SLV_REG19_OFFSET,		//x_time_over_threshold 	= (0.005,16,14);;
/*20-reg_out_21-REG20*/		DPP_REGISTERS_S00_AXI_SLV_REG20_OFFSET,		//x_min 			= (0.01,16,14);
/*21-reg_out_22-REG21*/		DPP_REGISTERS_S00_AXI_SLV_REG21_OFFSET,		//x_max 			= (1.99,16,14);
/*22-reg_out_23-REG22*/		DPP_REGISTERS_S00_AXI_SLV_REG22_OFFSET,		//flags 			= 1;

////////////////////////
// Scope: 10 parameters: 1 APP + 9 IP core
// $SP 3
////////////////////////
/*23*/		0,			//Tclk: 			clock period time in nsec
/*24*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//bram_size:		scope size
/*25*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//(-1,16,14);		threshold 1638 == 0.1, 49152 == -1
/*26*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//delay				delay in clocks
/*27*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//enable			enable
/*28*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//clear
/*29*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//full
/*30*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,		//down_sample_rate	down sample rate
/*31*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET, 	//sample_mode		sample mode
/*32*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET, 	//trigger_mode		trigger mode

////////////////////////
// Timers: 2 parameters writing, 6 parameters reading
// $SP 4
////////////////////////
/*33-reg_out_48-REG47*/		DPP_REGISTERS_S00_AXI_SLV_REG47_OFFSET,			//timer A count		register 0: read only
/*34-reg_out_49-REG48*/		DPP_REGISTERS_S00_AXI_SLV_REG48_OFFSET,			//timer B count		register 1: read only
/*35-reg_out_50-REG49*/		DPP_REGISTERS_S00_AXI_SLV_REG49_OFFSET,			//timer C count		register 2: read only
/*36-reg_out_51-REG50*/		DPP_REGISTERS_S00_AXI_SLV_REG50_OFFSET,			//					register 3: b0=timers_enabled, b1=read only
/*37-reg_out_52-REG51*/		DPP_REGISTERS_S00_AXI_SLV_REG51_OFFSET,			//preset			register 4: r/w
/*38-reg_out_53-REG52*/		DPP_REGISTERS_S00_AXI_SLV_REG52_OFFSET,			//ctrl bits 		register 5: r/w: b01:start/stop; b234: timers a,b,c measure LT or RT; b567: enable/disable timers a,b,c

////////////////////////
// BLR slow: 7 parameters
// $SP 5
////////////////////////
/*39-reg_out_12-REG11*/		DPP_REGISTERS_S00_AXI_SLV_REG11_OFFSET, 		//threshold (threshold high, threshold low)
/*40-reg_out_13-REG12*/		DPP_REGISTERS_S00_AXI_SLV_REG12_OFFSET,			//flags 	bit_0: rst, bit_1..2: blr speed
/*41-reg_out_14-REG13*/		DPP_REGISTERS_S00_AXI_SLV_REG13_OFFSET,			//threshold_gain
/*42-reg_out_15-REG14*/		DPP_REGISTERS_S00_AXI_SLV_REG14_OFFSET,			//preset,
/*43-reg_out_16-REG15*/		DPP_REGISTERS_S00_AXI_SLV_REG15_OFFSET,			//b0
/*44-reg_out_17-REG16*/		DPP_REGISTERS_S00_AXI_SLV_REG16_OFFSET,			//a1
/*45-reg_out_18-REG17*/		DPP_REGISTERS_S00_AXI_SLV_REG17_OFFSET,			//threshold_low_gain

////////////////////////
// Scope mux: 1 parameter
// $SP 6
////////////////////////
/*46-reg_out_54-REG53*/		DPP_REGISTERS_S00_AXI_SLV_REG53_OFFSET,

////////////////////////
// DCS slow: 3 parameters
// $SP 7
////////////////////////
/*47*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,
/*48*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,
/*49*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,

////////////////////////
// Formatter: 2 parameter
// $SP 8
////////////////////////
/*50-reg_out_55-REG54*/		DPP_REGISTERS_S00_AXI_SLV_REG54_OFFSET,
/*51-reg_out_56-REG55*/		DPP_REGISTERS_S00_AXI_SLV_REG55_OFFSET,

////////////////////////
// Shaper fast: 17 parameters = 11 IP core + 6
// $SP 9
////////////////////////
/*52-REG23*/		0,			//Tclk: 			clock period time in nsec
/*53-REGXX*/		0,			//Taur:				rise time of exponential input signal in nsec
/*54-REGXX*/		0,			//Taud:				decay time of exponential input signal in nsec
/*55-REGXX*/		0,			//Taupk:			trapezoid filter: peaking time in nsec
/*56-REGXX*/		0,			//Taupk_top:		trapezoid flat top in nsec
/*57-REGXX*/		0,			//gain;				gain at output of the filter

/*58-reg_out_24-REG23*/		DPP_REGISTERS_S00_AXI_SLV_REG23_OFFSET, 		//b10: 				(exp(-Tclk/Taud,24,24);
/*59-reg_out_25-REG24*/		DPP_REGISTERS_S00_AXI_SLV_REG24_OFFSET,			//na_inv			(Tclk/Taupk,26,25)
/*60-reg_out_26-REG25*/		DPP_REGISTERS_S00_AXI_SLV_REG25_OFFSET,			//na				Taupk/Tclk (10.0)
/*61-reg_out_27-REG26*/		DPP_REGISTERS_S00_AXI_SLV_REG26_OFFSET,			//nb				(Taupk+taupk_top)/Tclk (10.0)
/*62-reg_out_28-REG27*/		DPP_REGISTERS_S00_AXI_SLV_REG27_OFFSET,			//U(1,32,24);		b20
/*63-reg_out_29-REG28*/		DPP_REGISTERS_S00_AXI_SLV_REG28_OFFSET,			//U(1,14,13);		dc_offset_1
/*64-reg_out_30-REG29*/		DPP_REGISTERS_S00_AXI_SLV_REG29_OFFSET,			//U(0,25,25);		b2
/*65-reg_out_31-REG30*/		DPP_REGISTERS_S00_AXI_SLV_REG30_OFFSET,			//U(0,25,24);		b1
/*66-reg_out_32-REG31*/		DPP_REGISTERS_S00_AXI_SLV_REG31_OFFSET,			//U(0,25,25);		aa20
/*67-reg_out_33-REG32*/		DPP_REGISTERS_S00_AXI_SLV_REG32_OFFSET,			//U(0,32,0);		flags
/*68-reg_out_34-REG33*/		DPP_REGISTERS_S00_AXI_SLV_REG33_OFFSET,			//U(1,23,13);		dc_offset_2

////////////////////////
// BLR fast: 5 parameters
// $SP 10
////////////////////////
/*69-reg_out_35-REG34*/		DPP_REGISTERS_S00_AXI_SLV_REG34_OFFSET, 		//threshold (threshold high, threshold low)
/*70-reg_out_36-REG35*/		DPP_REGISTERS_S00_AXI_SLV_REG35_OFFSET,			//flags 	bit_0: rst=1, bit_1..2: blr speed
/*71-reg_out_37-REG36*/		DPP_REGISTERS_S00_AXI_SLV_REG36_OFFSET,			//threshold_gain
/*72-reg_out_38-REG37*/		DPP_REGISTERS_S00_AXI_SLV_REG37_OFFSET,			//b0
/*73-reg_out_39-REG38*/		DPP_REGISTERS_S00_AXI_SLV_REG38_OFFSET,			//a1

////////////////////////
// DCS fast: 3 parameters
// $SP 11
////////////////////////
/*74*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,
/*75*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,
/*76*/		DPP_REGISTERS_S00_AXI_SLV_REG63_OFFSET,

////////////////////////
// Peak detector fast: 6 parameters: 1 APP + 5 IP core
// $SP 12
////////////////////////
/*77*/		20,			//Tclk: 			clock period time in nsec

/*78-reg_out_40-REG39*/		DPP_REGISTERS_S00_AXI_SLV_REG39_OFFSET,		//x_delay 			(int) ((0.1*IpShaper.ConfigPtr->Taupk+IpShaper.ConfigPtr->Taupk_top)/(double)IpShaper.ConfigPtr->Tclk);		//trapezoid filter: peaking time in sec
/*79-reg_out_41-REG40*/		DPP_REGISTERS_S00_AXI_SLV_REG40_OFFSET,		//time_over_threshold 			= (0.005,16,14);;
/*80-reg_out_42-REG41*/		DPP_REGISTERS_S00_AXI_SLV_REG41_OFFSET,		//x_min 			= (0.01,16,14);
/*81-reg_out_43-REG42*/		DPP_REGISTERS_S00_AXI_SLV_REG42_OFFSET,		//x_max 			= (1.99,16,14);
/*82-reg_out_44-REG43*/		DPP_REGISTERS_S00_AXI_SLV_REG43_OFFSET,		//flags 			= 1;

////////////////////////
// PUR: 3 parameters
// $SP 13
////////////////////////
/*83-reg_out_45-REG44*/		DPP_REGISTERS_S00_AXI_SLV_REG44_OFFSET,
/*84-reg_out_46-REG45*/		DPP_REGISTERS_S00_AXI_SLV_REG45_OFFSET,
/*85-reg_out_47-REG46*/		DPP_REGISTERS_S00_AXI_SLV_REG46_OFFSET,

////////////////////////
// HV: 2 parameters
// $SP 14
////////////////////////
/*86*/		0,		//set 850V  	VAL = ((850 * 65536) / 1250. + 0.5)	(VAL is set with 16 bit DAC);
/*87*/		0,		//get HV		HV  = (1250.0 * VAL) / 4096.0		(VAL is measured with 12 bit ADC);

////////////////////////
// AMP
// $SP 15 4 parameters
////////////////////////
/*88*/		0,		//fine gain  = 1		AD5693: VAL = (int) ((gain * 65536.0)/6.6 + 0.5), AD5697: VAL = (int) ((gain * 4096.0)/3.3 + 0.5)
/*89*/		0,		//fine gain reading
/*90*/		0,		//coarse gain  = 1		VAL = (int) ((gain * 4096.0)/3.3 + 0.5)
/*91*/		0		//coarse gain reading
};

#endif /* SRC_MAIN_H_ */



