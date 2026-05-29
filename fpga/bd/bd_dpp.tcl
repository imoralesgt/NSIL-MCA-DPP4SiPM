
################################################################
# This is a generated script based on design: design_1
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2022.2
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_gid_msg -ssname BD::TCL -id 2041 -severity "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source design_1_script.tcl

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xc7a35tcpg236-1
   set_property BOARD_PART digilentinc.com:cmod_a7-35t:part0:1.2 [current_project]
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name design_1

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_gid_msg -ssname BD::TCL -id 2001 -severity "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_gid_msg -ssname BD::TCL -id 2002 -severity "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_gid_msg -ssname BD::TCL -id 2003 -severity "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_gid_msg -ssname BD::TCL -id 2004 -severity "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_gid_msg -ssname BD::TCL -id 2005 -severity "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_gid_msg -ssname BD::TCL -id 2006 -severity "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:clk_wiz:6.0\
iaea.org:user:dpp_iface:1.0\
xilinx.com:ip:axi_iic:2.1\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:microblaze:11.0\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:ila:6.2\
xilinx.com:user:ip_dbg_pha:1.0\
IAEA:user:timers:1.0\
iaea.org:user:wire_timers:1.0\
IAEA:user:blr_fast:1.0\
iaea.org:user:ip_dbg_pulse_cond_fast:1.0\
IAEA:user:shaper:3.0\
iaea.org:user:wire_blr_fast:1.0\
iaea.org:user:blr:2.0\
iaea.org:interface:ip_dbg_pulse_cond_slow:1.0\
iaea.org:user:Formatter:1.0\
iaea.org:user:ip_dbg_invert_and_offset:1.0\
User_Company:SysGen:ip_scope:2.2\
iaea.org:user:scope_mux:1.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:util_reduced_logic:2.0\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:axi_bram_ctrl:4.1\
iaea.org:user:bram_incr:1.0\
IAEA:user:peak_detector:3.0\
iaea.org:user:wire_peak_detector_slow:1.0\
IAEA:user:pur:1.0\
iaea.org:user:wire_peak_detector_fast:1.0\
iaea.org:user:wire_pur:1.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:xlslice:1.0\
xilinx.com:ip:c_shift_ram:12.0\
"

   set list_ips_missing ""
   common::send_gid_msg -ssname BD::TCL -id 2011 -severity "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_gid_msg -ssname BD::TCL -id 2012 -severity "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

if { $bCheckIPsPassed != 1 } {
  common::send_gid_msg -ssname BD::TCL -id 2023 -severity "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: shift
proc create_hier_cell_shift { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_shift() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 9 -to 0 -type data A
  create_bd_pin -dir I -type clk clk_dpp
  create_bd_pin -dir I -from 15 -to 0 -type data x
  create_bd_pin -dir O -from 15 -to 0 -type data x_out

  # Create instance: c_shift_ram_0, and set properties
  set c_shift_ram_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:c_shift_ram:12.0 c_shift_ram_0 ]
  set_property -dict [list \
    CONFIG.AsyncInitVal {0000000000000000} \
    CONFIG.DefaultData {0000000000000000} \
    CONFIG.Depth {1024} \
    CONFIG.ShiftRegType {Variable_Length_Lossless} \
  ] $c_shift_ram_0


  # Create port connections
  connect_bd_net -net ShiftRegisterControl_0_shift_value [get_bd_pins A] [get_bd_pins c_shift_ram_0/A]
  connect_bd_net -net c_shift_ram_0_Q [get_bd_pins x_out] [get_bd_pins c_shift_ram_0/Q]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins c_shift_ram_0/CLK]
  connect_bd_net -net x_1 [get_bd_pins x] [get_bd_pins c_shift_ram_0/D]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pur
