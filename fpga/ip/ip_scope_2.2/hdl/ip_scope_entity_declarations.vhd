-------------------------------------------------------------------
-- System Generator version 2019.1 VHDL source file.
--
-- Copyright(C) 2019 by Xilinx, Inc.  All rights reserved.  This
-- text/file contains proprietary, confidential information of Xilinx,
-- Inc., is distributed under license from Xilinx, Inc., and may be used,
-- copied and/or disclosed only pursuant to the terms of a valid license
-- agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
-- this text/file solely for design, simulation, implementation and
-- creation of design files limited to Xilinx devices or technologies.
-- Use with non-Xilinx devices or technologies is expressly prohibited
-- and immediately terminates your license unless covered by a separate
-- agreement.
--
-- Xilinx is providing this design, code, or information "as is" solely
-- for use in developing programs and solutions for Xilinx devices.  By
-- providing this design, code, or information as one possible
-- implementation of this feature, application or standard, Xilinx is
-- making no representation that this implementation is free from any
-- claims of infringement.  You are responsible for obtaining any rights
-- you may require for your implementation.  Xilinx expressly disclaims
-- any warranty whatsoever with respect to the adequacy of the
-- implementation, including but not limited to warranties of
-- merchantability or fitness for a particular purpose.
--
-- Xilinx products are not intended for use in life support appliances,
-- devices, or systems.  Use in such applications is expressly prohibited.
--
-- Any modifications that are made to the source code are done at the user's
-- sole risk and will be unsupported.
--
-- This copyright and support notice must be retained as part of this
-- text at all times.  (c) Copyright 1995-2019 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library xpm;
use xpm.vcomponents.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity ip_scope_xltdpram is
   generic(width_addr        : integer := -1;
           width             : integer := -1;
           addr_width_b      : integer := -1;
           data_width_b      : integer := -1;
           mem_size          : integer := 0;
           write_mode_a      : string := "no_change";
           write_mode_b      : string := "no_change";
           mem_init_file     : string  := "none";
           clocking_mode     : string  := "common_clock";
           read_reset_a    : string  := "0";
           read_reset_b    : string  := "0";
           latency           : integer := 0);
   port(dina: in std_logic_vector(width-1 downto 0);
        addra: in std_logic_vector(width_addr-1 downto 0);
        wea: in std_logic_vector(0 downto 0);
        ena: in std_logic_vector(0 downto 0);
        rsta: in std_logic_vector(0 downto 0);
        a_ce: in std_logic;
        a_clk: in std_logic;
        douta: out std_logic_vector(width-1 downto 0);
        dinb: in std_logic_vector(data_width_b-1 downto 0);
        addrb: in std_logic_vector(addr_width_b-1 downto 0);
        web: in std_logic_vector(0 downto 0);
        enb: in std_logic_vector(0 downto 0);
        rstb: in std_logic_vector(0 downto 0);
        b_ce: in std_logic;
        b_clk: in std_logic;
        doutb: out std_logic_vector(data_width_b-1 downto 0)
);

end ip_scope_xltdpram;

architecture behavior of ip_scope_xltdpram is

signal b_en: std_logic_vector(0 downto 0);
signal a_en: std_logic_vector(0 downto 0);
signal a_rst: std_logic_vector(0 downto 0);
signal b_rst: std_logic_vector(0 downto 0);
signal a_we: std_logic_vector(0 downto 0);
signal b_we: std_logic_vector(0 downto 0);
begin
b_en(0) <= enb(0) and b_ce;
a_en(0) <= ena(0) and a_ce;
b_rst(0) <= rstb(0) and b_ce;
a_rst(0) <= rsta(0) and a_ce;
b_we(0) <= web(0) and b_ce;
a_we(0) <= wea(0) and a_ce;
 xpm_memory_tdpram_inst : xpm_memory_tdpram

generic map (
   -- Common module generics
     MEMORY_SIZE        => mem_size,        --positive integer
     MEMORY_PRIMITIVE   => "block",
     MEMORY_INIT_FILE   => mem_init_file,
     CLOCKING_MODE      => clocking_mode,
     MEMORY_INIT_PARAM  => "",
     USE_MEM_INIT       => 1,
     WAKEUP_TIME        => "disable_sleep",
     MESSAGE_CONTROL    => 0,

     -- Port A module generics
     WRITE_DATA_WIDTH_A => width,
     READ_DATA_WIDTH_A  => width,
     BYTE_WRITE_WIDTH_A => width,
     ADDR_WIDTH_A       => width_addr,
     READ_RESET_VALUE_A => read_reset_a,
     READ_LATENCY_A     => latency,
     WRITE_MODE_A       => write_mode_a,
     -- Port A module generics
     WRITE_DATA_WIDTH_B => data_width_b,
     READ_DATA_WIDTH_B  => data_width_b,
     BYTE_WRITE_WIDTH_B => data_width_b,
     ADDR_WIDTH_B       => addr_width_b,
     READ_RESET_VALUE_B => read_reset_b,
     READ_LATENCY_B     => latency,
     WRITE_MODE_B       => write_mode_b
 )
 port map (
     -- Common module ports
     sleep          =>  '0',
     -- Port A module ports
     clka           =>  a_clk,
     rsta           =>  a_rst(0),
     ena            =>  a_en(0),
     regcea         =>  a_ce,
	  wea            =>  a_we,
	  addra          =>  addra,
	  dina           =>  dina,
	  injectsbiterra =>  '0',  --do not change
	  injectdbiterra =>  '0',  --do not change
	  douta          =>  douta,
	  sbiterra       =>  open, --do not change
	  dbiterra       =>  open,  --do not change
 
     -- Port B module ports
     clkb           =>  b_clk,
     rstb           =>  b_rst(0),
     enb            =>  b_en(0),
     regceb         =>  b_ce,
	  web            =>  b_we,
	  addrb          =>  addrb,
	  dinb           =>  dinb,
	  injectsbiterrb =>  '0',  --do not change
	  injectdbiterrb =>  '0',  --do not change
	  doutb          =>  doutb,
	  sbiterrb       =>  open, --do not change
	  dbiterrb       =>  open  --do not change
);
end behavior;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity ip_scope_xlAsynRegister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d     : in std_logic_vector (d_width-1 downto 0);
         rst   : in std_logic_vector(0 downto 0) := "0";
         en    : in std_logic_vector(0 downto 0) := "1";
         d_ce  : in std_logic;
         d_clk : in std_logic;
         q_ce  : in std_logic;
         q_clk : in std_logic;
         q     : out std_logic_vector (d_width-1 downto 0));

end ip_scope_xlAsynRegister;

architecture behavior of ip_scope_xlAsynRegister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   signal internal_d_clr      : std_logic;
   signal internal_d_ce       : std_logic;
   signal internal_q_clr      : std_logic;
   signal internal_q_ce       : std_logic;

   signal d1_net              : std_logic_vector (d_width-1 downto 0);
   signal d2_net              : std_logic_vector (d_width-1 downto 0);
   signal d3_net              : std_logic_vector (d_width-1 downto 0);

