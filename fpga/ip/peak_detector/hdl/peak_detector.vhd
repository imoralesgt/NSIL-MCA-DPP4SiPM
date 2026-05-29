-- Generated from Simulink block peak_detector/axiBusDomain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_axibusdomain is
  port (
    r1_blanking_time : in std_logic_vector( 32-1 downto 0 );
    r2_time_over_threshold : in std_logic_vector( 32-1 downto 0 );
    r3_x_min : in std_logic_vector( 32-1 downto 0 );
    r4_x_max : in std_logic_vector( 32-1 downto 0 );
    r5_flags : in std_logic_vector( 32-1 downto 0 )
  );
end peak_detector_axibusdomain;
architecture structural of peak_detector_axibusdomain is 
  signal r1_blanking_time_net : std_logic_vector( 32-1 downto 0 );
  signal r2_time_over_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r3_x_min_net : std_logic_vector( 32-1 downto 0 );
  signal r4_x_max_net : std_logic_vector( 32-1 downto 0 );
  signal r5_flags_net : std_logic_vector( 32-1 downto 0 );
begin
  r1_blanking_time_net <= r1_blanking_time;
  r2_time_over_threshold_net <= r2_time_over_threshold;
  r3_x_min_net <= r3_x_min;
  r4_x_max_net <= r4_x_max;
  r5_flags_net <= r5_flags;
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/MachineOverflowLogic/toSFIx5
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix5 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 10-1 downto 0 )
  );
end peak_detector_tosfix5;
architecture structural of peak_detector_tosfix5 is 
  signal reinterpret3_output_port_net : std_logic_vector( 10-1 downto 0 );
  signal r2_time_over_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 10-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r2_time_over_threshold_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_651d1f2bea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => r2_time_over_threshold_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/MachineOverflowLogic
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_machineoverflowlogic is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    x_width : in std_logic_vector( 32-1 downto 0 );
    peak_rdy : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    peak_acc : out std_logic_vector( 1-1 downto 0 )
  );