proc create_hier_cell_pur { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pur() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:peak_detector_fast_rtl:1.0 peak_detector_fast

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:pur_rtl:1.0 pur


  # Create pins
  create_bd_pin -dir I clk_cpui_aresetn
  create_bd_pin -dir I -type clk clk_dpp
  create_bd_pin -dir O -from 1 -to 0 lt_dir
  create_bd_pin -dir O -from 15 -to 0 -type data peak_amp
  create_bd_pin -dir O -from 0 -to 0 -type data peak_amp_rdy
  create_bd_pin -dir O rejectn
  create_bd_pin -dir I -from 15 -to 0 -type data threshold1
  create_bd_pin -dir I -from 15 -to 0 -type data x_f
  create_bd_pin -dir O -from 15 -to 0 -type data x_out
  create_bd_pin -dir I -from 15 -to 0 -type data x_s

  # Create instance: peak_detector_0, and set properties
  set peak_detector_0 [ create_bd_cell -type ip -vlnv IAEA:user:peak_detector:3.0 peak_detector_0 ]

  # Create instance: pur_0, and set properties
  set pur_0 [ create_bd_cell -type ip -vlnv IAEA:user:pur:1.0 pur_0 ]

  # Create instance: shift
  create_hier_cell_shift $hier_obj shift

  # Create instance: wire_peak_detector_f_0, and set properties
  set wire_peak_detector_f_0 [ create_bd_cell -type ip -vlnv iaea.org:user:wire_peak_detector_fast:1.0 wire_peak_detector_f_0 ]

  # Create instance: wire_pur_0, and set properties
  set wire_pur_0 [ create_bd_cell -type ip -vlnv iaea.org:user:wire_pur:1.0 wire_pur_0 ]

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [list \
    CONFIG.DIN_FROM {9} \
    CONFIG.DOUT_WIDTH {10} \
  ] $xlslice_0


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pur] [get_bd_intf_pins wire_pur_0/pur]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins peak_detector_fast] [get_bd_intf_pins wire_peak_detector_f_0/peak_detector_fast]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins peak_detector_0/clk] [get_bd_pins pur_0/clk] [get_bd_pins shift/clk_dpp]
  connect_bd_net -net peak_detector_0_peak_amp [get_bd_pins peak_amp] [get_bd_pins peak_detector_0/peak_amp]
  connect_bd_net -net peak_detector_0_peak_amp_rdy [get_bd_pins peak_amp_rdy] [get_bd_pins peak_detector_0/peak_amp_rdy] [get_bd_pins pur_0/amp_rdy]
  connect_bd_net -net pur_0_lt_dir [get_bd_pins lt_dir] [get_bd_pins pur_0/lt_dir]
  connect_bd_net -net pur_0_reject_n [get_bd_pins rejectn] [get_bd_pins pur_0/reject_n]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins clk_cpui_aresetn] [get_bd_pins pur_0/reset_n]
  connect_bd_net -net shift_x_out [get_bd_pins x_out] [get_bd_pins shift/x_out]
  connect_bd_net -net threshold1_1 [get_bd_pins threshold1] [get_bd_pins peak_detector_0/threshold]
  connect_bd_net -net wire_peak_detector_f_0_r1_blanking_time_out [get_bd_pins peak_detector_0/r1_blanking_time] [get_bd_pins wire_peak_detector_f_0/r1_blanking_time_out]
  connect_bd_net -net wire_peak_detector_f_0_r2_time_over_threshold_out [get_bd_pins peak_detector_0/r2_time_over_threshold] [get_bd_pins wire_peak_detector_f_0/r2_time_over_threshold_out]
  connect_bd_net -net wire_peak_detector_f_0_r3_xmin_out [get_bd_pins peak_detector_0/r3_x_min] [get_bd_pins wire_peak_detector_f_0/r3_xmin_out]
  connect_bd_net -net wire_peak_detector_f_0_r4_xmax_out [get_bd_pins peak_detector_0/r4_x_max] [get_bd_pins wire_peak_detector_f_0/r4_xmax_out]
  connect_bd_net -net wire_peak_detector_f_0_r5_flags_out [get_bd_pins peak_detector_0/r5_flags] [get_bd_pins wire_peak_detector_f_0/r5_flags_out]
  connect_bd_net -net wire_pur_0_r1_preset_out [get_bd_pins pur_0/r1_preset] [get_bd_pins wire_pur_0/r1_preset_out]
  connect_bd_net -net wire_pur_0_r2_flags_out [get_bd_pins pur_0/r2_flags] [get_bd_pins wire_pur_0/r2_flags_out]
  connect_bd_net -net wire_pur_0_r3_delay_out [get_bd_pins wire_pur_0/r3_delay_out] [get_bd_pins xlslice_0/Din]
  connect_bd_net -net x_1 [get_bd_pins x_f] [get_bd_pins peak_detector_0/x]
  connect_bd_net -net x_2 [get_bd_pins x_s] [get_bd_pins shift/x]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins peak_detector_0/threshold_invalid_n] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_pins shift/A] [get_bd_pins xlslice_0/Dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pkd
proc create_hier_cell_pkd { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pkd() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:peak_detector_slow_rtl:1.0 peak_detector_slow


  # Create pins
  create_bd_pin -dir I -type clk clk_cpu
  create_bd_pin -dir I -type rst clk_cpu_aresetn
  create_bd_pin -dir I -type clk clk_dpp
  create_bd_pin -dir O -from 15 -to 0 -type data peak_amp
  create_bd_pin -dir O -from 0 -to 0 -type data peak_amp_rdy
  create_bd_pin -dir I -from 15 -to 0 -type data threshold
  create_bd_pin -dir I -type data threshold_invalid_n
  create_bd_pin -dir I -from 15 -to 0 -type data x

  # Create instance: peak_detector_0, and set properties
  set peak_detector_0 [ create_bd_cell -type ip -vlnv IAEA:user:peak_detector:3.0 peak_detector_0 ]

  # Create instance: wire_peak_detector_s_0, and set properties
  set wire_peak_detector_s_0 [ create_bd_cell -type ip -vlnv iaea.org:user:wire_peak_detector_slow:1.0 wire_peak_detector_s_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins peak_detector_slow] [get_bd_intf_pins wire_peak_detector_s_0/peak_detector_slow]

  # Create port connections
  connect_bd_net -net D_1 [get_bd_pins x] [get_bd_pins peak_detector_0/x]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins peak_detector_0/clk]
  connect_bd_net -net peak_detector_0_peak_amp [get_bd_pins peak_amp] [get_bd_pins peak_detector_0/peak_amp]
  connect_bd_net -net peak_detector_0_peak_amp_rdy [get_bd_pins peak_amp_rdy] [get_bd_pins peak_detector_0/peak_amp_rdy]
  connect_bd_net -net threshold_1 [get_bd_pins threshold] [get_bd_pins peak_detector_0/threshold]
  connect_bd_net -net threshold_invalid_n_1 [get_bd_pins threshold_invalid_n] [get_bd_pins peak_detector_0/threshold_invalid_n]
  connect_bd_net -net wire_peak_detector_s_0_r1_blanking_time_out [get_bd_pins peak_detector_0/r1_blanking_time] [get_bd_pins wire_peak_detector_s_0/r1_blanking_time_out]
  connect_bd_net -net wire_peak_detector_s_0_r2_time_over_threshold_out [get_bd_pins peak_detector_0/r2_time_over_threshold] [get_bd_pins wire_peak_detector_s_0/r2_time_over_threshold_out]
  connect_bd_net -net wire_peak_detector_s_0_r3_xmin_out [get_bd_pins peak_detector_0/r3_x_min] [get_bd_pins wire_peak_detector_s_0/r3_xmin_out]
  connect_bd_net -net wire_peak_detector_s_0_r4_xmax_out [get_bd_pins peak_detector_0/r4_x_max] [get_bd_pins wire_peak_detector_s_0/r4_xmax_out]
  connect_bd_net -net wire_peak_detector_s_0_r5_flags_out [get_bd_pins peak_detector_0/r5_flags] [get_bd_pins wire_peak_detector_s_0/r5_flags_out]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mca
proc create_hier_cell_mca { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mca() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S09_AXI


  # Create pins
  create_bd_pin -dir I -type clk clk_cpu
  create_bd_pin -dir I -type rst clk_cpu_arestn
  create_bd_pin -dir I clk_dpp
  create_bd_pin -dir I -from 15 -to 0 -type data peak_amp
  create_bd_pin -dir I peak_amp_rdy
  create_bd_pin -dir I segment

  # Create instance: axi_bram_ctrl_0, and set properties
  set axi_bram_ctrl_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_bram_ctrl:4.1 axi_bram_ctrl_0 ]
  set_property CONFIG.SINGLE_PORT_BRAM {1} $axi_bram_ctrl_0


  # Create instance: blk_mem_gen_0, and set properties
  set blk_mem_gen_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 blk_mem_gen_0 ]
  set_property -dict [list \
    CONFIG.EN_SAFETY_CKT {false} \
    CONFIG.Enable_B {Use_ENB_Pin} \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.Port_B_Clock {100} \
    CONFIG.Port_B_Enable_Rate {100} \
    CONFIG.Port_B_Write_Rate {50} \
    CONFIG.Use_RSTB_Pin {true} \
  ] $blk_mem_gen_0


  # Create instance: bram_incr_0, and set properties
  set bram_incr_0 [ create_bd_cell -type ip -vlnv iaea.org:user:bram_incr:1.0 bram_incr_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins S09_AXI] [get_bd_intf_pins axi_bram_ctrl_0/S_AXI]
  connect_bd_intf_net -intf_net axi_bram_ctrl_0_BRAM_PORTA [get_bd_intf_pins axi_bram_ctrl_0/BRAM_PORTA] [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTA]
  connect_bd_intf_net -intf_net bram_incr_0_BRAM_PORTB [get_bd_intf_pins blk_mem_gen_0/BRAM_PORTB] [get_bd_intf_pins bram_incr_0/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins clk_cpu_arestn] [get_bd_pins axi_bram_ctrl_0/s_axi_aresetn] [get_bd_pins bram_incr_0/rstn]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins bram_incr_0/clk]
  connect_bd_net -net clk_cpu_1 [get_bd_pins clk_cpu] [get_bd_pins axi_bram_ctrl_0/s_axi_aclk]
  connect_bd_net -net peak_amp_1 [get_bd_pins peak_amp] [get_bd_pins bram_incr_0/peak_amp]
  connect_bd_net -net peak_amp_rdy_1 [get_bd_pins peak_amp_rdy] [get_bd_pins bram_incr_0/peak_amp_rdy]
  connect_bd_net -net segment_1 [get_bd_pins segment] [get_bd_pins bram_incr_0/segment]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: glue_logic
proc create_hier_cell_glue_logic { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_glue_logic() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins

  # Create pins
  create_bd_pin -dir I -from 0 -to 0 In0
  create_bd_pin -dir I -from 0 -to 0 In1
  create_bd_pin -dir I In2
  create_bd_pin -dir O Res
  create_bd_pin -dir O -from 0 -to 0 Res1

  # Create instance: util_reduced_logic_0, and set properties
  set util_reduced_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_reduced_logic:2.0 util_reduced_logic_0 ]
  set_property CONFIG.C_SIZE {3} $util_reduced_logic_0


  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [list \
    CONFIG.C_OPERATION {not} \
    CONFIG.C_SIZE {1} \
  ] $util_vector_logic_0


  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]
  set_property CONFIG.NUM_PORTS {3} $xlconcat_0


  # Create port connections
  connect_bd_net -net In0_1 [get_bd_pins In0] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net In1_1 [get_bd_pins In1] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net In2_1 [get_bd_pins In2] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins xlconcat_0/In2]
  connect_bd_net -net util_reduced_logic_0_Res [get_bd_pins Res] [get_bd_pins util_reduced_logic_0/Res]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins Res1] [get_bd_pins util_vector_logic_0/Res]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins util_reduced_logic_0/Op1] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: microblaze_0_local_memory