begin

   internal_d_clr <= rst(0) and d_ce;
   internal_d_ce  <= en(0) and d_ce;
   -- drive default values on enable and clear ports
   internal_q_clr <= '0' and q_ce;
   internal_q_ce  <= '1' and q_ce;

   -- Synthesizable behavioral model
   synth_reg_inst_0 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_d_ce,
                clr => internal_d_clr,
                clk => d_clk,
                o   => d1_net);

   synth_reg_inst_1 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d1_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => d2_net);

   synth_reg_inst_2 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d2_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => d3_net);

   synth_reg_inst_3 : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d3_net,
                ce  => internal_q_ce,
                clr => internal_q_clr,
                clk => q_clk,
                o   => q);

end architecture behavior;


library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

--$Header: /devl/xcs/repo/env/Jobs/sysgen/src/xbs/blocks/xlconvert/hdl/xlconvert.vhd,v 1.1 2004/11/22 00:17:30 rosty Exp $
---------------------------------------------------------------------
--
--  Filename      : xlconvert.vhd
--
--  Description   : VHDL description of a fixed point converter block that
--                  converts the input to a new output type.

--
---------------------------------------------------------------------


---------------------------------------------------------------------
--
--  Entity        : xlconvert
--
--  Architecture  : behavior
--
--  Description   : Top level VHDL description of fixed point conver block.
--
---------------------------------------------------------------------


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity convert_func_call_ip_scope_xlconvert is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        result : out std_logic_vector (dout_width-1 downto 0));
end convert_func_call_ip_scope_xlconvert ;

architecture behavior of convert_func_call_ip_scope_xlconvert is
begin
    -- Convert to output type and do saturation arith.
    result <= convert_type(din, din_width, din_bin_pt, din_arith,
                           dout_width, dout_bin_pt, dout_arith,
                           quantization, overflow);
end behavior;


