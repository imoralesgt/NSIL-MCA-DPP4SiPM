-- Generated from Simulink block blr/axi_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_axi_clk_domain is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_preset : in std_logic_vector( 32-1 downto 0 );
    r5_b0 : in std_logic_vector( 32-1 downto 0 );
    r6_a1 : in std_logic_vector( 32-1 downto 0 );
    r7_threshold_low_gain : in std_logic_vector( 32-1 downto 0 )
  );
end blr_axi_clk_domain;
architecture structural of blr_axi_clk_domain is 
  signal r7_threshold_low_gain_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b0_net : std_logic_vector( 32-1 downto 0 );
  signal r2_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r3_threshold_gain_net : std_logic_vector( 32-1 downto 0 );
  signal r4_preset_net : std_logic_vector( 32-1 downto 0 );
  signal r1_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal r6_a1_net : std_logic_vector( 32-1 downto 0 );
begin
  r1_threshold_net <= r1_threshold;
  r2_flags_net <= r2_flags;
  r3_threshold_gain_net <= r3_threshold_gain;
  r4_preset_net <= r4_preset;
  r5_b0_net <= r5_b0;
  r6_a1_net <= r6_a1;
  r7_threshold_low_gain_net <= r7_threshold_low_gain;
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/automatic_noise_level_sensor/envelope_filter/envelope_filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_envelope_filter_x0 is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    thr_gain : in std_logic_vector( 16-1 downto 0 );
    inhibit_n : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    thr_lo : out std_logic_vector( 24-1 downto 0 );
    thr_hi : out std_logic_vector( 24-1 downto 0 )
  );
end blr_envelope_filter_x0;
architecture structural of blr_envelope_filter_x0 is 
  signal mult2_p_net : std_logic_vector( 24-1 downto 0 );
  signal negate1_op_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 24-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
  signal mux1_y_net : std_logic_vector( 36-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 36-1 downto 0 );
  signal mult_p_net : std_logic_vector( 36-1 downto 0 );
  signal addsub2_s_net : std_logic_vector( 24-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
  signal negate2_op_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal mcode1_sel_net : std_logic_vector( 1-1 downto 0 );
  signal mux_y_net : std_logic_vector( 32-1 downto 0 );
  signal delay_q_net : std_logic_vector( 36-1 downto 0 );
  signal mcode_sel_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 24-1 downto 0 );
  signal mult1_p_net : std_logic_vector( 36-1 downto 0 );
  signal zero_op_net : std_logic_vector( 32-1 downto 0 );
begin
  thr_lo <= negate1_op_net;
  thr_hi <= mult2_p_net;
  down_sample2_q_net <= x;
  down_sample1_q_net <= thr_gain;
  down_sample3_q_net <= inhibit_n;
  down_sample4_q_net <= rst;
  down_sample5_q_net <= b0;
  down_sample6_q_net <= a1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  addsub : entity xil_defaultlib.blr_xladdsub 
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
    core_name0 => "blr_c_addsub_v12_0_i0",
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
    b => mux1_y_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  addsub1 : entity xil_defaultlib.blr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 1,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "blr_c_addsub_v12_0_i1",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 24
  )
  port map (
    clr => '0',
    en => "1",
    a => negate2_op_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  addsub2 : entity xil_defaultlib.blr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlUnsigned,
    b_bin_pt => 0,
    b_width => 1,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 25,
    core_name0 => "blr_c_addsub_v12_0_i2",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 1,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 24
  )
  port map (
    clr => '0',
    en => "1",
    a => convert_dout_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub2_s_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_d9c11edc2f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.blr_xlconvert 
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
  delay : entity xil_defaultlib.sysgen_delay_957015e4a0 
  port map (
    clr => '0',
    d => addsub_s_net,
    rst => down_sample4_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_6d93ce2cc8 
  port map (
    clr => '0',
    xi => mcode1_y_net,
    yi => convert_dout_net,
    inhibit_n => down_sample3_q_net,
    clk => clk_net,
    ce => ce_net,
    sel => mcode_sel_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_9ca88800ec 
  port map (
    clr => '0',
    x => addsub1_s_net,
    inh_n => down_sample3_q_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode1_y_net,
    sel => mcode1_sel_net
  );
  mult : entity xil_defaultlib.blr_xlmult 
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
    core_name0 => "blr_mult_gen_v12_0_i1",
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
    a => mcode1_y_net,
    b => mux_y_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  mult1 : entity xil_defaultlib.blr_xlmult 
  generic map (
    a_arith => xlUnsigned,
    a_bin_pt => 32,
    a_width => 32,
    b_arith => xlSigned,
    b_bin_pt => 26,
    b_width => 36,
    c_a_type => 1,
    c_a_width => 32,
    c_b_type => 0,
    c_b_width => 36,
    c_baat => 32,
    c_output_width => 68,
    c_type => 0,
    core_name0 => "blr_mult_gen_v12_0_i2",
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
    a => down_sample6_q_net,
    b => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult1_p_net
  );
  mult2 : entity xil_defaultlib.blr_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlUnsigned,
    b_bin_pt => 8,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 24,
    c_b_type => 1,
    c_b_width => 16,
    c_baat => 24,
    c_output_width => 40,
    c_type => 0,
    core_name0 => "blr_mult_gen_v12_0_i3",
    extra_registers => 1,
    multsign => 2,
    overflow => 2,
    p_arith => xlSigned,
    p_bin_pt => 14,
    p_width => 24,
    quantization => 1
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => addsub2_s_net,
    b => down_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult2_p_net
  );
  mux : entity xil_defaultlib.sysgen_mux_06165c2fc1 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode_sel_net,
    d0 => down_sample5_q_net,
    d1 => zero_op_net,
    y => mux_y_net
  );
  mux1 : entity xil_defaultlib.sysgen_mux_655fcc66af 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    sel => mcode1_sel_net,
    d0 => mult1_p_net,
    d1 => delay_q_net,
    y => mux1_y_net
  );
  negate1 : entity xil_defaultlib.sysgen_negate_e49e955988 
  port map (
    clr => '0',
    ip => mult2_p_net,
    clk => clk_net,
    ce => ce_net,
    op => negate1_op_net
  );
  negate2 : entity xil_defaultlib.sysgen_negate_e49e955988 
  port map (
    clr => '0',
    ip => down_sample2_q_net,
    clk => clk_net,
    ce => ce_net,
    op => negate2_op_net
  );
  zero : entity xil_defaultlib.sysgen_constant_8da86244b9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => zero_op_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/automatic_noise_level_sensor/envelope_filter
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_envelope_filter is
  port (
    y : in std_logic_vector( 24-1 downto 0 );
    thr_gain : in std_logic_vector( 16-1 downto 0 );
    inhibit_n : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    y_thr_hi : out std_logic_vector( 24-1 downto 0 );
    y_thr_lo : out std_logic_vector( 24-1 downto 0 )
  );
