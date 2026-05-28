-- Generated from Simulink block blr_fast/axi_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_axi_clk_domain is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_b0 : in std_logic_vector( 32-1 downto 0 );
    r5_a1 : in std_logic_vector( 32-1 downto 0 )
  );
end blr_fast_axi_clk_domain;
architecture structural of blr_fast_axi_clk_domain is 
  signal r3_threshold_gain_net : std_logic_vector( 32-1 downto 0 );
  signal r2_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r5_a1_net : std_logic_vector( 32-1 downto 0 );
  signal r1_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r4_b0_net : std_logic_vector( 32-1 downto 0 );
begin
  r1_threshold_net <= r1_threshold;
  r2_flags_net <= r2_flags;
  r3_threshold_gain_net <= r3_threshold_gain;
  r4_b0_net <= r4_b0;
  r5_a1_net <= r5_a1;
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/dco/auto_offseting/envelope_filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_envelope_filter is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    thr_lo : out std_logic_vector( 24-1 downto 0 )
  );
end blr_fast_envelope_filter;
architecture structural of blr_fast_envelope_filter is 
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode2_y_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub_s_net : std_logic_vector( 36-1 downto 0 );
  signal mult_p_net : std_logic_vector( 36-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 36-1 downto 0 );
  signal mcode_sel_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 36-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 24-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 24-1 downto 0 );
  signal zero_op_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