library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity ip_scope_xlconvert  is
    generic (
        din_width    : integer := 16;            -- Width of input
        din_bin_pt   : integer := 4;             -- Binary point of input
        din_arith    : integer := xlUnsigned;    -- Type of arith of input
        dout_width   : integer := 8;             -- Width of output
        dout_bin_pt  : integer := 2;             -- Binary point of output
        dout_arith   : integer := xlUnsigned;    -- Type of arith of output
        en_width     : integer := 1;
        en_bin_pt    : integer := 0;
        en_arith     : integer := xlUnsigned;
        bool_conversion : integer :=0;           -- if one, convert ufix_1_0 to
                                                 -- bool
        latency      : integer := 0;             -- Ouput delay clk cycles
        quantization : integer := xlTruncate;    -- xlRound or xlTruncate
        overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
    port (
        din : in std_logic_vector (din_width-1 downto 0);
        en  : in std_logic_vector (en_width-1 downto 0);
        ce  : in std_logic;
        clr : in std_logic;
        clk : in std_logic;
        dout : out std_logic_vector (dout_width-1 downto 0));

end ip_scope_xlconvert ;

architecture behavior of ip_scope_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_ip_scope_xlconvert 
        generic (
            din_width    : integer := 16;            -- Width of input
            din_bin_pt   : integer := 4;             -- Binary point of input
            din_arith    : integer := xlUnsigned;    -- Type of arith of input
            dout_width   : integer := 8;             -- Width of output
            dout_bin_pt  : integer := 2;             -- Binary point of output
            dout_arith   : integer := xlUnsigned;    -- Type of arith of output
            quantization : integer := xlTruncate;    -- xlRound or xlTruncate
            overflow     : integer := xlWrap);       -- xlSaturate or xlWrap
        port (
            din : in std_logic_vector (din_width-1 downto 0);
            result : out std_logic_vector (dout_width-1 downto 0));
    end component;


    -- synthesis translate_off
--    signal real_din, real_dout : real;    -- For debugging info ports
    -- synthesis translate_on
    signal result : std_logic_vector(dout_width-1 downto 0);
    signal internal_ce : std_logic;

begin

    -- Debugging info for internal full precision variables
    -- synthesis translate_off
--     real_din <= to_real(din, din_bin_pt, din_arith);
--     real_dout <= to_real(dout, dout_bin_pt, dout_arith);
    -- synthesis translate_on

    internal_ce <= ce and en(0);

    bool_conversion_generate : if (bool_conversion = 1)
    generate
      result <= din;
    end generate; --bool_conversion_generate

    std_conversion_generate : if (bool_conversion = 0)
    generate
      -- Workaround for XST bug
      convert : convert_func_call_ip_scope_xlconvert 
        generic map (
          din_width   => din_width,
          din_bin_pt  => din_bin_pt,
          din_arith   => din_arith,
          dout_width  => dout_width,
          dout_bin_pt => dout_bin_pt,
          dout_arith  => dout_arith,
          quantization => quantization,
          overflow     => overflow)
        port map (
          din => din,
          result => result);
    end generate; --std_conversion_generate

    latency_test : if (latency > 0) generate
        reg : synth_reg
            generic map (
              width => dout_width,
              latency => latency
            )
            port map (
              i => result,
              ce => internal_ce,
              clr => clr,
              clk => clk,
              o => dout
            );
    end generate;

    latency0 : if (latency = 0)
    generate
        dout <= result;
    end generate latency0;

end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlslice.vhd
--
--  Description   : VHDL description of a block that sets the output to a
--                  specified range of the input bits. The output is always
--                  set to an unsigned type with it's binary point at zero.
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity ip_scope_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end ip_scope_xlslice;

architecture behavior of ip_scope_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_cf6db46343 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_cf6db46343;
architecture behavior of sysgen_reinterpret_cf6db46343
is
  signal input_port_1_40: unsigned((16 - 1) downto 0);
  signal output_port_5_5_force: signed((16 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port_5_5_force <= unsigned_to_signed(input_port_1_40);
  output_port <= signed_to_std_logic_vector(output_port_5_5_force);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_749ec0155a is
  port (
    input_port : in std_logic_vector((11 - 1) downto 0);
    output_port : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_749ec0155a;
architecture behavior of sysgen_reinterpret_749ec0155a
is
  signal input_port_1_40: unsigned((11 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_1f1ea39045 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_1f1ea39045;
architecture behavior of sysgen_reinterpret_1f1ea39045
is
  signal input_port_1_40: unsigned((32 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_17d5e55a3b is
  port (
    input_port : in std_logic_vector((8 - 1) downto 0);
    output_port : out std_logic_vector((8 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_17d5e55a3b;
architecture behavior of sysgen_reinterpret_17d5e55a3b
is
  signal input_port_1_40: unsigned((8 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_f5f56dda1e is
  port (
    input_port : in std_logic_vector((6 - 1) downto 0);
    output_port : out std_logic_vector((6 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_f5f56dda1e;
architecture behavior of sysgen_reinterpret_f5f56dda1e
is
  signal input_port_1_40: unsigned((6 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_0b927c7559 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_0b927c7559;
architecture behavior of sysgen_reinterpret_0b927c7559
is
  signal input_port_1_40: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_concat_f45ca58bd3 is
  port (
    in0 : in std_logic_vector((16 - 1) downto 0);
    in1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_concat_f45ca58bd3;
architecture behavior of sysgen_concat_f45ca58bd3
is
  signal in0_1_23: unsigned((16 - 1) downto 0);
  signal in1_1_27: unsigned((16 - 1) downto 0);
  signal y_2_1_concat: unsigned((32 - 1) downto 0);
begin
  in0_1_23 <= std_logic_vector_to_unsigned(in0);
  in1_1_27 <= std_logic_vector_to_unsigned(in1);
  y_2_1_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(in0_1_23) & unsigned_to_std_logic_vector(in1_1_27));
  y <= unsigned_to_std_logic_vector(y_2_1_concat);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_c162b331dc is
  port (
    eni : in std_logic_vector((1 - 1) downto 0);
    rate : in std_logic_vector((8 - 1) downto 0);
    eno : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_c162b331dc;
architecture behavior of sysgen_mcode_block_c162b331dc
is
  signal eni_1_27: boolean;
  signal rate_1_31: unsigned((8 - 1) downto 0);
  signal eno_i_3_23_next: boolean;
  signal eno_i_3_23: boolean := false;
  signal eno_i_3_23_en: std_logic;
  signal down_sample_cnt_i_4_35_next: unsigned((8 - 1) downto 0);
  signal down_sample_cnt_i_4_35: unsigned((8 - 1) downto 0) := "00000000";
  signal down_sample_cnt_i_4_35_rst: std_logic;
  signal rel_6_8: boolean;
  signal eno_join_6_5: boolean;
  signal cast_20_33: unsigned((9 - 1) downto 0);
  signal down_sample_cnt_i_20_13_addsub: unsigned((9 - 1) downto 0);
  signal rel_16_12: boolean;
  signal down_sample_cnt_i_join_16_9: unsigned((9 - 1) downto 0);
  signal eno_i_join_16_9: boolean;
  signal rel_13_8: boolean;
  signal down_sample_cnt_i_join_13_5: unsigned((9 - 1) downto 0);
  signal down_sample_cnt_i_join_13_5_rst: std_logic;
  signal eno_i_join_13_5: boolean;
  signal eno_i_join_13_5_en: std_logic;
  signal cast_down_sample_cnt_i_4_35_next: unsigned((8 - 1) downto 0);
begin
  eni_1_27 <= ((eni) = "1");
  rate_1_31 <= std_logic_vector_to_unsigned(rate);
  proc_eno_i_3_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (eno_i_3_23_en = '1')) then
        eno_i_3_23 <= eno_i_3_23_next;
      end if;
    end if;
  end process proc_eno_i_3_23;
  proc_down_sample_cnt_i_4_35: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (down_sample_cnt_i_4_35_rst = '1')) then
        down_sample_cnt_i_4_35 <= "00000000";
      elsif (ce = '1') then 
        down_sample_cnt_i_4_35 <= down_sample_cnt_i_4_35_next;
      end if;
    end if;
  end process proc_down_sample_cnt_i_4_35;
  rel_6_8 <= rate_1_31 = std_logic_vector_to_unsigned("00000000");
  proc_if_6_5: process (eno_i_3_23, rel_6_8)
  is
  begin
    if rel_6_8 then
      eno_join_6_5 <= true;
    else 
      eno_join_6_5 <= eno_i_3_23;
    end if;
  end process proc_if_6_5;
  cast_20_33 <= u2u_cast(down_sample_cnt_i_4_35, 0, 9, 0);
  down_sample_cnt_i_20_13_addsub <= cast_20_33 + std_logic_vector_to_unsigned("000000001");
  rel_16_12 <= down_sample_cnt_i_4_35 = rate_1_31;
  proc_if_16_9: process (down_sample_cnt_i_20_13_addsub, rel_16_12)
  is
  begin
    if rel_16_12 then
      down_sample_cnt_i_join_16_9 <= std_logic_vector_to_unsigned("000000000");
      eno_i_join_16_9 <= true;
    else 
      down_sample_cnt_i_join_16_9 <= down_sample_cnt_i_20_13_addsub;
      eno_i_join_16_9 <= false;
    end if;
  end process proc_if_16_9;
  rel_13_8 <= eni_1_27 = false;
  proc_if_13_5: process (down_sample_cnt_i_join_16_9, eno_i_join_16_9, rel_13_8)
  is
  begin
    if rel_13_8 then
      down_sample_cnt_i_join_13_5_rst <= '1';
    else 
      down_sample_cnt_i_join_13_5_rst <= '0';
    end if;
    down_sample_cnt_i_join_13_5 <= down_sample_cnt_i_join_16_9;
    if rel_13_8 then
      eno_i_join_13_5_en <= '0';
    else 
      eno_i_join_13_5_en <= '1';
    end if;
    eno_i_join_13_5 <= eno_i_join_16_9;
  end process proc_if_13_5;
  eno_i_3_23_next <= eno_i_join_16_9;
  eno_i_3_23_en <= eno_i_join_13_5_en;
  cast_down_sample_cnt_i_4_35_next <= u2u_cast(down_sample_cnt_i_join_13_5, 0, 8, 0);
  down_sample_cnt_i_4_35_next <= cast_down_sample_cnt_i_4_35_next;
  down_sample_cnt_i_4_35_rst <= down_sample_cnt_i_join_13_5_rst;
  eno <= boolean_to_vector(eno_join_6_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_dd89f2f82f is
  port (
    x : in std_logic_vector((16 - 1) downto 0);
    threshold : in std_logic_vector((16 - 1) downto 0);
    ena : in std_logic_vector((1 - 1) downto 0);
    clear : in std_logic_vector((1 - 1) downto 0);
    clk_en : in std_logic_vector((1 - 1) downto 0);
    addr : out std_logic_vector((11 - 1) downto 0);
    we : out std_logic_vector((1 - 1) downto 0);
    full : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_dd89f2f82f;
architecture behavior of sysgen_mcode_block_dd89f2f82f
is
  signal x_1_56: signed((16 - 1) downto 0);
  signal threshold_1_59: signed((16 - 1) downto 0);
  signal ena_1_70: boolean;
  signal clear_1_75: boolean;
  signal clk_en_1_82: boolean;
  signal state_4_23_next: unsigned((3 - 1) downto 0);
  signal state_4_23: unsigned((3 - 1) downto 0) := "000";
  signal full_i_5_24_next: unsigned((1 - 1) downto 0);
  signal full_i_5_24: unsigned((1 - 1) downto 0) := "0";
  signal addr_i_6_24_next: unsigned((11 - 1) downto 0);
  signal addr_i_6_24: unsigned((11 - 1) downto 0) := "00000000000";
  signal addr_i_6_24_rst: std_logic;
  signal wm_8_20_next: boolean;
  signal wm_8_20: boolean := false;
  signal cast_19_22: unsigned((12 - 1) downto 0);
  signal addr_i_19_13_addsub: unsigned((12 - 1) downto 0);
  signal rel_18_12: boolean;
  signal addr_i_join_18_9: unsigned((12 - 1) downto 0);
  signal rel_15_8: boolean;
  signal addr_i_join_15_5: unsigned((12 - 1) downto 0);
  signal addr_i_join_15_5_rst: std_logic;
  signal rel_31_8: boolean;
  signal state_join_31_5: unsigned((3 - 1) downto 0);
  signal rel_41_16: boolean;
  signal state_join_41_13: unsigned((3 - 1) downto 0);
  signal rel_47_16: boolean;
  signal state_join_47_13: unsigned((3 - 1) downto 0);
  signal rel_54_16: boolean;
  signal state_join_54_13: unsigned((3 - 1) downto 0);
  signal state_join_35_5: unsigned((3 - 1) downto 0);
  signal full_i_join_35_5: unsigned((1 - 1) downto 0);
  signal wm_join_35_5: boolean;
  signal cast_addr_i_6_24_next: unsigned((11 - 1) downto 0);
begin
  x_1_56 <= std_logic_vector_to_signed(x);
  threshold_1_59 <= std_logic_vector_to_signed(threshold);
  ena_1_70 <= ((ena) = "1");
  clear_1_75 <= ((clear) = "1");
  clk_en_1_82 <= ((clk_en) = "1");
  proc_state_4_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        state_4_23 <= state_4_23_next;
      end if;
    end if;
  end process proc_state_4_23;
  proc_full_i_5_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        full_i_5_24 <= full_i_5_24_next;
      end if;
    end if;
  end process proc_full_i_5_24;
  proc_addr_i_6_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (addr_i_6_24_rst = '1')) then
        addr_i_6_24 <= "00000000000";
      elsif (ce = '1') then 
        addr_i_6_24 <= addr_i_6_24_next;
      end if;
    end if;
  end process proc_addr_i_6_24;
  proc_wm_8_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        wm_8_20 <= wm_8_20_next;
      end if;
    end if;
  end process proc_wm_8_20;
  cast_19_22 <= u2u_cast(addr_i_6_24, 0, 12, 0);
  addr_i_19_13_addsub <= cast_19_22 + std_logic_vector_to_unsigned("000000000001");
  rel_18_12 <= clk_en_1_82 = true;
  proc_if_18_9: process (addr_i_19_13_addsub, addr_i_6_24, rel_18_12)
  is
  begin
    if rel_18_12 then
      addr_i_join_18_9 <= addr_i_19_13_addsub;
    else 
      addr_i_join_18_9 <= u2u_cast(addr_i_6_24, 0, 12, 0);
    end if;
  end process proc_if_18_9;
  rel_15_8 <= wm_8_20 = false;
  proc_if_15_5: process (addr_i_join_18_9, rel_15_8)
  is
  begin
    if rel_15_8 then
      addr_i_join_15_5_rst <= '1';
    else 
      addr_i_join_15_5_rst <= '0';
    end if;
    addr_i_join_15_5 <= addr_i_join_18_9;
  end process proc_if_15_5;
  rel_31_8 <= ena_1_70 = false;
  proc_if_31_5: process (rel_31_8, state_4_23)
  is
  begin
    if rel_31_8 then
      state_join_31_5 <= std_logic_vector_to_unsigned("000");
    else 
      state_join_31_5 <= state_4_23;
    end if;
  end process proc_if_31_5;
  rel_41_16 <= x_1_56 > threshold_1_59;
  proc_if_41_13: process (rel_41_16, state_join_31_5)
  is
  begin
    if rel_41_16 then
      state_join_41_13 <= std_logic_vector_to_unsigned("010");
    else 
      state_join_41_13 <= state_join_31_5;
    end if;
  end process proc_if_41_13;
  rel_47_16 <= addr_i_6_24 = std_logic_vector_to_unsigned("11111111111");
  proc_if_47_13: process (rel_47_16, state_join_31_5)
  is
  begin
    if rel_47_16 then
      state_join_47_13 <= std_logic_vector_to_unsigned("011");
    else 
      state_join_47_13 <= state_join_31_5;
    end if;
  end process proc_if_47_13;
  rel_54_16 <= clear_1_75 = true;
  proc_if_54_13: process (rel_54_16, state_join_31_5)
  is
  begin
    if rel_54_16 then
      state_join_54_13 <= std_logic_vector_to_unsigned("001");
    else 
      state_join_54_13 <= state_join_31_5;
    end if;
  end process proc_if_54_13;
  proc_switch_35_5: process (state_join_31_5, state_join_41_13, state_join_47_13, state_join_54_13)
  is
  begin
    case state_join_31_5 is 
      when "000" =>
        state_join_35_5 <= std_logic_vector_to_unsigned("001");
        full_i_join_35_5 <= std_logic_vector_to_unsigned("0");
        wm_join_35_5 <= false;
      when "001" =>
        state_join_35_5 <= state_join_41_13;
        full_i_join_35_5 <= std_logic_vector_to_unsigned("0");
        wm_join_35_5 <= false;
      when "010" =>
        state_join_35_5 <= state_join_47_13;
        full_i_join_35_5 <= std_logic_vector_to_unsigned("0");
        wm_join_35_5 <= true;
      when "011" =>
        state_join_35_5 <= state_join_54_13;
        full_i_join_35_5 <= std_logic_vector_to_unsigned("1");
        wm_join_35_5 <= false;
      when others =>
        state_join_35_5 <= std_logic_vector_to_unsigned("000");
        full_i_join_35_5 <= std_logic_vector_to_unsigned("0");
        wm_join_35_5 <= false;
    end case;
  end process proc_switch_35_5;
  state_4_23_next <= state_join_35_5;
  full_i_5_24_next <= full_i_join_35_5;
  cast_addr_i_6_24_next <= u2u_cast(addr_i_join_15_5, 0, 11, 0);
  addr_i_6_24_next <= cast_addr_i_6_24_next;
  addr_i_6_24_rst <= addr_i_join_15_5_rst;
  wm_8_20_next <= wm_join_35_5;
  addr <= unsigned_to_std_logic_vector(addr_i_6_24);
  we <= boolean_to_vector(wm_8_20);
  full <= unsigned_to_std_logic_vector(full_i_5_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xlregister.vhd
--
--  Description   : VHDL description of an arbitrary wide register.
--                  Unlike the delay block, an initial value is
--                  specified and is considered valid at the start
--                  of simulation.  The register is only one word
--                  deep.
--
--  Mod. History  : Removed valid bit logic from wrapper.
--                : Changed VHDL to use a bit_vector generic for its
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity ip_scope_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end ip_scope_xlregister;

architecture behavior of ip_scope_xlregister is

   component synth_reg_w_init
      generic (width      : integer;
               init_index : integer;
               init_value : bit_vector;
               latency    : integer);
      port (i   : in std_logic_vector(width-1 downto 0);
            ce  : in std_logic;
            clr : in std_logic;
            clk : in std_logic;
            o   : out std_logic_vector(width-1 downto 0));
   end component; -- end synth_reg_w_init

   -- synthesis translate_off
   signal real_d, real_q           : real;    -- For debugging info ports
   -- synthesis translate_on
   signal internal_clr             : std_logic;
   signal internal_ce              : std_logic;

begin

   internal_clr <= rst(0) and ce;
   internal_ce  <= en(0) and ce;

   -- Synthesizable behavioral model
   synth_reg_inst : synth_reg_w_init
      generic map (width      => d_width,
                   init_index => 2,
                   init_value => init_value,
                   latency    => 1)
      port map (i   => d,
                ce  => internal_ce,
                clr => internal_clr,
                clk => clk,
                o   => q);

end architecture behavior;


library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_f4d98d0287 is
  port (
    op : out std_logic_vector((11 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_f4d98d0287;
architecture behavior of sysgen_constant_f4d98d0287
is
begin
  op <= "00000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_1c29ff0c58 is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_1c29ff0c58;
architecture behavior of sysgen_constant_1c29ff0c58
is
begin
  op <= "1";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_f845914c88 is
  port (
    a : in std_logic_vector((11 - 1) downto 0);
    b : in std_logic_vector((11 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_f845914c88;
architecture behavior of sysgen_relational_f845914c88
is
  signal a_1_31: unsigned((11 - 1) downto 0);
  signal b_1_34: unsigned((11 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_12_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_unsigned(a);
  b_1_34 <= std_logic_vector_to_unsigned(b);
  op_mem_37_22_back <= op_mem_37_22(0);
  proc_op_mem_37_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_37_22_push_front_pop_back_en = '1')) then
        op_mem_37_22(0) <= op_mem_37_22_front_din;
      end if;
    end if;
  end process proc_op_mem_37_22;
  result_12_3_rel <= a_1_31 = b_1_34;
  op_mem_37_22_front_din <= result_12_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library xpm;
use xpm.vcomponents.all;
library IEEE;
use IEEE.std_logic_1164.all;

entity ip_scope_xlspram is
   generic(width_addr        : integer := -1;
           width             : integer := -1;
           mem_size          : integer := 0;
           write_mode_a      : string  := "no_change";
           mem_init_file     : string  := "none";
           read_reset_val    : string  := "0";
           mem_type          : string  := "auto";
           init_value        : bit_vector := b"00";
           xpm_lat            : integer := 1;
           latency           : integer := 0);
   port(data_in: in std_logic_vector(width-1 downto 0);
        addr: in std_logic_vector(width_addr-1 downto 0);
        we: in std_logic_vector(0 downto 0);
        en: in std_logic_vector(0 downto 0);
        rst: in std_logic_vector(0 downto 0);
        ce: in std_logic;
        clk: in std_logic;
        data_out: out std_logic_vector(width-1 downto 0)
);

end ip_scope_xlspram;

architecture behavior of ip_scope_xlspram is
signal a_en: std_logic_vector(0 downto 0);
signal a_we: std_logic_vector(0 downto 0);
signal a_rst: std_logic_vector(0 downto 0);
signal xpm_rst: std_logic_vector(0 downto 0);
signal core_data_out, lat_data_out, dly_data_out: std_logic_vector(width-1 downto 0);

begin
a_en(0) <= en(0) and ce;
a_we(0) <= we(0) and ce;
a_rst(0) <= rst(0) and ce;
data_out <= dly_data_out;

  rst_test: if (latency > 1) generate
     xpm_rst(0) <= '0';
  end generate;
  rst_test_2:if (latency <= 1) generate
     xpm_rst(0) <= rst(0) and ce;
  end generate; 


xpm_memory_spram_inst : xpm_memory_spram

generic map (
   -- Common module generics
     MEMORY_SIZE        => mem_size,        --positive integer
     MEMORY_PRIMITIVE   => mem_type,
     MEMORY_INIT_FILE   => mem_init_file,
     MEMORY_INIT_PARAM  => "",
     USE_MEM_INIT       => 1,
     WAKEUP_TIME        => "disable_sleep",
     MESSAGE_CONTROL    => 0,

     -- Port A module generics
     WRITE_DATA_WIDTH_A => width,
     READ_DATA_WIDTH_A  => width,
     BYTE_WRITE_WIDTH_A => width,
     ADDR_WIDTH_A       => width_addr,
     READ_RESET_VALUE_A => read_reset_val,
     READ_LATENCY_A     => xpm_lat,
     WRITE_MODE_A       => write_mode_a
 )
 port map (
     -- Common module ports
     sleep          =>  '0',
     -- Port A module ports
     clka           =>  clk,
     rsta           =>  a_rst(0),
     ena            =>  a_en(0),
     regcea         =>  ce,
	  wea            =>  a_we,
	  addra          =>  addr,
	  dina           =>  data_in,
	  injectsbiterra =>  '0',  --do not change
	  injectdbiterra =>  '0',  --do not change
	  douta          =>  core_data_out,
	  sbiterra       =>  open, --do not change
	  dbiterra       =>  open  --do not change
);

  dly_data_out <= core_data_out;
end behavior;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_2be3aaba4a is
  port (
    x : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    re : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_2be3aaba4a;
architecture behavior of sysgen_mcode_block_2be3aaba4a
is
  signal x_1_38: unsigned((1 - 1) downto 0);
  signal ff_2_17_next: unsigned((1 - 1) downto 0);
  signal ff_2_17: unsigned((1 - 1) downto 0) := "0";
  signal rel_5_5: boolean;
  signal rel_5_15: boolean;
  signal bool_5_5: boolean;
  signal re_join_5_2: boolean;
begin
  x_1_38 <= std_logic_vector_to_unsigned(x);
  proc_ff_2_17: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        ff_2_17 <= ff_2_17_next;
      end if;
    end if;
  end process proc_ff_2_17;
  rel_5_5 <= ff_2_17 = std_logic_vector_to_unsigned("0");
  rel_5_15 <= x_1_38 = std_logic_vector_to_unsigned("1");
  bool_5_5 <= rel_5_5 and rel_5_15;
  proc_if_5_2: process (bool_5_5)
  is
  begin
    if bool_5_5 then
      re_join_5_2 <= true;
    else 
      re_join_5_2 <= false;
    end if;
  end process proc_if_5_2;
  ff_2_17_next <= x_1_38;
  y <= unsigned_to_std_logic_vector(ff_2_17);
  re <= boolean_to_vector(re_join_5_2);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_e87c6ac3f2 is
  port (
    x : in std_logic_vector((16 - 1) downto 0);
    clk_en : in std_logic_vector((1 - 1) downto 0);
    down_sample_rate : in std_logic_vector((8 - 1) downto 0);
    ena : in std_logic_vector((1 - 1) downto 0);
    z : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_e87c6ac3f2;
architecture behavior of sysgen_mcode_block_e87c6ac3f2
is
  signal x_5_19: signed((16 - 1) downto 0);
  signal clk_en_5_22: boolean;
  signal down_sample_rate_5_30: unsigned((8 - 1) downto 0);
  signal ena_5_48: boolean;
  signal state_7_23_next: unsigned((1 - 1) downto 0);
  signal state_7_23: unsigned((1 - 1) downto 0) := "0";
  signal z1_8_20_next: signed((16 - 1) downto 0);
  signal z1_8_20: signed((16 - 1) downto 0) := "0000000000000000";
  signal z2_9_20_next: signed((16 - 1) downto 0);
  signal z2_9_20: signed((16 - 1) downto 0) := "0000000000000000";
  signal z2_9_20_en: std_logic;
  signal rel_11_8: boolean;
  signal z_join_11_5: signed((16 - 1) downto 0);
  signal rel_17_8: boolean;
  signal state_join_17_5: unsigned((1 - 1) downto 0);
  signal rel_28_21: boolean;
  signal z2_join_28_17: signed((16 - 1) downto 0);
  signal rel_26_16: boolean;
  signal z2_join_26_13: signed((16 - 1) downto 0);
  signal z2_join_26_13_en: std_logic;
  signal state_join_26_13: unsigned((1 - 1) downto 0);
  signal rel_34_17: boolean;
  signal z1_join_34_13: signed((16 - 1) downto 0);
  signal z1_join_21_5: signed((16 - 1) downto 0);
  signal state_join_21_5: unsigned((1 - 1) downto 0);
  signal z2_join_21_5: signed((16 - 1) downto 0);
  signal z2_join_21_5_en: std_logic;
begin
  x_5_19 <= std_logic_vector_to_signed(x);
  clk_en_5_22 <= ((clk_en) = "1");
  down_sample_rate_5_30 <= std_logic_vector_to_unsigned(down_sample_rate);
  ena_5_48 <= ((ena) = "1");
  proc_state_7_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        state_7_23 <= state_7_23_next;
      end if;
    end if;
  end process proc_state_7_23;
  proc_z1_8_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        z1_8_20 <= z1_8_20_next;
      end if;
    end if;
  end process proc_z1_8_20;
  proc_z2_9_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (z2_9_20_en = '1')) then
        z2_9_20 <= z2_9_20_next;
      end if;
    end if;
  end process proc_z2_9_20;
  rel_11_8 <= down_sample_rate_5_30 = std_logic_vector_to_unsigned("00000000");
  proc_if_11_5: process (rel_11_8, x_5_19, z2_9_20)
  is
  begin
    if rel_11_8 then
      z_join_11_5 <= x_5_19;
    else 
      z_join_11_5 <= z2_9_20;
    end if;
  end process proc_if_11_5;
  rel_17_8 <= ena_5_48 = false;
  proc_if_17_5: process (rel_17_8, state_7_23)
  is
  begin
    if rel_17_8 then
      state_join_17_5 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_17_5 <= state_7_23;
    end if;
  end process proc_if_17_5;
  rel_28_21 <= z1_8_20 < x_5_19;
  proc_if_28_17: process (rel_28_21, x_5_19, z1_8_20)
  is
  begin
    if rel_28_21 then
      z2_join_28_17 <= x_5_19;
    else 
      z2_join_28_17 <= z1_8_20;
    end if;
  end process proc_if_28_17;
  rel_26_16 <= clk_en_5_22 = true;
  proc_if_26_13: process (rel_26_16, state_join_17_5, z2_join_28_17)
  is
  begin
    if rel_26_16 then
      z2_join_26_13_en <= '1';
    else 
      z2_join_26_13_en <= '0';
    end if;
    z2_join_26_13 <= z2_join_28_17;
    if rel_26_16 then
      state_join_26_13 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_26_13 <= state_join_17_5;
    end if;
  end process proc_if_26_13;
  rel_34_17 <= z1_8_20 < x_5_19;
  proc_if_34_13: process (rel_34_17, x_5_19, z1_8_20)
  is
  begin
    if rel_34_17 then
      z1_join_34_13 <= x_5_19;
    else 
      z1_join_34_13 <= z1_8_20;
    end if;
  end process proc_if_34_13;
  proc_switch_21_5: process (state_join_17_5, state_join_26_13, x_5_19, z1_8_20, z1_join_34_13, z2_join_26_13, z2_join_26_13_en)
  is
  begin
    case state_join_17_5 is 
      when "0" =>
        z2_join_21_5_en <= '0';
      when "1" =>
        z2_join_21_5_en <= z2_join_26_13_en;
      when others =>
        z2_join_21_5_en <= '0';
    end case;
    z2_join_21_5 <= z2_join_26_13;
    case state_join_17_5 is 
      when "0" =>
        z1_join_21_5 <= x_5_19;
        state_join_21_5 <= std_logic_vector_to_unsigned("1");
      when "1" =>
        z1_join_21_5 <= z1_join_34_13;
        state_join_21_5 <= state_join_26_13;
      when others =>
        z1_join_21_5 <= z1_8_20;
        state_join_21_5 <= state_join_17_5;
    end case;
  end process proc_switch_21_5;
  state_7_23_next <= state_join_21_5;
  z1_8_20_next <= z1_join_21_5;
  z2_9_20_next <= z2_join_21_5;
  z2_9_20_en <= z2_join_21_5_en;
  z <= signed_to_std_logic_vector(z_join_11_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_7d7d8dfe4a is
  port (
    x : in std_logic_vector((16 - 1) downto 0);
    clk_en : in std_logic_vector((1 - 1) downto 0);
    down_sample_rate : in std_logic_vector((8 - 1) downto 0);
    ena : in std_logic_vector((1 - 1) downto 0);
    z : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_7d7d8dfe4a;
architecture behavior of sysgen_mcode_block_7d7d8dfe4a
is
  signal x_1_19: signed((16 - 1) downto 0);
  signal clk_en_1_22: boolean;
  signal down_sample_rate_1_30: unsigned((8 - 1) downto 0);
  signal ena_1_48: boolean;
  signal state_3_23_next: unsigned((1 - 1) downto 0);
  signal state_3_23: unsigned((1 - 1) downto 0) := "0";
  signal z1_4_20_next: signed((16 - 1) downto 0);
  signal z1_4_20: signed((16 - 1) downto 0) := "0000000000000000";
  signal z2_5_20_next: signed((16 - 1) downto 0);
  signal z2_5_20: signed((16 - 1) downto 0) := "0000000000000000";
  signal z2_5_20_en: std_logic;
  signal rel_7_8: boolean;
  signal z_join_7_5: signed((16 - 1) downto 0);
  signal rel_13_8: boolean;
  signal state_join_13_5: unsigned((1 - 1) downto 0);
  signal rel_24_21: boolean;
  signal z2_join_24_17: signed((16 - 1) downto 0);
  signal rel_22_16: boolean;
  signal state_join_22_13: unsigned((1 - 1) downto 0);
  signal z2_join_22_13: signed((16 - 1) downto 0);
  signal z2_join_22_13_en: std_logic;
  signal rel_31_17: boolean;
  signal z1_join_31_13: signed((16 - 1) downto 0);
  signal z1_join_17_5: signed((16 - 1) downto 0);
  signal state_join_17_5: unsigned((1 - 1) downto 0);
  signal z2_join_17_5: signed((16 - 1) downto 0);
  signal z2_join_17_5_en: std_logic;
begin
  x_1_19 <= std_logic_vector_to_signed(x);
  clk_en_1_22 <= ((clk_en) = "1");
  down_sample_rate_1_30 <= std_logic_vector_to_unsigned(down_sample_rate);
  ena_1_48 <= ((ena) = "1");
  proc_state_3_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        state_3_23 <= state_3_23_next;
      end if;
    end if;
  end process proc_state_3_23;
  proc_z1_4_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        z1_4_20 <= z1_4_20_next;
      end if;
    end if;
  end process proc_z1_4_20;
  proc_z2_5_20: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (z2_5_20_en = '1')) then
        z2_5_20 <= z2_5_20_next;
      end if;
    end if;
  end process proc_z2_5_20;
  rel_7_8 <= down_sample_rate_1_30 = std_logic_vector_to_unsigned("00000000");
  proc_if_7_5: process (rel_7_8, x_1_19, z2_5_20)
  is
  begin
    if rel_7_8 then
      z_join_7_5 <= x_1_19;
    else 
      z_join_7_5 <= z2_5_20;
    end if;
  end process proc_if_7_5;
  rel_13_8 <= ena_1_48 = false;
  proc_if_13_5: process (rel_13_8, state_3_23)
  is
  begin
    if rel_13_8 then
      state_join_13_5 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_13_5 <= state_3_23;
    end if;
  end process proc_if_13_5;
  rel_24_21 <= z1_4_20 > x_1_19;
  proc_if_24_17: process (rel_24_21, x_1_19, z1_4_20)
  is
  begin
    if rel_24_21 then
      z2_join_24_17 <= x_1_19;
    else 
      z2_join_24_17 <= z1_4_20;
    end if;
  end process proc_if_24_17;
  rel_22_16 <= clk_en_1_22 = true;
  proc_if_22_13: process (rel_22_16, state_join_13_5, z2_join_24_17)
  is
  begin
    if rel_22_16 then
      z2_join_22_13_en <= '1';
    else 
      z2_join_22_13_en <= '0';
    end if;
    z2_join_22_13 <= z2_join_24_17;
    if rel_22_16 then
      state_join_22_13 <= std_logic_vector_to_unsigned("0");
    else 
      state_join_22_13 <= state_join_13_5;
    end if;
  end process proc_if_22_13;
  rel_31_17 <= z1_4_20 > x_1_19;
  proc_if_31_13: process (rel_31_17, x_1_19, z1_4_20)
  is
  begin
    if rel_31_17 then
      z1_join_31_13 <= x_1_19;
    else 
      z1_join_31_13 <= z1_4_20;
    end if;
  end process proc_if_31_13;
  proc_switch_17_5: process (state_join_13_5, state_join_22_13, x_1_19, z1_4_20, z1_join_31_13, z2_join_22_13, z2_join_22_13_en)
  is
  begin
    case state_join_13_5 is 
      when "0" =>
        z2_join_17_5_en <= '0';
      when "1" =>
        z2_join_17_5_en <= z2_join_22_13_en;
      when others =>
        z2_join_17_5_en <= '0';
    end case;
    z2_join_17_5 <= z2_join_22_13;
    case state_join_13_5 is 
      when "0" =>
        z1_join_17_5 <= x_1_19;
        state_join_17_5 <= std_logic_vector_to_unsigned("1");
      when "1" =>
        z1_join_17_5 <= z1_join_31_13;
        state_join_17_5 <= state_join_22_13;
      when others =>
        z1_join_17_5 <= z1_4_20;
        state_join_17_5 <= state_join_13_5;
    end case;
  end process proc_switch_17_5;
  state_3_23_next <= state_join_17_5;
  z1_4_20_next <= z1_join_17_5;
  z2_5_20_next <= z2_join_17_5;
  z2_5_20_en <= z2_join_17_5_en;
  z <= signed_to_std_logic_vector(z_join_7_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_d75d41ca60 is
  port (
    sel : in std_logic_vector((2 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    d2 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_d75d41ca60;
architecture behavior of sysgen_mux_d75d41ca60
is
  signal sel_1_20: std_logic_vector((2 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  signal d2_1_30: std_logic_vector((16 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  proc_switch_6_1: process (d0_1_24, d1_1_27, d2_1_30, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "00" =>
        unregy_join_6_1 <= d0_1_24;
      when "01" =>
        unregy_join_6_1 <= d1_1_27;
      when others =>
        unregy_join_6_1 <= d2_1_30;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_30d70cf429 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_30d70cf429;
architecture behavior of sysgen_reinterpret_30d70cf429
is
  signal input_port_1_40: unsigned((16 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_unsigned(input_port);
  output_port <= unsigned_to_std_logic_vector(input_port_1_40);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity axibusdomain_axi_lite_interface is 
    port(
        r9_down_sample_rate : out std_logic_vector(31 downto 0);
        r7_clear : out std_logic_vector(31 downto 0);
        r6_delay : out std_logic_vector(31 downto 0);
        r5_enable : out std_logic_vector(31 downto 0);
        r4_threshold : out std_logic_vector(31 downto 0);
        r3_dina : out std_logic_vector(31 downto 0);
        r2_wea : out std_logic_vector(31 downto 0);
        r1_addra : out std_logic_vector(31 downto 0);
        r11_trigger_mode : out std_logic_vector(31 downto 0);
        r10_sample_mode : out std_logic_vector(31 downto 0);
        r12_douta : in std_logic_vector(31 downto 0);
        r8_full : in std_logic_vector(0 downto 0);
        axibusdomain_clk : out std_logic;
        axibusdomain_aclk : in std_logic;
        axibusdomain_aresetn : in std_logic;
        axibusdomain_s_axi_awaddr : in std_logic_vector(6-1 downto 0);
        axibusdomain_s_axi_awvalid : in std_logic;
        axibusdomain_s_axi_awready : out std_logic;
        axibusdomain_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axibusdomain_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axibusdomain_s_axi_wvalid : in std_logic;
        axibusdomain_s_axi_wready : out std_logic;
        axibusdomain_s_axi_bresp : out std_logic_vector(1 downto 0);
        axibusdomain_s_axi_bvalid : out std_logic;
        axibusdomain_s_axi_bready : in std_logic;
        axibusdomain_s_axi_araddr : in std_logic_vector(6-1 downto 0);
        axibusdomain_s_axi_arvalid : in std_logic;
        axibusdomain_s_axi_arready : out std_logic;
        axibusdomain_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axibusdomain_s_axi_rresp : out std_logic_vector(1 downto 0);
        axibusdomain_s_axi_rvalid : out std_logic;
        axibusdomain_s_axi_rready : in std_logic
    );
end axibusdomain_axi_lite_interface;
architecture structural of axibusdomain_axi_lite_interface is 
component axibusdomain_axi_lite_interface_verilog is
    port(
        r9_down_sample_rate : out std_logic_vector(31 downto 0);
        r7_clear : out std_logic_vector(31 downto 0);
        r6_delay : out std_logic_vector(31 downto 0);
        r5_enable : out std_logic_vector(31 downto 0);
        r4_threshold : out std_logic_vector(31 downto 0);
        r3_dina : out std_logic_vector(31 downto 0);
        r2_wea : out std_logic_vector(31 downto 0);
        r1_addra : out std_logic_vector(31 downto 0);
        r11_trigger_mode : out std_logic_vector(31 downto 0);
        r10_sample_mode : out std_logic_vector(31 downto 0);
        r12_douta : in std_logic_vector(31 downto 0);
        r8_full : in std_logic_vector(0 downto 0);
        axibusdomain_clk : out std_logic;
        axibusdomain_aclk : in std_logic;
        axibusdomain_aresetn : in std_logic;
        axibusdomain_s_axi_awaddr : in std_logic_vector(6-1 downto 0);
        axibusdomain_s_axi_awvalid : in std_logic;
        axibusdomain_s_axi_awready : out std_logic;
        axibusdomain_s_axi_wdata : in std_logic_vector(32-1 downto 0);
        axibusdomain_s_axi_wstrb : in std_logic_vector(32/8-1 downto 0);
        axibusdomain_s_axi_wvalid : in std_logic;
        axibusdomain_s_axi_wready : out std_logic;
        axibusdomain_s_axi_bresp : out std_logic_vector(1 downto 0);
        axibusdomain_s_axi_bvalid : out std_logic;
        axibusdomain_s_axi_bready : in std_logic;
        axibusdomain_s_axi_araddr : in std_logic_vector(6-1 downto 0);
        axibusdomain_s_axi_arvalid : in std_logic;
        axibusdomain_s_axi_arready : out std_logic;
        axibusdomain_s_axi_rdata : out std_logic_vector(32-1 downto 0);
        axibusdomain_s_axi_rresp : out std_logic_vector(1 downto 0);
        axibusdomain_s_axi_rvalid : out std_logic;
        axibusdomain_s_axi_rready : in std_logic
    );
end component;
begin
inst : axibusdomain_axi_lite_interface_verilog
    port map(
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
    r12_douta => r12_douta,
    r8_full => r8_full,
    axibusdomain_clk => axibusdomain_clk,
    axibusdomain_aclk => axibusdomain_aclk,
    axibusdomain_aresetn => axibusdomain_aresetn,
    axibusdomain_s_axi_awaddr => axibusdomain_s_axi_awaddr,
    axibusdomain_s_axi_awvalid => axibusdomain_s_axi_awvalid,
    axibusdomain_s_axi_awready => axibusdomain_s_axi_awready,
    axibusdomain_s_axi_wdata => axibusdomain_s_axi_wdata,
    axibusdomain_s_axi_wstrb => axibusdomain_s_axi_wstrb,
    axibusdomain_s_axi_wvalid => axibusdomain_s_axi_wvalid,
    axibusdomain_s_axi_wready => axibusdomain_s_axi_wready,
    axibusdomain_s_axi_bresp => axibusdomain_s_axi_bresp,
    axibusdomain_s_axi_bvalid => axibusdomain_s_axi_bvalid,
    axibusdomain_s_axi_bready => axibusdomain_s_axi_bready,
    axibusdomain_s_axi_araddr => axibusdomain_s_axi_araddr,
    axibusdomain_s_axi_arvalid => axibusdomain_s_axi_arvalid,
    axibusdomain_s_axi_arready => axibusdomain_s_axi_arready,
    axibusdomain_s_axi_rdata => axibusdomain_s_axi_rdata,
    axibusdomain_s_axi_rresp => axibusdomain_s_axi_rresp,
    axibusdomain_s_axi_rvalid => axibusdomain_s_axi_rvalid,
    axibusdomain_s_axi_rready => axibusdomain_s_axi_rready
);
end structural;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
 --
 --  Filename      : xlcounter_rst.vhd
 --
 --  Created       : 1/31/01
 --  Modified      :
 --
 --  Description   : VHDL wrapper for a counter. This wrapper
 --                  uses the Binary Counter CoreGenerator core.
 --
 ---------------------------------------------------------------------
 
 
 ---------------------------------------------------------------------
 --
 --  Entity        : xlcounter
 --
 --  Architecture  : behavior
 --
 --  Description   : Top level VHDL description of a counter.
 --
 ---------------------------------------------------------------------
 
 library IEEE;
 use IEEE.std_logic_1164.all;

entity ip_scope_xlcounter_free is 
   generic (
     core_name0: string := "";
     op_width: integer := 5;
     op_arith: integer := xlSigned
   );
   port (
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     op: out std_logic_vector(op_width - 1 downto 0);
     up: in std_logic_vector(0 downto 0) := (others => '0');
     load: in std_logic_vector(0 downto 0) := (others => '0');
     din: in std_logic_vector(op_width - 1 downto 0) := (others => '0');
     en: in std_logic_vector(0 downto 0);
     rst: in std_logic_vector(0 downto 0)
   );
 end ip_scope_xlcounter_free;
 
 architecture behavior of ip_scope_xlcounter_free is


 component ip_scope_c_counter_binary_v12_0_i0
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0) 
 		  ); 
 end component;

-- synthesis translate_off
   constant zeroVec: std_logic_vector(op_width - 1 downto 0) := (others => '0');
   constant oneVec: std_logic_vector(op_width - 1 downto 0) := (others => '1');
   constant zeroStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(zeroVec);
   constant oneStr: string(1 to op_width) :=
     std_logic_vector_to_bin_string(oneVec);
 -- synthesis translate_on
 
   signal core_sinit: std_logic;
   signal core_ce: std_logic;
   signal op_net: std_logic_vector(op_width - 1 downto 0);
 begin
   core_ce <= ce and en(0);
   core_sinit <= (clr or rst(0)) and ce;
   op <= op_net;


 comp0: if ((core_name0 = "ip_scope_c_counter_binary_v12_0_i0")) generate 
  core_instance0:ip_scope_c_counter_binary_v12_0_i0
   port map ( 
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        load => load(0),
        l => din,
        q => op_net
  ); 
   end generate;

end behavior;