end peak_detector_machineoverflowlogic;
architecture structural of peak_detector_machineoverflowlogic is 
  signal mcode2_dbg_count_net : std_logic_vector( 10-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal r2_time_over_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal mcode2_pulse_acc_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 10-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
begin
  peak_acc <= mcode2_pulse_acc_net;
  reinterpret3_output_port_net <= x;
  r2_time_over_threshold_q_net <= x_width;
  mcode1_e_net <= peak_rdy;
  convert_dout_net <= rst;
  clk_net <= clk_1;
  ce_net <= ce_1;
  tosfix5 : entity xil_defaultlib.peak_detector_tosfix5 
  port map (
    in1 => r2_time_over_threshold_q_net,
    out1 => reinterpret3_output_port_net_x0
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_490670a1f6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mcode2 : entity xil_defaultlib.sysgen_mcode_block_3383358711 
  port map (
    clr => '0',
    x_p => reinterpret3_output_port_net,
    x_m => constant_op_net,
    count_m => reinterpret3_output_port_net_x0,
    rst => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    pulse_acc => mcode2_pulse_acc_net,
    dbg_count => mcode2_dbg_count_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/UserOverflowLogic
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_useroverflowlogic is
  port (
    xmin : in std_logic_vector( 16-1 downto 0 );
    xmax : in std_logic_vector( 16-1 downto 0 );
    rdy : in std_logic_vector( 1-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    inhibit_n : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y_rdy : out std_logic_vector( 1-1 downto 0 )
  );
end peak_detector_useroverflowlogic;
architecture structural of peak_detector_useroverflowlogic is 
  signal register1_q_net : std_logic_vector( 16-1 downto 0 );
  signal relational2_op_net : std_logic_vector( 1-1 downto 0 );
  signal mcode3_z_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
  signal register4_q_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal threshold_invalid_n_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
begin
  y_rdy <= logical_y_net;
  reinterpret3_output_port_net <= xmin;
  reinterpret3_output_port_net_x0 <= xmax;
  delay2_q_net <= rdy;
  register_q_net <= x;
  threshold_invalid_n_net <= inhibit_n;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_02102ce1a2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert1 : entity xil_defaultlib.peak_detector_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => delay2_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  logical : entity xil_defaultlib.sysgen_logical_c0c21a113c 
  port map (
    clr => '0',
    d0 => convert1_dout_net,
    d1 => relational1_op_net,
    d2 => relational2_op_net,
    d3 => threshold_invalid_n_net,
    clk => clk_net,
    ce => ce_net,
    y => logical_y_net
  );
  mcode3 : entity xil_defaultlib.sysgen_mcode_block_6672ae6d55 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    x => constant_op_net,
    y => register_q_net_x0,
    z => mcode3_z_net
  );
  register_x0 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net_x0
  );
  register1 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
  register3 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => mcode3_z_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_44eeae6177 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => register3_q_net,
    op => relational1_op_net
  );
  relational2 : entity xil_defaultlib.sysgen_relational_5cd29e6abc 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => register_q_net,
    b => register4_q_net,
    op => relational2_op_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/toSFIx
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end peak_detector_tosfix;
architecture structural of peak_detector_tosfix is 
  signal threshold_net : std_logic_vector( 16-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  threshold_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_bae48be5e4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 16,
    y_width => 16
  )
  port map (
    x => threshold_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/toSFIx1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix1 is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end peak_detector_tosfix1;
architecture structural of peak_detector_tosfix1 is 
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  x_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_bae48be5e4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 16,
    y_width => 16
  )
  port map (
    x => x_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/toSFIx2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix2 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end peak_detector_tosfix2;
architecture structural of peak_detector_tosfix2 is 
  signal r4_xmax_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r4_xmax_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_bae48be5e4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r4_xmax_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/toSFIx3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix3 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end peak_detector_tosfix3;
architecture structural of peak_detector_tosfix3 is 
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal r3_xmin_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r3_xmin_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_bae48be5e4 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r3_xmin_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem/toSFIx4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_tosfix4 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 10-1 downto 0 )
  );
end peak_detector_tosfix4;
architecture structural of peak_detector_tosfix4 is 
  signal r1_blanking_time_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 10-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 10-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r1_blanking_time_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_651d1f2bea 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => r1_blanking_time_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/Subsystem
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_subsystem is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    blanking_time : in std_logic_vector( 32-1 downto 0 );
    threshold : in std_logic_vector( 16-1 downto 0 );
    x_min : in std_logic_vector( 32-1 downto 0 );
    x_max : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    time_over_threshold : in std_logic_vector( 32-1 downto 0 );
    inhibit_n : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    peak_amp_rdy : out std_logic_vector( 1-1 downto 0 );
    peak_amp : out std_logic_vector( 16-1 downto 0 );
    tot_acc : out std_logic_vector( 1-1 downto 0 );
    over_threshold : out std_logic_vector( 1-1 downto 0 );
    stretcher_reset : out std_logic_vector( 1-1 downto 0 );
    peak_machine_acc : out std_logic_vector( 1-1 downto 0 );
    peak_90_detected : out std_logic_vector( 1-1 downto 0 );
    blanking_time_status : out std_logic_vector( 1-1 downto 0 )
  );
