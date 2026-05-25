-- Generated from Simulink block shaper/axi_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_axi_clk_domain is
  port (
    r10_flags : in std_logic_vector( 32-1 downto 0 );
    r11_dc_offset_2 : in std_logic_vector( 32-1 downto 0 );
    r1_b10 : in std_logic_vector( 32-1 downto 0 );
    r2_na_inv : in std_logic_vector( 32-1 downto 0 );
    r3_na : in std_logic_vector( 32-1 downto 0 );
    r4_nb : in std_logic_vector( 32-1 downto 0 );
    r5_b20 : in std_logic_vector( 32-1 downto 0 );
    r6_dc_offset_1 : in std_logic_vector( 32-1 downto 0 );
    r7_b2 : in std_logic_vector( 32-1 downto 0 );
    r8_b1 : in std_logic_vector( 32-1 downto 0 );
    r9_aa20 : in std_logic_vector( 32-1 downto 0 )
  );
end shaper_axi_clk_domain;
architecture structural of shaper_axi_clk_domain is 
  signal r10_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r6_dc_offset_1_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b20_net : std_logic_vector( 32-1 downto 0 );
  signal r7_b2_net : std_logic_vector( 32-1 downto 0 );
  signal r4_nb_net : std_logic_vector( 32-1 downto 0 );
  signal r1_b10_net : std_logic_vector( 32-1 downto 0 );
  signal r11_dc_offset_2_net : std_logic_vector( 32-1 downto 0 );
  signal r3_na_net : std_logic_vector( 32-1 downto 0 );
  signal r8_b1_net : std_logic_vector( 32-1 downto 0 );
  signal r9_aa20_net : std_logic_vector( 32-1 downto 0 );
  signal r2_na_inv_net : std_logic_vector( 32-1 downto 0 );
begin
  r10_flags_net <= r10_flags;
  r11_dc_offset_2_net <= r11_dc_offset_2;
  r1_b10_net <= r1_b10;
  r2_na_inv_net <= r2_na_inv;
  r3_na_net <= r3_na;
  r4_nb_net <= r4_nb;
  r5_b20_net <= r5_b20;
  r6_dc_offset_1_net <= r6_dc_offset_1;
  r7_b2_net <= r7_b2;
  r8_b1_net <= r8_b1;
  r9_aa20_net <= r9_aa20;
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/Normalization1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_normalization1 is
  port (
    in1 : in std_logic_vector( 36-1 downto 0 );
    nf : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 18-1 downto 0 )
  );
end shaper_normalization1;
architecture structural of shaper_normalization1 is 
  signal ce_net : std_logic;
  signal convert_dout_net : std_logic_vector( 36-1 downto 0 );
  signal clk_net : std_logic;
  signal reinterpret2_output_port_net : std_logic_vector( 18-1 downto 0 );
  signal delay_q_net : std_logic_vector( 18-1 downto 0 );
  signal register2_q_net : std_logic_vector( 32-1 downto 0 );
  signal mult_p_net : std_logic_vector( 18-1 downto 0 );
  signal slice2_y_net : std_logic_vector( 18-1 downto 0 );
begin
  out1 <= delay_q_net;
  convert_dout_net <= in1;
  register2_q_net <= nf;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delay : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 18
  )
  port map (
    en => '1',
    rst => '0',
    d => mult_p_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mult : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 23,
    a_width => 36,
    b_arith => xlUnsigned,
    b_bin_pt => 18,
    b_width => 18,
    c_a_type => 0,
    c_a_width => 36,
    c_b_type => 1,
    c_b_width => 18,
    c_baat => 36,
    c_output_width => 54,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 18,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => convert_dout_net,
    b => reinterpret2_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  reinterpret2 : entity xil_defaultlib.sysgen_reinterpret_60202eff2c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice2_y_net,
    output_port => reinterpret2_output_port_net
  );
  slice2 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 17,
    x_width => 32,
    y_width => 18
  )
  port map (
    x => register2_q_net,
    y => slice2_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/Overflow
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_overflow is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    of_x0 : out std_logic_vector( 1-1 downto 0 )
  );
end shaper_overflow;
architecture structural of shaper_overflow is 
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 16-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
begin
  of_x0 <= relational_op_net;
  mcode_y_net <= x;
  slice_y_net <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_08104d262e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_b65b0df425 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  mux : entity xil_defaultlib.sysgen_mux_85c585d2a3 
  port map (
    clr => '0',
    sel => slice_y_net,
    d0 => constant_op_net,
    d1 => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    y => mux_y_net
  );
  relational : entity xil_defaultlib.sysgen_relational_ed701c3806 
  port map (
    clr => '0',
    a => delay_q_net,
    b => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  delay : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => mcode_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/bipolar/delayLine
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_delayline is
  port (
    din : in std_logic_vector( 24-1 downto 0 );
    addr : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 24-1 downto 0 )
  );