begin
  thr_lo <= mcode2_y_net;
  down_sample2_q_net <= x;
  down_sample1_q_net <= rst;
  down_sample3_q_net <= b0;
  down_sample5_q_net <= a1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  addsub : entity xil_defaultlib.blr_fast_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 26,
    a_width => 36,
    b_arith => xlSigned,
    b_bin_pt => 26,
    b_width => 36,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 37,
    core_name0 => "blr_fast_c_addsub_v12_0_i2",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 37,
    latency => 0,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 26,
    s_width => 36
  )
  port map (
    clr => '0',
    en => "1",
    a => mult_p_net,
    b => mult1_p_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 26,
    din_width => 36,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 24,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  delay : entity xil_defaultlib.sysgen_delay_424298dd89 
  port map (
    clr => '0',
    d => addsub_s_net,
    rst => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.sysgen_delay_ee16ac16f0 
  port map (
    clr => '0',
    d => mcode1_y_net,
    rst => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_af8489a694 
  port map (
    clr => '0',
    xi => delay1_q_net,
    yi => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    sel => mcode_sel_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_a9a28a1c08 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    x => down_sample2_q_net,
    y => mcode1_y_net
  );
  mcode2 : entity xil_defaultlib.sysgen_mcode_block_a9a28a1c08 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    x => convert_dout_net,
    y => mcode2_y_net
  );
  mult : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 24,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 24,
    c_output_width => 56,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i1",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 26,
    p_width => 36,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay1_q_net,
    b => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 26,
    a_width => 36,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 36,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 36,
    c_output_width => 68,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i2",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 26,
    p_width => 36,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay_q_net,
    b => down_sample5_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_b71c6df45c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel_net,
    d0 => down_sample3_q_net,
    d1 => zero_op_net,
    y => mux_y_net
  );
  zero : entity xil_defaultlib.sysgen_constant_a943e65316 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => zero_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/dco/auto_offseting/low_pass_filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_low_pass_filter is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_low_pass_filter;
architecture structural of blr_fast_low_pass_filter is 
  signal mcode_en_net : std_logic_vector( 1-1 downto 0 );
  signal add_s_net : std_logic_vector( 31-1 downto 0 );
  signal clk_net : std_logic;
  signal shift_op_net : std_logic_vector( 29-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 39-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample7_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal delay_q_net : std_logic_vector( 31-1 downto 0 );
begin
  y <= convert_dout_net;
  down_sample7_q_net <= x;
  mcode_en_net <= en;
  down_sample4_q_net <= rst;
  clk_net <= clk_2;
  ce_net <= ce_2;
  add : entity xil_defaultlib.blr_fast_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 29,
    a_width => 29,
    b_arith => xlSigned,
    b_bin_pt => 29,
    b_width => 39,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 40,
    core_name0 => "blr_fast_c_addsub_v12_0_i3",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 40,
    latency => 0,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 29,
    s_width => 31
  )
  port map (
    clr => '0',
    en => "1",
    a => shift_op_net,
    b => cmult_p_net,
    clk => clk_net,
    ce => ce_net,
    s => add_s_net
  );
  cmult : entity xil_defaultlib.blr_fast_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 29,
    a_width => 31,
    b_bin_pt => 29,
    c_a_type => 0,
    c_a_width => 31,
    c_b_type => 1,
    c_b_width => 29,
    c_output_width => 60,
    core_name0 => "blr_fast_mult_gen_v12_0_i3",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 29,
    p_width => 39,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 29,
    din_width => 31,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  delay : entity xil_defaultlib.sysgen_delay_79759437de 
  port map (
    clr => '0',
    d => add_s_net,
    rst => down_sample4_q_net,
    en => mcode_en_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  shift : entity xil_defaultlib.sysgen_shift_e60fa2fe1b 
  port map (
    clr => '0',
    ip => down_sample7_q_net,
    clk => clk_net,
    ce => ce_net,
    op => shift_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/dco/auto_offseting
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_auto_offseting is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_max : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 );
    dc_offset : out std_logic_vector( 16-1 downto 0 );
    envelope : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_auto_offseting;
architecture structural of blr_fast_auto_offseting is 
  signal up_sample_q_net : std_logic_vector( 24-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal src_ce_net : std_logic;
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal src_clk_net : std_logic;
  signal down_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal sub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode2_y_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample8_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_en_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample7_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 32-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= sub1_s_net;
  dc_offset <= up_sample1_q_net;
  envelope <= convert_dout_net;
  x_net <= x;
  bit0_y_net <= rst;
  up_sample2_q_net <= threshold_max;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  envelope_filter : entity xil_defaultlib.blr_fast_envelope_filter 
  port map (
    x => down_sample2_q_net,
    rst => down_sample1_q_net,
    b0 => down_sample3_q_net,
    a1 => down_sample5_q_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    thr_lo => mcode2_y_net
  );
  low_pass_filter : entity xil_defaultlib.blr_fast_low_pass_filter 
  port map (
    x => down_sample7_q_net,
    en => mcode_en_net,
    rst => down_sample4_q_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    y => convert_dout_net_x0
  );
  cmult : entity xil_defaultlib.blr_fast_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_bin_pt => 0,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 2,
    c_output_width => 18,
    core_name0 => "blr_fast_mult_gen_v12_0_i0",
    extra_registers => 0,
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
    a => down_sample8_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_821aa7a8d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 24,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mcode2_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  down_sample1 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => bit0_y_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample1_q_net
  );
  down_sample2 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 24,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 24
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => x_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample2_q_net
  );
  down_sample3 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => b00_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample3_q_net
  );
  down_sample4 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => bit0_y_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample4_q_net
  );
  down_sample5 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => a01_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample5_q_net
  );
  down_sample7 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => sub2_s_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample7_q_net
  );
  down_sample8 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => up_sample2_q_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample8_q_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_ab102b6a84 
  port map (
    clr => '0',
    x => down_sample7_q_net,
    xmin => constant_op_net,
    xmax => cmult_p_net,
    clk => clk_net,
    ce => ce_net,
    en => mcode_en_net
  );
  sub1 : entity xil_defaultlib.blr_fast_xladdsub 
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
    core_name0 => "blr_fast_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    en => "1",
    a => sub2_s_net,
    b => up_sample1_q_net,
    clk => src_clk_net,
    ce => src_ce_net,
    s => sub1_s_net
  );
  sub2 : entity xil_defaultlib.blr_fast_xladdsub 
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
    core_name0 => "blr_fast_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    en => "1",
    a => x_net,
    b => up_sample_q_net,
    clk => src_clk_net,
    ce => src_ce_net,
    s => sub2_s_net
  );
  up_sample : entity xil_defaultlib.blr_fast_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 24,
    latency => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 24
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => mcode2_y_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => src_ce_net,
    q => up_sample_q_net
  );
  up_sample1 : entity xil_defaultlib.blr_fast_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    latency => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => convert_dout_net_x0,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => src_ce_net,
    q => up_sample1_q_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/dco/manual_offseting
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_manual_offseting is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    offset : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_manual_offseting;
architecture structural of blr_fast_manual_offseting is 
  signal offset_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal src_ce_net : std_logic;
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal sub1_s_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= sub2_s_net;
  sub1_s_net <= x;
  bit0_y_net <= rst;
  offset_output_port_net <= offset;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  delay : entity xil_defaultlib.sysgen_delay_f419747bdf 
  port map (
    clr => '0',
    d => offset_output_port_net,
    rst => bit0_y_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => delay_q_net
  );
  sub2 : entity xil_defaultlib.blr_fast_xladdsub 
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
    core_name0 => "blr_fast_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 17,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 16
  )
  port map (
    clr => '0',
    en => "1",
    a => sub1_s_net,
    b => delay_q_net,
    clk => src_clk_net,
    ce => src_ce_net,
    s => sub2_s_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/dco
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_dco is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    x_thr_hi : in std_logic_vector( 16-1 downto 0 );
    offset : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 );
    dc : out std_logic_vector( 16-1 downto 0 );
    envelope : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_dco;
