/*
 * define.h
 *
 *  Created on: Oct 21, 2019
 *      Author: boss
 */

#ifndef SRC_DEFINE_H_
#define SRC_DEFINE_H_

#define CMD_SET_PARAMETERS 	3
#define CMD_LOAD_SCOPE 		4
#define CMD_READ_SPECTRUM 	6
#define CMD_ACQ_START_STOP 	7
#define CMD_READ_TIMERS 	9
#define CMD_CLEAR_SPECTRUM 	10
#define CMD_GET_PARAMETERS 	11
#define CMD_GET_VERSION 	18
#define CMD_KEEP_ALIVE		19
#define CMD_GET_SERIAL_NUM	20
#define CMD_SET_SERIAL_NUM	21


#define MEMORY_RX_BUFFER_SIZE 512  //CMD_MAXCNT 256
#define MEMORY_TX_BUFFER_SIZE 8196 //8192+4 spectrum+4bytes ('!L\n\r' or '\R\n\r')
//for ROI: 1023x12 + preffix (2) + size (2) + suffix (2)
#define UART_TX_BUFFER_SIZE 12300

#define BRAM_SPECTRUM_SIZE 2048
#define CMD_CNT 21

#define ERROR_INVALID_COMMAND 0
#define ERROR_INVALID_COMMAND_PARAMETER 1
#define ERROR_SCOPE_DATA_NOT_READY 2

#define IIC_TRIALS_NUM 4

#define EV_RXFLAG 			((u8) 13)

/*
 BINARY DATA FORMAT
 | 0    |  1  |  2   |  3   |  4      |  5      | ....    | LEN + 6 | LEN + 7 |
 | 0xF5 |0xFA | MID1 | MID2 | LEN_MSB | LEN_LSB | PAYLOAD | CHKSUM1 | CHKSUM2 |
 ASCI DATA FORMAT
 |   $  |MID1 | MID2 |PAYLOAD|\n\r\
*/

/* --- CONFIGURATION --- */
#define SYNC_BIN 0xAA
#define SYNC_ASC '$'
#define MAX_BUF 512
#define TIMEOUT_MS 50

#endif /* SRC_DEFINE_H_ */