end peak_detector_subsystem;
architecture structural of peak_detector_subsystem is 
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal mcode2_y_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode4_y_net : std_logic_vector( 1-1 downto 0 );
  signal r3_xmin_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 16-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal mcode2_pulse_acc_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal r1_blanking_time_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal r2_time_over_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal threshold_net : std_logic_vector( 16-1 downto 0 );
  signal r4_xmax_q_net : std_logic_vector( 32-1 downto 0 );
  signal threshold_invalid_n_net : std_logic_vector( 1-1 downto 0 );
  signal stretcher_xmax_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net_x3 : std_logic_vector( 10-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 1-1 downto 0 );
  signal attenuator_p_net : std_logic_vector( 16-1 downto 0 );
  signal enable_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret2_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal mcode3_y_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  peak_amp_rdy <= logical_y_net;
  peak_amp <= register_q_net;
  tot_acc <= mcode2_pulse_acc_net;
  over_threshold <= reinterpret_output_port_net;
  stretcher_reset <= convert_dout_net;
  peak_machine_acc <= mcode1_e_net;
  peak_90_detected <= mcode2_y_net;
  blanking_time_status <= mcode4_y_net;
  x_net <= x;
  r1_blanking_time_q_net <= blanking_time;
  threshold_net <= threshold;
  r3_xmin_q_net <= x_min;
  r4_xmax_q_net <= x_max;
  r5_flags_q_net <= flags;
  r2_time_over_threshold_q_net <= time_over_threshold;
  threshold_invalid_n_net <= inhibit_n;
  clk_net <= clk_1;
  ce_net <= ce_1;
  machineoverflowlogic : entity xil_defaultlib.peak_detector_machineoverflowlogic 
  port map (
    x => reinterpret3_output_port_net_x0,
    x_width => r2_time_over_threshold_q_net,
    peak_rdy => mcode1_e_net,
    rst => convert_dout_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    peak_acc => mcode2_pulse_acc_net
  );
  useroverflowlogic : entity xil_defaultlib.peak_detector_useroverflowlogic 
  port map (
    xmin => reinterpret3_output_port_net_x2,
    xmax => reinterpret3_output_port_net_x1,
    rdy => delay2_q_net,
    x => register_q_net,
    inhibit_n => threshold_invalid_n_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y_rdy => logical_y_net
  );
  tosfix : entity xil_defaultlib.peak_detector_tosfix 
  port map (
    in1 => threshold_net,
    out1 => reinterpret3_output_port_net
  );
  tosfix1 : entity xil_defaultlib.peak_detector_tosfix1 
  port map (
    in1 => x_net,
    out1 => reinterpret3_output_port_net_x0
  );
  tosfix2 : entity xil_defaultlib.peak_detector_tosfix2 
  port map (
    in1 => r4_xmax_q_net,
    out1 => reinterpret3_output_port_net_x1
  );
  tosfix3 : entity xil_defaultlib.peak_detector_tosfix3 
  port map (
    in1 => r3_xmin_q_net,
    out1 => reinterpret3_output_port_net_x2
  );
  tosfix4 : entity xil_defaultlib.peak_detector_tosfix4 
  port map (
    in1 => r1_blanking_time_q_net,
    out1 => reinterpret3_output_port_net_x3
  );
  attenuator : entity xil_defaultlib.peak_detector_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "peak_detector_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 2,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => stretcher_xmax_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => attenuator_p_net
  );
  cmult : entity xil_defaultlib.peak_detector_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_output_width => 32,
    core_name0 => "peak_detector_mult_gen_v12_0_i1",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  convert : entity xil_defaultlib.peak_detector_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.peak_detector_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical2_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.peak_detector_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => enable_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  delay : entity xil_defaultlib.peak_detector_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => mcode1_e_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.peak_detector_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => inverter_op_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.peak_detector_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => mcode1_e_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_9774281692 
  port map (
    clr => '0',
    ip => convert2_dout_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_688b9e2638 
  port map (
    clr => '0',
    ip => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_cf4561827f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter1_op_net,
    d1 => reinterpret2_output_port_net,
    y => logical_y_net_x0
  );
  logical2 : entity xil_defaultlib.sysgen_logical_b63f181d40 
  port map (
    clr => '0',
    d0 => mcode2_pulse_acc_net,
    d1 => mcode2_y_net,
    clk => clk_net,
    ce => ce_net,
    y => logical2_y_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_c5ef7f85b2 
  port map (
    clr => '0',
    x => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode1_y_net,
    e => mcode1_e_net
  );
  mcode2 : entity xil_defaultlib.sysgen_mcode_block_47e1e3b3e3 
  port map (
    clr => '0',
    x_p => attenuator_p_net,
    x_m => reinterpret3_output_port_net_x0,
    hyst => cmult_p_net,
    rst => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode2_y_net
  );
  mcode3 : entity xil_defaultlib.sysgen_mcode_block_002d07903e 
  port map (
    clr => '0',
    x_p => reinterpret3_output_port_net_x0,
    x_m => reinterpret3_output_port_net,
    hyst => cmult_p_net,
    rst => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode3_y_net
  );
  mcode4 : entity xil_defaultlib.sysgen_mcode_block_0df92f27ed 
  port map (
    clr => '0',
    start => delay_q_net,
    preset => reinterpret3_output_port_net_x3,
    rst => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode4_y_net
  );
  register_x0 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    rst => "0",
    d => stretcher_xmax_net,
    en => mcode1_e_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_56dc5679ac 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mcode3_y_net,
    output_port => reinterpret_output_port_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_56dc5679ac 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mcode4_y_net,
    output_port => reinterpret2_output_port_net
  );
  stretcher : entity xil_defaultlib.sysgen_mcode_block_1b1787ae46 
  port map (
    clr => '0',
    x_in => reinterpret3_output_port_net_x0,
    rst => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    xmax => stretcher_xmax_net
  );
  enable : entity xil_defaultlib.peak_detector_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => r5_flags_q_net,
    y => enable_y_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain/format_dac
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_format_dac is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 14-1 downto 0 )
  );