architecture structural of blr_fast_dco is 
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal offset_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal src_clk_net : std_logic;
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal src_ce_net : std_logic;
  signal ce_net : std_logic;
  signal sub1_s_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= sub2_s_net;
  dc <= up_sample1_q_net;
  envelope <= convert_dout_net;
  x_net <= x;
  bit0_y_net <= rst;
  up_sample2_q_net <= x_thr_hi;
  offset_output_port_net <= offset;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  auto_offseting : entity xil_defaultlib.blr_fast_auto_offseting 
  port map (
    x => x_net,
    rst => bit0_y_net,
    threshold_max => up_sample2_q_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    y => sub1_s_net,
    dc_offset => up_sample1_q_net,
    envelope => convert_dout_net
  );
  manual_offseting : entity xil_defaultlib.blr_fast_manual_offseting 
  port map (
    x => sub1_s_net,
    rst => bit0_y_net,
    offset => offset_output_port_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    y => sub2_s_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/discriminator
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_discriminator is
  port (
    y : in std_logic_vector( 16-1 downto 0 );
    threshold : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    thr_trigger : out std_logic_vector( 1-1 downto 0 )
  );
end blr_fast_discriminator;
architecture structural of blr_fast_discriminator is 
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal src_ce_net : std_logic;
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal src_clk_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
begin
  thr_trigger <= register_q_net;
  sub2_s_net <= y;
  up_sample1_q_net <= threshold;
  bit0_y_net <= rst;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_14fe215324 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_821aa7a8d1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_a170d27a80 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => relational1_op_net,
    d1 => bit0_y_net,
    y => logical_y_net
  );
  register_x0 : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 1,
    init_value => b"0"
  )
  port map (
    d => constant_op_net,
    rst => logical_y_net,
    en => relational_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_51e31c3f58 
  port map (
    clr => '0',
    a => sub2_s_net,
    b => up_sample1_q_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => relational_op_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_20ef9d714e 
  port map (
    clr => '0',
    a => sub2_s_net,
    b => constant1_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => relational1_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_bipolar/envelope_filter2
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_envelope_filter2 is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_gain : in std_logic_vector( 16-1 downto 0 );
    threshold_min : in std_logic_vector( 16-1 downto 0 );
    threshold_max : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    thr_hi : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_envelope_filter2;
architecture structural of blr_fast_envelope_filter2 is 
  signal down_sample2_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 16-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal addsub_s_net : std_logic_vector( 32-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 22-1 downto 0 );
  signal delay_q_net : std_logic_vector( 32-1 downto 0 );
  signal mcode_sel1_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_sel2_net : std_logic_vector( 1-1 downto 0 );
  signal zero_op_net : std_logic_vector( 32-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 32-1 downto 0 );
begin
  thr_hi <= cmult_p_net;
  down_sample3_q_net <= x;
  down_sample_q_net <= rst;
  down_sample1_q_net <= threshold_gain;
  down_sample4_q_net <= threshold_min;
  down_sample5_q_net <= threshold_max;
  down_sample2_q_net <= b0;
  down_sample6_q_net <= a1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  addsub : entity xil_defaultlib.blr_fast_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 30,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 30,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 33,
    core_name0 => "blr_fast_c_addsub_v12_0_i4",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 33,
    latency => 0,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 30,
    s_width => 32
  )
  port map (
    clr => '0',
    en => "1",
    a => mult_p_net,
    b => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  cmult : entity xil_defaultlib.blr_fast_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 22,
    b_bin_pt => 14,
    c_a_type => 0,
    c_a_width => 22,
    c_b_type => 1,
    c_b_width => 14,
    c_output_width => 36,
    core_name0 => "blr_fast_mult_gen_v12_0_i4",
    extra_registers => 0,
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
    a => mult2_p_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  delay : entity xil_defaultlib.sysgen_delay_fb8aa4cf6c 
  port map (
    clr => '0',
    d => addsub_s_net,
    rst => down_sample_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.sysgen_delay_f419747bdf 
  port map (
    clr => '0',
    d => down_sample3_q_net,
    rst => down_sample_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_400c6990a3 
  port map (
    clr => '0',
    xi => delay1_q_net,
    yi => convert_dout_net,
    xi_max => down_sample5_q_net,
    xi_min => down_sample4_q_net,
    clk => clk_net,
    ce => ce_net,
    sel1 => mcode_sel1_net,
    sel2 => mcode_sel2_net
  );
  mult : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 16,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i5",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 30,
    p_width => 32,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay1_q_net,
    b => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 30,
    a_width => 32,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 32,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 32,
    c_output_width => 64,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 30,
    p_width => 32,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay_q_net,
    b => down_sample6_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 8,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i7",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 22,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => convert_dout_net,
    b => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_b71c6df45c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel1_net,
    d0 => down_sample2_q_net,
    d1 => zero_op_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_b71c6df45c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel2_net,
    d0 => mult1_p_net,
    d1 => delay_q_net,
    y => mux1_y_net
  );
  zero : entity xil_defaultlib.sysgen_constant_a943e65316 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => zero_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_bipolar/fullRectifier
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_fullrectifier is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_fullrectifier;
architecture structural of blr_fast_fullrectifier is 
  signal negate2_op_net : std_logic_vector( 16-1 downto 0 );
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal x_bipolar_net : std_logic_vector( 16-1 downto 0 );
  signal src_ce_net : std_logic;
begin
  y <= mcode1_z_net;
  x_bipolar_net <= x;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_612f82fb10 
  port map (
    clr => '0',
    x => x_bipolar_net,
    xn => negate2_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    z => mcode1_z_net
  );
  negate2 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => x_bipolar_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate2_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_bipolar
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_envelope_bipolar is
  port (
    x_bipolar : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_gain : in std_logic_vector( 16-1 downto 0 );
    threshold_min : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    x_bipolar_abs : out std_logic_vector( 16-1 downto 0 );
    x_thr_hi : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_envelope_bipolar;
architecture structural of blr_fast_envelope_bipolar is 
  signal x_bipolar_net : std_logic_vector( 16-1 downto 0 );
  signal min_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal down_sample4_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 16-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal src_clk_net : std_logic;
  signal src_ce_net : std_logic;
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal negate2_op_net : std_logic_vector( 16-1 downto 0 );
begin
  x_bipolar_abs <= mcode1_z_net;
  x_thr_hi <= up_sample2_q_net;
  x_bipolar_net <= x_bipolar;
  bit0_y_net <= rst;
  gain_output_port_net <= threshold_gain;
  min_output_port_net <= threshold_min;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  envelope_filter2 : entity xil_defaultlib.blr_fast_envelope_filter2 
  port map (
    x => down_sample3_q_net,
    rst => down_sample_q_net,
    threshold_gain => down_sample1_q_net,
    threshold_min => down_sample4_q_net,
    threshold_max => down_sample5_q_net,
    b0 => down_sample2_q_net,
    a1 => down_sample6_q_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    thr_hi => cmult_p_net
  );
  fullrectifier : entity xil_defaultlib.blr_fast_fullrectifier 
  port map (
    x => x_bipolar_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    y => mcode1_z_net
  );
  down_sample : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => bit0_y_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample_q_net
  );
  down_sample1 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 8,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 8,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => gain_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample1_q_net
  );
  down_sample2 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => b00_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample2_q_net
  );
  down_sample3 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => mcode1_z_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample3_q_net
  );
  down_sample4 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => min_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample4_q_net
  );
  down_sample5 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => negate2_op_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample5_q_net
  );
  down_sample6 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => a01_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample6_q_net
  );
  negate2 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => min_output_port_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate2_op_net
  );
  up_sample2 : entity xil_defaultlib.blr_fast_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    latency => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => cmult_p_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => src_ce_net,
    q => up_sample2_q_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_unipolar/envelope_filter1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_envelope_filter1 is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_gain : in std_logic_vector( 16-1 downto 0 );
    threshold_min : in std_logic_vector( 16-1 downto 0 );
    threshold_max : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    thr_hi : out std_logic_vector( 16-1 downto 0 );
    thr_lo : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_envelope_filter1;
