-- Generated from Simulink block ip_scope/AxiBusDomain/toBool
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_tobool is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 1-1 downto 0 )
  );
end ip_scope_tobool;
architecture structural of ip_scope_tobool is 
  signal ce_net : std_logic;
  signal r2_wea_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
begin
  out1 <= convert_dout_net;
  r2_wea_net <= in1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.ip_scope_xlconvert 
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
    din => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  slice : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => r2_wea_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toBool1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_tobool1 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 1-1 downto 0 )
  );
end ip_scope_tobool1;
architecture structural of ip_scope_tobool1 is 
  signal r5_enable_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
begin
  out1 <= convert_dout_net;
  r5_enable_net <= in1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.ip_scope_xlconvert 
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
    din => slice_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  slice : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => r5_enable_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toSFIx
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_tosfix is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end ip_scope_tosfix;
architecture structural of ip_scope_tosfix is 
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal r4_threshold_net : std_logic_vector( 32-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r4_threshold_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_cf6db46343 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r4_threshold_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toUFix
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 11-1 downto 0 )
  );
end ip_scope_toufix;
architecture structural of ip_scope_toufix is 
  signal reinterpret3_output_port_net : std_logic_vector( 11-1 downto 0 );
  signal r1_addra_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 11-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r1_addra_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_749ec0155a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 10,
    x_width => 32,
    y_width => 11
  )
  port map (
    x => r1_addra_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toUFix1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix1 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 32-1 downto 0 )
  );
end ip_scope_toufix1;
architecture structural of ip_scope_toufix1 is 
  signal reinterpret3_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal r3_dina_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 32-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r3_dina_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_1f1ea39045 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 31,
    x_width => 32,
    y_width => 32
  )
  port map (
    x => r3_dina_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toUFix2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix2 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 11-1 downto 0 )
  );
end ip_scope_toufix2;
architecture structural of ip_scope_toufix2 is 
  signal r6_delay_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 11-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 11-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r6_delay_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_749ec0155a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 10,
    x_width => 32,
    y_width => 11
  )
  port map (
    x => r6_delay_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toUFix3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix3 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 8-1 downto 0 )
  );
end ip_scope_toufix3;
architecture structural of ip_scope_toufix3 is 
  signal reinterpret3_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal r9_down_sample_rate_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 8-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r9_down_sample_rate_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_17d5e55a3b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 7,
    x_width => 32,
    y_width => 8
  )
  port map (
    x => r9_down_sample_rate_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain/toUFix4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix4 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 6-1 downto 0 )
  );
end ip_scope_toufix4;
architecture structural of ip_scope_toufix4 is 
  signal reinterpret3_output_port_net : std_logic_vector( 6-1 downto 0 );
  signal r10_sample_mode_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 6-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  r10_sample_mode_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_f5f56dda1e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 5,
    x_width => 32,
    y_width => 6
  )
  port map (
    x => r10_sample_mode_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/AxiBusDomain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_axibusdomain is
  port (
    full : in std_logic_vector( 1-1 downto 0 );
    douta : in std_logic_vector( 32-1 downto 0 );
    r10_sample_mode : in std_logic_vector( 32-1 downto 0 );
    r1_addra : in std_logic_vector( 32-1 downto 0 );
    r2_wea : in std_logic_vector( 32-1 downto 0 );
    r3_dina : in std_logic_vector( 32-1 downto 0 );
    r4_threshold : in std_logic_vector( 32-1 downto 0 );
    r5_enable : in std_logic_vector( 32-1 downto 0 );
    r6_delay : in std_logic_vector( 32-1 downto 0 );
    r7_clear : in std_logic_vector( 32-1 downto 0 );
    r9_down_sample_rate : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    threshold : out std_logic_vector( 16-1 downto 0 );
    enable : out std_logic_vector( 1-1 downto 0 );
    delay : out std_logic_vector( 11-1 downto 0 );
    addra : out std_logic_vector( 11-1 downto 0 );
    dina : out std_logic_vector( 32-1 downto 0 );
    wea : out std_logic_vector( 1-1 downto 0 );
    down_sample_rate : out std_logic_vector( 8-1 downto 0 );
    sample_mode : out std_logic_vector( 6-1 downto 0 )
  );
end ip_scope_axibusdomain;
architecture structural of ip_scope_axibusdomain is 
  signal reinterpret3_output_port_net_x5 : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal r5_enable_net : std_logic_vector( 32-1 downto 0 );
  signal r6_delay_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 11-1 downto 0 );
  signal r7_clear_net : std_logic_vector( 32-1 downto 0 );
  signal r9_down_sample_rate_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal r3_dina_net : std_logic_vector( 32-1 downto 0 );
  signal r2_wea_net : std_logic_vector( 32-1 downto 0 );
  signal r10_sample_mode_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x4 : std_logic_vector( 11-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 8-1 downto 0 );
  signal r4_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x3 : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal r1_addra_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 6-1 downto 0 );
  signal dual_port_ram_douta_net : std_logic_vector( 32-1 downto 0 );