end peak_detector_format_dac;
architecture structural of peak_detector_format_dac is 
  signal ce_net : std_logic;
  signal constant7_op_net : std_logic_vector( 14-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal logical_y_net : std_logic_vector( 14-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 14-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 14-1 downto 0 );
begin
  out1 <= logical_y_net;
  register_q_net <= in1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant7 : entity xil_defaultlib.sysgen_constant_4171fa8991 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant7_op_net
  );
  convert4 : entity xil_defaultlib.peak_detector_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 12,
    dout_width => 14,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  logical : entity xil_defaultlib.sysgen_logical_38a5424d30 
  port map (
    clr => '0',
    d0 => reinterpret_output_port_net,
    d1 => constant7_op_net,
    clk => clk_net,
    ce => ce_net,
    y => logical_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_49837bee95 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => convert4_dout_net,
    output_port => reinterpret_output_port_net
  );
end structural;
-- Generated from Simulink block peak_detector/signalDomain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_signaldomain is
  port (
    blanking_time : in std_logic_vector( 32-1 downto 0 );
    time_over_threshold : in std_logic_vector( 32-1 downto 0 );
    x_min : in std_logic_vector( 32-1 downto 0 );
    x_max : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    threshold : in std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : in std_logic_vector( 1-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dbg_1 : out std_logic_vector( 14-1 downto 0 );
    peak_amp : out std_logic_vector( 16-1 downto 0 );
    peak_amp_rdy : out std_logic_vector( 1-1 downto 0 )
  );
end peak_detector_signaldomain;
architecture structural of peak_detector_signaldomain is 
  signal mcode4_y_net : std_logic_vector( 1-1 downto 0 );
  signal r4_xmax_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 14-1 downto 0 );
  signal reinterpret_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal r3_xmin_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode2_pulse_acc_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal r2_time_over_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal r1_blanking_time_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal threshold_net : std_logic_vector( 16-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal threshold_invalid_n_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode2_y_net : std_logic_vector( 1-1 downto 0 );
begin
  r1_blanking_time_q_net <= blanking_time;
  r2_time_over_threshold_q_net <= time_over_threshold;
  r3_xmin_q_net <= x_min;
  r4_xmax_q_net <= x_max;
  r5_flags_q_net <= flags;
  dbg_1 <= logical_y_net;
  peak_amp <= reinterpret_output_port_net_x0;
  peak_amp_rdy <= logical_y_net_x0;
  threshold_net <= threshold;
  threshold_invalid_n_net <= threshold_invalid_n;
  x_net <= x;
  clk_net <= clk_1;
  ce_net <= ce_1;
  subsystem : entity xil_defaultlib.peak_detector_subsystem 
  port map (
    x => x_net,
    blanking_time => r1_blanking_time_q_net,
    threshold => threshold_net,
    x_min => r3_xmin_q_net,
    x_max => r4_xmax_q_net,
    flags => r5_flags_q_net,
    time_over_threshold => r2_time_over_threshold_q_net,
    inhibit_n => threshold_invalid_n_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    peak_amp_rdy => logical_y_net_x0,
    peak_amp => register_q_net,
    tot_acc => mcode2_pulse_acc_net,
    over_threshold => reinterpret_output_port_net,
    stretcher_reset => convert_dout_net,
    peak_machine_acc => mcode1_e_net,
    peak_90_detected => mcode2_y_net,
    blanking_time_status => mcode4_y_net
  );
  format_dac : entity xil_defaultlib.peak_detector_format_dac 
  port map (
    in1 => register_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => logical_y_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_b875eb6c7e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_q_net,
    output_port => reinterpret_output_port_net_x0
  );
end structural;
-- Generated from Simulink block peak_detector_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_struct is
  port (
    r1_blanking_time : in std_logic_vector( 32-1 downto 0 );
    r2_time_over_threshold : in std_logic_vector( 32-1 downto 0 );
    r3_x_min : in std_logic_vector( 32-1 downto 0 );
    r4_x_max : in std_logic_vector( 32-1 downto 0 );
    r5_flags : in std_logic_vector( 32-1 downto 0 );
    threshold : in std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : in std_logic_vector( 1-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dbg_1 : out std_logic_vector( 14-1 downto 0 );
    peak_amp : out std_logic_vector( 16-1 downto 0 );
    peak_amp_rdy : out std_logic_vector( 1-1 downto 0 )
  );
end peak_detector_struct;
architecture structural of peak_detector_struct is 
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal r2_time_over_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r4_x_max_net : std_logic_vector( 32-1 downto 0 );
  signal r3_x_min_net : std_logic_vector( 32-1 downto 0 );
  signal threshold_invalid_n_net : std_logic_vector( 1-1 downto 0 );
  signal r1_blanking_time_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_flags_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 14-1 downto 0 );
  signal r2_time_over_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal r3_xmin_q_net : std_logic_vector( 32-1 downto 0 );
  signal threshold_net : std_logic_vector( 16-1 downto 0 );
  signal r4_xmax_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal r1_blanking_time_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
begin
  r1_blanking_time_net <= r1_blanking_time;
  r2_time_over_threshold_net <= r2_time_over_threshold;
  r3_x_min_net <= r3_x_min;
  r4_x_max_net <= r4_x_max;
  r5_flags_net <= r5_flags;
  dbg_1 <= logical_y_net;
  peak_amp <= reinterpret_output_port_net;
  peak_amp_rdy <= logical_y_net_x0;
  threshold_net <= threshold;
  threshold_invalid_n_net <= threshold_invalid_n;
  x_net <= x;
  clk_net <= clk_1;
  ce_net <= ce_1;
  axibusdomain : entity xil_defaultlib.peak_detector_axibusdomain 
  port map (
    r1_blanking_time => r1_blanking_time_net,
    r2_time_over_threshold => r2_time_over_threshold_net,
    r3_x_min => r3_x_min_net,
    r4_x_max => r4_x_max_net,
    r5_flags => r5_flags_net
  );
  signaldomain : entity xil_defaultlib.peak_detector_signaldomain 
  port map (
    blanking_time => r1_blanking_time_q_net,
    time_over_threshold => r2_time_over_threshold_q_net,
    x_min => r3_xmin_q_net,
    x_max => r4_xmax_q_net,
    flags => r5_flags_q_net,
    threshold => threshold_net,
    threshold_invalid_n => threshold_invalid_n_net,
    x => x_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dbg_1 => logical_y_net,
    peak_amp => reinterpret_output_port_net,
    peak_amp_rdy => logical_y_net_x0
  );
  r1_blanking_time_x0 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r1_blanking_time_net,
    clk => clk_net,
    ce => ce_net,
    q => r1_blanking_time_q_net
  );
  r2_time_over_threshold_x0 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r2_time_over_threshold_net,
    clk => clk_net,
    ce => ce_net,
    q => r2_time_over_threshold_q_net
  );
  r3_xmin : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r3_x_min_net,
    clk => clk_net,
    ce => ce_net,
    q => r3_xmin_q_net
  );
  r4_xmax : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r4_x_max_net,
    clk => clk_net,
    ce => ce_net,
    q => r4_xmax_q_net
  );
  r5_flags_x0 : entity xil_defaultlib.peak_detector_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r5_flags_net,
    clk => clk_net,
    ce => ce_net,
    q => r5_flags_q_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector_default_clock_driver is
  port (
    peak_detector_sysclk : in std_logic;
    peak_detector_sysce : in std_logic;
    peak_detector_sysclr : in std_logic;
    peak_detector_clk1 : out std_logic;
    peak_detector_ce1 : out std_logic
  );