end blr_envelope_filter;
architecture structural of blr_envelope_filter is 
  signal down_sample1_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal mult2_p_net : std_logic_vector( 24-1 downto 0 );
  signal negate1_op_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample3_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample4_q_net : std_logic_vector( 1-1 downto 0 );
  signal down_sample5_q_net : std_logic_vector( 32-1 downto 0 );
  signal down_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal down_sample6_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal ce_net_x0 : std_logic;
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal up_sample1_q_net : std_logic_vector( 24-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal thr_gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
begin
  y_thr_hi <= up_sample1_q_net;
  y_thr_lo <= up_sample2_q_net;
  addsub_s_net <= y;
  thr_gain_output_port_net <= thr_gain;
  inverter1_op_net <= inhibit_n;
  bit0_y_net <= rst;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  envelope_filter : entity xil_defaultlib.blr_envelope_filter_x0 
  port map (
    x => down_sample2_q_net,
    thr_gain => down_sample1_q_net,
    inhibit_n => down_sample3_q_net,
    rst => down_sample4_q_net,
    b0 => down_sample5_q_net,
    a1 => down_sample6_q_net,
    clk_2 => clk_net,
    ce_2 => ce_net,
    thr_lo => negate1_op_net,
    thr_hi => mult2_p_net
  );
  down_sample1 : entity xil_defaultlib.blr_xldsamp 
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
    d => thr_gain_output_port_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample1_q_net
  );
  down_sample2 : entity xil_defaultlib.blr_xldsamp 
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
    d => addsub_s_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample2_q_net
  );
  down_sample3 : entity xil_defaultlib.blr_xldsamp 
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
    d => inverter1_op_net,
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample3_q_net
  );
  down_sample4 : entity xil_defaultlib.blr_xldsamp 
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
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample4_q_net
  );
  down_sample5 : entity xil_defaultlib.blr_xldsamp 
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
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample5_q_net
  );
  down_sample6 : entity xil_defaultlib.blr_xldsamp 
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
    src_clk => clk_net_x0,
    src_ce => ce_net_x0,
    dest_clk => clk_net,
    dest_ce => ce_net,
    q => down_sample6_q_net
  );
  up_sample1 : entity xil_defaultlib.blr_xlusamp 
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
    d => mult2_p_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => up_sample1_q_net
  );
  up_sample2 : entity xil_defaultlib.blr_xlusamp 
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
    d => negate1_op_net,
    src_clk => clk_net,
    src_ce => ce_net,
    dest_clk => clk_net_x0,
    dest_ce => ce_net_x0,
    q => up_sample2_q_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/automatic_noise_level_sensor
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_automatic_noise_level_sensor is
  port (
    y : in std_logic_vector( 24-1 downto 0 );
    thr_min : in std_logic_vector( 16-1 downto 0 );
    thr_gain : in std_logic_vector( 16-1 downto 0 );
    inhibit_n : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    thr_low_gain : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    threshold_invalid_n : out std_logic_vector( 1-1 downto 0 );
    thr_hi : out std_logic_vector( 16-1 downto 0 );
    thr_lo : out std_logic_vector( 16-1 downto 0 );
    threshold_overflow : out std_logic_vector( 1-1 downto 0 )
  );