end shaper_delayline;
architecture structural of shaper_delayline is 
  signal subtractor_s_net : std_logic_vector( 24-1 downto 0 );
  signal add_s_net : std_logic_vector( 10-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal single_port_ram_data_out_net : std_logic_vector( 24-1 downto 0 );
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 10-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 10-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 10-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
begin
  dout <= single_port_ram_data_out_net;
  subtractor_s_net <= din;
  add_s_net <= addr;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_0a1632bad0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5ff2b537ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  counter : entity xil_defaultlib.shaper_xlcounter_free 
  generic map (
    core_name0 => "shaper_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 10
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
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_4ba09cd993 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_1931267d49 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  single_port_ram : entity xil_defaultlib.shaper_xlspram 
  generic map (
    init_value => b"000000000000000000000000",
    latency => 1,
    mem_init_file => "xpm_f5fed5_vivado.mem",
    mem_size => 24576,
    mem_type => "block",
    read_reset_val => "0",
    width => 24,
    width_addr => 10,
    write_mode_a => "read_first",
    xpm_lat => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => subtractor_s_net,
    we => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => single_port_ram_data_out_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 10,
    y_width => 10
  )
  port map (
    x => add_s_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/bipolar
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_bipolar is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    na : in std_logic_vector( 10-1 downto 0 );
    nb : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end shaper_bipolar;
architecture structural of shaper_bipolar is 
  signal sub_s_net : std_logic_vector( 16-1 downto 0 );
  signal subtractor_s_net : std_logic_vector( 24-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 10-1 downto 0 );
  signal clk_net : std_logic;
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal single_port_ram_data_out_net : std_logic_vector( 24-1 downto 0 );
  signal add_s_net : std_logic_vector( 10-1 downto 0 );
begin
  y <= sub_s_net;
  subtractor_s_net <= x;
  slice1_y_net <= na;
  register4_q_net <= nb;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delayline : entity xil_defaultlib.shaper_delayline 
  port map (
    din => subtractor_s_net,
    addr => add_s_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => single_port_ram_data_out_net
  );
  add : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 0,
    a_width => 10,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 33,
    core_name0 => "shaper_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 1,
    full_s_width => 33,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlUnsigned,
    s_bin_pt => 0,
    s_width => 10
  )
  port map (
    clr => '0',
    en => "1",
    a => slice1_y_net,
    b => register4_q_net,
    clk => clk_net,
    ce => ce_net,
    s => add_s_net
  );
  sub : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "shaper_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    en => "1",
    a => subtractor_s_net,
    b => single_port_ram_data_out_net,
    clk => clk_net,
    ce => ce_net,
    s => sub_s_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/movingAverage1/delayLine
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_delayline_x1 is
  port (
    din : in std_logic_vector( 36-1 downto 0 );
    addr : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end shaper_delayline_x1;
architecture structural of shaper_delayline_x1 is 
  signal reinterpret3_output_port_net : std_logic_vector( 10-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 36-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 10-1 downto 0 );
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 10-1 downto 0 );
  signal accumulator_q_net : std_logic_vector( 36-1 downto 0 );
  signal constant_op_net : std_logic_vector( 10-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
begin
  dout <= single_port_ram_data_out_net;
  accumulator_q_net <= din;
  slice1_y_net <= addr;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_0a1632bad0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5ff2b537ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  counter : entity xil_defaultlib.shaper_xlcounter_free 
  generic map (
    core_name0 => "shaper_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 10
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
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_4ba09cd993 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_1931267d49 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  single_port_ram : entity xil_defaultlib.shaper_xlspram 
  generic map (
    init_value => b"000000000000000000000000000000000000",
    latency => 1,
    mem_init_file => "xpm_f5fed5_vivado.mem",
    mem_size => 36864,
    mem_type => "block",
    read_reset_val => "0",
    width => 36,
    width_addr => 10,
    write_mode_a => "read_first",
    xpm_lat => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => accumulator_q_net,
    we => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => single_port_ram_data_out_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 10,
    y_width => 10
  )
  port map (
    x => slice1_y_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/movingAverage1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_movingaverage1 is
  port (
    in1 : in std_logic_vector( 28-1 downto 0 );
    n : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 36-1 downto 0 )
  );
end shaper_movingaverage1;
architecture structural of shaper_movingaverage1 is 
  signal convert_dout_net : std_logic_vector( 36-1 downto 0 );
  signal subtractor1_s_net : std_logic_vector( 28-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 36-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 10-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal accumulator_q_net : std_logic_vector( 36-1 downto 0 );
  signal sub_s_net : std_logic_vector( 36-1 downto 0 );
begin
  out1 <= convert_dout_net;
  subtractor1_s_net <= in1;
  slice1_y_net <= n;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delayline : entity xil_defaultlib.shaper_delayline_x1 
  port map (
    din => accumulator_q_net,
    addr => slice1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => single_port_ram_data_out_net
  );
  accumulator : entity xil_defaultlib.sysgen_accum_839b0f77f1 
  port map (
    clr => '0',
    b => subtractor1_s_net,
    clk => clk_net,
    ce => ce_net,
    q => accumulator_q_net
  );
  convert : entity xil_defaultlib.shaper_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 23,
    din_width => 36,
    dout_arith => 2,
    dout_bin_pt => 23,
    dout_width => 36,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => sub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  sub : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 23,
    a_width => 36,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 36,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 37,
    core_name0 => "shaper_c_addsub_v12_0_i2",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 37,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 23,
    s_width => 36
  )
  port map (
    clr => '0',
    en => "1",
    a => accumulator_q_net,
    b => single_port_ram_data_out_net,
    clk => clk_net,
    ce => ce_net,
    s => sub_s_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/movingAverage2/delayLine
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_delayline_x0 is
  port (
    din : in std_logic_vector( 36-1 downto 0 );
    addr : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    dout : out std_logic_vector( 36-1 downto 0 )
  );
end shaper_delayline_x0;
architecture structural of shaper_delayline_x0 is 
  signal ce_net : std_logic;
  signal constant1_op_net : std_logic_vector( 1-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 10-1 downto 0 );
  signal accumulator_q_net : std_logic_vector( 36-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 36-1 downto 0 );
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal constant_op_net : std_logic_vector( 10-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 10-1 downto 0 );
begin
  dout <= single_port_ram_data_out_net;
  accumulator_q_net <= din;
  register4_q_net <= addr;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_0a1632bad0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_5ff2b537ee 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  counter : entity xil_defaultlib.shaper_xlcounter_free 
  generic map (
    core_name0 => "shaper_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 10
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
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_4ba09cd993 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  relational : entity xil_defaultlib.sysgen_relational_1931267d49 
  port map (
    clr => '0',
    a => reinterpret3_output_port_net,
    b => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
  single_port_ram : entity xil_defaultlib.shaper_xlspram 
  generic map (
    init_value => b"000000000000000000000000000000000000",
    latency => 1,
    mem_init_file => "xpm_f5fed5_vivado.mem",
    mem_size => 36864,
    mem_type => "block",
    read_reset_val => "0",
    width => 36,
    width_addr => 10,
    write_mode_a => "read_first",
    xpm_lat => 1
  )
  port map (
    en => "1",
    rst => "0",
    addr => counter_op_net,
    data_in => accumulator_q_net,
    we => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    data_out => single_port_ram_data_out_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => register4_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/movingAverage2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_movingaverage2 is
  port (
    in1 : in std_logic_vector( 18-1 downto 0 );
    n : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 24-1 downto 0 )
  );
end shaper_movingaverage2;
architecture structural of shaper_movingaverage2 is 
  signal delay_q_net : std_logic_vector( 18-1 downto 0 );
  signal accumulator_q_net : std_logic_vector( 36-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal sub_s_net : std_logic_vector( 36-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal single_port_ram_data_out_net : std_logic_vector( 36-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
begin
  out1 <= convert_dout_net;
  delay_q_net <= in1;
  register4_q_net <= n;
  clk_net <= clk_1;
  ce_net <= ce_1;
  delayline : entity xil_defaultlib.shaper_delayline_x0 
  port map (
    din => accumulator_q_net,
    addr => register4_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    dout => single_port_ram_data_out_net
  );
  accumulator : entity xil_defaultlib.sysgen_accum_6b296a6a89 
  port map (
    clr => '0',
    b => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => accumulator_q_net
  );
  convert : entity xil_defaultlib.shaper_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 36,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 24,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => sub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  sub : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 36,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 36,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 37,
    core_name0 => "shaper_c_addsub_v12_0_i2",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 37,
    latency => 1,
    overflow => 1,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 36
  )
  port map (
    clr => '0',
    en => "1",
    a => accumulator_q_net,
    b => single_port_ram_data_out_net,
    clk => clk_net,
    ce => ce_net,
    s => sub_s_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/offset/toSFIx
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_tosfix is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end shaper_tosfix;
architecture structural of shaper_tosfix is 
  signal register7_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register7_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_29c4b7c846 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => register7_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/offset
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_offset is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    dc_offset : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 16-1 downto 0 )
  );
end shaper_offset;
architecture structural of shaper_offset is 
  signal register7_q_net : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
begin
  out1 <= addsub1_s_net;
  mcode_y_net <= in1;
  register7_q_net <= dc_offset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  tosfix : entity xil_defaultlib.shaper_tosfix 
  port map (
    in1 => register7_q_net,
    out1 => reinterpret3_output_port_net
  );
  addsub1 : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 17,
    core_name0 => "shaper_c_addsub_v12_0_i3",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    en => "1",
    a => delay_q_net,
    b => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  delay : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => mcode_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/offset2/toSFIx
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_tosfix_x0 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 24-1 downto 0 )
  );
end shaper_tosfix_x0;
architecture structural of shaper_tosfix_x0 is 
  signal register11_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 24-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 24-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register11_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_94aea5db82 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 23,
    x_width => 32,
    y_width => 24
  )
  port map (
    x => register11_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/offset2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_offset2 is
  port (
    in1 : in std_logic_vector( 24-1 downto 0 );
    dc_offset : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 24-1 downto 0 )
  );
end shaper_offset2;
architecture structural of shaper_offset2 is 
  signal reinterpret3_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal subtractor_s_net : std_logic_vector( 24-1 downto 0 );
  signal ce_net : std_logic;
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal register11_q_net : std_logic_vector( 32-1 downto 0 );
begin
  out1 <= subtractor_s_net;
  convert_dout_net <= in1;
  register11_q_net <= dc_offset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  tosfix : entity xil_defaultlib.shaper_tosfix_x0 
  port map (
    in1 => register11_q_net,
    out1 => reinterpret3_output_port_net
  );
  subtractor : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "shaper_c_addsub_v12_0_i4",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 24
  )
  port map (
    clr => '0',
    en => "1",
    a => convert_dout_net,
    b => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    s => subtractor_s_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/poles_correction/toUFix
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_toufix is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_toufix;
architecture structural of shaper_toufix is 
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register5_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ee7e285d6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 24,
    x_width => 32,
    y_width => 25
  )
  port map (
    x => register5_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/poles_correction/toUFix2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_toufix2 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_toufix2;
architecture structural of shaper_toufix2 is 
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
  signal register9_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register9_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ee7e285d6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 24,
    x_width => 32,
    y_width => 25
  )
  port map (
    x => register9_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/poles_correction/toUFix3
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_toufix3 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_toufix3;
architecture structural of shaper_toufix3 is 
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
  signal register8_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register8_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ee7e285d6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 24,
    x_width => 32,
    y_width => 25
  )
  port map (
    x => register8_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/poles_correction/toUFix4
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_toufix4 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_toufix4;
architecture structural of shaper_toufix4 is 
  signal register6_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 25-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register6_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ee7e285d6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 24,
    x_width => 32,
    y_width => 25
  )
  port map (
    x => register6_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/poles_correction
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_poles_correction is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    b1 : in std_logic_vector( 32-1 downto 0 );
    b2 : in std_logic_vector( 32-1 downto 0 );
    aa20 : in std_logic_vector( 32-1 downto 0 );
    b20 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_poles_correction;
architecture structural of shaper_poles_correction is 
  signal reinterpret3_output_port_net_x1 : std_logic_vector( 25-1 downto 0 );
  signal reinterpret3_output_port_net_x2 : std_logic_vector( 25-1 downto 0 );
  signal multiplier2_p_net : std_logic_vector( 25-1 downto 0 );
  signal addsub1_s_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register8_q_net : std_logic_vector( 32-1 downto 0 );
  signal register6_q_net : std_logic_vector( 32-1 downto 0 );
  signal register9_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net_x0 : std_logic_vector( 25-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 43-1 downto 0 );
  signal multiplier3_p_net : std_logic_vector( 39-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 39-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 16-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 43-1 downto 0 );
  signal multiplier4_p_net : std_logic_vector( 43-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 41-1 downto 0 );
  signal multiplier1_p_net : std_logic_vector( 40-1 downto 0 );
  signal delay_q_net : std_logic_vector( 43-1 downto 0 );
begin
  out1 <= multiplier2_p_net;
  addsub1_s_net_x0 <= x;
  register8_q_net <= b1;
  register6_q_net <= b2;
  register9_q_net <= aa20;
  register5_q_net <= b20;
  clk_net <= clk_1;
  ce_net <= ce_1;
  toufix : entity xil_defaultlib.shaper_toufix 
  port map (
    in1 => register5_q_net,
    out1 => reinterpret3_output_port_net_x0
  );
  toufix2 : entity xil_defaultlib.shaper_toufix2 
  port map (
    in1 => register9_q_net,
    out1 => reinterpret3_output_port_net_x1
  );
  toufix3 : entity xil_defaultlib.shaper_toufix3 
  port map (
    in1 => register8_q_net,
    out1 => reinterpret3_output_port_net_x2
  );
  toufix4 : entity xil_defaultlib.shaper_toufix4 
  port map (
    in1 => register6_q_net,
    out1 => reinterpret3_output_port_net
  );
  addsub : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlSigned,
    b_bin_pt => 37,
    b_width => 43,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 44,
    core_name0 => "shaper_c_addsub_v12_0_i5",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 44,
    latency => 0,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 37,
    s_width => 43
  )
  port map (
    clr => '0',
    en => "1",
    a => delay2_q_net,
    b => addsub2_s_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 37,
    a_width => 39,
    b_arith => xlSigned,
    b_bin_pt => 37,
    b_width => 40,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 41,
    core_name0 => "shaper_c_addsub_v12_0_i6",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 41,
    latency => 0,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 37,
    s_width => 41
  )
  port map (
    clr => '0',
    en => "1",
    a => delay3_q_net,
    b => multiplier1_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 37,
    a_width => 41,
    b_arith => xlSigned,
    b_bin_pt => 37,
    b_width => 43,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 44,
    core_name0 => "shaper_c_addsub_v12_0_i7",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 44,
    latency => 1,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 37,
    s_width => 43
  )
  port map (
    clr => '0',
    en => "1",
    a => addsub1_s_net,
    b => multiplier4_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  delay2 : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => addsub1_s_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 39
  )
  port map (
    en => '1',
    rst => '0',
    d => multiplier3_p_net,
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  multiplier1 : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 24,
    b_width => 25,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 25,
    c_baat => 16,
    c_output_width => 41,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i1",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 37,
    p_width => 40,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub1_s_net_x0,
    b => reinterpret3_output_port_net_x2,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => multiplier1_p_net
  );
  multiplier2 : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 37,
    a_width => 43,
    b_arith => xlUnsigned,
    b_bin_pt => 21,
    b_width => 25,
    c_a_type => 0,
    c_a_width => 43,
    c_b_type => 1,
    c_b_width => 25,
    c_baat => 43,
    c_output_width => 68,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i2",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 25,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay_q_net,
    b => reinterpret3_output_port_net_x0,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => multiplier2_p_net
  );
  multiplier3 : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 25,
    b_width => 25,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 25,
    c_baat => 16,
    c_output_width => 41,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i1",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 37,
    p_width => 39,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub1_s_net_x0,
    b => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => multiplier3_p_net
  );
  multiplier4 : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 37,
    a_width => 43,
    b_arith => xlUnsigned,
    b_bin_pt => 25,
    b_width => 25,
    c_a_type => 0,
    c_a_width => 43,
    c_b_type => 1,
    c_b_width => 25,
    c_baat => 43,
    c_output_width => 68,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i3",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 37,
    p_width => 43,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub_s_net,
    b => reinterpret3_output_port_net_x1,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => multiplier4_p_net
  );
  delay : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 43
  )
  port map (
    en => '1',
    rst => '0',
    d => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/pulse_unfolder/toUFix1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_toufix1 is
  port (
    in1 : in std_logic_vector( 32-1 downto 0 );
    out1 : out std_logic_vector( 25-1 downto 0 )
  );
end shaper_toufix1;
architecture structural of shaper_toufix1 is 
  signal register1_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice3_y_net : std_logic_vector( 25-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= reinterpret3_output_port_net;
  register1_q_net <= in1;
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_6ee7e285d6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice3_y_net,
    output_port => reinterpret3_output_port_net
  );
  slice3 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 24,
    x_width => 32,
    y_width => 25
  )
  port map (
    x => register1_q_net,
    y => slice3_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/pulse_unfolder
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_pulse_unfolder is
  port (
    x : in std_logic_vector( 25-1 downto 0 );
    b10 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 28-1 downto 0 )
  );