architecture structural of blr_fast_envelope_filter1 is 
  signal down_sample4_q_net : std_logic_vector( 16-1 downto 0 );
  signal negate3_op_net : std_logic_vector( 16-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 16-1 downto 0 );
  signal mult_p_net : std_logic_vector( 32-1 downto 0 );
  signal mux1_y_net : std_logic_vector( 32-1 downto 0 );
  signal mult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal down_sample3_q_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 32-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode_sel1_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 32-1 downto 0 );
  signal mcode_sel2_net : std_logic_vector( 1-1 downto 0 );
  signal zero_op_net : std_logic_vector( 32-1 downto 0 );
begin
  thr_hi <= mult2_p_net;
  thr_lo <= negate3_op_net;
  down_sample2_q_net <= x;
  down_sample_q_net <= rst;
  down_sample1_q_net <= threshold_gain;
  down_sample4_q_net <= threshold_min;
  down_sample5_q_net <= threshold_max;
  down_sample3_q_net <= b0;
  down_sample6_q_net <= a1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  addsub : entity xil_defaultlib.blr_fast_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 30,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 30,
    b_width => 32,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 33,
    core_name0 => "blr_fast_c_addsub_v12_0_i4",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 33,
    latency => 0,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 30,
    s_width => 32
  )
  port map (
    clr => '0',
    en => "1",
    a => mult_p_net,
    b => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  delay : entity xil_defaultlib.sysgen_delay_fb8aa4cf6c 
  port map (
    clr => '0',
    d => addsub_s_net,
    rst => down_sample_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.sysgen_delay_f419747bdf 
  port map (
    clr => '0',
    d => down_sample2_q_net,
    rst => down_sample_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_400c6990a3 
  port map (
    clr => '0',
    xi => delay1_q_net,
    yi => convert_dout_net,
    xi_max => down_sample5_q_net,
    xi_min => down_sample4_q_net,
    clk => clk_net,
    ce => ce_net,
    sel1 => mcode_sel1_net,
    sel2 => mcode_sel2_net
  );
  mult : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 16,
    c_output_width => 48,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i5",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 30,
    p_width => 32,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay1_q_net,
    b => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 30,
    a_width => 32,
    b_arith => xlUnsigned,
    b_bin_pt => 32,
    b_width => 32,
    c_a_type => 0,
    c_a_width => 32,
    c_b_type => 1,
    c_b_width => 32,
    c_baat => 32,
    c_output_width => 64,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i6",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 30,
    p_width => 32,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => delay_q_net,
    b => down_sample6_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.blr_fast_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 16,
    b_arith => xlUnsigned,
    b_bin_pt => 8,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 16,
    c_baat => 16,
    c_output_width => 32,
    c_type => 0,
    core_name0 => "blr_fast_mult_gen_v12_0_i7",
    extra_registers => 0,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 16,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => convert_dout_net,
    b => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_b71c6df45c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel1_net,
    d0 => down_sample3_q_net,
    d1 => zero_op_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_b71c6df45c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel2_net,
    d0 => mult1_p_net,
    d1 => delay_q_net,
    y => mux1_y_net
  );
  negate3 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => mult2_p_net,
    clk => clk_net,
    ce => ce_net,
    op => negate3_op_net
  );
  zero : entity xil_defaultlib.sysgen_constant_a943e65316 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => zero_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_unipolar/fullRectifier1
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_fullrectifier1 is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_fast_fullrectifier1;
architecture structural of blr_fast_fullrectifier1 is 
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal negate2_op_net : std_logic_vector( 16-1 downto 0 );
  signal src_ce_net : std_logic;
  signal negate1_op_net : std_logic_vector( 16-1 downto 0 );
begin
  y <= mcode1_z_net;
  negate1_op_net <= x;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_612f82fb10 
  port map (
    clr => '0',
    x => negate1_op_net,
    xn => negate2_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    z => mcode1_z_net
  );
  negate2 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => negate1_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate2_op_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/envelope_unipolar
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_envelope_unipolar is
  port (
    x : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_gain : in std_logic_vector( 16-1 downto 0 );
    threshold_min : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    thr_hi : out std_logic_vector( 16-1 downto 0 );
    thr_lo : out std_logic_vector( 16-1 downto 0 );
    thr_valid : out std_logic_vector( 1-1 downto 0 )
  );
end blr_fast_envelope_unipolar;
architecture structural of blr_fast_envelope_unipolar is 
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal negate3_op_net : std_logic_vector( 16-1 downto 0 );
  signal src_ce_net : std_logic;
  signal down_sample5_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 32-1 downto 0 );
  signal negate1_op_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal min_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 16-1 downto 0 );
  signal down_sample_q_net : std_logic_vector( 1-1 downto 0 );
  signal gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
  signal mult2_p_net : std_logic_vector( 16-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal negate2_op_net : std_logic_vector( 16-1 downto 0 );
begin
  thr_hi <= up_sample1_q_net;
  thr_lo <= up_sample2_q_net;
  thr_valid <= relational_op_net;
  sub2_s_net <= x;
  bit0_y_net <= rst;
  gain_output_port_net <= threshold_gain;
  min_output_port_net <= threshold_min;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  envelope_filter1 : entity xil_defaultlib.blr_fast_envelope_filter1 
  port map (
    x => down_sample2_q_net,
    rst => down_sample_q_net,
    threshold_gain => down_sample1_q_net,
    threshold_min => down_sample4_q_net,
    threshold_max => down_sample5_q_net,
    b0 => down_sample3_q_net,
    a1 => down_sample6_q_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    thr_hi => mult2_p_net,
    thr_lo => negate3_op_net
  );
  fullrectifier1 : entity xil_defaultlib.blr_fast_fullrectifier1 
  port map (
    x => negate1_op_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    y => mcode1_z_net
  );
  down_sample : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 0,
    d_width => 1,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 0,
    q_width => 1
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => bit0_y_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample_q_net
  );
  down_sample1 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 8,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 8,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => gain_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample1_q_net
  );
  down_sample2 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => mcode1_z_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample2_q_net
  );
  down_sample3 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => b00_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample3_q_net
  );
  down_sample4 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => min_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample4_q_net
  );
  down_sample5 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => negate2_op_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample5_q_net
  );
  down_sample6 : entity xil_defaultlib.blr_fast_xldsamp 
  generic map (
    d_arith => xlUnsigned,
    d_bin_pt => 32,
    d_width => 32,
    ds_ratio => 2,
    latency => 1,
    phase => 1,
    q_arith => xlUnsigned,
    q_bin_pt => 32,
    q_width => 32
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    rst => "0",
    d => a01_output_port_net,
    src_clk => src_clk_net,
    src_ce => src_ce_net,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample6_q_net
  );
  negate1 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => sub2_s_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate1_op_net
  );
  negate2 : entity xil_defaultlib.sysgen_negate_dd74dc1dba 
  port map (
    clr => '0',
    ip => min_output_port_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate2_op_net
  );
  relational : entity xil_defaultlib.sysgen_relational_51e31c3f58 
  port map (
    clr => '0',
    a => up_sample2_q_net,
    b => min_output_port_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => relational_op_net
  );
  up_sample1 : entity xil_defaultlib.blr_fast_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    latency => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => mult2_p_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => src_ce_net,
    q => up_sample1_q_net
  );
  up_sample2 : entity xil_defaultlib.blr_fast_xlusamp 
  generic map (
    copy_samples => 1,
    d_arith => xlSigned,
    d_bin_pt => 14,
    d_width => 16,
    latency => 1,
    q_arith => xlSigned,
    q_bin_pt => 14,
    q_width => 16
  )
  port map (
    src_clr => '0',
    dest_clr => '0',
    en => "1",
    d => negate3_op_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => src_clk_net,
    dest_ce => src_ce_net,
    q => up_sample2_q_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain/format_dac
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_format_dac is
  port (
    y : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    out1 : out std_logic_vector( 14-1 downto 0 )
  );
end blr_fast_format_dac;
architecture structural of blr_fast_format_dac is 
  signal src_ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 14-1 downto 0 );
  signal negate_op_net : std_logic_vector( 17-1 downto 0 );
  signal src_clk_net : std_logic;
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 14-1 downto 0 );
  signal slice_y_net : std_logic_vector( 14-1 downto 0 );