end peak_detector_default_clock_driver;
architecture structural of peak_detector_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => peak_detector_sysclk,
    sysce => peak_detector_sysce,
    sysclr => peak_detector_sysclr,
    clk => peak_detector_clk1,
    ce => peak_detector_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity peak_detector is
  port (
    r1_blanking_time : in std_logic_vector( 32-1 downto 0 );
    r2_time_over_threshold : in std_logic_vector( 32-1 downto 0 );
    r3_x_min : in std_logic_vector( 32-1 downto 0 );
    r4_x_max : in std_logic_vector( 32-1 downto 0 );
    r5_flags : in std_logic_vector( 32-1 downto 0 );
    threshold : in std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : in std_logic;
    x : in std_logic_vector( 16-1 downto 0 );
    clk : in std_logic;
    dbg_1 : out std_logic_vector( 14-1 downto 0 );
    peak_amp : out std_logic_vector( 16-1 downto 0 );
    peak_amp_rdy : out std_logic
  );
end peak_detector;
architecture structural of peak_detector is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "peak_detector,sysgen_core_2022_2,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=1,ce_clr=0,clock_period=20,system_simulink_period=2e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.02,cmult=2,constant=3,convert=5,delay=3,inv=2,logical=4,mcode=7,register=10,reinterpret=10,relational=2,slice=7,}";
  signal ce_1_net : std_logic;
  signal clk_1_net : std_logic;
begin
  peak_detector_default_clock_driver : entity xil_defaultlib.peak_detector_default_clock_driver 
  port map (
    peak_detector_sysclk => clk,
    peak_detector_sysce => '1',
    peak_detector_sysclr => '0',
    peak_detector_clk1 => clk_1_net,
    peak_detector_ce1 => ce_1_net
  );
  peak_detector_struct : entity xil_defaultlib.peak_detector_struct 
  port map (
    r1_blanking_time => r1_blanking_time,
    r2_time_over_threshold => r2_time_over_threshold,
    r3_x_min => r3_x_min,
    r4_x_max => r4_x_max,
    r5_flags => r5_flags,
    threshold => threshold,
    threshold_invalid_n(0) => threshold_invalid_n,
    x => x,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    dbg_1 => dbg_1,
    peak_amp => peak_amp,
    peak_amp_rdy(0) => peak_amp_rdy
  );
end structural;