end shaper_pulse_unfolder;
architecture structural of shaper_pulse_unfolder is 
  signal delay1_q_net : std_logic_vector( 25-1 downto 0 );
  signal ce_net : std_logic;
  signal subtractor1_s_net : std_logic_vector( 28-1 downto 0 );
  signal register1_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal reinterpret3_output_port_net : std_logic_vector( 25-1 downto 0 );
  signal multiplier2_p_net_x0 : std_logic_vector( 25-1 downto 0 );
  signal multiplier2_p_net : std_logic_vector( 32-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 25-1 downto 0 );
begin
  out1 <= subtractor1_s_net;
  multiplier2_p_net_x0 <= x;
  register1_q_net <= b10;
  clk_net <= clk_1;
  ce_net <= ce_1;
  toufix1 : entity xil_defaultlib.shaper_toufix1 
  port map (
    in1 => register1_q_net,
    out1 => reinterpret3_output_port_net
  );
  delay1 : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 25
  )
  port map (
    en => '1',
    rst => '0',
    d => multiplier2_p_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 25
  )
  port map (
    en => '1',
    rst => '0',
    d => multiplier2_p_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  multiplier2 : entity xil_defaultlib.shaper_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 25,
    b_arith => xlUnsigned,
    b_bin_pt => 25,
    b_width => 25,
    c_a_type => 0,
    c_a_width => 25,
    c_b_type => 1,
    c_b_width => 25,
    c_baat => 25,
    c_output_width => 50,
    c_type => 0,
    core_name0 => "shaper_mult_gen_v12_0_i4",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 23,
    p_width => 32,
    quantization => 2
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay1_q_net,
    b => reinterpret3_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => multiplier2_p_net
  );
  subtractor1 : entity xil_defaultlib.shaper_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 25,
    b_arith => xlSigned,
    b_bin_pt => 23,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 35,
    core_name0 => "shaper_c_addsub_v12_0_i8",
    extra_registers => 2,
    full_s_arith => 2,
    full_s_width => 35,
    latency => 3,
    overflow => 2,
    quantization => 2,
    s_arith => xlSigned,
    s_bin_pt => 23,
    s_width => 28
  )
  port map (
    clr => '0',
    en => "1",
    a => delay2_q_net,
    b => multiplier2_p_net,
    clk => clk_net,
    ce => ce_net,
    s => subtractor1_s_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter/signInverter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_signinverter is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end shaper_signinverter;
architecture structural of shaper_signinverter is 
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal slice_y_net_x0 : std_logic_vector( 1-1 downto 0 );
begin
  y <= mcode_y_net;
  x_net <= x;
  slice_y_net_x0 <= en;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.shaper_xlconvert 
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
  mcode : entity xil_defaultlib.sysgen_mcode_block_19fdac68ff 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    x => x_net,
    en => convert_dout_net,
    y => mcode_y_net
  );
  slice : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 1,
    y_width => 1
  )
  port map (
    x => slice_y_net_x0,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain/Filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_filter is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    b10 : in std_logic_vector( 32-1 downto 0 );
    na_inv : in std_logic_vector( 32-1 downto 0 );
    na : in std_logic_vector( 32-1 downto 0 );
    nb : in std_logic_vector( 32-1 downto 0 );
    b20 : in std_logic_vector( 32-1 downto 0 );
    b2 : in std_logic_vector( 32-1 downto 0 );
    dc_offset_1 : in std_logic_vector( 32-1 downto 0 );
    b1 : in std_logic_vector( 32-1 downto 0 );
    aa20 : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    dc_offset_2 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 24-1 downto 0 );
    impulse : out std_logic_vector( 16-1 downto 0 );
    yb : out std_logic_vector( 16-1 downto 0 );
    of_x0 : out std_logic_vector( 1-1 downto 0 );
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 1-1 downto 0 )
  );