begin
  out1 <= logical1_y_net;
  sub2_s_net <= y;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_f0fc88c341 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_bb8cf88150 
  port map (
    clr => '0',
    d0 => slice_y_net,
    d1 => constant_op_net,
    clk => src_clk_net,
    ce => src_ce_net,
    y => logical1_y_net
  );
  negate : entity xil_defaultlib.sysgen_negate_aa2cc0630d 
  port map (
    clr => '0',
    ip => sub2_s_net,
    clk => src_clk_net,
    ce => src_ce_net,
    op => negate_op_net
  );
  slice : entity xil_defaultlib.blr_fast_xlslice 
  generic map (
    new_lsb => 2,
    new_msb => 15,
    x_width => 17,
    y_width => 14
  )
  port map (
    x => negate_op_net,
    y => slice_y_net
  );
end structural;
-- Generated from Simulink block blr_fast/blr_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_blr_clk_domain is
  port (
    threshold_min_offset : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    threshold_gain : in std_logic_vector( 32-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    x_bipolar : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    fast_discriminator : out std_logic_vector( 18-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 );
    y_dac : out std_logic_vector( 14-1 downto 0 )
  );
end blr_fast_blr_clk_domain;
architecture structural of blr_fast_blr_clk_domain is 
  signal register_b0_q_net : std_logic_vector( 32-1 downto 0 );
  signal register_a1_q_net : std_logic_vector( 32-1 downto 0 );
  signal register_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal register_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal register_threshold_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 14-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal thr_lo_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice_lo_y_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal min_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal x_bipolar_net : std_logic_vector( 16-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal up_sample2_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal concat_y_net : std_logic_vector( 18-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal src_ce_net : std_logic;
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal mcode1_z_net : std_logic_vector( 16-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample1_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal thr_lo_valid_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal offset_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal thr_trigger_output_port_net : std_logic_vector( 1-1 downto 0 );
  signal slice_lo1_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_hi_y_net : std_logic_vector( 16-1 downto 0 );
begin
  register_threshold_q_net <= threshold_min_offset;
  register_flags_q_net <= flags;
  register_threshold_gain_q_net <= threshold_gain;
  register_b0_q_net <= b0;
  register_a1_q_net <= a1;
  dbg_1 <= convert_dout_net_x0;
  dbg_2 <= convert_dout_net;
  dbg_3 <= up_sample2_q_net;
  dbg_4 <= convert1_dout_net;
  fast_discriminator <= concat_y_net;
  threshold <= up_sample1_q_net_x0;
  x_net <= x;
  x_bipolar_net <= x_bipolar;
  y <= sub2_s_net;
  y_dac <= logical1_y_net;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  dco : entity xil_defaultlib.blr_fast_dco 
  port map (
    x => x_net,
    rst => bit0_y_net,
    x_thr_hi => up_sample2_q_net,
    offset => offset_output_port_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    y => sub2_s_net,
    dc => up_sample1_q_net,
    envelope => convert_dout_net
  );
  discriminator : entity xil_defaultlib.blr_fast_discriminator 
  port map (
    y => sub2_s_net,
    threshold => up_sample1_q_net_x0,
    rst => bit0_y_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    thr_trigger => register_q_net
  );
  envelope_bipolar : entity xil_defaultlib.blr_fast_envelope_bipolar 
  port map (
    x_bipolar => x_bipolar_net,
    rst => bit0_y_net,
    threshold_gain => gain_output_port_net,
    threshold_min => min_output_port_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    x_bipolar_abs => mcode1_z_net,
    x_thr_hi => up_sample2_q_net
  );
  envelope_unipolar : entity xil_defaultlib.blr_fast_envelope_unipolar 
  port map (
    x => sub2_s_net,
    rst => bit0_y_net,
    threshold_gain => gain_output_port_net,
    threshold_min => min_output_port_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    thr_hi => up_sample1_q_net_x0,
    thr_lo => up_sample2_q_net_x0,
    thr_valid => relational_op_net
  );
  format_dac : entity xil_defaultlib.blr_fast_format_dac 
  port map (
    y => sub2_s_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    out1 => logical1_y_net
  );
  concat : entity xil_defaultlib.sysgen_concat_3ee54af9b0 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    in0 => thr_lo_output_port_net,
    in1 => thr_lo_valid_output_port_net,
    in2 => thr_trigger_output_port_net,
    y => concat_y_net
  );
  convert : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 24,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => x_net,
    clk => src_clk_net,
    ce => src_ce_net,
    dout => convert_dout_net_x0
  );
  convert1 : entity xil_defaultlib.blr_fast_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => register_q_net,
    clk => src_clk_net,
    ce => src_ce_net,
    dout => convert1_dout_net
  );
  slice_lo : entity xil_defaultlib.blr_fast_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => register_threshold_gain_q_net,
    y => slice_lo_y_net
  );
  slice_lo1 : entity xil_defaultlib.blr_fast_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => register_threshold_q_net,
    y => slice_lo1_y_net
  );
  a01 : entity xil_defaultlib.sysgen_reinterpret_fc8df2963b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_a1_q_net,
    output_port => a01_output_port_net
  );
  b00 : entity xil_defaultlib.sysgen_reinterpret_fc8df2963b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_b0_q_net,
    output_port => b00_output_port_net
  );
  bit0 : entity xil_defaultlib.blr_fast_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => register_flags_q_net,
    y => bit0_y_net
  );
  gain : entity xil_defaultlib.sysgen_reinterpret_edb7126536 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_lo_y_net,
    output_port => gain_output_port_net
  );
  min : entity xil_defaultlib.sysgen_reinterpret_9f4e26957b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_lo1_y_net,
    output_port => min_output_port_net
  );
  offset : entity xil_defaultlib.sysgen_reinterpret_9f4e26957b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_hi_y_net,
    output_port => offset_output_port_net
  );
  slice_hi : entity xil_defaultlib.blr_fast_xlslice 
  generic map (
    new_lsb => 16,
    new_msb => 31,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => register_threshold_q_net,
    y => slice_hi_y_net
  );
  thr_lo : entity xil_defaultlib.sysgen_reinterpret_7e1d6116f1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => up_sample2_q_net_x0,
    output_port => thr_lo_output_port_net
  );
  thr_lo_valid : entity xil_defaultlib.sysgen_reinterpret_b179844065 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => relational_op_net,
    output_port => thr_lo_valid_output_port_net
  );
  thr_trigger : entity xil_defaultlib.sysgen_reinterpret_0f15dbc7b5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => register_q_net,
    output_port => thr_trigger_output_port_net
  );