end blr_automatic_noise_level_sensor;
architecture structural of blr_automatic_noise_level_sensor is 
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal thr_gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal thr_clip_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal up_sample1_q_net : std_logic_vector( 24-1 downto 0 );
  signal up_sample2_q_net : std_logic_vector( 24-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay_q_net : std_logic_vector( 24-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal thr_gain_low_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal delay1_q_net : std_logic_vector( 24-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal relational6_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
begin
  threshold_invalid_n <= logical_y_net;
  thr_hi <= convert_dout_net;
  thr_lo <= mult_p_net;
  threshold_overflow <= relational1_op_net;
  addsub_s_net <= y;
  thr_clip_output_port_net <= thr_min;
  thr_gain_output_port_net <= thr_gain;
  logical_y_net_x0 <= inhibit_n;
  bit0_y_net <= rst;
  thr_gain_low_output_port_net <= thr_low_gain;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  clk_net <= clk_1;
  ce_net <= ce_1;
  clk_net_x0 <= clk_2;
  ce_net_x0 <= ce_2;
  envelope_filter : entity xil_defaultlib.blr_envelope_filter 
  port map (
    y => addsub_s_net,
    thr_gain => thr_gain_output_port_net,
    inhibit_n => inverter1_op_net,
    rst => bit0_y_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    clk_2 => clk_net_x0,
    ce_2 => ce_net_x0,
    y_thr_hi => up_sample1_q_net,
    y_thr_lo => up_sample2_q_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_e13b6bbcdb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.blr_xlconvert 
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
    din => delay_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.blr_xlconvert 
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
    din => delay1_q_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.blr_xlconvert 
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
    din => up_sample2_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.blr_xlconvert 
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
    din => up_sample2_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
  delay : entity xil_defaultlib.blr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 24
  )
  port map (
    en => '1',
    rst => '0',
    d => up_sample1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.blr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 24
  )
  port map (
    en => '1',
    rst => '0',
    d => up_sample2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => logical_y_net_x0,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_4c22f7ea81 
  port map (
    clr => '0',
    ip => logical1_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_384951ac67 
  port map (
    clr => '0',
    d0 => relational1_op_net,
    d1 => relational6_op_net,
    clk => clk_net,
    ce => ce_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_89f07ef260 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => logical_y_net,
    y => logical1_y_net
  );
  mult : entity xil_defaultlib.blr_xlmult 
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
    core_name0 => "blr_mult_gen_v12_0_i0",
    extra_registers => 1,
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
    a => convert1_dout_net,
    b => thr_gain_low_output_port_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  relational1 : entity xil_defaultlib.sysgen_relational_051878d70a 
  port map (
    clr => '0',
    a => convert2_dout_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational1_op_net
  );
  relational6 : entity xil_defaultlib.sysgen_relational_3fb7ac86c5 
  port map (
    clr => '0',
    a => convert3_dout_net,
    b => thr_clip_output_port_net,
    clk => clk_net,
    ce => ce_net,
    op => relational6_op_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/gate_limiting
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_gate_limiting is
  port (
    gate_in : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    preset : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    gate_out : out std_logic_vector( 1-1 downto 0 )
  );
end blr_gate_limiting;
architecture structural of blr_gate_limiting is 
  signal counter1_op_net : std_logic_vector( 10-1 downto 0 );
  signal clk_net : std_logic;
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal inverter1_op_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal slice_lo5_y_net : std_logic_vector( 10-1 downto 0 );
  signal ce_net : std_logic;
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal sequential_switch_state_o_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 1-1 downto 0 );
begin
  gate_out <= logical_y_net;
  sequential_switch_state_o_net <= gate_in;
  bit0_y_net <= rst;
  slice_lo5_y_net <= preset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.blr_xlconvert 
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
    din => sequential_switch_state_o_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  counter1 : entity xil_defaultlib.blr_xlcounter_free 
  generic map (
    core_name0 => "blr_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 10
  )
  port map (
    clr => '0',
    load => bit0_y_net,
    din => slice_lo5_y_net,
    rst => mcode1_e_net,
    en => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => counter1_op_net
  );
  delay : entity xil_defaultlib.blr_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => inverter1_op_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  inverter1 : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => mcode1_e_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter1_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_90fc4f836b 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical1_y_net,
    d1 => sequential_switch_state_o_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_ddf9ff1230 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => delay_q_net,
    d2 => inverter1_op_net,
    y => logical1_y_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_76f4d8a2e6 
  port map (
    clr => '0',
    x => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode1_y_net,
    e => mcode1_e_net
  );
  relational : entity xil_defaultlib.sysgen_relational_378474a09a 
  port map (
    clr => '0',
    a => slice_lo5_y_net,
    b => counter1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/gate_trailing
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_gate_trailing is
  port (
    gate_in : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    preset : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    gate_out : out std_logic_vector( 1-1 downto 0 );
    trailing_enabled_n : out std_logic_vector( 1-1 downto 0 );
    counts : out std_logic_vector( 10-1 downto 0 );
    trailing_start : out std_logic_vector( 1-1 downto 0 )
  );
end blr_gate_trailing;
architecture structural of blr_gate_trailing is 
  signal clk_net : std_logic;
  signal convert_dout_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_lo4_y_net : std_logic_vector( 10-1 downto 0 );
  signal counter1_op_net : std_logic_vector( 10-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
begin
  gate_out <= logical_y_net;
  trailing_enabled_n <= inverter_op_net;
  counts <= counter1_op_net;
  trailing_start <= mcode1_e_net;
  logical2_y_net <= gate_in;
  bit0_y_net <= rst;
  slice_lo4_y_net <= preset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert : entity xil_defaultlib.blr_xlconvert 
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
    dout => convert_dout_net
  );
  counter1 : entity xil_defaultlib.blr_xlcounter_free 
  generic map (
    core_name0 => "blr_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 10
  )
  port map (
    clr => '0',
    load => bit0_y_net,
    din => slice_lo4_y_net,
    rst => mcode1_e_net,
    en => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => counter1_op_net
  );
  delay : entity xil_defaultlib.blr_xldelay 
  generic map (
    latency => 2,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical2_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => relational_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_ddf9ff1230 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => delay_q_net,
    d2 => logical2_y_net,
    y => logical_y_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_d94ab2c5a6 
  port map (
    clr => '0',
    x => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode1_y_net,
    e => mcode1_e_net
  );
  relational : entity xil_defaultlib.sysgen_relational_378474a09a 
  port map (
    clr => '0',
    a => slice_lo4_y_net,
    b => counter1_op_net,
    clk => clk_net,
    ce => ce_net,
    op => relational_op_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/gated_hpf
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_gated_hpf is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    en : in std_logic_vector( 1-1 downto 0 );
    m : in std_logic_vector( 2-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y_fbk : out std_logic_vector( 24-1 downto 0 );
    dc_offset : out std_logic_vector( 24-1 downto 0 )
  );
end blr_gated_hpf;
architecture structural of blr_gated_hpf is 
  signal bit12_y_net : std_logic_vector( 2-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
  signal delay_q_net : std_logic_vector( 24-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal accumulator_q_net : std_logic_vector( 32-1 downto 0 );
  signal ce_net : std_logic;
  signal mcode_y_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net : std_logic;
begin
  y_fbk <= addsub_s_net;
  dc_offset <= convert_dout_net;
  delay_q_net <= x;
  bit0_y_net <= rst;
  logical_y_net <= en;
  bit12_y_net <= m;
  clk_net <= clk_1;
  ce_net <= ce_1;
  accumulator : entity xil_defaultlib.sysgen_accum_6a280f5788 
  port map (
    clr => '0',
    b => addsub_s_net,
    rst => bit0_y_net,
    en => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => accumulator_q_net
  );
  addsub : entity xil_defaultlib.blr_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 14,
    a_width => 24,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 24,
    c_has_c_out => 0,
    c_latency => 0,
    c_output_width => 25,
    core_name0 => "blr_c_addsub_v12_0_i3",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 25,
    latency => 0,
    overflow => 2,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 14,
    s_width => 24
  )
  port map (
    clr => '0',
    en => "1",
    a => delay_q_net,
    b => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub_s_net
  );
  convert : entity xil_defaultlib.blr_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 14,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 24,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => mcode_y_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  mcode : entity xil_defaultlib.sysgen_mcode_block_a6f788c992 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    x => accumulator_q_net,
    m => bit12_y_net,
    y => mcode_y_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/look_ahead_discriminator_logic
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_look_ahead_discriminator_logic is
  port (
    fd : in std_logic_vector( 1-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    preset : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    blr_invalid_n : out std_logic_vector( 1-1 downto 0 );
    counts : out std_logic_vector( 10-1 downto 0 );
    trigger : out std_logic_vector( 1-1 downto 0 );
    state : out std_logic_vector( 2-1 downto 0 )
  );
end blr_look_ahead_discriminator_logic;
architecture structural of blr_look_ahead_discriminator_logic is 
  signal slice_lo2_y_net : std_logic_vector( 10-1 downto 0 );
  signal slice_fast_trigger_y_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal ce_net : std_logic;
  signal constant_op_net : std_logic_vector( 1-1 downto 0 );
  signal sequential_present_state_net : std_logic_vector( 2-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal sequential_blr_gate_o_net : std_logic_vector( 1-1 downto 0 );
  signal combinatorial_2_cnt_rst_net : std_logic_vector( 1-1 downto 0 );
  signal combinatorial_2_blr_gate_net : std_logic_vector( 1-1 downto 0 );
  signal combinatorial_2_cnt_en_net : std_logic_vector( 1-1 downto 0 );
  signal sequential_cnt_rst_o_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal combinatorial_1_next_state_net : std_logic_vector( 2-1 downto 0 );
  signal mcode1_y_net : std_logic_vector( 1-1 downto 0 );
  signal sequential_cnt_en_o_net : std_logic_vector( 1-1 downto 0 );
begin
  blr_invalid_n <= sequential_blr_gate_o_net;
  counts <= counter_op_net;
  trigger <= mcode1_e_net;
  state <= sequential_present_state_net;
  slice_fast_trigger_y_net <= fd;
  bit0_y_net <= rst;
  slice_lo2_y_net <= preset;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_d9c11edc2f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  counter : entity xil_defaultlib.blr_xlcounter_free 
  generic map (
    core_name0 => "blr_c_counter_binary_v12_0_i1",
    op_arith => xlUnsigned,
    op_width => 10
  )
  port map (
    clr => '0',
    rst => sequential_cnt_rst_o_net,
    en => sequential_cnt_en_o_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_db7909516e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => bit0_y_net,
    y => logical2_y_net
  );
  mcode1 : entity xil_defaultlib.sysgen_mcode_block_d94ab2c5a6 
  port map (
    clr => '0',
    x => slice_fast_trigger_y_net,
    clk => clk_net,
    ce => ce_net,
    y => mcode1_y_net,
    e => mcode1_e_net
  );
  combinatorial_1 : entity xil_defaultlib.sysgen_mcode_block_1fcbfeb0b2 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    present_state => sequential_present_state_net,
    start => mcode1_e_net,
    preset => slice_lo2_y_net,
    counts => counter_op_net,
    next_state => combinatorial_1_next_state_net
  );
  combinatorial_2 : entity xil_defaultlib.sysgen_mcode_block_acc60cbd6c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    present_state => sequential_present_state_net,
    blr_gate => combinatorial_2_blr_gate_net,
    cnt_rst => combinatorial_2_cnt_rst_net,
    cnt_en => combinatorial_2_cnt_en_net
  );
  sequential : entity xil_defaultlib.sysgen_mcode_block_2ddf0a765f 
  port map (
    clr => '0',
    next_state => combinatorial_1_next_state_net,
    rst => logical2_y_net,
    blr_gate_i => combinatorial_2_blr_gate_net,
    cnt_rst_i => combinatorial_2_cnt_rst_net,
    cnt_en_i => combinatorial_2_cnt_en_net,
    clk => clk_net,
    ce => ce_net,
    present_state => sequential_present_state_net,
    blr_gate_o => sequential_blr_gate_o_net,
    cnt_rst_o => sequential_cnt_rst_o_net,
    cnt_en_o => sequential_cnt_en_o_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer/wrap_around_discriminator_logic
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_wrap_around_discriminator_logic is
  port (
    y : in std_logic_vector( 24-1 downto 0 );
    y_thr_hi : in std_logic_vector( 16-1 downto 0 );
    y_thr_lo : in std_logic_vector( 16-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    threshold_invalid_n : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    blr_invalid_n : out std_logic_vector( 1-1 downto 0 );
    state : out std_logic_vector( 1-1 downto 0 )
  );
end blr_wrap_around_discriminator_logic;
architecture structural of blr_wrap_around_discriminator_logic is 
  signal sequential_switch_state_o_net : std_logic_vector( 1-1 downto 0 );
  signal combinatorial_2_switch_state_net : std_logic_vector( 1-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal combinatorial_1_next_state_net : std_logic_vector( 2-1 downto 0 );
  signal sequential_present_state_net : std_logic_vector( 2-1 downto 0 );
begin
  blr_invalid_n <= sequential_switch_state_o_net;
  state <= combinatorial_2_switch_state_net;
  addsub_s_net <= y;
  convert_dout_net <= y_thr_hi;
  mult_p_net <= y_thr_lo;
  bit0_y_net <= rst;
  logical_y_net <= threshold_invalid_n;
  clk_net <= clk_1;
  ce_net <= ce_1;
  convert3 : entity xil_defaultlib.blr_xlconvert 
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
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_1eaf01c06f 
  port map (
    clr => '0',
    ip => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_db7909516e 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => inverter_op_net,
    d1 => bit0_y_net,
    y => logical2_y_net
  );
  combinatorial_1 : entity xil_defaultlib.sysgen_mcode_block_3c95d293bb 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    present_state => sequential_present_state_net,
    threshold_ul_low => convert_dout_net,
    threshold_ul_hi => convert_dout_net,
    threshold_ll_low => mult_p_net,
    threshold_ll_hi => mult_p_net,
    x => convert3_dout_net,
    next_state => combinatorial_1_next_state_net
  );
  combinatorial_2 : entity xil_defaultlib.sysgen_mcode_block_cabb49fa0c 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    present_state => sequential_present_state_net,
    switch_state => combinatorial_2_switch_state_net
  );
  sequential : entity xil_defaultlib.sysgen_mcode_block_7c66abb3c9 
  port map (
    clr => '0',
    next_state => combinatorial_1_next_state_net,
    rst => logical2_y_net,
    switch_state_i => combinatorial_2_switch_state_net,
    clk => clk_net,
    ce => ce_net,
    present_state => sequential_present_state_net,
    switch_state_o => sequential_switch_state_o_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain/restorer
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_restorer is
  port (
    x : in std_logic_vector( 24-1 downto 0 );
    rst : in std_logic_vector( 1-1 downto 0 );
    m : in std_logic_vector( 2-1 downto 0 );
    fd : in std_logic_vector( 1-1 downto 0 );
    look_ahead_preset : in std_logic_vector( 10-1 downto 0 );
    thr_min : in std_logic_vector( 16-1 downto 0 );
    thr_gain : in std_logic_vector( 16-1 downto 0 );
    thr_low_gain : in std_logic_vector( 16-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    trailing_preset : in std_logic_vector( 10-1 downto 0 );
    limiting_preset : in std_logic_vector( 10-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    sw_wa : out std_logic_vector( 1-1 downto 0 );
    sw_look_ahead : out std_logic_vector( 1-1 downto 0 );
    state : out std_logic_vector( 1-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 );
    y_thr_hi : out std_logic_vector( 16-1 downto 0 );
    y_thr_lo : out std_logic_vector( 16-1 downto 0 );
    sw_trail_counts : out std_logic_vector( 10-1 downto 0 );
    trigger : out std_logic_vector( 1-1 downto 0 );
    sw : out std_logic_vector( 1-1 downto 0 );
    threshold_invalid_n : out std_logic_vector( 1-1 downto 0 );
    sw_trail_enable_n : out std_logic_vector( 1-1 downto 0 );
    sw_trail_start : out std_logic_vector( 1-1 downto 0 );
    sw_wa_in : out std_logic_vector( 1-1 downto 0 );
    sw_in : out std_logic_vector( 1-1 downto 0 )
  );
end blr_restorer;
architecture structural of blr_restorer is 
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal sequential_blr_gate_o_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal combinatorial_2_switch_state_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_e_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal sequential_switch_state_o_net : std_logic_vector( 1-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 24-1 downto 0 );
  signal counter1_op_net : std_logic_vector( 10-1 downto 0 );
  signal logical_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal thr_gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal thr_gain_low_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice_lo2_y_net : std_logic_vector( 10-1 downto 0 );
  signal slice_fast_trigger_y_net : std_logic_vector( 1-1 downto 0 );
  signal bit12_y_net : std_logic_vector( 2-1 downto 0 );
  signal thr_clip_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 24-1 downto 0 );
  signal addsub_s_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal slice_lo5_y_net : std_logic_vector( 10-1 downto 0 );
  signal relational1_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal counter_op_net : std_logic_vector( 10-1 downto 0 );
  signal sequential_present_state_net : std_logic_vector( 2-1 downto 0 );
  signal slice_lo4_y_net : std_logic_vector( 10-1 downto 0 );
  signal ce_net_x0 : std_logic;
begin
  sw_wa <= logical_y_net_x0;
  sw_look_ahead <= sequential_blr_gate_o_net;
  state <= combinatorial_2_switch_state_net;
  y <= convert1_dout_net;
  y_thr_hi <= convert_dout_net_x0;
  y_thr_lo <= mult_p_net;
  sw_trail_counts <= counter1_op_net;
  trigger <= mcode1_e_net;
  sw <= logical_y_net;
  threshold_invalid_n <= logical_y_net_x1;
  sw_trail_enable_n <= inverter_op_net;
  sw_trail_start <= mcode1_e_net_x0;
  sw_wa_in <= sequential_switch_state_o_net;
  sw_in <= logical2_y_net;
  delay_q_net <= x;
  bit0_y_net <= rst;
  bit12_y_net <= m;
  slice_fast_trigger_y_net <= fd;
  slice_lo2_y_net <= look_ahead_preset;
  thr_clip_output_port_net <= thr_min;
  thr_gain_output_port_net <= thr_gain;
  thr_gain_low_output_port_net <= thr_low_gain;
  b00_output_port_net <= b0;
  a01_output_port_net <= a1;
  slice_lo4_y_net <= trailing_preset;
  slice_lo5_y_net <= limiting_preset;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  automatic_noise_level_sensor : entity xil_defaultlib.blr_automatic_noise_level_sensor 
  port map (
    y => addsub_s_net,
    thr_min => thr_clip_output_port_net,
    thr_gain => thr_gain_output_port_net,
    inhibit_n => logical_y_net_x0,
    rst => bit0_y_net,
    thr_low_gain => thr_gain_low_output_port_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    clk_2 => clk_net,
    ce_2 => ce_net,
    threshold_invalid_n => logical_y_net_x1,
    thr_hi => convert_dout_net_x0,
    thr_lo => mult_p_net,
    threshold_overflow => relational1_op_net
  );
  gate_limiting : entity xil_defaultlib.blr_gate_limiting 
  port map (
    gate_in => sequential_switch_state_o_net,
    rst => bit0_y_net,
    preset => slice_lo5_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    gate_out => logical_y_net_x0
  );
  gate_trailing : entity xil_defaultlib.blr_gate_trailing 
  port map (
    gate_in => logical2_y_net,
    rst => bit0_y_net,
    preset => slice_lo4_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    gate_out => logical_y_net,
    trailing_enabled_n => inverter_op_net,
    counts => counter1_op_net,
    trailing_start => mcode1_e_net_x0
  );
  gated_hpf : entity xil_defaultlib.blr_gated_hpf 
  port map (
    x => delay_q_net,
    rst => bit0_y_net,
    en => logical_y_net,
    m => bit12_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    y_fbk => addsub_s_net,
    dc_offset => convert_dout_net
  );
  look_ahead_discriminator_logic : entity xil_defaultlib.blr_look_ahead_discriminator_logic 
  port map (
    fd => slice_fast_trigger_y_net,
    rst => bit0_y_net,
    preset => slice_lo2_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    blr_invalid_n => sequential_blr_gate_o_net,
    counts => counter_op_net,
    trigger => mcode1_e_net,
    state => sequential_present_state_net
  );
  wrap_around_discriminator_logic : entity xil_defaultlib.blr_wrap_around_discriminator_logic 
  port map (
    y => addsub_s_net,
    y_thr_hi => convert_dout_net_x0,
    y_thr_lo => mult_p_net,
    rst => bit0_y_net,
    threshold_invalid_n => logical_y_net_x1,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    blr_invalid_n => sequential_switch_state_o_net,
    state => combinatorial_2_switch_state_net
  );
  convert1 : entity xil_defaultlib.blr_xlconvert 
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
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => addsub_s_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert1_dout_net
  );
  logical2 : entity xil_defaultlib.sysgen_logical_e4473d5569 
  port map (
    clr => '0',
    d0 => logical_y_net_x0,
    d1 => sequential_blr_gate_o_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    y => logical2_y_net
  );
end structural;
-- Generated from Simulink block blr/blr_clk_domain
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_blr_clk_domain is
  port (
    threshold_clip : in std_logic_vector( 32-1 downto 0 );
    flags : in std_logic_vector( 32-1 downto 0 );
    threshold_gain : in std_logic_vector( 32-1 downto 0 );
    preset : in std_logic_vector( 32-1 downto 0 );
    b0 : in std_logic_vector( 32-1 downto 0 );
    a1 : in std_logic_vector( 32-1 downto 0 );
    threshold_low_gain : in std_logic_vector( 32-1 downto 0 );
    fast_discriminator : in std_logic_vector( 18-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : out std_logic_vector( 1-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_blr_clk_domain;
architecture structural of blr_blr_clk_domain is 
  signal r2_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal r4_preset_q_net : std_logic_vector( 32-1 downto 0 );
  signal r3_threshold_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b0_q_net : std_logic_vector( 32-1 downto 0 );
  signal r7_threshold_low_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal r1_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal r6_a1_q_net : std_logic_vector( 32-1 downto 0 );
  signal combinatorial_2_switch_state_net : std_logic_vector( 1-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal fast_discriminator_net : std_logic_vector( 18-1 downto 0 );
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal sequential_blr_gate_o_net : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_e_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal logical_y_net_x1 : std_logic_vector( 1-1 downto 0 );
  signal counter1_op_net : std_logic_vector( 10-1 downto 0 );
  signal inverter_op_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 24-1 downto 0 );
  signal sequential_switch_state_o_net : std_logic_vector( 1-1 downto 0 );
  signal mcode1_e_net : std_logic_vector( 1-1 downto 0 );
  signal slice_lo4_y_net : std_logic_vector( 10-1 downto 0 );
  signal bit12_y_net : std_logic_vector( 2-1 downto 0 );
  signal slice_lo5_y_net : std_logic_vector( 10-1 downto 0 );
  signal logical2_y_net : std_logic_vector( 1-1 downto 0 );
  signal thr_clip_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal thr_gain_low_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal slice_lo2_y_net : std_logic_vector( 10-1 downto 0 );
  signal thr_gain_output_port_net : std_logic_vector( 16-1 downto 0 );
  signal bit0_y_net : std_logic_vector( 1-1 downto 0 );
  signal slice_fast_trigger_y_net : std_logic_vector( 1-1 downto 0 );
  signal a01_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal b00_output_port_net : std_logic_vector( 32-1 downto 0 );
  signal slice_lo_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_lo3_y_net : std_logic_vector( 16-1 downto 0 );
  signal slice_lo1_y_net : std_logic_vector( 16-1 downto 0 );
begin
  r1_threshold_q_net <= threshold_clip;
  r2_flags_q_net <= flags;
  r3_threshold_gain_q_net <= threshold_gain;
  r4_preset_q_net <= preset;
  r5_b0_q_net <= b0;
  r6_a1_q_net <= a1;
  r7_threshold_low_gain_q_net <= threshold_low_gain;
  dbg_1 <= convert2_dout_net;
  dbg_2 <= convert_dout_net_x0;
  dbg_3 <= convert1_dout_net_x0;
  dbg_4 <= convert3_dout_net;
  fast_discriminator_net <= fast_discriminator;
  threshold <= convert_dout_net;
  threshold_invalid_n <= logical_y_net;
  x_net <= x;
  y <= convert1_dout_net;
  clk_net_x0 <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net <= clk_2;
  ce_net <= ce_2;
  restorer : entity xil_defaultlib.blr_restorer 
  port map (
    x => delay_q_net,
    rst => bit0_y_net,
    m => bit12_y_net,
    fd => slice_fast_trigger_y_net,
    look_ahead_preset => slice_lo2_y_net,
    thr_min => thr_clip_output_port_net,
    thr_gain => thr_gain_output_port_net,
    thr_low_gain => thr_gain_low_output_port_net,
    b0 => b00_output_port_net,
    a1 => a01_output_port_net,
    trailing_preset => slice_lo4_y_net,
    limiting_preset => slice_lo5_y_net,
    clk_1 => clk_net_x0,
    ce_1 => ce_net_x0,
    clk_2 => clk_net,
    ce_2 => ce_net,
    sw_wa => logical_y_net_x0,
    sw_look_ahead => sequential_blr_gate_o_net,
    state => combinatorial_2_switch_state_net,
    y => convert1_dout_net,
    y_thr_hi => convert_dout_net,
    y_thr_lo => mult_p_net,
    sw_trail_counts => counter1_op_net,
    trigger => mcode1_e_net_x0,
    sw => logical_y_net_x1,
    threshold_invalid_n => logical_y_net,
    sw_trail_enable_n => inverter_op_net_x0,
    sw_trail_start => mcode1_e_net,
    sw_wa_in => sequential_switch_state_o_net,
    sw_in => logical2_y_net
  );
  convert : entity xil_defaultlib.blr_xlconvert 
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
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => sequential_blr_gate_o_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert_dout_net_x0
  );
  convert1 : entity xil_defaultlib.blr_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 2,
    dout_bin_pt => 14,
    dout_width => 16,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical_y_net_x0,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert1_dout_net_x0
  );
  convert2 : entity xil_defaultlib.blr_xlconvert 
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
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical_y_net_x1,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.blr_xlconvert 
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
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => logical_y_net_x1,
    clk => clk_net_x0,
    ce => ce_net_x0,
    dout => convert3_dout_net
  );
  delay : entity xil_defaultlib.blr_xldelay 
  generic map (
    latency => 20,
    reg_retiming => 0,
    reset => 0,
    width => 24
  )
  port map (
    en => '1',
    rst => '0',
    d => x_net,
    clk => clk_net_x0,
    ce => ce_net_x0,
    q => delay_q_net
  );
  slice_fast_trigger : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 18,
    y_width => 1
  )
  port map (
    x => fast_discriminator_net,
    y => slice_fast_trigger_y_net
  );
  slice_lo : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r3_threshold_gain_q_net,
    y => slice_lo_y_net
  );
  slice_lo1 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r1_threshold_q_net,
    y => slice_lo1_y_net
  );
  slice_lo2 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 9,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => r4_preset_q_net,
    y => slice_lo2_y_net
  );
  slice_lo3 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 15,
    x_width => 32,
    y_width => 16
  )
  port map (
    x => r7_threshold_low_gain_q_net,
    y => slice_lo3_y_net
  );
  slice_lo4 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 20,
    new_msb => 29,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => r4_preset_q_net,
    y => slice_lo4_y_net
  );
  slice_lo5 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 10,
    new_msb => 19,
    x_width => 32,
    y_width => 10
  )
  port map (
    x => r4_preset_q_net,
    y => slice_lo5_y_net
  );
  a01 : entity xil_defaultlib.sysgen_reinterpret_6445586f68 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => r6_a1_q_net,
    output_port => a01_output_port_net
  );
  b00 : entity xil_defaultlib.sysgen_reinterpret_6445586f68 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => r5_b0_q_net,
    output_port => b00_output_port_net
  );
  bit0 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 0,
    new_msb => 0,
    x_width => 32,
    y_width => 1
  )
  port map (
    x => r2_flags_q_net,
    y => bit0_y_net
  );
  bit12 : entity xil_defaultlib.blr_xlslice 
  generic map (
    new_lsb => 1,
    new_msb => 2,
    x_width => 32,
    y_width => 2
  )
  port map (
    x => r2_flags_q_net,
    y => bit12_y_net
  );
  thr_clip : entity xil_defaultlib.sysgen_reinterpret_65ee335b25 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_lo1_y_net,
    output_port => thr_clip_output_port_net
  );
  thr_gain : entity xil_defaultlib.sysgen_reinterpret_5b93d52556 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_lo_y_net,
    output_port => thr_gain_output_port_net
  );
  thr_gain_low : entity xil_defaultlib.sysgen_reinterpret_5b93d52556 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    input_port => slice_lo3_y_net,
    output_port => thr_gain_low_output_port_net
  );