end shaper_filter;
architecture structural of shaper_filter is 
  signal mux1_y_net : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal register1_q_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal sub_s_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net_x1 : std_logic_vector( 36-1 downto 0 );
  signal register10_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal slice1_y_net : std_logic_vector( 10-1 downto 0 );
  signal delay_q_net : std_logic_vector( 18-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 24-1 downto 0 );
  signal register8_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal register7_q_net : std_logic_vector( 32-1 downto 0 );
  signal subtractor_s_net : std_logic_vector( 24-1 downto 0 );
  signal multiplier2_p_net : std_logic_vector( 25-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal subtractor1_s_net : std_logic_vector( 28-1 downto 0 );
  signal register6_q_net : std_logic_vector( 32-1 downto 0 );
  signal register9_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal convert_dout_net_x2 : std_logic_vector( 24-1 downto 0 );
  signal register2_q_net : std_logic_vector( 32-1 downto 0 );
  signal register11_q_net : std_logic_vector( 32-1 downto 0 );
begin
  y <= mux1_y_net;
  impulse <= addsub1_s_net;
  yb <= sub_s_net;
  of_x0 <= delay1_q_net;
  x_net <= x;
  register1_q_net <= b10;
  register2_q_net <= na_inv;
  register3_q_net <= na;
  register4_q_net <= nb;
  register5_q_net <= b20;
  register6_q_net <= b2;
  register7_q_net <= dc_offset_1;
  register8_q_net <= b1;
  register9_q_net <= aa20;
  register10_q_net <= flags;
  register11_q_net <= dc_offset_2;
  dbg_1 <= mcode_y_net;
  dbg_2 <= addsub1_s_net;
  dbg_3 <= slice_y_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  normalization1 : entity xil_defaultlib.shaper_normalization1 
  port map (
    in1 => convert_dout_net_x1,
    nf => register2_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => delay_q_net
  );
  overflow : entity xil_defaultlib.shaper_overflow 
  port map (
    x => mcode_y_net,
    en => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    of_x0 => relational_op_net
  );
  bipolar : entity xil_defaultlib.shaper_bipolar 
  port map (
    x => subtractor_s_net,
    na => slice1_y_net,
    nb => register4_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => sub_s_net
  );
  movingaverage1 : entity xil_defaultlib.shaper_movingaverage1 
  port map (
    in1 => subtractor1_s_net,
    n => slice1_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => convert_dout_net_x1
  );
  movingaverage2 : entity xil_defaultlib.shaper_movingaverage2 
  port map (
    in1 => delay_q_net,
    n => register4_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => convert_dout_net_x2
  );
  offset : entity xil_defaultlib.shaper_offset 
  port map (
    in1 => mcode_y_net,
    dc_offset => register7_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => addsub1_s_net
  );
  offset2 : entity xil_defaultlib.shaper_offset2 
  port map (
    in1 => convert_dout_net_x2,
    dc_offset => register11_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => subtractor_s_net
  );
  poles_correction : entity xil_defaultlib.shaper_poles_correction 
  port map (
    x => addsub1_s_net,
    b1 => register8_q_net,
    b2 => register6_q_net,
    aa20 => register9_q_net,
    b20 => register5_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => multiplier2_p_net
  );
  pulse_unfolder : entity xil_defaultlib.shaper_pulse_unfolder 
  port map (
    x => multiplier2_p_net,
    b10 => register1_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    out1 => subtractor1_s_net
  );
  signinverter : entity xil_defaultlib.shaper_signinverter 
  port map (
    x => x_net,
    en => slice_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => mcode_y_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_042c1fdb12 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  delay1 : entity xil_defaultlib.shaper_xldelay 
  generic map (
    latency => 23,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_4252e54314 
  port map (
    clr => '0',
    sel => delay1_q_net,
    d0 => subtractor_s_net,
    d1 => constant1_op_net,
    clk => clk_net,
    ce => ce_net,
    y => mux1_y_net
  );
  slice : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => register10_q_net,
    y => slice_y_net
  );
  slice1 : entity xil_defaultlib.shaper_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => register3_q_net,
    y => slice1_y_net
  );
end structural;
-- Generated from Simulink block shaper/filter_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_filter_clk_domain is
  port (
    b10 : in std_logic_vector( 32-1 downto 0 );
    na_inv : in std_logic_vector( 32-1 downto 0 );
    na : in std_logic_vector( 32-1 downto 0 );
    nb : in std_logic_vector( 32-1 downto 0 );
    b20 : in std_logic_vector( 32-1 downto 0 );
    b2 : in std_logic_vector( 32-1 downto 0 );
    dc_offset_1 : in std_logic_vector( 32-1 downto 0 );
    b1 : in std_logic_vector( 32-1 downto 0 );
    aa20 : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    dc_offset_2 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 24-1 downto 0 );
    y_bipolar : out std_logic_vector( 16-1 downto 0 );
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 1-1 downto 0 )
  );