end structural;
-- Generated from Simulink block blr_fast_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_struct is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_b0 : in std_logic_vector( 32-1 downto 0 );
    r5_a1 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    x_bipolar : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    fast_discriminator : out std_logic_vector( 18-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 );
    y_dac : out std_logic_vector( 14-1 downto 0 )
  );
end blr_fast_struct;
architecture structural of blr_fast_struct is 
  signal r1_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r2_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r3_threshold_gain_net : std_logic_vector( 32-1 downto 0 );
  signal register_threshold_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal concat_y_net : std_logic_vector( 18-1 downto 0 );
  signal r4_b0_net : std_logic_vector( 32-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 16-1 downto 0 );
  signal sub2_s_net : std_logic_vector( 16-1 downto 0 );
  signal src_clk_net : std_logic;
  signal register_b0_q_net : std_logic_vector( 32-1 downto 0 );
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal src_ce_net : std_logic;
  signal ce_net : std_logic;
  signal logical1_y_net : std_logic_vector( 14-1 downto 0 );
  signal register_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal register_a1_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_a1_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal x_bipolar_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal register_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
begin
  r1_threshold_net <= r1_threshold;
  r2_flags_net <= r2_flags;
  r3_threshold_gain_net <= r3_threshold_gain;
  r4_b0_net <= r4_b0;
  r5_a1_net <= r5_a1;
  dbg_1 <= convert_dout_net_x0;
  dbg_2 <= convert_dout_net;
  dbg_3 <= up_sample2_q_net;
  dbg_4 <= convert1_dout_net;
  fast_discriminator <= concat_y_net;
  threshold <= up_sample1_q_net;
  x_net <= x;
  x_bipolar_net <= x_bipolar;
  y <= sub2_s_net;
  y_dac <= logical1_y_net;
  src_clk_net <= clk_1;
  src_ce_net <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  axi_clk_domain : entity xil_defaultlib.blr_fast_axi_clk_domain 
  port map (
    r1_threshold => r1_threshold_net,
    r2_flags => r2_flags_net,
    r3_threshold_gain => r3_threshold_gain_net,
    r4_b0 => r4_b0_net,
    r5_a1 => r5_a1_net
  );
  blr_clk_domain : entity xil_defaultlib.blr_fast_blr_clk_domain 
  port map (
    threshold_min_offset => register_threshold_q_net,
    flags => register_flags_q_net,
    threshold_gain => register_threshold_gain_q_net,
    b0 => register_b0_q_net,
    a1 => register_a1_q_net,
    x => x_net,
    x_bipolar => x_bipolar_net,
    clk_1 => src_clk_net,
    ce_1 => src_ce_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    dbg_1 => convert_dout_net_x0,
    dbg_2 => convert_dout_net,
    dbg_3 => up_sample2_q_net,
    dbg_4 => convert1_dout_net,
    fast_discriminator => concat_y_net,
    threshold => up_sample1_q_net,
    y => sub2_s_net,
    y_dac => logical1_y_net
  );
  register_a1 : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r5_a1_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_a1_q_net
  );
  register_b0 : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r4_b0_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_b0_q_net
  );
  register_flags : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000011"
  )
  port map (
    en => "1",
    rst => "0",
    d => r2_flags_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_flags_q_net
  );
  register_threshold : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000111101101111111100001010"
  )
  port map (
    en => "1",
    rst => "0",
    d => r1_threshold_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_threshold_q_net
  );
  register_threshold_gain : entity xil_defaultlib.blr_fast_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000100000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r3_threshold_gain_net,
    clk => src_clk_net,
    ce => src_ce_net,
    q => register_threshold_gain_q_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast_default_clock_driver is
  port (
    blr_fast_sysclk : in std_logic;
    blr_fast_sysce : in std_logic;
    blr_fast_sysclr : in std_logic;
    blr_fast_clk1 : out std_logic;
    blr_fast_ce1 : out std_logic;
    blr_fast_clk2 : out std_logic;
    blr_fast_ce2 : out std_logic
  );