begin
  threshold <= reinterpret3_output_port_net_x5;
  enable <= convert_dout_net;
  delay <= reinterpret3_output_port_net_x2;
  addra <= reinterpret3_output_port_net_x4;
  dina <= reinterpret3_output_port_net_x3;
  wea <= convert_dout_net_x0;
  down_sample_rate <= reinterpret3_output_port_net;
  sample_mode <= reinterpret3_output_port_net_x0;
  register4_q_net <= full;
  dual_port_ram_douta_net <= douta;
  r10_sample_mode_net <= r10_sample_mode;
  r1_addra_net <= r1_addra;
  r2_wea_net <= r2_wea;
  r3_dina_net <= r3_dina;
  r4_threshold_net <= r4_threshold;
  r5_enable_net <= r5_enable;
  r6_delay_net <= r6_delay;
  r7_clear_net <= r7_clear;
  r9_down_sample_rate_net <= r9_down_sample_rate;
  clk_net <= clk_1;
  ce_net <= ce_1;
  tobool : entity xil_defaultlib.ip_scope_tobool 
  port map (
    in1 => r2_wea_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => convert_dout_net_x0
  );
  tobool1 : entity xil_defaultlib.ip_scope_tobool1 
  port map (
    in1 => r5_enable_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => convert_dout_net
  );
  tosfix : entity xil_defaultlib.ip_scope_tosfix 
  port map (
    in1 => r4_threshold_net,
    out1 => reinterpret3_output_port_net_x5
  );
  toufix : entity xil_defaultlib.ip_scope_toufix 
  port map (
    in1 => r1_addra_net,
    out1 => reinterpret3_output_port_net_x4
  );
  toufix1 : entity xil_defaultlib.ip_scope_toufix1 
  port map (
    in1 => r3_dina_net,
    out1 => reinterpret3_output_port_net_x3
  );
  toufix2 : entity xil_defaultlib.ip_scope_toufix2 
  port map (
    in1 => r6_delay_net,
    out1 => reinterpret3_output_port_net_x2
  );
  toufix3 : entity xil_defaultlib.ip_scope_toufix3 
  port map (
    in1 => r9_down_sample_rate_net,
    out1 => reinterpret3_output_port_net
  );
  toufix4 : entity xil_defaultlib.ip_scope_toufix4 
  port map (
    in1 => r10_sample_mode_net,
    out1 => reinterpret3_output_port_net_x0
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/delayLine
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_delayline is
  port (
    din : in std_logic_vector( 32-1 downto 0 );
    addr : in std_logic_vector( 11-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 32-1 downto 0 )
  );
end ip_scope_delayline;
architecture structural of ip_scope_delayline is 
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 11-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 11-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 11-1 downto 0 );
  signal counter_op_net : std_logic_vector( 11-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 11-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  dout <= single_port_ram_data_out_net;
  concat_y_net <= din;
  register2_q_net <= addr;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_f4d98d0287 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_1c29ff0c58 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  counter : entity xil_defaultlib.ip_scope_xlcounter_free 
  generic map (
    core_name0 => "ip_scope_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 11
  )
  port map (
    en => "1",
    rst => "0",
    clr => '0',
    load => relational_op_net,
    din => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_749ec0155a 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_f845914c88 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  single_port_ram : entity xil_defaultlib.ip_scope_xlspram 
  generic map (
    init_value => b"00000000000000000000000000000000",
    latency => 1,
    mem_init_file => "xpm_f79b36_vivado.mem",
    mem_size => 65536,
    mem_type => "block",
    read_reset_val => "0",
    width => 32,
    width_addr => 11,
    write_mode_a => "read_first",
    xpm_lat => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => concat_y_net,
    we => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => single_port_ram_data_out_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 10,
    x_width => 11,
    y_width => 11
  )
  port map (
    x => register2_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/risingEdgeTrigger
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_risingedgetrigger is
  port (
    x : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    re_trigg : out std_logic_vector( 1-1 downto 0 )
  );
end ip_scope_risingedgetrigger;
architecture structural of ip_scope_risingedgetrigger is 
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal reinterpret_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
begin
  re_trigg <= mcode_re_net;
  register4_q_net <= x;
  clk_net <= clk_1;
  ce_net <= ce_1;
  mcode : entity xil_defaultlib.sysgen_mcode_block_2be3aaba4a 
  port map (
    clr => '0',
    x => reinterpret_output_port_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode_y_net,
    re => mcode_re_net
  );
  reinterpret : entity xil_defaultlib.sysgen_reinterpret_0b927c7559 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_y_net,
    output_port => reinterpret_output_port_net
  );
  slice : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => register4_q_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/sample_mode_ch1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_sample_mode_ch1 is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    clk_en : in std_logic_vector( 1-1 downto 0 );
    down_sample_rate : in std_logic_vector( 8-1 downto 0 );
    ena : in std_logic_vector( 1-1 downto 0 );
    sample_mode : in std_logic_vector( 2-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end ip_scope_sample_mode_ch1;
architecture structural of ip_scope_sample_mode_ch1 is 
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal register6_q_net : std_logic_vector( 8-1 downto 0 );
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_eno_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_z_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal slice_y_net : std_logic_vector( 2-1 downto 0 );
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= mux_y_net;
  register2_q_net <= x;
  mcode_eno_net <= clk_en;
  register6_q_net <= down_sample_rate;
  register_q_net <= ena;
  slice_y_net <= sample_mode;
  clk_net <= clk_1;
  ce_net <= ce_1;
  mcode : entity xil_defaultlib.sysgen_mcode_block_e87c6ac3f2 
  port map (
    clr => '0',
    x => register2_q_net,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net,
    ena => register_q_net,
    clk => clk_net,
    ce => ce_net,
    z => mcode_z_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_7d7d8dfe4a 
  port map (
    clr => '0',
    x => register2_q_net,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net,
    ena => register_q_net,
    clk => clk_net,
    ce => ce_net,
    z => mcode1_z_net
  );
  mux : entity xil_defaultlib.sysgen_mux_d75d41ca60 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice_y_net,
    d0 => register2_q_net,
    d1 => mcode_z_net,
    d2 => mcode1_z_net,
    y => mux_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/sample_mode_ch2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_sample_mode_ch2 is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    clk_en : in std_logic_vector( 1-1 downto 0 );
    down_sample_rate : in std_logic_vector( 8-1 downto 0 );
    ena : in std_logic_vector( 1-1 downto 0 );
    sample_mode : in std_logic_vector( 2-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end ip_scope_sample_mode_ch2;
architecture structural of ip_scope_sample_mode_ch2 is 
  signal register6_q_net : std_logic_vector( 8-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 2-1 downto 0 );
  signal clk_net : std_logic;
  signal mcode_z_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal mcode_eno_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal register3_q_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= mux_y_net;
  register3_q_net <= x;
  mcode_eno_net <= clk_en;
  register6_q_net <= down_sample_rate;
  register_q_net <= ena;
  slice1_y_net <= sample_mode;
  clk_net <= clk_1;
  ce_net <= ce_1;
  mcode : entity xil_defaultlib.sysgen_mcode_block_e87c6ac3f2 
  port map (
    clr => '0',
    x => register3_q_net,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net,
    ena => register_q_net,
    clk => clk_net,
    ce => ce_net,
    z => mcode_z_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_7d7d8dfe4a 
  port map (
    clr => '0',
    x => register3_q_net,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net,
    ena => register_q_net,
    clk => clk_net,
    ce => ce_net,
    z => mcode1_z_net
  );
  mux : entity xil_defaultlib.sysgen_mux_d75d41ca60 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => slice1_y_net,
    d0 => register3_q_net,
    d1 => mcode_z_net,
    d2 => mcode1_z_net,
    y => mux_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/toUFix1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix1_x0 is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end ip_scope_toufix1_x0;
architecture structural of ip_scope_toufix1_x0 is 
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  mux_y_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_30d70cf429 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 16,
    y_width => 16
  )
  port map (
    x => mux_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain/toUFix2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_toufix2_x0 is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end ip_scope_toufix2_x0;
architecture structural of ip_scope_toufix2_x0 is 
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  mux_y_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_30d70cf429 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 16,
    y_width => 16
  )
  port map (
    x => mux_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block ip_scope/SignalDomain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_signaldomain is
  port (
    threshold : in std_logic_vector( 16-1 downto 0 );
    enable : in std_logic_vector( 1-1 downto 0 );
    delay : in std_logic_vector( 11-1 downto 0 );
    clear : in std_logic_vector( 32-1 downto 0 );
    down_sample_rate : in std_logic_vector( 8-1 downto 0 );
    sample_mode : in std_logic_vector( 6-1 downto 0 );
    ch1 : in std_logic_vector( 16-1 downto 0 );
    ch2 : in std_logic_vector( 16-1 downto 0 );
    ch_trigger : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    full_x0 : out std_logic_vector( 1-1 downto 0 );
    addrb : out std_logic_vector( 11-1 downto 0 );
    dinb : out std_logic_vector( 32-1 downto 0 );
    web : out std_logic_vector( 1-1 downto 0 );
    full : out std_logic_vector( 1-1 downto 0 )
  );
end ip_scope_signaldomain;
architecture structural of ip_scope_signaldomain is 
  signal register7_q_net_x0 : std_logic_vector( 6-1 downto 0 );
  signal mcode1_addr_net : std_logic_vector( 11-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register9_q_net : std_logic_vector( 1-1 downto 0 );
  signal ch1_net : std_logic_vector( 16-1 downto 0 );
  signal ch2_net : std_logic_vector( 16-1 downto 0 );
  signal register5_q_net : std_logic_vector( 8-1 downto 0 );
  signal mcode1_we_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 11-1 downto 0 );
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal register6_q_net : std_logic_vector( 6-1 downto 0 );
  signal mux_y_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register5_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal slice1_y_net : std_logic_vector( 2-1 downto 0 );
  signal mcode_eno_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 32-1 downto 0 );
  signal mcode1_full_net : std_logic_vector( 1-1 downto 0 );
  signal register6_q_net_x0 : std_logic_vector( 8-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 2-1 downto 0 );
  signal register1_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal ch_trigger_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_re_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal register3_q_net_x0 : std_logic_vector( 16-1 downto 0 );
begin
  full_x0 <= register9_q_net;
  addrb <= mcode1_addr_net;
  dinb <= single_port_ram_data_out_net;
  web <= mcode1_we_net;
  register_q_net <= threshold;
  register1_q_net <= enable;
  register2_q_net <= delay;
  register3_q_net <= clear;
  register5_q_net <= down_sample_rate;
  register6_q_net <= sample_mode;
  full <= register9_q_net;
  ch1_net <= ch1;
  ch2_net <= ch2;
  ch_trigger_net <= ch_trigger;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delayline : entity xil_defaultlib.ip_scope_delayline 
  port map (
    din => concat_y_net,
    addr => register2_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => single_port_ram_data_out_net
  );
  risingedgetrigger : entity xil_defaultlib.ip_scope_risingedgetrigger 
  port map (
    x => register4_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    re_trigg => mcode_re_net
  );
  sample_mode_ch1 : entity xil_defaultlib.ip_scope_sample_mode_ch1 
  port map (
    x => register2_q_net_x0,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net_x0,
    ena => register_q_net_x0,
    sample_mode => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => mux_y_net
  );
  sample_mode_ch2 : entity xil_defaultlib.ip_scope_sample_mode_ch2 
  port map (
    x => register3_q_net_x0,
    clk_en => mcode_eno_net,
    down_sample_rate => register6_q_net_x0,
    ena => register_q_net_x0,
    sample_mode => slice1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => mux_y_net_x0
  );
  toufix1 : entity xil_defaultlib.ip_scope_toufix1_x0 
  port map (
    in1 => mux_y_net_x0,
    out1 => reinterpret3_output_port_net
  );
  toufix2 : entity xil_defaultlib.ip_scope_toufix2_x0 
  port map (
    in1 => mux_y_net,
    out1 => reinterpret3_output_port_net_x0
  );
  concat : entity xil_defaultlib.sysgen_concat_f45ca58bd3 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => reinterpret3_output_port_net_x0,
    in1 => reinterpret3_output_port_net,
    y => concat_y_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_c162b331dc 
  port map (
    clr => '0',
    eni => register_q_net_x0,
    rate => register6_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    eno => mcode_eno_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_dd89f2f82f 
  port map (
    clr => '0',
    x => register1_q_net_x0,
    threshold => register5_q_net_x0,
    ena => register_q_net_x0,
    clear => mcode_re_net,
    clk_en => mcode_eno_net,
    clk => clk_net,
    ce => ce_net,
    addr => mcode1_addr_net,
    we => mcode1_we_net,
    full => mcode1_full_net
  );
  register_x0 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net_x0
  );
  register1 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => ch_trigger_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net_x0
  );
  register2 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => ch1_net,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net_x0
  );
  register3 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => ch2_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net_x0
  );
  register4 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => register3_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => register_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net_x0
  );
  register6 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 8,
    init_value => b"00000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => register5_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register6_q_net_x0
  );
  register7 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 6,
    init_value => b"000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => register6_q_net,
    clk => clk_net,
    ce => ce_net,
    q => register7_q_net_x0
  );
  register9 : entity xil_defaultlib.ip_scope_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => mcode1_full_net,
    clk => clk_net,
    ce => ce_net,
    q => register9_q_net
  );
  slice : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 1,
    x_width => 6,
    y_width => 2
  )
  port map (
    x => register7_q_net_x0,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.ip_scope_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 3,
    x_width => 6,
    y_width => 2
  )
  port map (
    x => register7_q_net_x0,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block ip_scope_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_struct is
  port (
    r10_sample_mode : in std_logic_vector( 32-1 downto 0 );
    r11_trigger_mode : in std_logic_vector( 32-1 downto 0 );
    r1_addra : in std_logic_vector( 32-1 downto 0 );
    r2_wea : in std_logic_vector( 32-1 downto 0 );
    r3_dina : in std_logic_vector( 32-1 downto 0 );
    r4_threshold : in std_logic_vector( 32-1 downto 0 );
    r5_enable : in std_logic_vector( 32-1 downto 0 );
    r6_delay : in std_logic_vector( 32-1 downto 0 );
    r7_clear : in std_logic_vector( 32-1 downto 0 );
    r9_down_sample_rate : in std_logic_vector( 32-1 downto 0 );
    ch1 : in std_logic_vector( 16-1 downto 0 );
    ch2 : in std_logic_vector( 16-1 downto 0 );
    ch_trigger : in std_logic_vector( 16-1 downto 0 );
    clk_1_x0 : in std_logic;
    ce_1_x0 : in std_logic;
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    r12_douta : out std_logic_vector( 32-1 downto 0 );
    r8_full : out std_logic_vector( 1-1 downto 0 );
    full : out std_logic_vector( 1-1 downto 0 )
  );
end ip_scope_struct;
architecture structural of ip_scope_struct is 
  signal r5_enable_net : std_logic_vector( 32-1 downto 0 );
  signal r6_delay_net : std_logic_vector( 32-1 downto 0 );
  signal r7_clear_net : std_logic_vector( 32-1 downto 0 );
  signal r11_trigger_mode_net : std_logic_vector( 32-1 downto 0 );
  signal r4_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r10_sample_mode_net : std_logic_vector( 32-1 downto 0 );
  signal dual_port_ram_douta_net : std_logic_vector( 32-1 downto 0 );
  signal r2_wea_net : std_logic_vector( 32-1 downto 0 );
  signal r3_dina_net : std_logic_vector( 32-1 downto 0 );
  signal r1_addra_net : std_logic_vector( 32-1 downto 0 );
  signal register1_q_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_addr_net : std_logic_vector( 11-1 downto 0 );
  signal ce_net : std_logic;
  signal convert_dout_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 8-1 downto 0 );
  signal r9_down_sample_rate_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x3 : std_logic_vector( 32-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 1-1 downto 0 );
  signal dual_port_ram_doutb_net : std_logic_vector( 32-1 downto 0 );
  signal register_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net_x4 : std_logic_vector( 11-1 downto 0 );
  signal clk_net : std_logic;
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 11-1 downto 0 );
  signal ch_trigger_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net_x5 : std_logic_vector( 16-1 downto 0 );
  signal ch1_net : std_logic_vector( 16-1 downto 0 );
  signal register9_q_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_we_net : std_logic_vector( 1-1 downto 0 );
  signal register2_q_net : std_logic_vector( 11-1 downto 0 );
  signal register5_q_net : std_logic_vector( 8-1 downto 0 );
  signal ch2_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal register6_q_net : std_logic_vector( 6-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 6-1 downto 0 );
  signal ce_net_x0 : std_logic;