end shaper_filter_clk_domain;
architecture structural of shaper_filter_clk_domain is 
  signal register2_q_net : std_logic_vector( 32-1 downto 0 );
  signal register1_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register9_q_net : std_logic_vector( 32-1 downto 0 );
  signal register11_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 24-1 downto 0 );
  signal register10_q_net : std_logic_vector( 32-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal register7_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal register6_q_net : std_logic_vector( 32-1 downto 0 );
  signal register8_q_net : std_logic_vector( 32-1 downto 0 );
  signal sub_s_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
begin
  register1_q_net <= b10;
  register2_q_net <= na_inv;
  register3_q_net <= na;
  register4_q_net <= nb;
  register5_q_net <= b20;
  register6_q_net <= b2;
  register7_q_net <= dc_offset_1;
  register8_q_net <= b1;
  register9_q_net <= aa20;
  register10_q_net <= flags;
  register11_q_net <= dc_offset_2;
  x_net <= x;
  y <= reinterpret1_output_port_net;
  y_bipolar <= reinterpret3_output_port_net;
  dbg_1 <= mcode_y_net;
  dbg_2 <= addsub1_s_net;
  dbg_3 <= slice_y_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  filter : entity xil_defaultlib.shaper_filter 
  port map (
    x => x_net,
    b10 => register1_q_net,
    na_inv => register2_q_net,
    na => register3_q_net,
    nb => register4_q_net,
    b20 => register5_q_net,
    b2 => register6_q_net,
    dc_offset_1 => register7_q_net,
    b1 => register8_q_net,
    aa20 => register9_q_net,
    flags => register10_q_net,
    dc_offset_2 => register11_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => mux1_y_net,
    impulse => addsub1_s_net,
    yb => sub_s_net,
    of_x0 => delay1_q_net,
    dbg_1 => mcode_y_net,
    dbg_2 => addsub1_s_net,
    dbg_3 => slice_y_net
  );
  reinterpret1 : entity xil_defaultlib.sysgen_reinterpret_8ae4f37d7b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => mux1_y_net,
    output_port => reinterpret1_output_port_net
  );
  reinterpret3 : entity xil_defaultlib.sysgen_reinterpret_b49c565758 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => sub_s_net,
    output_port => reinterpret3_output_port_net
  );