end blr_fast_default_clock_driver;
architecture structural of blr_fast_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => blr_fast_sysclk,
    sysce => blr_fast_sysce,
    sysclr => blr_fast_sysclr,
    clk => blr_fast_clk1,
    ce => blr_fast_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 2,
    log_2_period => 2
  )
  port map (
    sysclk => blr_fast_sysclk,
    sysce => blr_fast_sysce,
    sysclr => blr_fast_sysclr,
    clk => blr_fast_clk2,
    ce => blr_fast_ce2
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_fast is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_b0 : in std_logic_vector( 32-1 downto 0 );
    r5_a1 : in std_logic_vector( 32-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    x_bipolar : in std_logic_vector( 16-1 downto 0 );
    clk : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    fast_discriminator : out std_logic_vector( 18-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 );
    y_dac : out std_logic_vector( 14-1 downto 0 )
  );
end blr_fast;
architecture structural of blr_fast is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "blr_fast,sysgen_core_2022_2,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=1,ce_clr=0,clock_period=20,system_simulink_period=2e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.1,addsub=7,cmult=3,concat=1,constant=13,convert=7,delay=8,dsamp=21,logical=2,mcode=8,mult=8,mux=5,negate=7,register=6,reinterpret=8,relational=3,shift=1,slice=6,usamp=5,}";
  signal ce_1_net : std_logic;
  signal clk_2_net : std_logic;
  signal clk_1_net : std_logic;
  signal ce_2_net : std_logic;
begin
  blr_fast_default_clock_driver : entity xil_defaultlib.blr_fast_default_clock_driver 
  port map (
    blr_fast_sysclk => clk,
    blr_fast_sysce => '1',
    blr_fast_sysclr => '0',
    blr_fast_clk1 => clk_1_net,
    blr_fast_ce1 => ce_1_net,
    blr_fast_clk2 => clk_2_net,
    blr_fast_ce2 => ce_2_net
  );
  blr_fast_struct : entity xil_defaultlib.blr_fast_struct 
  port map (
    r1_threshold => r1_threshold,
    r2_flags => r2_flags,
    r3_threshold_gain => r3_threshold_gain,
    r4_b0 => r4_b0,
    r5_a1 => r5_a1,
    x => x,
    x_bipolar => x_bipolar,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_2 => clk_2_net,
    ce_2 => ce_2_net,
    dbg_1 => dbg_1,
    dbg_2 => dbg_2,
    dbg_3 => dbg_3,
    dbg_4 => dbg_4,
    fast_discriminator => fast_discriminator,
    threshold => threshold,
    y => y,
    y_dac => y_dac
  );
end structural;