proc create_hier_cell_microblaze_0_local_memory { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_microblaze_0_local_memory() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 DLMB

  create_bd_intf_pin -mode MirroredMaster -vlnv xilinx.com:interface:lmb_rtl:1.0 ILMB


  # Create pins
  create_bd_pin -dir I -type clk LMB_Clk
  create_bd_pin -dir I -type rst SYS_Rst

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property CONFIG.C_ECC {0} $dlmb_bram_if_cntlr


  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property CONFIG.C_ECC {0} $ilmb_bram_if_cntlr


  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [list \
    CONFIG.Enable_B {Use_ENB_Pin} \
    CONFIG.Memory_Type {True_Dual_Port_RAM} \
    CONFIG.Port_B_Clock {100} \
    CONFIG.Port_B_Enable_Rate {100} \
    CONFIG.Port_B_Write_Rate {50} \
    CONFIG.Use_RSTB_Pin {true} \
    CONFIG.use_bram_block {BRAM_Controller} \
  ] $lmb_bram


  # Create interface connections
  connect_bd_intf_net -intf_net microblaze_0_dlmb [get_bd_intf_pins DLMB] [get_bd_intf_pins dlmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_bus [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_cntlr [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net microblaze_0_ilmb [get_bd_intf_pins ILMB] [get_bd_intf_pins ilmb_v10/LMB_M]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_bus [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_cntlr [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]

  # Create port connections
  connect_bd_net -net SYS_Rst_1 [get_bd_pins SYS_Rst] [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins LMB_Clk] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: scope
proc create_hier_cell_scope { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_scope() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S03_AXI

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:dbg_invert_and_offset_rtl:1.0 dbg_invert_and_offset

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:dbg_pha_rtl:1.0 dbg_pha

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:dbg_pulse_cond_fast_rtl:1.0 dbg_pulse_cond_fast

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:dbg_pulse_cond_slow_rtl:1.0 dbg_pulse_cond_slow

  create_bd_intf_pin -mode Slave -vlnv iaea.org:user:scope_mux_rtl:1.0 scope_mux


  # Create pins
  create_bd_pin -dir I -type clk clk_cpu
  create_bd_pin -dir I -type rst clk_cpu_aresetn
  create_bd_pin -dir I -type clk clk_dpp
  create_bd_pin -dir O -from 0 -to 0 -type intr full

  # Create instance: ip_scope_0, and set properties
  set ip_scope_0 [ create_bd_cell -type ip -vlnv User_Company:SysGen:ip_scope:2.2 ip_scope_0 ]

  # Create instance: scope_mux_0, and set properties
  set scope_mux_0 [ create_bd_cell -type ip -vlnv iaea.org:user:scope_mux:1.0 scope_mux_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins dbg_pha] [get_bd_intf_pins scope_mux_0/dbg_pha]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins dbg_invert_and_offset] [get_bd_intf_pins scope_mux_0/dbg_invert_and_offset]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins scope_mux] [get_bd_intf_pins scope_mux_0/scope_mux]
  connect_bd_intf_net -intf_net axibusdomain_s_axi_1 [get_bd_intf_pins S03_AXI] [get_bd_intf_pins ip_scope_0/axibusdomain_s_axi]
  connect_bd_intf_net -intf_net dbg_pulse_cond_fast_1 [get_bd_intf_pins dbg_pulse_cond_fast] [get_bd_intf_pins scope_mux_0/dbg_pulse_cond_fast]
  connect_bd_intf_net -intf_net dbg_pulse_cond_slow_1 [get_bd_intf_pins dbg_pulse_cond_slow] [get_bd_intf_pins scope_mux_0/dbg_pulse_cond_slow]

  # Create port connections
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins ip_scope_0/signaldomain_clk]
  connect_bd_net -net ip_scope_0_full [get_bd_pins full] [get_bd_pins ip_scope_0/full]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins clk_cpu] [get_bd_pins ip_scope_0/axibusdomain_clk]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins clk_cpu_aresetn] [get_bd_pins ip_scope_0/axibusdomain_aresetn]
  connect_bd_net -net scope_mux_0_ch1 [get_bd_pins ip_scope_0/ch1] [get_bd_pins scope_mux_0/ch1]
  connect_bd_net -net scope_mux_0_ch2 [get_bd_pins ip_scope_0/ch2] [get_bd_pins scope_mux_0/ch2]
  connect_bd_net -net scope_mux_0_trigger [get_bd_pins ip_scope_0/ch_trigger] [get_bd_pins scope_mux_0/trigger]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pulse_preprocessing
proc create_hier_cell_pulse_preprocessing { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pulse_preprocessing() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv iaea.org:interface:dbg_invert_and_offset_rtl:1.0 dbg_invert_and_offset_m0

  create_bd_intf_pin -mode Slave -vlnv iaea.org:user:formatter_rtl:1.0 formatter


  # Create pins
  create_bd_pin -dir I -from 13 -to 0 adc_data
  create_bd_pin -dir I -type rst clk_cpu_aresetn
  create_bd_pin -dir I clk_dpp
  create_bd_pin -dir O -from 15 -to 0 -type data y

  # Create instance: Formatter_0, and set properties
  set Formatter_0 [ create_bd_cell -type ip -vlnv iaea.org:user:Formatter:1.0 Formatter_0 ]

  # Create instance: ip_dbg_invert_and_of_1, and set properties
  set ip_dbg_invert_and_of_1 [ create_bd_cell -type ip -vlnv iaea.org:user:ip_dbg_invert_and_offset:1.0 ip_dbg_invert_and_of_1 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins formatter] [get_bd_intf_pins Formatter_0/formatter]
  connect_bd_intf_net -intf_net ip_dbg_invert_and_of_1_dbg_invert_and_offset_m0 [get_bd_intf_pins dbg_invert_and_offset_m0] [get_bd_intf_pins ip_dbg_invert_and_of_1/dbg_invert_and_offset_m0]

  # Create port connections
  connect_bd_net -net Formatter_0_data_out [get_bd_pins y] [get_bd_pins Formatter_0/data_out] [get_bd_pins ip_dbg_invert_and_of_1/outp]
  connect_bd_net -net adc_data_1 [get_bd_pins adc_data] [get_bd_pins Formatter_0/adc_data] [get_bd_pins ip_dbg_invert_and_of_1/adc_data]
  connect_bd_net -net clk_cpu_aresetn_1 [get_bd_pins clk_cpu_aresetn] [get_bd_pins Formatter_0/reset_n]
  connect_bd_net -net clk_dpp_1 [get_bd_pins clk_dpp] [get_bd_pins Formatter_0/clk_dpp]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pulse_filtering_slow
proc create_hier_cell_pulse_filtering_slow { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pulse_filtering_slow() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:blr_slow_rtl:1.0 blr_slow

  create_bd_intf_pin -mode Master -vlnv iaea.org:interface:dbg_pulse_cond_slow_rtl:1.0 dbg_pulse_cond_slow_m0

  create_bd_intf_pin -mode Slave -vlnv iaea.org:user:shaper_rtl:1.0 shaper


  # Create pins
  create_bd_pin -dir I -type clk clk_dpp
  create_bd_pin -dir I -from 15 -to 0 -type data data_in
  create_bd_pin -dir I -from 17 -to 0 -type data fast_discriminator
  create_bd_pin -dir O -from 15 -to 0 -type data threshold
  create_bd_pin -dir O -type data threshold_invalid_n
  create_bd_pin -dir O -from 15 -to 0 -type data y

  # Create instance: blr_0, and set properties
  set blr_0 [ create_bd_cell -type ip -vlnv iaea.org:user:blr:2.0 blr_0 ]

  # Create instance: ip_dbg_pulse_cond_sl_0, and set properties
  set ip_dbg_pulse_cond_sl_0 [ create_bd_cell -type ip -vlnv iaea.org:interface:ip_dbg_pulse_cond_slow:1.0 ip_dbg_pulse_cond_sl_0 ]

  # Create instance: shaper_0, and set properties
  set shaper_0 [ create_bd_cell -type ip -vlnv IAEA:user:shaper:3.0 shaper_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins dbg_pulse_cond_slow_m0] [get_bd_intf_pins ip_dbg_pulse_cond_sl_0/dbg_pulse_cond_slow_m0]
  connect_bd_intf_net -intf_net blr_slow_1 [get_bd_intf_pins blr_slow] [get_bd_intf_pins blr_0/blr_slow]
  connect_bd_intf_net -intf_net shaper_2 [get_bd_intf_pins shaper] [get_bd_intf_pins shaper_0/shaper]

  # Create port connections
  connect_bd_net -net blr_0_dbg_1 [get_bd_pins blr_0/dbg_1] [get_bd_pins ip_dbg_pulse_cond_sl_0/dc_stab_acc]
  connect_bd_net -net blr_0_dbg_2 [get_bd_pins blr_0/dbg_2] [get_bd_pins ip_dbg_pulse_cond_sl_0/shaper]
  connect_bd_net -net blr_0_dbg_3 [get_bd_pins blr_0/dbg_3] [get_bd_pins ip_dbg_pulse_cond_sl_0/impulse]
  connect_bd_net -net blr_0_dbg_4 [get_bd_pins blr_0/dbg_4] [get_bd_pins ip_dbg_pulse_cond_sl_0/rect]
  connect_bd_net -net blr_0_threshold [get_bd_pins threshold] [get_bd_pins blr_0/threshold] [get_bd_pins ip_dbg_pulse_cond_sl_0/dc_stab]
  connect_bd_net -net blr_0_threshold_invalid_n [get_bd_pins threshold_invalid_n] [get_bd_pins blr_0/threshold_invalid_n]
  connect_bd_net -net blr_0_y [get_bd_pins y] [get_bd_pins blr_0/y] [get_bd_pins ip_dbg_pulse_cond_sl_0/blr]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins blr_0/clk] [get_bd_pins shaper_0/clk]
  connect_bd_net -net data_in_1 [get_bd_pins data_in] [get_bd_pins shaper_0/x]
  connect_bd_net -net fast_discriminator_1 [get_bd_pins fast_discriminator] [get_bd_pins blr_0/fast_discriminator]
  connect_bd_net -net shaper_1_y [get_bd_pins blr_0/x] [get_bd_pins shaper_0/y]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pulse_filtering_fast
proc create_hier_cell_pulse_filtering_fast { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pulse_filtering_fast() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:blr_fast_rtl:1.0 blr_fast

  create_bd_intf_pin -mode Master -vlnv iaea.org:interface:dbg_pulse_cond_fast_rtl:1.0 dbg_pulse_cond_fast

  create_bd_intf_pin -mode Slave -vlnv iaea.org:user:shaper_rtl:1.0 shaper


  # Create pins
  create_bd_pin -dir I clk_dpp
  create_bd_pin -dir I -from 15 -to 0 -type data data_in
  create_bd_pin -dir O -from 17 -to 0 -type data fast_discriminator
  create_bd_pin -dir O -from 15 -to 0 -type data threshold
  create_bd_pin -dir O -from 15 -to 0 -type data y

  # Create instance: blr_fast_0, and set properties
  set blr_fast_0 [ create_bd_cell -type ip -vlnv IAEA:user:blr_fast:1.0 blr_fast_0 ]

  # Create instance: ip_dbg_pulse_cond_fa_0, and set properties
  set ip_dbg_pulse_cond_fa_0 [ create_bd_cell -type ip -vlnv iaea.org:user:ip_dbg_pulse_cond_fast:1.0 ip_dbg_pulse_cond_fa_0 ]

  # Create instance: shaper_0, and set properties
  set shaper_0 [ create_bd_cell -type ip -vlnv IAEA:user:shaper:3.0 shaper_0 ]

  # Create instance: wire_blr_fast_0, and set properties
  set wire_blr_fast_0 [ create_bd_cell -type ip -vlnv iaea.org:user:wire_blr_fast:1.0 wire_blr_fast_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins blr_fast] [get_bd_intf_pins wire_blr_fast_0/blr_fast]
  connect_bd_intf_net -intf_net ip_dbg_pulse_cond_fa_0_dbg_pulse_cond_fast [get_bd_intf_pins dbg_pulse_cond_fast] [get_bd_intf_pins ip_dbg_pulse_cond_fa_0/dbg_pulse_cond_fast]
  connect_bd_intf_net -intf_net shaper_2 [get_bd_intf_pins shaper] [get_bd_intf_pins shaper_0/shaper]

  # Create port connections
  connect_bd_net -net blr_fast_0_dbg_1 [get_bd_pins blr_fast_0/dbg_1] [get_bd_pins ip_dbg_pulse_cond_fa_0/shaper]
  connect_bd_net -net blr_fast_0_dbg_2 [get_bd_pins blr_fast_0/dbg_2] [get_bd_pins ip_dbg_pulse_cond_fa_0/rect]
  connect_bd_net -net blr_fast_0_dbg_3 [get_bd_pins blr_fast_0/dbg_3] [get_bd_pins ip_dbg_pulse_cond_fa_0/impulse]
  connect_bd_net -net blr_fast_0_fast_discriminator [get_bd_pins fast_discriminator] [get_bd_pins blr_fast_0/fast_discriminator]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins blr_fast_0/clk] [get_bd_pins shaper_0/clk]
  connect_bd_net -net data_in_1 [get_bd_pins data_in] [get_bd_pins shaper_0/x]
  connect_bd_net -net ip_blr_0_y [get_bd_pins y] [get_bd_pins blr_fast_0/y] [get_bd_pins ip_dbg_pulse_cond_fa_0/blr]
  connect_bd_net -net ip_blr_0_zc [get_bd_pins threshold] [get_bd_pins blr_fast_0/threshold] [get_bd_pins ip_dbg_pulse_cond_fa_0/dc_stab]
  connect_bd_net -net shaper_1_y [get_bd_pins blr_fast_0/x] [get_bd_pins shaper_0/y]
  connect_bd_net -net shaper_1_y_bipolar [get_bd_pins blr_fast_0/x_bipolar] [get_bd_pins shaper_0/y_bipolar]
  connect_bd_net -net wire_blr_fast_0_r1_threshold_out [get_bd_pins blr_fast_0/r1_threshold] [get_bd_pins wire_blr_fast_0/r1_threshold_out]
  connect_bd_net -net wire_blr_fast_0_r2_flags_out [get_bd_pins blr_fast_0/r2_flags] [get_bd_pins wire_blr_fast_0/r2_flags_out]
  connect_bd_net -net wire_blr_fast_0_r3_threshold_gain_out [get_bd_pins blr_fast_0/r3_threshold_gain] [get_bd_pins wire_blr_fast_0/r3_threshold_gain_out]
  connect_bd_net -net wire_blr_fast_0_r4_b0_out [get_bd_pins blr_fast_0/r4_b0] [get_bd_pins wire_blr_fast_0/r4_b0_out]
  connect_bd_net -net wire_blr_fast_0_r5_a1_out [get_bd_pins blr_fast_0/r5_a1] [get_bd_pins wire_blr_fast_0/r5_a1_out]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: pulse_analyzing
proc create_hier_cell_pulse_analyzing { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_pulse_analyzing() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S09_AXI

  create_bd_intf_pin -mode Master -vlnv iaea.org:interface:dbg_pha_rtl:1.0 dbg_pha_m0

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:peak_detector_fast_rtl:1.0 peak_detector_fast

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:peak_detector_slow_rtl:1.0 peak_detector_slow

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:pur_rtl:1.0 pur1

  create_bd_intf_pin -mode Slave -vlnv iaea.org:interface:timers_rtl:1.0 timers


  # Create pins
  create_bd_pin -dir I -type clk clk_cpu
  create_bd_pin -dir I -type rst clk_cpu_aresetn
  create_bd_pin -dir I clk_dpp
  create_bd_pin -dir I -from 15 -to 0 -type data threshold
  create_bd_pin -dir I -from 15 -to 0 -type data threshold1
  create_bd_pin -dir I -type data threshold_invalid_n
  create_bd_pin -dir I -from 15 -to 0 -type data x_f
  create_bd_pin -dir I -from 15 -to 0 -type data x_s

  # Create instance: glue_logic
  create_hier_cell_glue_logic $hier_obj glue_logic

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.2 ila_0 ]
  set_property -dict [list \
    CONFIG.C_ENABLE_ILA_AXI_MON {false} \
    CONFIG.C_MONITOR_TYPE {Native} \
    CONFIG.C_NUM_OF_PROBES {10} \
  ] $ila_0


  # Create instance: ip_dbg_pha_0, and set properties
  set ip_dbg_pha_0 [ create_bd_cell -type ip -vlnv xilinx.com:user:ip_dbg_pha:1.0 ip_dbg_pha_0 ]

  # Create instance: mca
  create_hier_cell_mca $hier_obj mca

  # Create instance: pkd
  create_hier_cell_pkd $hier_obj pkd

  # Create instance: pur
  create_hier_cell_pur $hier_obj pur

  # Create instance: timers_0, and set properties
  set timers_0 [ create_bd_cell -type ip -vlnv IAEA:user:timers:1.0 timers_0 ]

  # Create instance: wire_timers_0, and set properties
  set wire_timers_0 [ create_bd_cell -type ip -vlnv iaea.org:user:wire_timers:1.0 wire_timers_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins pur1] [get_bd_intf_pins pur/pur]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins S09_AXI] [get_bd_intf_pins mca/S09_AXI]
  connect_bd_intf_net -intf_net Conn3 [get_bd_intf_pins peak_detector_slow] [get_bd_intf_pins pkd/peak_detector_slow]
  connect_bd_intf_net -intf_net Conn4 [get_bd_intf_pins peak_detector_fast] [get_bd_intf_pins pur/peak_detector_fast]
  connect_bd_intf_net -intf_net Conn6 [get_bd_intf_pins timers] [get_bd_intf_pins wire_timers_0/timers]
  connect_bd_intf_net -intf_net ip_dbg_pha_0_dbg_pha_m0 [get_bd_intf_pins dbg_pha_m0] [get_bd_intf_pins ip_dbg_pha_0/dbg_pha_m0]

  # Create port connections
  connect_bd_net -net D_1 [get_bd_pins x_s] [get_bd_pins pur/x_s]
  connect_bd_net -net In0_1 [get_bd_pins glue_logic/In0] [get_bd_pins timers_0/timers_enabled]
  connect_bd_net -net S00_ARESETN_1 [get_bd_pins clk_cpu_aresetn] [get_bd_pins mca/clk_cpu_arestn] [get_bd_pins pkd/clk_cpu_aresetn] [get_bd_pins pur/clk_cpui_aresetn]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins ila_0/clk] [get_bd_pins mca/clk_dpp] [get_bd_pins pkd/clk_dpp] [get_bd_pins pur/clk_dpp] [get_bd_pins timers_0/clk]
  connect_bd_net -net clk_cpu_1 [get_bd_pins clk_cpu] [get_bd_pins mca/clk_cpu] [get_bd_pins pkd/clk_cpu]
  connect_bd_net -net glue_logic_Res1 [get_bd_pins glue_logic/Res1] [get_bd_pins ila_0/probe9] [get_bd_pins ip_dbg_pha_0/rejectn]
  connect_bd_net -net peak_amp_1 [get_bd_pins ila_0/probe0] [get_bd_pins ila_0/probe3] [get_bd_pins ila_0/probe5] [get_bd_pins ila_0/probe7] [get_bd_pins ip_dbg_pha_0/peak_det_signal] [get_bd_pins mca/peak_amp] [get_bd_pins pkd/peak_amp]
  connect_bd_net -net peak_amp_rdy_1 [get_bd_pins glue_logic/Res] [get_bd_pins mca/peak_amp_rdy]
  connect_bd_net -net pkd_peak_amp_rdy [get_bd_pins glue_logic/In1] [get_bd_pins ila_0/probe2] [get_bd_pins ip_dbg_pha_0/peak_amp_rdy_slow] [get_bd_pins pkd/peak_amp_rdy]
  connect_bd_net -net pur_lt_dir [get_bd_pins ila_0/probe4] [get_bd_pins pur/lt_dir] [get_bd_pins timers_0/lt_dir]
  connect_bd_net -net pur_peak_amp [get_bd_pins ila_0/probe1] [get_bd_pins pur/peak_amp]
  connect_bd_net -net pur_peak_amp_rdy [get_bd_pins ila_0/probe6] [get_bd_pins ip_dbg_pha_0/peak_amp_rdy_fast] [get_bd_pins pur/peak_amp_rdy]
  connect_bd_net -net pur_rejectn [get_bd_pins glue_logic/In2] [get_bd_pins ila_0/probe8] [get_bd_pins pur/rejectn]
  connect_bd_net -net sense_1 [get_bd_pins mca/segment] [get_bd_pins timers_0/bram_seg]
  connect_bd_net -net threshold1_1 [get_bd_pins threshold1] [get_bd_pins pur/threshold1]
  connect_bd_net -net threshold_1 [get_bd_pins threshold] [get_bd_pins pkd/threshold]
  connect_bd_net -net threshold_invalid_n_1 [get_bd_pins threshold_invalid_n] [get_bd_pins pkd/threshold_invalid_n]
  connect_bd_net -net timers_0_r1_timer_a_cnt [get_bd_pins timers_0/r1_timer_a_cnt] [get_bd_pins wire_timers_0/r1_timer_a_cnt]
  connect_bd_net -net timers_0_r2_timer_b_cnt [get_bd_pins timers_0/r2_timer_b_cnt] [get_bd_pins wire_timers_0/r2_timer_b_cnt]
  connect_bd_net -net timers_0_r3_timer_c_cnt [get_bd_pins timers_0/r3_timer_c_cnt] [get_bd_pins wire_timers_0/r3_timer_c_cnt]
  connect_bd_net -net timers_0_r4_status [get_bd_pins timers_0/r4_status] [get_bd_pins wire_timers_0/r4_status]
  connect_bd_net -net wire_timers_0_r1_timer_c_preset_out [get_bd_pins timers_0/r1_timer_c_preset] [get_bd_pins wire_timers_0/r1_timer_c_preset_out]
  connect_bd_net -net wire_timers_0_r2_control_out [get_bd_pins timers_0/r2_control] [get_bd_pins wire_timers_0/r2_control_out]
  connect_bd_net -net x_1 [get_bd_pins x_f] [get_bd_pins pur/x_f]
  connect_bd_net -net x_2 [get_bd_pins pkd/x] [get_bd_pins pur/x_out]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: ps_mb_0