end structural;
-- Generated from Simulink block shaper_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_struct is
  port (
    r10_flags : in std_logic_vector( 32-1 downto 0 );
    r11_dc_offset_2 : in std_logic_vector( 32-1 downto 0 );
    r1_b10 : in std_logic_vector( 32-1 downto 0 );
    r2_na_inv : in std_logic_vector( 32-1 downto 0 );
    r3_na : in std_logic_vector( 32-1 downto 0 );
    r4_nb : in std_logic_vector( 32-1 downto 0 );
    r5_b20 : in std_logic_vector( 32-1 downto 0 );
    r6_dc_offset_1 : in std_logic_vector( 32-1 downto 0 );
    r7_b2 : in std_logic_vector( 32-1 downto 0 );
    r8_b1 : in std_logic_vector( 32-1 downto 0 );
    r9_aa20 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 24-1 downto 0 );
    y_bipolar : out std_logic_vector( 16-1 downto 0 );
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 1-1 downto 0 )
  );
end shaper_struct;
architecture structural of shaper_struct is 
  signal r4_nb_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b20_net : std_logic_vector( 32-1 downto 0 );
  signal r6_dc_offset_1_net : std_logic_vector( 32-1 downto 0 );
  signal r10_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r1_b10_net : std_logic_vector( 32-1 downto 0 );
  signal r11_dc_offset_2_net : std_logic_vector( 32-1 downto 0 );
  signal r2_na_inv_net : std_logic_vector( 32-1 downto 0 );
  signal r3_na_net : std_logic_vector( 32-1 downto 0 );
  signal mcode_y_net : std_logic_vector( 16-1 downto 0 );
  signal r8_b1_net : std_logic_vector( 32-1 downto 0 );
  signal register2_q_net : std_logic_vector( 32-1 downto 0 );
  signal register11_q_net : std_logic_vector( 32-1 downto 0 );
  signal register3_q_net : std_logic_vector( 32-1 downto 0 );
  signal register6_q_net : std_logic_vector( 32-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal r7_b2_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal register5_q_net : std_logic_vector( 32-1 downto 0 );
  signal register8_q_net : std_logic_vector( 32-1 downto 0 );
  signal register9_q_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret1_output_port_net : std_logic_vector( 24-1 downto 0 );
  signal x_net : std_logic_vector( 16-1 downto 0 );
  signal slice_y_net : std_logic_vector( 1-1 downto 0 );
  signal r9_aa20_net : std_logic_vector( 32-1 downto 0 );
  signal reinterpret3_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal register1_q_net : std_logic_vector( 32-1 downto 0 );
  signal register4_q_net : std_logic_vector( 32-1 downto 0 );
  signal register7_q_net : std_logic_vector( 32-1 downto 0 );
  signal register10_q_net : std_logic_vector( 32-1 downto 0 );
begin
  r10_flags_net <= r10_flags;
  r11_dc_offset_2_net <= r11_dc_offset_2;
  r1_b10_net <= r1_b10;
  r2_na_inv_net <= r2_na_inv;
  r3_na_net <= r3_na;
  r4_nb_net <= r4_nb;
  r5_b20_net <= r5_b20;
  r6_dc_offset_1_net <= r6_dc_offset_1;
  r7_b2_net <= r7_b2;
  r8_b1_net <= r8_b1;
  r9_aa20_net <= r9_aa20;
  x_net <= x;
  y <= reinterpret1_output_port_net;
  y_bipolar <= reinterpret3_output_port_net;
  dbg_1 <= mcode_y_net;
  dbg_2 <= addsub1_s_net;
  dbg_3 <= slice_y_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  axi_clk_domain : entity xil_defaultlib.shaper_axi_clk_domain 
  port map (
    r10_flags => r10_flags_net,
    r11_dc_offset_2 => r11_dc_offset_2_net,
    r1_b10 => r1_b10_net,
    r2_na_inv => r2_na_inv_net,
    r3_na => r3_na_net,
    r4_nb => r4_nb_net,
    r5_b20 => r5_b20_net,
    r6_dc_offset_1 => r6_dc_offset_1_net,
    r7_b2 => r7_b2_net,
    r8_b1 => r8_b1_net,
    r9_aa20 => r9_aa20_net
  );
  filter_clk_domain : entity xil_defaultlib.shaper_filter_clk_domain 
  port map (
    b10 => register1_q_net,
    na_inv => register2_q_net,
    na => register3_q_net,
    nb => register4_q_net,
    b20 => register5_q_net,
    b2 => register6_q_net,
    dc_offset_1 => register7_q_net,
    b1 => register8_q_net,
    aa20 => register9_q_net,
    flags => register10_q_net,
    dc_offset_2 => register11_q_net,
    x => x_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    y => reinterpret1_output_port_net,
    y_bipolar => reinterpret3_output_port_net,
    dbg_1 => mcode_y_net,
    dbg_2 => addsub1_s_net,
    dbg_3 => slice_y_net
  );
  register1 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r1_b10_net,
    clk => clk_net,
    ce => ce_net,
    q => register1_q_net
  );
  register10 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r10_flags_net,
    clk => clk_net,
    ce => ce_net,
    q => register10_q_net
  );
  register11 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r11_dc_offset_2_net,
    clk => clk_net,
    ce => ce_net,
    q => register11_q_net
  );
  register2 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r2_na_inv_net,
    clk => clk_net,
    ce => ce_net,
    q => register2_q_net
  );
  register3 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r3_na_net,
    clk => clk_net,
    ce => ce_net,
    q => register3_q_net
  );
  register4 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r4_nb_net,
    clk => clk_net,
    ce => ce_net,
    q => register4_q_net
  );
  register5 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r5_b20_net,
    clk => clk_net,
    ce => ce_net,
    q => register5_q_net
  );
  register6 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r7_b2_net,
    clk => clk_net,
    ce => ce_net,
    q => register6_q_net
  );
  register7 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r6_dc_offset_1_net,
    clk => clk_net,
    ce => ce_net,
    q => register7_q_net
  );
  register8 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r8_b1_net,
    clk => clk_net,
    ce => ce_net,
    q => register8_q_net
  );
  register9 : entity xil_defaultlib.shaper_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r9_aa20_net,
    clk => clk_net,
    ce => ce_net,
    q => register9_q_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper_default_clock_driver is
  port (
    shaper_sysclk : in std_logic;
    shaper_sysce : in std_logic;
    shaper_sysclr : in std_logic;
    shaper_clk1 : out std_logic;
    shaper_ce1 : out std_logic
  );
