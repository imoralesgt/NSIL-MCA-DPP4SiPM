-- Generated from Simulink block ip_mav_14_13_16_14/mav
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_mav_14_13_16_14_mav is
  port (
    x : in std_logic_vector( 14-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    x_out : out std_logic_vector( 16-1 downto 0 )
  );
end ip_mav_14_13_16_14_mav;
architecture structural of ip_mav_14_13_16_14_mav is 
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal x_net : std_logic_vector( 14-1 downto 0 );
  signal addsub1_s_net : std_logic_vector( 15-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 14-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
begin
  x_out <= mult_p_net;
  x_net <= x;
  clk_net <= clk_1;
  ce_net <= ce_1;
  constant_x0 : entity xil_defaultlib.sysgen_constant_e0e180b5ad 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  mult : entity xil_defaultlib.ip_mav_14_13_16_14_xlmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 15,
    b_arith => xlSigned,
    b_bin_pt => 14,
    b_width => 16,
    c_a_type => 0,
    c_a_width => 15,
    c_b_type => 0,
    c_b_width => 16,
    c_baat => 15,
    c_output_width => 31,
    c_type => 0,
    core_name0 => "ip_mav_14_13_16_14_mult_gen_v12_0_i0",
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
    a => addsub1_s_net,
    b => constant_op_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => mult_p_net
  );
  addsub1 : entity xil_defaultlib.ip_mav_14_13_16_14_xladdsub 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 14,
    b_arith => xlSigned,
    b_bin_pt => 13,
    b_width => 14,
    c_has_c_out => 0,
    c_latency => 1,
    c_output_width => 15,
    core_name0 => "ip_mav_14_13_16_14_c_addsub_v12_0_i0",
    extra_registers => 0,
    full_s_arith => 2,
    full_s_width => 15,
    latency => 1,
    overflow => 1,
    quantization => 1,
    s_arith => xlSigned,
    s_bin_pt => 13,
    s_width => 15
  )
  port map (
    clr => '0',
    en => "1",
    a => x_net,
    b => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    s => addsub1_s_net
  );
  delay1 : entity xil_defaultlib.ip_mav_14_13_16_14_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 14
  )
  port map (
    en => '1',
    rst => '0',
    d => x_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
end structural;
-- Generated from Simulink block ip_mav_14_13_16_14_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_mav_14_13_16_14_struct is
  port (
    x : in std_logic_vector( 14-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end ip_mav_14_13_16_14_struct;
architecture structural of ip_mav_14_13_16_14_struct is 
  signal x_net : std_logic_vector( 14-1 downto 0 );
  signal mult_p_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal clk_net : std_logic;
begin
  x_net <= x;
  y <= mult_p_net;
  clk_net <= clk_1;
  ce_net <= ce_1;
  mav : entity xil_defaultlib.ip_mav_14_13_16_14_mav 
  port map (
    x => x_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    x_out => mult_p_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_mav_14_13_16_14_default_clock_driver is
  port (
    ip_mav_14_13_16_14_sysclk : in std_logic;
    ip_mav_14_13_16_14_sysce : in std_logic;
    ip_mav_14_13_16_14_sysclr : in std_logic;
    ip_mav_14_13_16_14_clk1 : out std_logic;
    ip_mav_14_13_16_14_ce1 : out std_logic
  );
end ip_mav_14_13_16_14_default_clock_driver;
architecture structural of ip_mav_14_13_16_14_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => ip_mav_14_13_16_14_sysclk,
    sysce => ip_mav_14_13_16_14_sysce,
    sysclr => ip_mav_14_13_16_14_sysclr,
    clk => ip_mav_14_13_16_14_clk1,
    ce => ip_mav_14_13_16_14_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ip_mav_14_13_16_14 is
  port (
    x : in std_logic_vector( 14-1 downto 0 );
    clk : in std_logic;
    y : out std_logic_vector( 16-1 downto 0 )
  );
end ip_mav_14_13_16_14;
architecture structural of ip_mav_14_13_16_14 is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "ip_mav_14_13_16_14,sysgen_core_2019_1,{,compilation=IP Catalog,block_icon_display=Default,family=artix7,part=xc7a35t,speed=-1,package=cpg236,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=0,interface_doc=1,ce_clr=0,clock_period=20,system_simulink_period=2e-08,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.02,addsub=1,constant=1,delay=1,mult=1,}";
  signal ce_1_net : std_logic;
  signal clk_1_net : std_logic;
begin
  ip_mav_14_13_16_14_default_clock_driver : entity xil_defaultlib.ip_mav_14_13_16_14_default_clock_driver 
  port map (
    ip_mav_14_13_16_14_sysclk => clk,
    ip_mav_14_13_16_14_sysce => '1',
    ip_mav_14_13_16_14_sysclr => '0',
    ip_mav_14_13_16_14_clk1 => clk_1_net,
    ip_mav_14_13_16_14_ce1 => ce_1_net
  );
  ip_mav_14_13_16_14_struct : entity xil_defaultlib.ip_mav_14_13_16_14_struct 
  port map (
    x => x,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    y => y
  );
end structural;