proc create_hier_cell_ps_mb_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_ps_mb_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M03_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M09_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M19_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M20_AXI


  # Create pins
  create_bd_pin -dir I -type clk Clk
  create_bd_pin -dir I dcm_locked
  create_bd_pin -dir I -from 0 -to 0 -type intr intr
  create_bd_pin -dir I -type intr intr1
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir I -type rst reset

  # Create instance: axi_intc_0, and set properties
  set axi_intc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc_0 ]

  # Create instance: mdm_1, and set properties
  set mdm_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm_1 ]

  # Create instance: microblaze_0, and set properties
  set microblaze_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:11.0 microblaze_0 ]
  set_property -dict [list \
    CONFIG.C_DEBUG_ENABLED {1} \
    CONFIG.C_D_AXI {1} \
    CONFIG.C_D_LMB {1} \
    CONFIG.C_I_LMB {1} \
  ] $microblaze_0


  # Create instance: microblaze_0_axi_periph, and set properties
  set microblaze_0_axi_periph [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 microblaze_0_axi_periph ]
  set_property CONFIG.NUM_MI {7} $microblaze_0_axi_periph


  # Create instance: microblaze_0_local_memory
  create_hier_cell_microblaze_0_local_memory $hier_obj microblaze_0_local_memory

  # Create instance: rst_clk_wiz_0_120M, and set properties
  set rst_clk_wiz_0_120M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_clk_wiz_0_120M ]

  # Create instance: xlconcat_0, and set properties
  set xlconcat_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat_0 ]

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins M02_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M02_AXI]
  connect_bd_intf_net -intf_net axi_intc_0_interrupt [get_bd_intf_pins axi_intc_0/interrupt] [get_bd_intf_pins microblaze_0/INTERRUPT]
  connect_bd_intf_net -intf_net microblaze_0_M_AXI_DP [get_bd_intf_pins microblaze_0/M_AXI_DP] [get_bd_intf_pins microblaze_0_axi_periph/S00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M00_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M01_AXI [get_bd_intf_pins M09_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M01_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M03_AXI [get_bd_intf_pins M03_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M03_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M04_AXI [get_bd_intf_pins axi_intc_0/s_axi] [get_bd_intf_pins microblaze_0_axi_periph/M04_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M05_AXI [get_bd_intf_pins M20_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M05_AXI]
  connect_bd_intf_net -intf_net microblaze_0_axi_periph_M06_AXI [get_bd_intf_pins M19_AXI] [get_bd_intf_pins microblaze_0_axi_periph/M06_AXI]
  connect_bd_intf_net -intf_net microblaze_0_debug [get_bd_intf_pins mdm_1/MBDEBUG_0] [get_bd_intf_pins microblaze_0/DEBUG]
  connect_bd_intf_net -intf_net microblaze_0_dlmb_1 [get_bd_intf_pins microblaze_0/DLMB] [get_bd_intf_pins microblaze_0_local_memory/DLMB]
  connect_bd_intf_net -intf_net microblaze_0_ilmb_1 [get_bd_intf_pins microblaze_0/ILMB] [get_bd_intf_pins microblaze_0_local_memory/ILMB]

  # Create port connections
  connect_bd_net -net In1_1 [get_bd_pins intr1] [get_bd_pins xlconcat_0/In1]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins dcm_locked] [get_bd_pins rst_clk_wiz_0_120M/dcm_locked]
  connect_bd_net -net intr_1 [get_bd_pins intr] [get_bd_pins xlconcat_0/In0]
  connect_bd_net -net mdm_1_debug_sys_rst [get_bd_pins mdm_1/Debug_SYS_Rst] [get_bd_pins rst_clk_wiz_0_120M/mb_debug_sys_rst]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins Clk] [get_bd_pins axi_intc_0/s_axi_aclk] [get_bd_pins microblaze_0/Clk] [get_bd_pins microblaze_0_axi_periph/ACLK] [get_bd_pins microblaze_0_axi_periph/M00_ACLK] [get_bd_pins microblaze_0_axi_periph/M01_ACLK] [get_bd_pins microblaze_0_axi_periph/M02_ACLK] [get_bd_pins microblaze_0_axi_periph/M03_ACLK] [get_bd_pins microblaze_0_axi_periph/M04_ACLK] [get_bd_pins microblaze_0_axi_periph/M05_ACLK] [get_bd_pins microblaze_0_axi_periph/M06_ACLK] [get_bd_pins microblaze_0_axi_periph/S00_ACLK] [get_bd_pins microblaze_0_local_memory/LMB_Clk] [get_bd_pins rst_clk_wiz_0_120M/slowest_sync_clk]
  connect_bd_net -net reset_1 [get_bd_pins reset] [get_bd_pins rst_clk_wiz_0_120M/ext_reset_in]
  connect_bd_net -net rst_clk_wiz_0_120M_bus_struct_reset [get_bd_pins microblaze_0_local_memory/SYS_Rst] [get_bd_pins rst_clk_wiz_0_120M/bus_struct_reset]
  connect_bd_net -net rst_clk_wiz_0_120M_mb_reset [get_bd_pins microblaze_0/Reset] [get_bd_pins rst_clk_wiz_0_120M/mb_reset]
  connect_bd_net -net rst_clk_wiz_0_120M_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins axi_intc_0/s_axi_aresetn] [get_bd_pins microblaze_0_axi_periph/ARESETN] [get_bd_pins microblaze_0_axi_periph/M00_ARESETN] [get_bd_pins microblaze_0_axi_periph/M01_ARESETN] [get_bd_pins microblaze_0_axi_periph/M02_ARESETN] [get_bd_pins microblaze_0_axi_periph/M03_ARESETN] [get_bd_pins microblaze_0_axi_periph/M04_ARESETN] [get_bd_pins microblaze_0_axi_periph/M05_ARESETN] [get_bd_pins microblaze_0_axi_periph/M06_ARESETN] [get_bd_pins microblaze_0_axi_periph/S00_ARESETN] [get_bd_pins rst_clk_wiz_0_120M/peripheral_aresetn]
  connect_bd_net -net xlconcat_0_dout [get_bd_pins axi_intc_0/intr] [get_bd_pins xlconcat_0/dout]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mb_periph_0
proc create_hier_cell_mb_periph_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_mb_periph_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S19_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S20_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S21_AXI

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart

  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart1


  # Create pins
  create_bd_pin -dir O -type intr iic2intc_irpt
  create_bd_pin -dir I -type clk s_axi_aclk
  create_bd_pin -dir I -type rst s_axi_aresetn

  # Create instance: axi_iic_0, and set properties
  set axi_iic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.1 axi_iic_0 ]
  set_property -dict [list \
    CONFIG.IIC_BOARD_INTERFACE {Custom} \
    CONFIG.IIC_FREQ_KHZ {100} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $axi_iic_0


  # Create instance: axi_uartlite_0, and set properties
  set axi_uartlite_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_0 ]
  set_property -dict [list \
    CONFIG.C_BAUDRATE {460800} \
    CONFIG.C_S_AXI_ACLK_FREQ_HZ {120000000} \
    CONFIG.C_S_AXI_ACLK_FREQ_HZ_d {120.0} \
    CONFIG.UARTLITE_BOARD_INTERFACE {Custom} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $axi_uartlite_0


  # Create instance: axi_uartlite_1, and set properties
  set axi_uartlite_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite_1 ]
  set_property -dict [list \
    CONFIG.C_BAUDRATE {115200} \
    CONFIG.C_S_AXI_ACLK_FREQ_HZ {120000000} \
    CONFIG.UARTLITE_BOARD_INTERFACE {Custom} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $axi_uartlite_1


  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins i2c] [get_bd_intf_pins axi_iic_0/IIC]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins usb_uart1] [get_bd_intf_pins axi_uartlite_1/UART]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S19_AXI] [get_bd_intf_pins axi_uartlite_0/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_2 [get_bd_intf_pins S20_AXI] [get_bd_intf_pins axi_iic_0/S_AXI]
  connect_bd_intf_net -intf_net S_AXI_3 [get_bd_intf_pins S21_AXI] [get_bd_intf_pins axi_uartlite_1/S_AXI]
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_pins usb_uart] [get_bd_intf_pins axi_uartlite_0/UART]

  # Create port connections
  connect_bd_net -net axi_iic_0_iic2intc_irpt [get_bd_pins iic2intc_irpt] [get_bd_pins axi_iic_0/iic2intc_irpt]
  connect_bd_net -net s_axi_aclk_1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_iic_0/s_axi_aclk] [get_bd_pins axi_uartlite_0/s_axi_aclk] [get_bd_pins axi_uartlite_1/s_axi_aclk]
  connect_bd_net -net s_axi_aresetn_1 [get_bd_pins s_axi_aresetn] [get_bd_pins axi_iic_0/s_axi_aresetn] [get_bd_pins axi_uartlite_0/s_axi_aresetn] [get_bd_pins axi_uartlite_1/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: dpp_0
proc create_hier_cell_dpp_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2092 -severity "ERROR" "create_hier_cell_dpp_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S03_AXI

  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S09_AXI


  # Create pins
  create_bd_pin -dir I -from 13 -to 0 adc_data
  create_bd_pin -dir I -type clk clk_cpu
  create_bd_pin -dir I -type rst clk_cpu_aresetn
  create_bd_pin -dir I clk_dpp
  create_bd_pin -dir O -from 0 -to 0 -type intr full

  # Create instance: dpp_iface_0, and set properties
  set dpp_iface_0 [ create_bd_cell -type ip -vlnv iaea.org:user:dpp_iface:1.0 dpp_iface_0 ]

  # Create instance: pulse_analyzing
  create_hier_cell_pulse_analyzing $hier_obj pulse_analyzing

  # Create instance: pulse_filtering_fast
  create_hier_cell_pulse_filtering_fast $hier_obj pulse_filtering_fast

  # Create instance: pulse_filtering_slow
  create_hier_cell_pulse_filtering_slow $hier_obj pulse_filtering_slow

  # Create instance: pulse_preprocessing
  create_hier_cell_pulse_preprocessing $hier_obj pulse_preprocessing

  # Create instance: scope
  create_hier_cell_scope $hier_obj scope

  # Create interface connections
  connect_bd_intf_net -intf_net S00_AXI_1 [get_bd_intf_pins S00_AXI] [get_bd_intf_pins dpp_iface_0/s_axi]
  connect_bd_intf_net -intf_net S_AXI_1 [get_bd_intf_pins S09_AXI] [get_bd_intf_pins pulse_analyzing/S09_AXI]
  connect_bd_intf_net -intf_net axibusdomain_s_axi_1 [get_bd_intf_pins S03_AXI] [get_bd_intf_pins scope/S03_AXI]
  connect_bd_intf_net -intf_net blr_slow_1 [get_bd_intf_pins dpp_iface_0/blr_slow] [get_bd_intf_pins pulse_filtering_slow/blr_slow]
  connect_bd_intf_net -intf_net dbg_pulse_cond_fast_1 [get_bd_intf_pins pulse_filtering_fast/dbg_pulse_cond_fast] [get_bd_intf_pins scope/dbg_pulse_cond_fast]
  connect_bd_intf_net -intf_net dbg_pulse_cond_slow_1 [get_bd_intf_pins pulse_filtering_slow/dbg_pulse_cond_slow_m0] [get_bd_intf_pins scope/dbg_pulse_cond_slow]
  connect_bd_intf_net -intf_net dpp_iface_0_blr_fast [get_bd_intf_pins dpp_iface_0/blr_fast] [get_bd_intf_pins pulse_filtering_fast/blr_fast]
  connect_bd_intf_net -intf_net dpp_iface_0_formatter [get_bd_intf_pins dpp_iface_0/formatter] [get_bd_intf_pins pulse_preprocessing/formatter]
  connect_bd_intf_net -intf_net dpp_iface_0_peak_detector_fast [get_bd_intf_pins dpp_iface_0/peak_detector_fast] [get_bd_intf_pins pulse_analyzing/peak_detector_fast]
  connect_bd_intf_net -intf_net dpp_iface_0_peak_detector_slow [get_bd_intf_pins dpp_iface_0/peak_detector_slow] [get_bd_intf_pins pulse_analyzing/peak_detector_slow]
  connect_bd_intf_net -intf_net dpp_iface_0_pur [get_bd_intf_pins dpp_iface_0/pur] [get_bd_intf_pins pulse_analyzing/pur1]
  connect_bd_intf_net -intf_net dpp_iface_0_scope_mux [get_bd_intf_pins dpp_iface_0/scope_mux] [get_bd_intf_pins scope/scope_mux]
  connect_bd_intf_net -intf_net dpp_iface_0_shaper_fast [get_bd_intf_pins dpp_iface_0/shaper_fast] [get_bd_intf_pins pulse_filtering_fast/shaper]
  connect_bd_intf_net -intf_net dpp_iface_0_shaper_slow [get_bd_intf_pins dpp_iface_0/shaper_slow] [get_bd_intf_pins pulse_filtering_slow/shaper]
  connect_bd_intf_net -intf_net dpp_iface_0_timers [get_bd_intf_pins dpp_iface_0/timers] [get_bd_intf_pins pulse_analyzing/timers]
  connect_bd_intf_net -intf_net pha_dbg_pha_m0 [get_bd_intf_pins pulse_analyzing/dbg_pha_m0] [get_bd_intf_pins scope/dbg_pha]
  connect_bd_intf_net -intf_net pulse_preprocessing_dbg_invert_and_offset_m0 [get_bd_intf_pins pulse_preprocessing/dbg_invert_and_offset_m0] [get_bd_intf_pins scope/dbg_invert_and_offset]

  # Create port connections
  connect_bd_net -net D_1 [get_bd_pins pulse_analyzing/x_s] [get_bd_pins pulse_filtering_slow/y]
  connect_bd_net -net adc_data_1 [get_bd_pins adc_data] [get_bd_pins pulse_preprocessing/adc_data]
  connect_bd_net -net clk_1 [get_bd_pins clk_dpp] [get_bd_pins dpp_iface_0/clk_dpp] [get_bd_pins pulse_analyzing/clk_dpp] [get_bd_pins pulse_filtering_fast/clk_dpp] [get_bd_pins pulse_filtering_slow/clk_dpp] [get_bd_pins pulse_preprocessing/clk_dpp] [get_bd_pins scope/clk_dpp]
  connect_bd_net -net data_in_1 [get_bd_pins pulse_filtering_fast/data_in] [get_bd_pins pulse_filtering_slow/data_in] [get_bd_pins pulse_preprocessing/y]
  connect_bd_net -net fast_discriminator_1 [get_bd_pins pulse_filtering_fast/fast_discriminator] [get_bd_pins pulse_filtering_slow/fast_discriminator]
  connect_bd_net -net pulse_conditioning_slow_threshold [get_bd_pins pulse_analyzing/threshold] [get_bd_pins pulse_filtering_slow/threshold]
  connect_bd_net -net s00_axi_aclk_1 [get_bd_pins clk_cpu] [get_bd_pins dpp_iface_0/s_axi_aclk] [get_bd_pins pulse_analyzing/clk_cpu] [get_bd_pins scope/clk_cpu]
  connect_bd_net -net s00_axi_aresetn_1 [get_bd_pins clk_cpu_aresetn] [get_bd_pins dpp_iface_0/s_axi_aresetn] [get_bd_pins pulse_analyzing/clk_cpu_aresetn] [get_bd_pins pulse_preprocessing/clk_cpu_aresetn] [get_bd_pins scope/clk_cpu_aresetn]
  connect_bd_net -net scope_full [get_bd_pins full] [get_bd_pins scope/full]
  connect_bd_net -net threshold1_1 [get_bd_pins pulse_analyzing/threshold1] [get_bd_pins pulse_filtering_fast/threshold]
  connect_bd_net -net threshold_invalid_n_1 [get_bd_pins pulse_analyzing/threshold_invalid_n] [get_bd_pins pulse_filtering_slow/threshold_invalid_n]
  connect_bd_net -net x_1 [get_bd_pins pulse_analyzing/x_f] [get_bd_pins pulse_filtering_fast/y]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2090 -severity "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_gid_msg -ssname BD::TCL -id 2091 -severity "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set i2c [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 i2c ]

  set usb_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart ]

  set usb_uart1 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 usb_uart1 ]


  # Create ports
  set adc_clk [ create_bd_port -dir O -type clk adc_clk ]
  set adc_data [ create_bd_port -dir I -from 13 -to 0 -type data adc_data ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset
  set sys_clock [ create_bd_port -dir I -type clk -freq_hz 12000000 sys_clock ]
  set_property -dict [ list \
   CONFIG.PHASE {0.000} \
 ] $sys_clock

  # Create instance: clk_wiz_0, and set properties
  set clk_wiz_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:6.0 clk_wiz_0 ]
  set_property -dict [list \
    CONFIG.CLKIN1_JITTER_PS {833.33} \
    CONFIG.CLKOUT1_JITTER {469.462} \
    CONFIG.CLKOUT1_PHASE_ERROR {668.310} \
    CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {120.000} \
    CONFIG.CLKOUT2_JITTER {522.315} \
    CONFIG.CLKOUT2_PHASE_ERROR {668.310} \
    CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {50.000} \
    CONFIG.CLKOUT2_USED {true} \
    CONFIG.CLKOUT3_JITTER {522.315} \
    CONFIG.CLKOUT3_PHASE_ERROR {668.310} \
    CONFIG.CLKOUT3_REQUESTED_OUT_FREQ {50.000} \
    CONFIG.CLKOUT3_USED {true} \
    CONFIG.CLK_IN1_BOARD_INTERFACE {sys_clock} \
    CONFIG.CLK_OUT1_PORT {clk_cpu} \
    CONFIG.CLK_OUT2_PORT {clk_dpp} \
    CONFIG.CLK_OUT3_PORT {clk_adc} \
    CONFIG.MMCM_CLKFBOUT_MULT_F {62.500} \
    CONFIG.MMCM_CLKIN1_PERIOD {83.333} \
    CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
    CONFIG.MMCM_CLKOUT0_DIVIDE_F {6.250} \
    CONFIG.MMCM_CLKOUT1_DIVIDE {15} \
    CONFIG.MMCM_CLKOUT2_DIVIDE {15} \
    CONFIG.MMCM_DIVCLK_DIVIDE {1} \
    CONFIG.NUM_OUT_CLKS {3} \
    CONFIG.RESET_BOARD_INTERFACE {reset} \
    CONFIG.USE_BOARD_FLOW {true} \
  ] $clk_wiz_0


  # Create instance: dpp_0
  create_hier_cell_dpp_0 [current_bd_instance .] dpp_0

  # Create instance: mb_periph_0
  create_hier_cell_mb_periph_0 [current_bd_instance .] mb_periph_0

  # Create instance: ps_mb_0
  create_hier_cell_ps_mb_0 [current_bd_instance .] ps_mb_0

  # Create interface connections
  connect_bd_intf_net -intf_net axi_uartlite_0_UART [get_bd_intf_ports usb_uart] [get_bd_intf_pins mb_periph_0/usb_uart]
  connect_bd_intf_net -intf_net mb_periph_0_i2c [get_bd_intf_ports i2c] [get_bd_intf_pins mb_periph_0/i2c]
  connect_bd_intf_net -intf_net mb_periph_0_usb_uart1 [get_bd_intf_ports usb_uart1] [get_bd_intf_pins mb_periph_0/usb_uart1]
  connect_bd_intf_net -intf_net ps_mb_0_M00_AXI [get_bd_intf_pins dpp_0/S00_AXI] [get_bd_intf_pins ps_mb_0/M00_AXI]
  connect_bd_intf_net -intf_net ps_mb_0_M03_AXI [get_bd_intf_pins dpp_0/S03_AXI] [get_bd_intf_pins ps_mb_0/M03_AXI]
  connect_bd_intf_net -intf_net ps_mb_0_M09_AXI [get_bd_intf_pins dpp_0/S09_AXI] [get_bd_intf_pins ps_mb_0/M09_AXI]
  connect_bd_intf_net -intf_net ps_mb_0_M17_AXI2 [get_bd_intf_pins mb_periph_0/S19_AXI] [get_bd_intf_pins ps_mb_0/M19_AXI]
  connect_bd_intf_net -intf_net ps_mb_0_M18_AXI2 [get_bd_intf_pins mb_periph_0/S20_AXI] [get_bd_intf_pins ps_mb_0/M20_AXI]
  connect_bd_intf_net -intf_net ps_mb_0_M19_AXI1 [get_bd_intf_pins mb_periph_0/S21_AXI] [get_bd_intf_pins ps_mb_0/M02_AXI]

  # Create port connections
  connect_bd_net -net adc_data_1 [get_bd_ports adc_data] [get_bd_pins dpp_0/adc_data]
  connect_bd_net -net clk_wiz_0_clk_adc [get_bd_ports adc_clk] [get_bd_pins clk_wiz_0/clk_adc]
  connect_bd_net -net clk_wiz_0_clk_dpp [get_bd_pins clk_wiz_0/clk_dpp] [get_bd_pins dpp_0/clk_dpp]
  connect_bd_net -net clk_wiz_0_locked [get_bd_pins clk_wiz_0/locked] [get_bd_pins ps_mb_0/dcm_locked]
  connect_bd_net -net dpp_0_full [get_bd_pins dpp_0/full] [get_bd_pins ps_mb_0/intr]
  connect_bd_net -net intr1_1 [get_bd_pins mb_periph_0/iic2intc_irpt] [get_bd_pins ps_mb_0/intr1]
  connect_bd_net -net microblaze_0_Clk [get_bd_pins clk_wiz_0/clk_cpu] [get_bd_pins dpp_0/clk_cpu] [get_bd_pins mb_periph_0/s_axi_aclk] [get_bd_pins ps_mb_0/Clk]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins clk_wiz_0/reset] [get_bd_pins ps_mb_0/reset]
  connect_bd_net -net rst_clk_wiz_0_120M_peripheral_aresetn [get_bd_pins dpp_0/clk_cpu_aresetn] [get_bd_pins mb_periph_0/s_axi_aresetn] [get_bd_pins ps_mb_0/peripheral_aresetn]
  connect_bd_net -net sys_clock_1 [get_bd_ports sys_clock] [get_bd_pins clk_wiz_0/clk_in1]

  # Create address segments
  assign_bd_address -offset 0xC0000000 -range 0x00002000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs dpp_0/pulse_analyzing/mca/axi_bram_ctrl_0/S_AXI/Mem0] -force
  assign_bd_address -offset 0x40800000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs mb_periph_0/axi_iic_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x41200000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs ps_mb_0/axi_intc_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40600000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs mb_periph_0/axi_uartlite_0/S_AXI/Reg] -force
  assign_bd_address -offset 0x40610000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs mb_periph_0/axi_uartlite_1/S_AXI/Reg] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs ps_mb_0/microblaze_0_local_memory/dlmb_bram_if_cntlr/SLMB/Mem] -force
  assign_bd_address -offset 0x80000000 -range 0x00001000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs dpp_0/dpp_iface_0/s_axi/reg0] -force
  assign_bd_address -offset 0x44A20000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Data] [get_bd_addr_segs dpp_0/scope/ip_scope_0/axibusdomain_s_axi/reg0] -force
  assign_bd_address -offset 0x00000000 -range 0x00010000 -target_address_space [get_bd_addr_spaces ps_mb_0/microblaze_0/Instruction] [get_bd_addr_segs ps_mb_0/microblaze_0_local_memory/ilmb_bram_if_cntlr/SLMB/Mem] -force


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


