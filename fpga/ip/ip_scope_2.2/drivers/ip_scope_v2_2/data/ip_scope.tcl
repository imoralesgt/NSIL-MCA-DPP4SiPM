proc generate {drv_handle} {
    xdefine_include_file $drv_handle "xparameters.h" "ip_scope" "NUM_INSTANCES" "DEVICE_ID" "C_AXIBUSDOMAIN_S_AXI_BASEADDR" "C_AXIBUSDOMAIN_S_AXI_HIGHADDR" 
    xdefine_config_file $drv_handle "ip_scope_g.c" "ip_scope" "DEVICE_ID" "C_AXIBUSDOMAIN_S_AXI_BASEADDR" 
    xdefine_canonical_xpars $drv_handle "xparameters.h" "ip_scope" "DEVICE_ID" "C_AXIBUSDOMAIN_S_AXI_BASEADDR" "C_AXIBUSDOMAIN_S_AXI_HIGHADDR" 

}