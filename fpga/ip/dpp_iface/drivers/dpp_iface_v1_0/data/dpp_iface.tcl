
# This command maps HW parameters to XPAR_ macros in xparameters.h
proc generate {drv_handle} {
	# 1. Define the instance-specific parameters
    ::hsi::utils::define_include_file $drv_handle "xparameters.h" "dpp_iface" \
        "NUM_INSTANCES" \
        "DEVICE_ID" \
        "C_S_AXI_BASEADDR" \
        "C_S_AXI_HIGHADDR"
	
	# 2. Define canonical parameters (Crucial for generic driver code)
    ::hsi::utils::define_canonical_xpars $drv_handle "xparameters.h" "dpp_iface" \
        "DEVICE_ID" \
        "C_S_AXI_BASEADDR" \
        "C_S_AXI_HIGHADDR"
}