begin
  r10_sample_mode_net <= r10_sample_mode;
  r11_trigger_mode_net <= r11_trigger_mode;
  r12_douta <= dual_port_ram_douta_net;
  r1_addra_net <= r1_addra;
  r2_wea_net <= r2_wea;
  r3_dina_net <= r3_dina;
  r4_threshold_net <= r4_threshold;
  r5_enable_net <= r5_enable;
  r6_delay_net <= r6_delay;
  r7_clear_net <= r7_clear;
  r8_full <= register4_q_net;
  r9_down_sample_rate_net <= r9_down_sample_rate;
  full <= register9_q_net;
  ch1_net <= ch1;
  ch2_net <= ch2;
  ch_trigger_net <= ch_trigger;
  clk_net <= clk_1_x0;
  ce_net <= ce_1_x0;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  axibusdomain : entity xil_defaultlib.ip_scope_axibusdomain 
  port map (
    full => register4_q_net,
    douta => dual_port_ram_douta_net,
    r10_sample_mode => r10_sample_mode_net,
    r1_addra => r1_addra_net,
    r2_wea => r2_wea_net,
    r3_dina => r3_dina_net,
    r4_threshold => r4_threshold_net,
    r5_enable => r5_enable_net,
    r6_delay => r6_delay_net,
    r7_clear => r7_clear_net,
    r9_down_sample_rate => r9_down_sample_rate_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    threshold => reinterpret3_output_port_net_x5,
    enable => convert_dout_net,
    delay => reinterpret3_output_port_net_x2,
    addra => reinterpret3_output_port_net_x4,
    dina => reinterpret3_output_port_net_x3,
    wea => convert_dout_net_x0,
    down_sample_rate => reinterpret3_output_port_net_x1,
    sample_mode => reinterpret3_output_port_net_x0
  );
  signaldomain : entity xil_defaultlib.ip_scope_signaldomain 
  port map (
    threshold => register_q_net,
    enable => register1_q_net,
    delay => register2_q_net,
    clear => register3_q_net,
    down_sample_rate => register5_q_net,
    sample_mode => register6_q_net,
    ch1 => ch1_net,
    ch2 => ch2_net,
    ch_trigger => ch_trigger_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    full_x0 => register9_q_net,
    addrb => mcode1_addr_net,
    dinb => single_port_ram_data_out_net,
    web => mcode1_we_net,
    full => register9_q_net
  );
  dual_port_ram : entity xil_defaultlib.ip_scope_xltdpram 
  generic map (
    addr_width_b => 11,
    clocking_mode => "independent_clock",
    data_width_b => 32,
    latency => 1,
    mem_init_file => "xpm_f79b36_dpram.mem",
    mem_size => 65536,
    read_reset_a => "0",
    read_reset_b => "0",
    width => 32,
    width_addr => 11,
    write_mode_a => "write_first",
    write_mode_b => "write_first"
  )
  port map (
    ena => "1",
    enb => "1",
    rsta => "0",
    rstb => "0",
    addra => reinterpret3_output_port_net_x4,
    dina => reinterpret3_output_port_net_x3,
    wea => convert_dout_net_x0,
    addrb => mcode1_addr_net,
    dinb => single_port_ram_data_out_net,
    web => mcode1_we_net,
    a_clk => clk_net_x0,
    a_ce => ce_net_x0,
    b_clk => clk_net,
    b_ce => ce_net,
    douta => dual_port_ram_douta_net,
    doutb => dual_port_ram_doutb_net
  );
  register_x0 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 16,
    init_value => b"0000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net_x5,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register_q_net
  );
  register1 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => convert_dout_net,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register1_q_net
  );
  register2 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 11,
    init_value => b"00000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net_x2,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r7_clear_net,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    en => "1",
    rst => "0",
    d => register9_q_net,
    d_clk => clk_net,
    q_ce => ce_net,
    q_clk => clk_net_x0,
    d_ce => ce_net_x0,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 8,
    init_value => b"00000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net_x1,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register5_q_net
  );
  register6 : entity xil_defaultlib.ip_scope_xlAsynRegister 
  generic map (
    d_width => 6,
    init_value => b"000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => reinterpret3_output_port_net_x0,
    d_clk => clk_net_x0,
    q_ce => ce_net_x0,
    q_clk => clk_net,
    d_ce => ce_net,
    q => register6_q_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope_default_clock_driver is
  port (
    signaldomain_sysclk : in std_logic;
    signaldomain_sysce : in std_logic;
    signaldomain_sysclr : in std_logic;
    axibusdomain_sysclk : in std_logic;
    axibusdomain_sysce : in std_logic;
    axibusdomain_sysclr : in std_logic;
    signaldomain_clk1 : out std_logic;
    signaldomain_ce1 : out std_logic;
    axibusdomain_clk1 : out std_logic;
    axibusdomain_ce1 : out std_logic
  );
end ip_scope_default_clock_driver;
architecture structural of ip_scope_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => signaldomain_sysclk,
    sysce => signaldomain_sysce,
    sysclr => signaldomain_sysclr,
    clk => signaldomain_clk1,
    ce => signaldomain_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => axibusdomain_sysclk,
    sysce => axibusdomain_sysce,
    sysclr => axibusdomain_sysclr,
    clk => axibusdomain_clk1,
    ce => axibusdomain_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_scope is
  port (
    ch1 : in std_logic_vector( 16-1 downto 0 );
    ch2 : in std_logic_vector( 16-1 downto 0 );
    ch_trigger : in std_logic_vector( 16-1 downto 0 );
    signaldomain_clk : in std_logic;
    axibusdomain_clk : in std_logic;
    axibusdomain_aresetn : in std_logic;
    axibusdomain_s_axi_awaddr : in std_logic_vector( 6-1 downto 0 );
    axibusdomain_s_axi_awvalid : in std_logic;
    axibusdomain_s_axi_wdata : in std_logic_vector( 32-1 downto 0 );
    axibusdomain_s_axi_wstrb : in std_logic_vector( 4-1 downto 0 );
    axibusdomain_s_axi_wvalid : in std_logic;
    axibusdomain_s_axi_bready : in std_logic;
    axibusdomain_s_axi_araddr : in std_logic_vector( 6-1 downto 0 );
    axibusdomain_s_axi_arvalid : in std_logic;
    axibusdomain_s_axi_rready : in std_logic;
    full : out std_logic_vector( 1-1 downto 0 );
    axibusdomain_s_axi_awready : out std_logic;
    axibusdomain_s_axi_wready : out std_logic;
    axibusdomain_s_axi_bresp : out std_logic_vector( 2-1 downto 0 );
    axibusdomain_s_axi_bvalid : out std_logic;
    axibusdomain_s_axi_arready : out std_logic;
    axibusdomain_s_axi_rdata : out std_logic_vector( 32-1 downto 0 );
    axibusdomain_s_axi_rresp : out std_logic_vector( 2-1 downto 0 );
    axibusdomain_s_axi_rvalid : out std_logic
  );
end ip_scope;
architecture structural of ip_scope is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "ip_scope,sysgen_core_2019_1,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=0,ce_clr=0,clock_period=-10,system_simulink_period=-1,waveform_viewer=0,axilite_interface=1,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.0008,concat=1,constant=2,convert=2,counter=1,dpram=1,mcode=7,mux=2,register=18,reinterpret=11,relational=1,slice=15,spram=1,}";
  signal r2_wea : std_logic_vector( 32-1 downto 0 );
  signal r3_dina : std_logic_vector( 32-1 downto 0 );
  signal r5_enable : std_logic_vector( 32-1 downto 0 );
  signal r4_threshold : std_logic_vector( 32-1 downto 0 );
  signal r6_delay : std_logic_vector( 32-1 downto 0 );
  signal r10_sample_mode : std_logic_vector( 32-1 downto 0 );
  signal r7_clear : std_logic_vector( 32-1 downto 0 );
  signal r8_full : std_logic_vector( 1-1 downto 0 );
  signal r11_trigger_mode : std_logic_vector( 32-1 downto 0 );
  signal r12_douta : std_logic_vector( 32-1 downto 0 );
  signal r1_addra : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net_x0 : std_logic;
  signal r9_down_sample_rate : std_logic_vector( 32-1 downto 0 );
  signal clk_1_net : std_logic;
  signal ce_1_net_x0 : std_logic;
  signal ce_1_net : std_logic;
  signal axibusdomain_clk_net : std_logic;
begin
  axibusdomain_axi_lite_interface : entity xil_defaultlib.axibusdomain_axi_lite_interface 
  port map (
    r12_douta => r12_douta,
    r8_full => r8_full,
    axibusdomain_s_axi_awaddr => axibusdomain_s_axi_awaddr,
    axibusdomain_s_axi_awvalid => axibusdomain_s_axi_awvalid,
    axibusdomain_s_axi_wdata => axibusdomain_s_axi_wdata,
    axibusdomain_s_axi_wstrb => axibusdomain_s_axi_wstrb,
    axibusdomain_s_axi_wvalid => axibusdomain_s_axi_wvalid,
    axibusdomain_s_axi_bready => axibusdomain_s_axi_bready,
    axibusdomain_s_axi_araddr => axibusdomain_s_axi_araddr,
    axibusdomain_s_axi_arvalid => axibusdomain_s_axi_arvalid,
    axibusdomain_s_axi_rready => axibusdomain_s_axi_rready,
    axibusdomain_aresetn => axibusdomain_aresetn,
    axibusdomain_aclk => axibusdomain_clk,
    r9_down_sample_rate => r9_down_sample_rate,
    r7_clear => r7_clear,
    r6_delay => r6_delay,
    r5_enable => r5_enable,
    r4_threshold => r4_threshold,
    r3_dina => r3_dina,
    r2_wea => r2_wea,
    r1_addra => r1_addra,
    r11_trigger_mode => r11_trigger_mode,
    r10_sample_mode => r10_sample_mode,
    axibusdomain_s_axi_awready => axibusdomain_s_axi_awready,
    axibusdomain_s_axi_wready => axibusdomain_s_axi_wready,
    axibusdomain_s_axi_bresp => axibusdomain_s_axi_bresp,
    axibusdomain_s_axi_bvalid => axibusdomain_s_axi_bvalid,
    axibusdomain_s_axi_arready => axibusdomain_s_axi_arready,
    axibusdomain_s_axi_rdata => axibusdomain_s_axi_rdata,
    axibusdomain_s_axi_rresp => axibusdomain_s_axi_rresp,
    axibusdomain_s_axi_rvalid => axibusdomain_s_axi_rvalid,
    axibusdomain_clk => axibusdomain_clk_net
  );
  ip_scope_default_clock_driver : entity xil_defaultlib.ip_scope_default_clock_driver 
  port map (
    signaldomain_sysclk => signaldomain_clk,
    signaldomain_sysce => '1',
    signaldomain_sysclr => '0',
    axibusdomain_sysclk => axibusdomain_clk_net,
    axibusdomain_sysce => '1',
    axibusdomain_sysclr => '0',
    signaldomain_clk1 => clk_1_net_x0,
    signaldomain_ce1 => ce_1_net_x0,
    axibusdomain_clk1 => clk_1_net,
    axibusdomain_ce1 => ce_1_net
  );
  ip_scope_struct : entity xil_defaultlib.ip_scope_struct 
  port map (
    r10_sample_mode => r10_sample_mode,
    r11_trigger_mode => r11_trigger_mode,
    r1_addra => r1_addra,
    r2_wea => r2_wea,
    r3_dina => r3_dina,
    r4_threshold => r4_threshold,
    r5_enable => r5_enable,
    r6_delay => r6_delay,
    r7_clear => r7_clear,
    r9_down_sample_rate => r9_down_sample_rate,
    ch1 => ch1,
    ch2 => ch2,
    ch_trigger => ch_trigger,
    clk_1_x0 => clk_1_net_x0,
    ce_1_x0 => ce_1_net_x0,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    r12_douta => r12_douta,
    r8_full => r8_full,
    full => full
  );
end structural;