end structural;
-- Generated from Simulink block blr_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_struct is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_preset : in std_logic_vector( 32-1 downto 0 );
    r5_b0 : in std_logic_vector( 32-1 downto 0 );
    r6_a1 : in std_logic_vector( 32-1 downto 0 );
    r7_threshold_low_gain : in std_logic_vector( 32-1 downto 0 );
    fast_discriminator : in std_logic_vector( 18-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    clk_2 : in std_logic;
    ce_2 : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : out std_logic_vector( 1-1 downto 0 );
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr_struct;
architecture structural of blr_struct is 
  signal r2_flags_net : std_logic_vector( 32-1 downto 0 );
  signal r4_preset_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b0_net : std_logic_vector( 32-1 downto 0 );
  signal r3_threshold_gain_net : std_logic_vector( 32-1 downto 0 );
  signal r7_threshold_low_gain_net : std_logic_vector( 32-1 downto 0 );
  signal r1_threshold_net : std_logic_vector( 32-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal r6_a1_net : std_logic_vector( 32-1 downto 0 );
  signal convert_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal fast_discriminator_net : std_logic_vector( 18-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 16-1 downto 0 );
  signal r4_preset_q_net : std_logic_vector( 32-1 downto 0 );
  signal clk_net_x0 : std_logic;
  signal r2_flags_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net_x0 : std_logic;
  signal r6_a1_q_net : std_logic_vector( 32-1 downto 0 );
  signal r1_threshold_q_net : std_logic_vector( 32-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 16-1 downto 0 );
  signal x_net : std_logic_vector( 24-1 downto 0 );
  signal clk_net : std_logic;
  signal r3_threshold_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal r5_b0_q_net : std_logic_vector( 32-1 downto 0 );
  signal r7_threshold_low_gain_q_net : std_logic_vector( 32-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
begin
  r1_threshold_net <= r1_threshold;
  r2_flags_net <= r2_flags;
  r3_threshold_gain_net <= r3_threshold_gain;
  r4_preset_net <= r4_preset;
  r5_b0_net <= r5_b0;
  r6_a1_net <= r6_a1;
  r7_threshold_low_gain_net <= r7_threshold_low_gain;
  dbg_1 <= convert2_dout_net;
  dbg_2 <= convert_dout_net_x0;
  dbg_3 <= convert1_dout_net_x0;
  dbg_4 <= convert3_dout_net;
  fast_discriminator_net <= fast_discriminator;
  threshold <= convert_dout_net;
  threshold_invalid_n <= logical_y_net;
  x_net <= x;
  y <= convert1_dout_net;
  clk_net <= clk_1;
  ce_net_x0 <= ce_1;
  clk_net_x0 <= clk_2;
  ce_net <= ce_2;
  axi_clk_domain : entity xil_defaultlib.blr_axi_clk_domain 
  port map (
    r1_threshold => r1_threshold_net,
    r2_flags => r2_flags_net,
    r3_threshold_gain => r3_threshold_gain_net,
    r4_preset => r4_preset_net,
    r5_b0 => r5_b0_net,
    r6_a1 => r6_a1_net,
    r7_threshold_low_gain => r7_threshold_low_gain_net
  );
  blr_clk_domain : entity xil_defaultlib.blr_blr_clk_domain 
  port map (
    threshold_clip => r1_threshold_q_net,
    flags => r2_flags_q_net,
    threshold_gain => r3_threshold_gain_q_net,
    preset => r4_preset_q_net,
    b0 => r5_b0_q_net,
    a1 => r6_a1_q_net,
    threshold_low_gain => r7_threshold_low_gain_q_net,
    fast_discriminator => fast_discriminator_net,
    x => x_net,
    clk_1 => clk_net,
    ce_1 => ce_net_x0,
    clk_2 => clk_net_x0,
    ce_2 => ce_net,
    dbg_1 => convert2_dout_net,
    dbg_2 => convert_dout_net_x0,
    dbg_3 => convert1_dout_net_x0,
    dbg_4 => convert3_dout_net,
    threshold => convert_dout_net,
    threshold_invalid_n => logical_y_net,
    y => convert1_dout_net
  );
  r1_threshold_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000111101101111111100001010"
  )
  port map (
    en => "1",
    rst => "0",
    d => r1_threshold_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r1_threshold_q_net
  );
  r2_flags_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000011"
  )
  port map (
    en => "1",
    rst => "0",
    d => r2_flags_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r2_flags_q_net
  );
  r3_threshold_gain_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000100000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r3_threshold_gain_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r3_threshold_gain_q_net
  );
  r4_preset_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000100000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r4_preset_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r4_preset_q_net
  );
  r5_b0_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r5_b0_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r5_b0_q_net
  );
  r6_a1_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r6_a1_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r6_a1_q_net
  );
  r7_threshold_low_gain_x0 : entity xil_defaultlib.blr_xlregister 
  generic map (
    d_width => 32,
    init_value => b"00000000000000000000000000000000"
  )
  port map (
    en => "1",
    rst => "0",
    d => r7_threshold_low_gain_net,
    clk => clk_net,
    ce => ce_net_x0,
    q => r7_threshold_low_gain_q_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr_default_clock_driver is
  port (
    blr_sysclk : in std_logic;
    blr_sysce : in std_logic;
    blr_sysclr : in std_logic;
    blr_clk1 : out std_logic;
    blr_ce1 : out std_logic;
    blr_clk2 : out std_logic;
    blr_ce2 : out std_logic
  );
end blr_default_clock_driver;
architecture structural of blr_default_clock_driver is 
begin
  clockdriver_x0 : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => blr_sysclk,
    sysce => blr_sysce,
    sysclr => blr_sysclr,
    clk => blr_clk1,
    ce => blr_ce1
  );
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 2,
    log_2_period => 2
  )
  port map (
    sysclk => blr_sysclk,
    sysce => blr_sysce,
    sysclr => blr_sysclr,
    clk => blr_clk2,
    ce => blr_ce2
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity blr is
  port (
    r1_threshold : in std_logic_vector( 32-1 downto 0 );
    r2_flags : in std_logic_vector( 32-1 downto 0 );
    r3_threshold_gain : in std_logic_vector( 32-1 downto 0 );
    r4_preset : in std_logic_vector( 32-1 downto 0 );
    r5_b0 : in std_logic_vector( 32-1 downto 0 );
    r6_a1 : in std_logic_vector( 32-1 downto 0 );
    r7_threshold_low_gain : in std_logic_vector( 32-1 downto 0 );
    fast_discriminator : in std_logic_vector( 18-1 downto 0 );
    x : in std_logic_vector( 24-1 downto 0 );
    clk : in std_logic;
    dbg_1 : out std_logic_vector( 16-1 downto 0 );
    dbg_2 : out std_logic_vector( 16-1 downto 0 );
    dbg_3 : out std_logic_vector( 16-1 downto 0 );
    dbg_4 : out std_logic_vector( 16-1 downto 0 );
    threshold : out std_logic_vector( 16-1 downto 0 );
    threshold_invalid_n : out std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end blr;
architecture structural of blr is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "blr,sysgen_core_2022_2,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=1,ce_clr=0,clock_period=20,system_simulink_period=2e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.1,accum=1,addsub=4,constant=5,convert=14,counter=3,delay=6,dsamp=6,inv=8,logical=9,mcode=12,mult=4,mux=3,negate=3,register=7,reinterpret=7,relational=4,slice=13,usamp=2,}";
  signal ce_1_net : std_logic;
  signal clk_1_net : std_logic;
  signal ce_2_net : std_logic;
  signal clk_2_net : std_logic;
begin
  blr_default_clock_driver : entity xil_defaultlib.blr_default_clock_driver 
  port map (
    blr_sysclk => clk,
    blr_sysce => '1',
    blr_sysclr => '0',
    blr_clk1 => clk_1_net,
    blr_ce1 => ce_1_net,
    blr_clk2 => clk_2_net,
    blr_ce2 => ce_2_net
  );
  blr_struct : entity xil_defaultlib.blr_struct 
  port map (
    r1_threshold => r1_threshold,
    r2_flags => r2_flags,
    r3_threshold_gain => r3_threshold_gain,
    r4_preset => r4_preset,
    r5_b0 => r5_b0,
    r6_a1 => r6_a1,
    r7_threshold_low_gain => r7_threshold_low_gain,
    fast_discriminator => fast_discriminator,
    x => x,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    clk_2 => clk_2_net,
    ce_2 => ce_2_net,
    dbg_1 => dbg_1,
    dbg_2 => dbg_2,
    dbg_3 => dbg_3,
    dbg_4 => dbg_4,
    threshold => threshold,
    threshold_invalid_n(0) => threshold_invalid_n,
    y => y
  );
end structural;