end shaper_default_clock_driver;
architecture structural of shaper_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => shaper_sysclk,
    sysce => shaper_sysce,
    sysclr => shaper_sysclr,
    clk => shaper_clk1,
    ce => shaper_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity shaper is
  port (
    r10_flags : in std_logic_vector( 32-1 downto 0 );
    r11_dc_offset_2 : in std_logic_vector( 32-1 downto 0 );
    r1_b10 : in std_logic_vector( 32-1 downto 0 );
    r2_na_inv : in std_logic_vector( 32-1 downto 0 );
    r3_na : in std_logic_vector( 32-1 downto 0 );
    r4_nb : in std_logic_vector( 32-1 downto 0 );
    r5_b20 : in std_logic_vector( 32-1 downto 0 );
    r6_dc_offset_1 : in std_logic_vector( 32-1 downto 0 );
    r7_b2 : in std_logic_vector( 32-1 downto 0 );
    r8_b1 : in std_logic_vector( 32-1 downto 0 );
    r9_aa20 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 16-1 downto 0 );
    clk : in std_logic;
    y : out std_logic_vector( 24-1 downto 0 );
    y_bipolar : out std_logic_vector( 16-1 downto 0 );
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic
  );
end shaper;
architecture structural of shaper is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "shaper,sysgen_core_2022_2,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=1,ce_clr=0,clock_period=20,system_simulink_period=2e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.001,accum=2,addsub=10,constant=9,convert=5,counter=3,delay=9,inv=1,mcode=1,mult=6,mux=2,register=11,reinterpret=14,relational=4,slice=14,spram=3,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  shaper_default_clock_driver : entity xil_defaultlib.shaper_default_clock_driver 
  port map (
    shaper_sysclk => clk,
    shaper_sysce => '1',
    shaper_sysclr => '0',
    shaper_clk1 => clk_1_net,
    shaper_ce1 => ce_1_net
  );
  shaper_struct : entity xil_defaultlib.shaper_struct 
  port map (
    r10_flags => r10_flags,
    r11_dc_offset_2 => r11_dc_offset_2,
    r1_b10 => r1_b10,
    r2_na_inv => r2_na_inv,
    r3_na => r3_na,
    r4_nb => r4_nb,
    r5_b20 => r5_b20,
    r6_dc_offset_1 => r6_dc_offset_1,
    r7_b2 => r7_b2,
    r8_b1 => r8_b1,
    r9_aa20 => r9_aa20,
    x => x,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    y => y,
    y_bipolar => y_bipolar,
    dbg_1 => dbg_1,
    dbg_2 => dbg_2,
    dbg_3(0) => dbg_3
  );
end structural;
