/**
* @file ip_scope_sinit.c
*
* The implementation of the ip_scope driver's static initialzation
* functionality.
*
* @note
*
* None
*
*/

#include "xstatus.h"
#include "xparameters.h"
#include "ip_scope.h"
extern ip_scope_Config ip_scope_ConfigTable[];
/**
* Lookup the device configuration based on the unique device ID.  The table
* ConfigTable contains the configuration info for each device in the system.
*
* @param DeviceId is the device identifier to lookup.
*
* @return
*     - A pointer of data type ip_scope_Config which
*    points to the device configuration if DeviceID is found.
*    - NULL if DeviceID is not found.
*
* @note    None.
*
*/
ip_scope_Config *ip_scope_LookupConfig(u16 DeviceId) {
    ip_scope_Config *ConfigPtr = NULL;
    int Index;
    for (Index = 0; Index < XPAR_IP_SCOPE_NUM_INSTANCES; Index++) {
        if (ip_scope_ConfigTable[Index].DeviceId == DeviceId) {
            ConfigPtr = &ip_scope_ConfigTable[Index];
            break;
        }
    }
    return ConfigPtr;
}
int ip_scope_Initialize(ip_scope *InstancePtr, u16 DeviceId) {
    ip_scope_Config *ConfigPtr;
    Xil_AssertNonvoid(InstancePtr != NULL);
    ConfigPtr = ip_scope_LookupConfig(DeviceId);
    if (ConfigPtr == NULL) {
        InstancePtr->IsReady = 0;
        return (XST_DEVICE_NOT_FOUND);
    }
    return ip_scope_CfgInitialize(InstancePtr, ConfigPtr);
}

