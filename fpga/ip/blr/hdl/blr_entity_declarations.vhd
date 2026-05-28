-------------------------------------------------------------------
-- System Generator version 2022.2 VHDL source file.
--
-- Copyright(C) 2022 by Xilinx, Inc.  All rights reserved.  This
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
-- text at all times.  (c) Copyright 1995-2022 Xilinx, Inc.  All rights
-- reserved.
-------------------------------------------------------------------

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


entity blr_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end blr_xlregister;

architecture behavior of blr_xlregister is

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


entity convert_func_call_blr_xlconvert is
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
end convert_func_call_blr_xlconvert ;

architecture behavior of convert_func_call_blr_xlconvert is
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


entity blr_xlconvert  is
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

end blr_xlconvert ;

architecture behavior of blr_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_blr_xlconvert 
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
      convert : convert_func_call_blr_xlconvert 
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

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


entity blr_xldelay is
   generic(width        : integer := -1;
           latency      : integer := -1;
           reg_retiming : integer :=  0;
           reset        : integer :=  0);
   port(d       : in std_logic_vector (width-1 downto 0);
        ce      : in std_logic;
        clk     : in std_logic;
        en      : in std_logic;
        rst     : in std_logic;
        q       : out std_logic_vector (width-1 downto 0));

end blr_xldelay;

architecture behavior of blr_xldelay is
   component synth_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component; -- end component synth_reg

   component synth_reg_reg
      generic (width       : integer;
               latency     : integer);
      port (i       : in std_logic_vector(width-1 downto 0);
            ce      : in std_logic;
            clr     : in std_logic;
            clk     : in std_logic;
            o       : out std_logic_vector(width-1 downto 0));
   end component;

   signal internal_ce  : std_logic;

begin
   internal_ce  <= ce and en;

   srl_delay: if ((reg_retiming = 0) and (reset = 0)) or (latency < 1) generate
     synth_reg_srl_inst : synth_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => '0',
         clk => clk,
         o   => q);
   end generate srl_delay;

   reg_delay: if ((reg_retiming = 1) or (reset = 1)) and (latency >= 1) generate
     synth_reg_reg_inst : synth_reg_reg
       generic map (
         width   => width,
         latency => latency)
       port map (
         i   => d,
         ce  => internal_ce,
         clr => rst,
         clk => clk,
         o   => q);
   end generate reg_delay;
end architecture behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_inverter_4c22f7ea81 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_4c22f7ea81;
architecture behavior of sysgen_inverter_4c22f7ea81
is
  signal ip_1_26: boolean;
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of boolean;
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => false);
  signal op_mem_22_20_front_din: boolean;
  signal op_mem_22_20_back: boolean;
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: boolean;
begin
  ip_1_26 <= ((ip) = "1");
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= ((not boolean_to_vector(ip_1_26)) = "1");
  op_mem_22_20_front_din <= internal_ip_12_1_bitnot;
  op_mem_22_20_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_22_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_642f368137 is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_642f368137;
architecture behavior of sysgen_reinterpret_642f368137
is
  signal input_port_1_40: boolean;
  signal output_port_7_5_convert: unsigned((1 - 1) downto 0);
begin
  input_port_1_40 <= ((input_port) = "1");
  output_port_7_5_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(input_port_1_40)), 0, 1, 0);
  output_port <= unsigned_to_std_logic_vector(output_port_7_5_convert);
end behavior;

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


entity blr_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end blr_xlslice;

architecture behavior of blr_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_6445586f68 is
  port (
    input_port : in std_logic_vector((32 - 1) downto 0);
    output_port : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_6445586f68;
architecture behavior of sysgen_reinterpret_6445586f68
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
entity sysgen_reinterpret_65ee335b25 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_65ee335b25;
architecture behavior of sysgen_reinterpret_65ee335b25
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
entity sysgen_reinterpret_5b93d52556 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_5b93d52556;
architecture behavior of sysgen_reinterpret_5b93d52556
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
entity sysgen_constant_53d8a08726 is
  port (
    op : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_53d8a08726;
architecture behavior of sysgen_constant_53d8a08726
is
begin
  op <= "10000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_5dabd742fd is
  port (
    d0 : in std_logic_vector((14 - 1) downto 0);
    d1 : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_5dabd742fd;
architecture behavior of sysgen_logical_5dabd742fd
is
  signal d0_1_24: std_logic_vector((14 - 1) downto 0);
  signal d1_1_27: std_logic_vector((14 - 1) downto 0);
  type array_type_latency_pipe_5_26 is array (0 to (1 - 1)) of std_logic_vector((14 - 1) downto 0);
  signal latency_pipe_5_26: array_type_latency_pipe_5_26 := (
    0 => "00000000000000");
  signal latency_pipe_5_26_front_din: std_logic_vector((14 - 1) downto 0);
  signal latency_pipe_5_26_back: std_logic_vector((14 - 1) downto 0);
  signal latency_pipe_5_26_push_front_pop_back_en: std_logic;
  signal fully_2_1_bit: std_logic_vector((14 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  latency_pipe_5_26_back <= latency_pipe_5_26(0);
  proc_latency_pipe_5_26: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (latency_pipe_5_26_push_front_pop_back_en = '1')) then
        latency_pipe_5_26(0) <= latency_pipe_5_26_front_din;
      end if;
    end if;
  end process proc_latency_pipe_5_26;
  fully_2_1_bit <= d0_1_24 xor d1_1_27;
  latency_pipe_5_26_front_din <= fully_2_1_bit;
  latency_pipe_5_26_push_front_pop_back_en <= '1';
  y <= latency_pipe_5_26_back;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_negate_7410b929e5 is
  port (
    ip : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((17 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_negate_7410b929e5;
architecture behavior of sysgen_negate_7410b929e5
is
  signal ip_18_25: signed((16 - 1) downto 0);
  type array_type_op_mem_48_20 is array (0 to (1 - 1)) of signed((17 - 1) downto 0);
  signal op_mem_48_20: array_type_op_mem_48_20 := (
    0 => "00000000000000000");
  signal op_mem_48_20_front_din: signed((17 - 1) downto 0);
  signal op_mem_48_20_back: signed((17 - 1) downto 0);
  signal op_mem_48_20_push_front_pop_back_en: std_logic;
  signal cast_35_24: signed((17 - 1) downto 0);
  signal internal_ip_35_9_neg: signed((17 - 1) downto 0);
  signal internal_ip_join_30_1: signed((17 - 1) downto 0);
begin
  ip_18_25 <= std_logic_vector_to_signed(ip);
  op_mem_48_20_back <= op_mem_48_20(0);
  proc_op_mem_48_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_48_20_push_front_pop_back_en = '1')) then
        op_mem_48_20(0) <= op_mem_48_20_front_din;
      end if;
    end if;
  end process proc_op_mem_48_20;
  cast_35_24 <= s2s_cast(ip_18_25, 14, 17, 14);
  internal_ip_35_9_neg <=  -cast_35_24;
  proc_if_30_1: process (internal_ip_35_9_neg)
  is
  begin
    if false then
      internal_ip_join_30_1 <= std_logic_vector_to_signed("00000000000000000");
    else 
      internal_ip_join_30_1 <= internal_ip_35_9_neg;
    end if;
  end process proc_if_30_1;
  op_mem_48_20_front_din <= internal_ip_join_30_1;
  op_mem_48_20_push_front_pop_back_en <= '1';
  op <= signed_to_std_logic_vector(op_mem_48_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_e4473d5569 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_e4473d5569;
architecture behavior of sysgen_logical_e4473d5569
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  type array_type_latency_pipe_5_26 is array (0 to (1 - 1)) of std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26: array_type_latency_pipe_5_26 := (
    0 => "0");
  signal latency_pipe_5_26_front_din: std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26_back: std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26_push_front_pop_back_en: std_logic;
  signal fully_2_1_bit: std_logic;
  signal unregy_3_1_convert: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  latency_pipe_5_26_back <= latency_pipe_5_26(0);
  proc_latency_pipe_5_26: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (latency_pipe_5_26_push_front_pop_back_en = '1')) then
        latency_pipe_5_26(0) <= latency_pipe_5_26_front_din;
      end if;
    end if;
  end process proc_latency_pipe_5_26;
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  unregy_3_1_convert <= cast(std_logic_to_vector(fully_2_1_bit), 0, 1, 0, xlUnsigned);
  latency_pipe_5_26_front_din <= unregy_3_1_convert;
  latency_pipe_5_26_push_front_pop_back_en <= '1';
  y <= latency_pipe_5_26_back;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_e13b6bbcdb is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_e13b6bbcdb;
architecture behavior of sysgen_constant_e13b6bbcdb
is
begin
  op <= "0000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_inverter_1eaf01c06f is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_1eaf01c06f;
architecture behavior of sysgen_inverter_1eaf01c06f
is
  signal ip_1_26: boolean;
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of boolean;
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => false);
  signal op_mem_22_20_front_din: boolean;
  signal op_mem_22_20_back: boolean;
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: boolean;
begin
  ip_1_26 <= ((ip) = "1");
  op_mem_22_20_back <= op_mem_22_20(0);
  proc_op_mem_22_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_22_20_push_front_pop_back_en = '1')) then
        op_mem_22_20(0) <= op_mem_22_20_front_din;
      end if;
    end if;
  end process proc_op_mem_22_20;
  internal_ip_12_1_bitnot <= ((not boolean_to_vector(ip_1_26)) = "1");
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= boolean_to_vector(internal_ip_12_1_bitnot);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_384951ac67 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_384951ac67;
architecture behavior of sysgen_logical_384951ac67
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  type array_type_latency_pipe_5_26 is array (0 to (1 - 1)) of std_logic;
  signal latency_pipe_5_26: array_type_latency_pipe_5_26 := (
    0 => '0');
  signal latency_pipe_5_26_front_din: std_logic;
  signal latency_pipe_5_26_back: std_logic;
  signal latency_pipe_5_26_push_front_pop_back_en: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  latency_pipe_5_26_back <= latency_pipe_5_26(0);
  proc_latency_pipe_5_26: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (latency_pipe_5_26_push_front_pop_back_en = '1')) then
        latency_pipe_5_26(0) <= latency_pipe_5_26_front_din;
      end if;
    end if;
  end process proc_latency_pipe_5_26;
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  latency_pipe_5_26_front_din <= fully_2_1_bit;
  latency_pipe_5_26_push_front_pop_back_en <= '1';
  y <= std_logic_to_vector(latency_pipe_5_26_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_89f07ef260 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_89f07ef260;
architecture behavior of sysgen_logical_89f07ef260
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_051878d70a is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_051878d70a;
architecture behavior of sysgen_relational_051878d70a
is
  signal a_1_31: signed((16 - 1) downto 0);
  signal b_1_34: signed((16 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_16_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
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
  result_16_3_rel <= a_1_31 < b_1_34;
  op_mem_37_22_front_din <= result_16_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_3fb7ac86c5 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_3fb7ac86c5;
architecture behavior of sysgen_relational_3fb7ac86c5
is
  signal a_1_31: signed((16 - 1) downto 0);
  signal b_1_34: signed((16 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_18_3_rel: boolean;
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
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
  result_18_3_rel <= a_1_31 > b_1_34;
  op_mem_37_22_front_din <= result_18_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

---------------------------------------------------------------------
--
--  Filename      : xldsamp.vhd
--
--  Description   : VHDL description of a block that is inserted into the
--                  data path to down sample the data betwen two blocks
--                  where the period is different between two blocks.
--
--  Mod. History  : Changed clock timing on the down sampler.  The
--                  destination enable is delayed by one system clock
--                  cycle and held until the next consecutive source
--                  enable pulse.  This change allows downsampler data
--                  transitions to occur on the rising clock edge when
--                  the destination ce is asserted.
--                : Added optional latency is the downsampler.  Note, if
--                  the latency is greater than 0, no shutter is used.
--                : Removed valid bit logic from wrapper
--
--
---------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on

entity blr_xldsamp is
  generic (
    d_width: integer := 12;
    d_bin_pt: integer := 0;
    d_arith: integer := xlUnsigned;
    q_width: integer := 12;
    q_bin_pt: integer := 0;
    q_arith: integer := xlUnsigned;
    en_width: integer := 1;
    en_bin_pt: integer := 0;
    en_arith: integer := xlUnsigned;
    rst_width: integer := 1;
    rst_bin_pt: integer := 0;
    rst_arith: integer := xlUnsigned;
    ds_ratio: integer := 2;
    phase: integer := 0;
    latency: integer := 1
  );
  port (
    d: in std_logic_vector(d_width - 1 downto 0);
    src_clk: in std_logic;
    src_ce: in std_logic;
    src_clr: in std_logic;
    dest_clk: in std_logic;
    dest_ce: in std_logic;
    dest_clr: in std_logic;
    en: in std_logic_vector(en_width - 1 downto 0);
    rst: in std_logic_vector(rst_width - 1 downto 0);
    q: out std_logic_vector(q_width - 1 downto 0)
  );
end blr_xldsamp;

architecture struct of blr_xldsamp is
  component synth_reg
    generic (
      width: integer := 16;
      latency: integer := 5
    );
    port (
      i: in std_logic_vector(width - 1 downto 0);
      ce: in std_logic;
      clr: in std_logic;
      clk: in std_logic;
      o: out std_logic_vector(width - 1 downto 0)
    );
  end component; -- end synth_reg

  component synth_reg_reg
     generic (width       : integer;
              latency     : integer);
     port (i       : in std_logic_vector(width-1 downto 0);
           ce      : in std_logic;
           clr     : in std_logic;
           clk     : in std_logic;
           o       : out std_logic_vector(width-1 downto 0));
  end component;

  component fdse
    port (
      q: out   std_ulogic;
      d: in    std_ulogic;
      c: in    std_ulogic;
      s: in    std_ulogic;
      ce: in    std_ulogic
    );
  end component; -- end fdse
  attribute syn_black_box of fdse: component is true;
  attribute fpga_dont_touch of fdse: component is "true";

  signal adjusted_dest_ce: std_logic;
  signal adjusted_dest_ce_w_en: std_logic;
  signal dest_ce_w_en: std_logic;
  signal smpld_d: std_logic_vector(d_width-1 downto 0);
  signal sclr:std_logic;
begin
  -- An 'adjusted' destination clock enable signal must be generated for
  -- the zero latency and double registered down-sampler implementations.
  -- For both cases, it is necassary to adjust the timing of the clock
  -- enable so that it is asserted at the start of the sample period,
  -- instead of the end.  This is realized using an fdse prim. to register
  -- the destination clock enable.  The fdse itself is enabled with the
  -- source clock enable.  Enabling the fdse holds the adjusted CE high
  -- for the duration of the fast sample period and is needed to satisfy
  -- the multicycle constraint if the input data is running at a non-system
  -- rate.
  adjusted_ce_needed: if ((latency = 0) or (phase /= (ds_ratio - 1))) generate
    dest_ce_reg: fdse
      port map (
        q => adjusted_dest_ce,
        d => dest_ce,
        c => src_clk,
        s => sclr,
        ce => src_ce
      );
  end generate; -- adjusted_ce_needed

  -- A shutter (mux/reg pair) is used to implement a 0 latency downsampler.
  -- The shutter uses the adjusted destination clock enable to select between
  -- the current input and the sampled input.
  latency_eq_0: if (latency = 0) generate
    shutter_d_reg: synth_reg
      generic map (
        width => d_width,
        latency => 1
      )
      port map (
        i => d,
        ce => adjusted_dest_ce,
        clr => sclr,
        clk => src_clk,
        o => smpld_d
      );

    -- Mux selects current input value or register value.
    shutter_mux: process (adjusted_dest_ce, d, smpld_d)
    begin
	  if adjusted_dest_ce = '0' then
        q <= smpld_d;
      else
        q <= d;
      end if;
    end process; -- end select_mux
  end generate; -- end latency_eq_0

  -- A more efficient downsampler can be implemented if a latency > 0 is
  -- allowed.  There are two possible implementations, depending on the
  -- requested sampling phase.  A double register downsampler is needed
  -- for all cases except when the sample phase is the last input frame
  -- of the sample period.  In this case, only one register is needed.

  latency_gt_0: if (latency > 0) generate
    -- The first register in the double reg implementation is used to
    -- sample the correct frame (phase) of the input data.  Both the
    -- data and valid bit must be sampled.
    dbl_reg_test: if (phase /= (ds_ratio-1)) generate
        smpl_d_reg: synth_reg_reg
          generic map (
            width => d_width,
            latency => 1
          )
          port map (
            i => d,
            ce => adjusted_dest_ce_w_en,
            clr => sclr,
            clk => src_clk,
            o => smpld_d
          );
    end generate; -- end dbl_reg_test

    sngl_reg_test: if (phase = (ds_ratio -1)) generate
      smpld_d <= d;
    end generate; -- sngl_reg_test

    -- The latency pipe captures the sampled data and the END of the sample
    -- period.  Note that if the requested sample phase is the last input
    -- frame in the period, the first register (smpl_reg) is not needed.
    latency_pipe: synth_reg_reg
      generic map (
        width => d_width,
        latency => latency
      )
      port map (
        i => smpld_d,
        ce => dest_ce_w_en,
        clr => sclr,
        clk => dest_clk,
        o => q
      );
  end generate; -- end latency_gt_0

  -- Signal assignments
  dest_ce_w_en <= dest_ce and en(0);
  adjusted_dest_ce_w_en <= adjusted_dest_ce and en(0);
  sclr <= (src_clr or rst(0)) and dest_ce;
end architecture struct;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

----------------------------------------------------------------------------
--
--  Filename      : xlusamp.vhd
--
--  Description   : VHDL description of an up sampler.  The input signal
--                  has a larger period than the output signal's period
--                  and the blocks's period is set on the Simulink mask
--                  GUI.
--
--  Assumptions   : Input size, bin_pt, etc. are the same as the output
--
--  Mod. History  : Removed the shutter from the upsampler.  A mux is used
--                  to zero pad the data samples.  The mux select line is
--                  generated by registering the source enable signal
--                  when the destination ce is asserted.
--                : Removed valid bits from wrapper.
--
----------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;


-- synthesis translate_off
library unisim;
use unisim.vcomponents.all;
-- synthesis translate_on

entity blr_xlusamp is

    generic (
             d_width      : integer := 5;          -- Width of d input
             d_bin_pt     : integer := 2;          -- Binary point of input d
             d_arith      : integer := xlUnsigned; -- Type of arith of d input
             q_width      : integer := 5;          -- Width of q output
             q_bin_pt     : integer := 2;          -- Binary point of output q
             q_arith      : integer := xlUnsigned; -- Type of arith of output
             en_width     : integer := 1;
             en_bin_pt    : integer := 0;
             en_arith     : integer := xlUnsigned;
             sampling_ratio     : integer := 2;
             latency      : integer := 1;
             copy_samples : integer := 0);         -- if 0, output q = 0
                                                   -- when ce = 0, else sample
                                                   -- is held until next clk

    port (
          d        : in std_logic_vector (d_width-1 downto 0);
          src_clk  : in std_logic;
          src_ce   : in std_logic;
          src_clr  : in std_logic;
          dest_clk : in std_logic;
          dest_ce  : in std_logic;
          dest_clr : in std_logic;
          en       : in std_logic_vector(en_width-1 downto 0);
          q        : out std_logic_vector (q_width-1 downto 0)
         );
end blr_xlusamp;

architecture struct of blr_xlusamp is
    component synth_reg
      generic (
        width: integer := 16;
        latency: integer := 5
      );
      port (
        i: in std_logic_vector(width - 1 downto 0);
        ce: in std_logic;
        clr: in std_logic;
        clk: in std_logic;
        o: out std_logic_vector(width - 1 downto 0)
      );
    end component; -- end synth_reg

    component FDSE
        port (q  : out   std_ulogic;
              d  : in    std_ulogic;
              c  : in    std_ulogic;
              s  : in    std_ulogic;
              ce : in    std_ulogic);
    end component; -- end FDSE

    attribute syn_black_box of FDSE : component is true;
    attribute fpga_dont_touch of FDSE : component is "true";

    signal zero    : std_logic_vector (d_width-1 downto 0);
    signal mux_sel : std_logic;
    signal sampled_d  : std_logic_vector (d_width-1 downto 0);
    signal internal_ce : std_logic;

begin


   -- If zero padding is required, a mux is used to switch between data input
   -- and zeros.  The mux select is generated by registering the source enable
   -- signal.  This register is enabled by the destination enable signal. This
   -- has the effect of holding the select line high until the next consecutive
   -- destination enable pulse, and thereby satisfying the timing constraints.
   -- Signal assignments

   -- register the source enable signal with the register enabled
   -- by the destination enable
   sel_gen : FDSE
       port map (q  => mux_sel,
           d  => src_ce,
            c  => src_clk,
            s  => src_clr,
            ce => dest_ce);
  -- Generate the user enable
  internal_ce <= src_ce and en(0);

  copy_samples_false : if (copy_samples = 0) generate

      -- signal assignments
      zero <= (others => '0');

      -- purpose: latency is 0 and copy_samples is 0
      -- type   : combinational
      -- inputs : mux_sel, d, zero
      -- outputs: q
      gen_q_cp_smpls_0_and_lat_0: if (latency = 0) generate
        cp_smpls_0_and_lat_0: process (mux_sel, d, zero)
        begin  -- process cp_smpls_0_and_lat_0
          if (mux_sel = '1') then
            q <= d;
          else
            q <= zero;
          end if;
        end process cp_smpls_0_and_lat_0;
      end generate; -- end gen_q_cp_smpls_0_and_lat_0

      gen_q_cp_smpls_0_and_lat_gt_0: if (latency > 0) generate
        sampled_d_reg: synth_reg
          generic map (
            width => d_width,
            latency => latency
          )

          port map (
            i => d,
            ce => internal_ce,
            clr => src_clr,
            clk => src_clk,
            o => sampled_d
          );

        gen_q_check_mux_sel: process (mux_sel, sampled_d, zero)
        begin
          if (mux_sel = '1') then
            q <= sampled_d;
          else
            q <= zero;
          end if;
        end process gen_q_check_mux_sel;
      end generate; -- end gen_q_cp_smpls_0_and_lat_gt_0
   end generate; -- end copy_samples_false

   -- If zero padding is not required, we can short the upsampler data inputs
   -- to the upsampler data outputs when latency is 0.
   -- This option uses no hardware resources.

   copy_samples_true : if (copy_samples = 1) generate

     gen_q_cp_smpls_1_and_lat_0: if (latency = 0) generate
       q <= d;
     end generate; -- end gen_q_cp_smpls_1_and_lat_0

     gen_q_cp_smpls_1_and_lat_gt_0: if (latency > 0) generate
       q <= sampled_d;
       sampled_d_reg2: synth_reg
         generic map (
           width => d_width,
           latency => latency
         )

         port map (
           i => d,
           ce => internal_ce,
           clr => src_clr,
           clk => src_clk,
           o => sampled_d
         );
     end generate; -- end gen_q_cp_smpls_1_and_lat_gt_0
   end generate; -- end copy_samples_true
end architecture struct;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_d9c11edc2f is
  port (
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_d9c11edc2f;
architecture behavior of sysgen_constant_d9c11edc2f
is
begin
  op <= "1";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_delay_957015e4a0 is
  port (
    d : in std_logic_vector((36 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((36 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_delay_957015e4a0;
architecture behavior of sysgen_delay_957015e4a0
is
  signal d_1_22: std_logic_vector((36 - 1) downto 0);
  signal rst_1_29: std_logic;
  signal op_mem_0_8_24_next: std_logic_vector((36 - 1) downto 0);
  signal op_mem_0_8_24: std_logic_vector((36 - 1) downto 0) := "000000000000000000000000000000000000";
  signal op_mem_0_8_24_rst: std_logic;
  signal op_mem_0_join_10_5: std_logic_vector((36 - 1) downto 0);
  signal op_mem_0_join_10_5_rst: std_logic;
begin
  d_1_22 <= d;
  rst_1_29 <= rst(0);
  proc_op_mem_0_8_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_0_8_24_rst = '1')) then
        op_mem_0_8_24 <= "000000000000000000000000000000000000";
      elsif (ce = '1') then 
        op_mem_0_8_24 <= op_mem_0_8_24_next;
      end if;
    end if;
  end process proc_op_mem_0_8_24;
  proc_if_10_5: process (d_1_22, rst_1_29)
  is
  begin
    if rst_1_29 = '1' then
      op_mem_0_join_10_5_rst <= '1';
    else 
      op_mem_0_join_10_5_rst <= '0';
    end if;
    op_mem_0_join_10_5 <= d_1_22;
  end process proc_if_10_5;
  op_mem_0_8_24_next <= d_1_22;
  op_mem_0_8_24_rst <= op_mem_0_join_10_5_rst;
  q <= op_mem_0_8_24;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_6d93ce2cc8 is
  port (
    xi : in std_logic_vector((24 - 1) downto 0);
    yi : in std_logic_vector((24 - 1) downto 0);
    inhibit_n : in std_logic_vector((1 - 1) downto 0);
    sel : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_6d93ce2cc8;
architecture behavior of sysgen_mcode_block_6d93ce2cc8
is
  signal xi_3_69: signed((24 - 1) downto 0);
  signal yi_3_73: signed((24 - 1) downto 0);
  signal inhibit_n_3_77: boolean;
  signal sel_i_5_23_next: unsigned((1 - 1) downto 0);
  signal sel_i_5_23: unsigned((1 - 1) downto 0) := "0";
  signal sel_i_5_23_rst: std_logic;
  signal rel_12_10: boolean;
  signal rel_12_22: boolean;
  signal bool_12_10: boolean;
  signal sel_i_join_12_5: unsigned((1 - 1) downto 0);
  signal sel_i_join_12_5_rst: std_logic;
begin
  xi_3_69 <= std_logic_vector_to_signed(xi);
  yi_3_73 <= std_logic_vector_to_signed(yi);
  inhibit_n_3_77 <= ((inhibit_n) = "1");
  proc_sel_i_5_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (sel_i_5_23_rst = '1')) then
        sel_i_5_23 <= "0";
      elsif (ce = '1') then 
        sel_i_5_23 <= sel_i_5_23_next;
      end if;
    end if;
  end process proc_sel_i_5_23;
  rel_12_10 <= xi_3_69 >= yi_3_73;
  rel_12_22 <= inhibit_n_3_77 = true;
  bool_12_10 <= rel_12_10 and rel_12_22;
  proc_if_12_5: process (bool_12_10)
  is
  begin
    if bool_12_10 then
      sel_i_join_12_5_rst <= '1';
    else 
      sel_i_join_12_5_rst <= '0';
    end if;
    sel_i_join_12_5 <= std_logic_vector_to_unsigned("1");
  end process proc_if_12_5;
  sel_i_5_23_next <= std_logic_vector_to_unsigned("1");
  sel_i_5_23_rst <= sel_i_join_12_5_rst;
  sel <= unsigned_to_std_logic_vector(sel_i_5_23);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_9ca88800ec is
  port (
    x : in std_logic_vector((24 - 1) downto 0);
    inh_n : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((24 - 1) downto 0);
    sel : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_9ca88800ec;
architecture behavior of sysgen_mcode_block_9ca88800ec
is
  signal x_1_48: signed((24 - 1) downto 0);
  signal inh_n_1_51: boolean;
  signal sel_i_2_19_next: unsigned((1 - 1) downto 0);
  signal sel_i_2_19: unsigned((1 - 1) downto 0) := "0";
  signal y_i_3_17_next: signed((24 - 1) downto 0);
  signal y_i_3_17: signed((24 - 1) downto 0) := "000000000000000000000000";
  signal y_i_3_17_rst: std_logic;
  signal rel_6_5: boolean;
  signal rel_6_15: boolean;
  signal bool_6_5: boolean;
  signal y_i_join_6_1: signed((24 - 1) downto 0);
  signal y_i_join_6_1_rst: std_logic;
  signal sel_i_join_6_1: unsigned((1 - 1) downto 0);
begin
  x_1_48 <= std_logic_vector_to_signed(x);
  inh_n_1_51 <= ((inh_n) = "1");
  proc_sel_i_2_19: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        sel_i_2_19 <= sel_i_2_19_next;
      end if;
    end if;
  end process proc_sel_i_2_19;
  proc_y_i_3_17: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (y_i_3_17_rst = '1')) then
        y_i_3_17 <= "000000000000000000000000";
      elsif (ce = '1') then 
        y_i_3_17 <= y_i_3_17_next;
      end if;
    end if;
  end process proc_y_i_3_17;
  rel_6_5 <= x_1_48 <= std_logic_vector_to_signed("000000000000000000000000");
  rel_6_15 <= inh_n_1_51 = false;
  bool_6_5 <= rel_6_5 or rel_6_15;
  proc_if_6_1: process (bool_6_5, x_1_48)
  is
  begin
    if bool_6_5 then
      y_i_join_6_1_rst <= '1';
    else 
      y_i_join_6_1_rst <= '0';
    end if;
    y_i_join_6_1 <= x_1_48;
    if bool_6_5 then
      sel_i_join_6_1 <= std_logic_vector_to_unsigned("1");
    else 
      sel_i_join_6_1 <= std_logic_vector_to_unsigned("0");
    end if;
  end process proc_if_6_1;
  sel_i_2_19_next <= sel_i_join_6_1;
  y_i_3_17_next <= x_1_48;
  y_i_3_17_rst <= y_i_join_6_1_rst;
  y <= signed_to_std_logic_vector(y_i_3_17);
  sel <= unsigned_to_std_logic_vector(sel_i_2_19);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_06165c2fc1 is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((32 - 1) downto 0);
    d1 : in std_logic_vector((32 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_06165c2fc1;
architecture behavior of sysgen_mux_06165c2fc1
is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((32 - 1) downto 0);
  signal d1_1_27: std_logic_vector((32 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((32 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_655fcc66af is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((36 - 1) downto 0);
    d1 : in std_logic_vector((36 - 1) downto 0);
    y : out std_logic_vector((36 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_655fcc66af;
architecture behavior of sysgen_mux_655fcc66af
is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((36 - 1) downto 0);
  signal d1_1_27: std_logic_vector((36 - 1) downto 0);
  signal unregy_join_6_1: std_logic_vector((36 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  y <= unregy_join_6_1;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_negate_e49e955988 is
  port (
    ip : in std_logic_vector((24 - 1) downto 0);
    op : out std_logic_vector((24 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_negate_e49e955988;
architecture behavior of sysgen_negate_e49e955988
is
  signal ip_18_25: signed((24 - 1) downto 0);
  type array_type_op_mem_48_20 is array (0 to (1 - 1)) of signed((24 - 1) downto 0);
  signal op_mem_48_20: array_type_op_mem_48_20 := (
    0 => "000000000000000000000000");
  signal op_mem_48_20_front_din: signed((24 - 1) downto 0);
  signal op_mem_48_20_back: signed((24 - 1) downto 0);
  signal op_mem_48_20_push_front_pop_back_en: std_logic;
  signal cast_35_24: signed((25 - 1) downto 0);
  signal internal_ip_35_9_neg: signed((25 - 1) downto 0);
  signal internal_ip_join_30_1: signed((25 - 1) downto 0);
  signal internal_ip_40_3_convert: signed((24 - 1) downto 0);
begin
  ip_18_25 <= std_logic_vector_to_signed(ip);
  op_mem_48_20_back <= op_mem_48_20(0);
  proc_op_mem_48_20: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (op_mem_48_20_push_front_pop_back_en = '1')) then
        op_mem_48_20(0) <= op_mem_48_20_front_din;
      end if;
    end if;
  end process proc_op_mem_48_20;
  cast_35_24 <= s2s_cast(ip_18_25, 14, 25, 14);
  internal_ip_35_9_neg <=  -cast_35_24;
  proc_if_30_1: process (internal_ip_35_9_neg)
  is
  begin
    if false then
      internal_ip_join_30_1 <= std_logic_vector_to_signed("0000000000000000000000000");
    else 
      internal_ip_join_30_1 <= internal_ip_35_9_neg;
    end if;
  end process proc_if_30_1;
  internal_ip_40_3_convert <= std_logic_vector_to_signed(convert_type(signed_to_std_logic_vector(internal_ip_join_30_1), 25, 14, xlSigned, 24, 14, xlSigned, xlTruncate, xlSaturate));
  op_mem_48_20_front_din <= internal_ip_40_3_convert;
  op_mem_48_20_push_front_pop_back_en <= '1';
  op <= signed_to_std_logic_vector(op_mem_48_20_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_8da86244b9 is
  port (
    op : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_8da86244b9;
architecture behavior of sysgen_constant_8da86244b9
is
begin
  op <= "00000000000000000000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_90fc4f836b is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_90fc4f836b;
architecture behavior of sysgen_logical_90fc4f836b
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_ddf9ff1230 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_ddf9ff1230;
architecture behavior of sysgen_logical_ddf9ff1230
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal d2_1_30: std_logic;
  signal fully_2_1_bit: std_logic;
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  d2_1_30 <= d2(0);
  fully_2_1_bit <= d0_1_24 and d1_1_27 and d2_1_30;
  y <= std_logic_to_vector(fully_2_1_bit);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_76f4d8a2e6 is
  port (
    x : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    e : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_76f4d8a2e6;
architecture behavior of sysgen_mcode_block_76f4d8a2e6
is
  signal x_1_39: unsigned((1 - 1) downto 0);
  signal ff_2_17_next: unsigned((1 - 1) downto 0);
  signal ff_2_17: unsigned((1 - 1) downto 0) := "0";
  signal rel_5_5: boolean;
  signal rel_5_15: boolean;
  signal bool_5_5: boolean;
  signal e_join_5_2: boolean;
begin
  x_1_39 <= std_logic_vector_to_unsigned(x);
  proc_ff_2_17: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        ff_2_17 <= ff_2_17_next;
      end if;
    end if;
  end process proc_ff_2_17;
  rel_5_5 <= ff_2_17 = std_logic_vector_to_unsigned("1");
  rel_5_15 <= x_1_39 = std_logic_vector_to_unsigned("0");
  bool_5_5 <= rel_5_5 and rel_5_15;
  proc_if_5_2: process (bool_5_5)
  is
  begin
    if bool_5_5 then
      e_join_5_2 <= true;
    else 
      e_join_5_2 <= false;
    end if;
  end process proc_if_5_2;
  ff_2_17_next <= x_1_39;
  y <= unsigned_to_std_logic_vector(ff_2_17);
  e <= boolean_to_vector(e_join_5_2);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_378474a09a is
  port (
    a : in std_logic_vector((10 - 1) downto 0);
    b : in std_logic_vector((10 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_378474a09a;
architecture behavior of sysgen_relational_378474a09a
is
  signal a_1_31: unsigned((10 - 1) downto 0);
  signal b_1_34: unsigned((10 - 1) downto 0);
  type array_type_op_mem_37_22 is array (0 to (1 - 1)) of boolean;
  signal op_mem_37_22: array_type_op_mem_37_22 := (
    0 => false);
  signal op_mem_37_22_front_din: boolean;
  signal op_mem_37_22_back: boolean;
  signal op_mem_37_22_push_front_pop_back_en: std_logic;
  signal result_18_3_rel: boolean;
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
  result_18_3_rel <= a_1_31 > b_1_34;
  op_mem_37_22_front_din <= result_18_3_rel;
  op_mem_37_22_push_front_pop_back_en <= '1';
  op <= boolean_to_vector(op_mem_37_22_back);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_d94ab2c5a6 is
  port (
    x : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    e : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_d94ab2c5a6;
architecture behavior of sysgen_mcode_block_d94ab2c5a6
is
  signal x_1_39: unsigned((1 - 1) downto 0);
  signal ff_2_17_next: unsigned((1 - 1) downto 0);
  signal ff_2_17: unsigned((1 - 1) downto 0) := "0";
  signal rel_5_5: boolean;
  signal rel_5_15: boolean;
  signal bool_5_5: boolean;
  signal e_join_5_2: boolean;
begin
  x_1_39 <= std_logic_vector_to_unsigned(x);
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
  rel_5_15 <= x_1_39 = std_logic_vector_to_unsigned("1");
  bool_5_5 <= rel_5_5 and rel_5_15;
  proc_if_5_2: process (bool_5_5)
  is
  begin
    if bool_5_5 then
      e_join_5_2 <= true;
    else 
      e_join_5_2 <= false;
    end if;
  end process proc_if_5_2;
  ff_2_17_next <= x_1_39;
  y <= unsigned_to_std_logic_vector(ff_2_17);
  e <= boolean_to_vector(e_join_5_2);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_accum_6a280f5788 is
  port (
    b : in std_logic_vector((24 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    en : in std_logic_vector((1 - 1) downto 0);
    q : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_accum_6a280f5788;
architecture behavior of sysgen_accum_6a280f5788
is
  signal b_17_24: signed((24 - 1) downto 0);
  signal rst_17_27: boolean;
  signal en_17_32: boolean;
  signal accum_reg_39_23: signed((32 - 1) downto 0) := "00000000000000000000000000000000";
  signal accum_reg_39_23_rst: std_logic;
  signal accum_reg_39_23_en: std_logic;
  signal cast_49_42: signed((32 - 1) downto 0);
  signal accum_reg_join_45_1: signed((33 - 1) downto 0);
  signal accum_reg_join_45_1_en: std_logic;
  signal accum_reg_join_45_1_rst: std_logic;
begin
  b_17_24 <= std_logic_vector_to_signed(b);
  rst_17_27 <= ((rst) = "1");
  en_17_32 <= ((en) = "1");
  proc_accum_reg_39_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (accum_reg_39_23_rst = '1')) then
        accum_reg_39_23 <= "00000000000000000000000000000000";
      elsif ((ce = '1') and (accum_reg_39_23_en = '1')) then 
        accum_reg_39_23 <= accum_reg_39_23 + cast_49_42;
      end if;
    end if;
  end process proc_accum_reg_39_23;
  cast_49_42 <= s2s_cast(b_17_24, 14, 32, 14);
  proc_if_45_1: process (accum_reg_39_23, cast_49_42, en_17_32, rst_17_27)
  is
  begin
    if rst_17_27 then
      accum_reg_join_45_1_rst <= '1';
    elsif en_17_32 then
      accum_reg_join_45_1_rst <= '0';
    else 
      accum_reg_join_45_1_rst <= '0';
    end if;
    if en_17_32 then
      accum_reg_join_45_1_en <= '1';
    else 
      accum_reg_join_45_1_en <= '0';
    end if;
  end process proc_if_45_1;
  accum_reg_39_23_rst <= accum_reg_join_45_1_rst;
  accum_reg_39_23_en <= accum_reg_join_45_1_en;
  q <= signed_to_std_logic_vector(accum_reg_39_23);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_a6f788c992 is
  port (
    x : in std_logic_vector((32 - 1) downto 0);
    m : in std_logic_vector((2 - 1) downto 0);
    y : out std_logic_vector((32 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_a6f788c992;
architecture behavior of sysgen_mcode_block_a6f788c992
is
  signal x_1_30: signed((32 - 1) downto 0);
  signal m_1_33: unsigned((2 - 1) downto 0);
  signal sign_22_5_slice: unsigned((1 - 1) downto 0);
  signal slice_39_42: unsigned((19 - 1) downto 0);
  signal y12n_39_5_concat: unsigned((32 - 1) downto 0);
  signal slice_40_42: unsigned((22 - 1) downto 0);
  signal y9n_40_5_concat: unsigned((32 - 1) downto 0);
  signal slice_41_42: unsigned((25 - 1) downto 0);
  signal y6n_41_5_concat: unsigned((32 - 1) downto 0);
  signal slice_42_42: unsigned((28 - 1) downto 0);
  signal y3n_42_5_concat: unsigned((32 - 1) downto 0);
  signal slice_45_42: unsigned((19 - 1) downto 0);
  signal y12p_45_5_concat: unsigned((32 - 1) downto 0);
  signal slice_46_42: unsigned((22 - 1) downto 0);
  signal y9p_46_5_concat: unsigned((32 - 1) downto 0);
  signal slice_47_42: unsigned((25 - 1) downto 0);
  signal y6p_47_5_concat: unsigned((32 - 1) downto 0);
  signal slice_48_42: unsigned((28 - 1) downto 0);
  signal y3p_48_5_concat: unsigned((32 - 1) downto 0);
  signal y_53_13_force: signed((32 - 1) downto 0);
  signal y_55_13_force: signed((32 - 1) downto 0);
  signal y_57_13_force: signed((32 - 1) downto 0);
  signal y_59_13_force: signed((32 - 1) downto 0);
  signal y_61_13_force: signed((32 - 1) downto 0);
  signal y_63_13_force: signed((32 - 1) downto 0);
  signal y_66_13_force: signed((32 - 1) downto 0);
  signal y_68_13_force: signed((32 - 1) downto 0);
  signal rel_65_12: boolean;
  signal rel_65_22: boolean;
  signal bool_65_12: boolean;
  signal y_join_65_9: signed((32 - 1) downto 0);
  signal rel_52_8: boolean;
  signal rel_52_18: boolean;
  signal bool_52_8: boolean;
  signal rel_54_12: boolean;
  signal rel_54_22: boolean;
  signal bool_54_12: boolean;
  signal rel_56_12: boolean;
  signal rel_56_22: boolean;
  signal bool_56_12: boolean;
  signal rel_58_12: boolean;
  signal rel_58_22: boolean;
  signal bool_58_12: boolean;
  signal rel_60_12: boolean;
  signal rel_60_22: boolean;
  signal bool_60_12: boolean;
  signal rel_62_12: boolean;
  signal rel_62_22: boolean;
  signal bool_62_12: boolean;
  signal y_join_52_5: signed((32 - 1) downto 0);
begin
  x_1_30 <= std_logic_vector_to_signed(x);
  m_1_33 <= std_logic_vector_to_unsigned(m);
  sign_22_5_slice <= s2u_slice(x_1_30, 31, 31);
  slice_39_42 <= s2u_slice(x_1_30, 30, 12);
  y12n_39_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("111111111111")) & unsigned_to_std_logic_vector(slice_39_42));
  slice_40_42 <= s2u_slice(x_1_30, 30, 9);
  y9n_40_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("111111111")) & unsigned_to_std_logic_vector(slice_40_42));
  slice_41_42 <= s2u_slice(x_1_30, 30, 6);
  y6n_41_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("111111")) & unsigned_to_std_logic_vector(slice_41_42));
  slice_42_42 <= s2u_slice(x_1_30, 30, 3);
  y3n_42_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("111")) & unsigned_to_std_logic_vector(slice_42_42));
  slice_45_42 <= s2u_slice(x_1_30, 30, 12);
  y12p_45_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("000000000000")) & unsigned_to_std_logic_vector(slice_45_42));
  slice_46_42 <= s2u_slice(x_1_30, 30, 9);
  y9p_46_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("000000000")) & unsigned_to_std_logic_vector(slice_46_42));
  slice_47_42 <= s2u_slice(x_1_30, 30, 6);
  y6p_47_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("000000")) & unsigned_to_std_logic_vector(slice_47_42));
  slice_48_42 <= s2u_slice(x_1_30, 30, 3);
  y3p_48_5_concat <= std_logic_vector_to_unsigned(unsigned_to_std_logic_vector(sign_22_5_slice) & unsigned_to_std_logic_vector(std_logic_vector_to_unsigned("000")) & unsigned_to_std_logic_vector(slice_48_42));
  y_53_13_force <= unsigned_to_signed(y3p_48_5_concat);
  y_55_13_force <= unsigned_to_signed(y3n_42_5_concat);
  y_57_13_force <= unsigned_to_signed(y6p_47_5_concat);
  y_59_13_force <= unsigned_to_signed(y6n_41_5_concat);
  y_61_13_force <= unsigned_to_signed(y9p_46_5_concat);
  y_63_13_force <= unsigned_to_signed(y9n_40_5_concat);
  y_66_13_force <= unsigned_to_signed(y12p_45_5_concat);
  y_68_13_force <= unsigned_to_signed(y12n_39_5_concat);
  rel_65_12 <= m_1_33 = std_logic_vector_to_unsigned("11");
  rel_65_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("0");
  bool_65_12 <= rel_65_12 and rel_65_22;
  proc_if_65_9: process (bool_65_12, y_66_13_force, y_68_13_force)
  is
  begin
    if bool_65_12 then
      y_join_65_9 <= y_66_13_force;
    else 
      y_join_65_9 <= y_68_13_force;
    end if;
  end process proc_if_65_9;
  rel_52_8 <= m_1_33 = std_logic_vector_to_unsigned("00");
  rel_52_18 <= sign_22_5_slice = std_logic_vector_to_unsigned("0");
  bool_52_8 <= rel_52_8 and rel_52_18;
  rel_54_12 <= m_1_33 = std_logic_vector_to_unsigned("00");
  rel_54_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("1");
  bool_54_12 <= rel_54_12 and rel_54_22;
  rel_56_12 <= m_1_33 = std_logic_vector_to_unsigned("01");
  rel_56_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("0");
  bool_56_12 <= rel_56_12 and rel_56_22;
  rel_58_12 <= m_1_33 = std_logic_vector_to_unsigned("01");
  rel_58_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("1");
  bool_58_12 <= rel_58_12 and rel_58_22;
  rel_60_12 <= m_1_33 = std_logic_vector_to_unsigned("10");
  rel_60_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("0");
  bool_60_12 <= rel_60_12 and rel_60_22;
  rel_62_12 <= m_1_33 = std_logic_vector_to_unsigned("10");
  rel_62_22 <= sign_22_5_slice = std_logic_vector_to_unsigned("1");
  bool_62_12 <= rel_62_12 and rel_62_22;
  proc_if_52_5: process (bool_52_8, bool_54_12, bool_56_12, bool_58_12, bool_60_12, bool_62_12, y_53_13_force, y_55_13_force, y_57_13_force, y_59_13_force, y_61_13_force, y_63_13_force, y_join_65_9)
  is
  begin
    if bool_52_8 then
      y_join_52_5 <= y_53_13_force;
    elsif bool_54_12 then
      y_join_52_5 <= y_55_13_force;
    elsif bool_56_12 then
      y_join_52_5 <= y_57_13_force;
    elsif bool_58_12 then
      y_join_52_5 <= y_59_13_force;
    elsif bool_60_12 then
      y_join_52_5 <= y_61_13_force;
    elsif bool_62_12 then
      y_join_52_5 <= y_63_13_force;
    else 
      y_join_52_5 <= y_join_65_9;
    end if;
  end process proc_if_52_5;
  y <= signed_to_std_logic_vector(y_join_52_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_db7909516e is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_db7909516e;
architecture behavior of sysgen_logical_db7909516e
is
  signal d0_1_24: std_logic;
  signal d1_1_27: std_logic;
  signal fully_2_1_bit: std_logic;
  signal unregy_3_1_convert: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0(0);
  d1_1_27 <= d1(0);
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  unregy_3_1_convert <= cast(std_logic_to_vector(fully_2_1_bit), 0, 1, 0, xlUnsigned);
  y <= unregy_3_1_convert;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_1fcbfeb0b2 is
  port (
    present_state : in std_logic_vector((2 - 1) downto 0);
    start : in std_logic_vector((1 - 1) downto 0);
    preset : in std_logic_vector((10 - 1) downto 0);
    counts : in std_logic_vector((10 - 1) downto 0);
    next_state : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_1fcbfeb0b2;
architecture behavior of sysgen_mcode_block_1fcbfeb0b2
is
  signal present_state_1_57: unsigned((2 - 1) downto 0);
  signal start_1_72: boolean;
  signal preset_1_79: unsigned((10 - 1) downto 0);
  signal counts_1_87: unsigned((10 - 1) downto 0);
  signal rel_10_16: boolean;
  signal next_state_join_10_13: unsigned((2 - 1) downto 0);
  signal rel_14_16: boolean;
  signal next_state_join_14_13: unsigned((2 - 1) downto 0);
  signal rel_17_16: boolean;
  signal next_state_join_17_13: unsigned((2 - 1) downto 0);
  signal next_state_join_6_5: unsigned((2 - 1) downto 0);
begin
  present_state_1_57 <= std_logic_vector_to_unsigned(present_state);
  start_1_72 <= ((start) = "1");
  preset_1_79 <= std_logic_vector_to_unsigned(preset);
  counts_1_87 <= std_logic_vector_to_unsigned(counts);
  rel_10_16 <= start_1_72 = true;
  proc_if_10_13: process (present_state_1_57, rel_10_16)
  is
  begin
    if rel_10_16 then
      next_state_join_10_13 <= std_logic_vector_to_unsigned("10");
    else 
      next_state_join_10_13 <= present_state_1_57;
    end if;
  end process proc_if_10_13;
  rel_14_16 <= counts_1_87 = preset_1_79;
  proc_if_14_13: process (present_state_1_57, rel_14_16)
  is
  begin
    if rel_14_16 then
      next_state_join_14_13 <= std_logic_vector_to_unsigned("01");
    else 
      next_state_join_14_13 <= present_state_1_57;
    end if;
  end process proc_if_14_13;
  rel_17_16 <= start_1_72 = true;
  proc_if_17_13: process (next_state_join_14_13, rel_17_16)
  is
  begin
    if rel_17_16 then
      next_state_join_17_13 <= std_logic_vector_to_unsigned("11");
    else 
      next_state_join_17_13 <= next_state_join_14_13;
    end if;
  end process proc_if_17_13;
  proc_switch_6_5: process (next_state_join_10_13, next_state_join_17_13, present_state_1_57)
  is
  begin
    case present_state_1_57 is 
      when "00" =>
        next_state_join_6_5 <= std_logic_vector_to_unsigned("01");
      when "01" =>
        next_state_join_6_5 <= next_state_join_10_13;
      when "10" =>
        next_state_join_6_5 <= next_state_join_17_13;
      when "11" =>
        next_state_join_6_5 <= std_logic_vector_to_unsigned("10");
      when others =>
        next_state_join_6_5 <= present_state_1_57;
    end case;
  end process proc_switch_6_5;
  next_state <= unsigned_to_std_logic_vector(next_state_join_6_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_acc60cbd6c is
  port (
    present_state : in std_logic_vector((2 - 1) downto 0);
    blr_gate : out std_logic_vector((1 - 1) downto 0);
    cnt_rst : out std_logic_vector((1 - 1) downto 0);
    cnt_en : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_acc60cbd6c;
architecture behavior of sysgen_mcode_block_acc60cbd6c
is
  signal present_state_3_69: unsigned((2 - 1) downto 0);
  signal blr_gate_join_9_5: boolean;
  signal cnt_rst_join_9_5: boolean;
  signal cnt_en_join_9_5: boolean;
begin
  present_state_3_69 <= std_logic_vector_to_unsigned(present_state);
  proc_switch_9_5: process (present_state_3_69)
  is
  begin
    case present_state_3_69 is 
      when "00" =>
        blr_gate_join_9_5 <= false;
        cnt_rst_join_9_5 <= true;
        cnt_en_join_9_5 <= false;
      when "01" =>
        blr_gate_join_9_5 <= true;
        cnt_rst_join_9_5 <= true;
        cnt_en_join_9_5 <= false;
      when "10" =>
        blr_gate_join_9_5 <= false;
        cnt_rst_join_9_5 <= false;
        cnt_en_join_9_5 <= true;
      when "11" =>
        blr_gate_join_9_5 <= false;
        cnt_rst_join_9_5 <= true;
        cnt_en_join_9_5 <= true;
      when others =>
        blr_gate_join_9_5 <= false;
        cnt_rst_join_9_5 <= false;
        cnt_en_join_9_5 <= false;
    end case;
  end process proc_switch_9_5;
  blr_gate <= boolean_to_vector(blr_gate_join_9_5);
  cnt_rst <= boolean_to_vector(cnt_rst_join_9_5);
  cnt_en <= boolean_to_vector(cnt_en_join_9_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_2ddf0a765f is
  port (
    next_state : in std_logic_vector((2 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    blr_gate_i : in std_logic_vector((1 - 1) downto 0);
    cnt_rst_i : in std_logic_vector((1 - 1) downto 0);
    cnt_en_i : in std_logic_vector((1 - 1) downto 0);
    present_state : out std_logic_vector((2 - 1) downto 0);
    blr_gate_o : out std_logic_vector((1 - 1) downto 0);
    cnt_rst_o : out std_logic_vector((1 - 1) downto 0);
    cnt_en_o : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_2ddf0a765f;
architecture behavior of sysgen_mcode_block_2ddf0a765f
is
  signal next_state_2_86: unsigned((2 - 1) downto 0);
  signal rst_2_98: boolean;
  signal blr_gate_i_2_103: boolean;
  signal cnt_rst_i_2_115: boolean;
  signal cnt_en_i_2_126: boolean;
  signal state_5_23_next: unsigned((2 - 1) downto 0);
  signal state_5_23: unsigned((2 - 1) downto 0) := "00";
  signal state_5_23_rst: std_logic;
  signal blr_gate_6_26_next: boolean;
  signal blr_gate_6_26: boolean := false;
  signal blr_gate_6_26_rst: std_logic;
  signal cnt_en_7_24_next: boolean;
  signal cnt_en_7_24: boolean := false;
  signal cnt_en_7_24_rst: std_logic;
  signal cnt_rst_8_25_next: boolean;
  signal cnt_rst_8_25: boolean := false;
  signal rel_16_9: boolean;
  signal blr_gate_join_16_5: boolean;
  signal blr_gate_join_16_5_rst: std_logic;
  signal cnt_rst_join_16_5: boolean;
  signal state_join_16_5: unsigned((2 - 1) downto 0);
  signal state_join_16_5_rst: std_logic;
  signal cnt_en_join_16_5: boolean;
  signal cnt_en_join_16_5_rst: std_logic;
begin
  next_state_2_86 <= std_logic_vector_to_unsigned(next_state);
  rst_2_98 <= ((rst) = "1");
  blr_gate_i_2_103 <= ((blr_gate_i) = "1");
  cnt_rst_i_2_115 <= ((cnt_rst_i) = "1");
  cnt_en_i_2_126 <= ((cnt_en_i) = "1");
  proc_state_5_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (state_5_23_rst = '1')) then
        state_5_23 <= "00";
      elsif (ce = '1') then 
        state_5_23 <= state_5_23_next;
      end if;
    end if;
  end process proc_state_5_23;
  proc_blr_gate_6_26: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (blr_gate_6_26_rst = '1')) then
        blr_gate_6_26 <= false;
      elsif (ce = '1') then 
        blr_gate_6_26 <= blr_gate_6_26_next;
      end if;
    end if;
  end process proc_blr_gate_6_26;
  proc_cnt_en_7_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (cnt_en_7_24_rst = '1')) then
        cnt_en_7_24 <= false;
      elsif (ce = '1') then 
        cnt_en_7_24 <= cnt_en_7_24_next;
      end if;
    end if;
  end process proc_cnt_en_7_24;
  proc_cnt_rst_8_25: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        cnt_rst_8_25 <= cnt_rst_8_25_next;
      end if;
    end if;
  end process proc_cnt_rst_8_25;
  rel_16_9 <= rst_2_98 = true;
  proc_if_16_5: process (blr_gate_i_2_103, cnt_en_i_2_126, cnt_rst_i_2_115, next_state_2_86, rel_16_9)
  is
  begin
    if rel_16_9 then
      blr_gate_join_16_5_rst <= '1';
    else 
      blr_gate_join_16_5_rst <= '0';
    end if;
    blr_gate_join_16_5 <= blr_gate_i_2_103;
    if rel_16_9 then
      state_join_16_5_rst <= '1';
    else 
      state_join_16_5_rst <= '0';
    end if;
    state_join_16_5 <= next_state_2_86;
    if rel_16_9 then
      cnt_en_join_16_5_rst <= '1';
    else 
      cnt_en_join_16_5_rst <= '0';
    end if;
    cnt_en_join_16_5 <= cnt_en_i_2_126;
    if rel_16_9 then
      cnt_rst_join_16_5 <= true;
    else 
      cnt_rst_join_16_5 <= cnt_rst_i_2_115;
    end if;
  end process proc_if_16_5;
  state_5_23_next <= next_state_2_86;
  state_5_23_rst <= state_join_16_5_rst;
  blr_gate_6_26_next <= blr_gate_i_2_103;
  blr_gate_6_26_rst <= blr_gate_join_16_5_rst;
  cnt_en_7_24_next <= cnt_en_i_2_126;
  cnt_en_7_24_rst <= cnt_en_join_16_5_rst;
  cnt_rst_8_25_next <= cnt_rst_join_16_5;
  present_state <= unsigned_to_std_logic_vector(state_5_23);
  blr_gate_o <= boolean_to_vector(blr_gate_6_26);
  cnt_rst_o <= boolean_to_vector(cnt_rst_8_25);
  cnt_en_o <= boolean_to_vector(cnt_en_7_24);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_3c95d293bb is
  port (
    present_state : in std_logic_vector((2 - 1) downto 0);
    threshold_ul_low : in std_logic_vector((16 - 1) downto 0);
    threshold_ul_hi : in std_logic_vector((16 - 1) downto 0);
    threshold_ll_low : in std_logic_vector((16 - 1) downto 0);
    threshold_ll_hi : in std_logic_vector((16 - 1) downto 0);
    x : in std_logic_vector((16 - 1) downto 0);
    next_state : out std_logic_vector((2 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_3c95d293bb;
architecture behavior of sysgen_mcode_block_3c95d293bb
is
  signal present_state_1_48: unsigned((2 - 1) downto 0);
  signal threshold_ul_low_1_63: signed((16 - 1) downto 0);
  signal threshold_ul_hi_1_81: signed((16 - 1) downto 0);
  signal threshold_ll_low_1_98: signed((16 - 1) downto 0);
  signal threshold_ll_hi_1_116: signed((16 - 1) downto 0);
  signal x_1_133: signed((16 - 1) downto 0);
  signal rel_9_17: boolean;
  signal rel_9_41: boolean;
  signal bool_9_17: boolean;
  signal rel_11_21: boolean;
  signal rel_13_21: boolean;
  signal next_state_join_9_13: unsigned((2 - 1) downto 0);
  signal rel_19_16: boolean;
  signal rel_21_20: boolean;
  signal next_state_join_19_13: unsigned((2 - 1) downto 0);
  signal rel_25_16: boolean;
  signal rel_25_40: boolean;
  signal bool_25_16: boolean;
  signal rel_27_21: boolean;
  signal next_state_join_25_13: unsigned((2 - 1) downto 0);
  signal rel_31_17: boolean;
  signal rel_31_41: boolean;
  signal bool_31_17: boolean;
  signal rel_33_21: boolean;
  signal next_state_join_31_13: unsigned((2 - 1) downto 0);
  signal next_state_join_6_5: unsigned((2 - 1) downto 0);
begin
  present_state_1_48 <= std_logic_vector_to_unsigned(present_state);
  threshold_ul_low_1_63 <= std_logic_vector_to_signed(threshold_ul_low);
  threshold_ul_hi_1_81 <= std_logic_vector_to_signed(threshold_ul_hi);
  threshold_ll_low_1_98 <= std_logic_vector_to_signed(threshold_ll_low);
  threshold_ll_hi_1_116 <= std_logic_vector_to_signed(threshold_ll_hi);
  x_1_133 <= std_logic_vector_to_signed(x);
  rel_9_17 <= x_1_133 >= threshold_ll_hi_1_116;
  rel_9_41 <= x_1_133 <= threshold_ul_low_1_63;
  bool_9_17 <= rel_9_17 and rel_9_41;
  rel_11_21 <= x_1_133 >= threshold_ul_hi_1_81;
  rel_13_21 <= x_1_133 <= threshold_ll_low_1_98;
  proc_if_9_13: process (bool_9_17, present_state_1_48, rel_11_21, rel_13_21)
  is
  begin
    if bool_9_17 then
      next_state_join_9_13 <= std_logic_vector_to_unsigned("11");
    elsif rel_11_21 then
      next_state_join_9_13 <= std_logic_vector_to_unsigned("01");
    elsif rel_13_21 then
      next_state_join_9_13 <= std_logic_vector_to_unsigned("10");
    else 
      next_state_join_9_13 <= present_state_1_48;
    end if;
  end process proc_if_9_13;
  rel_19_16 <= x_1_133 <= threshold_ll_low_1_98;
  rel_21_20 <= x_1_133 >= threshold_ul_hi_1_81;
  proc_if_19_13: process (present_state_1_48, rel_19_16, rel_21_20)
  is
  begin
    if rel_19_16 then
      next_state_join_19_13 <= std_logic_vector_to_unsigned("10");
    elsif rel_21_20 then
      next_state_join_19_13 <= std_logic_vector_to_unsigned("01");
    else 
      next_state_join_19_13 <= present_state_1_48;
    end if;
  end process proc_if_19_13;
  rel_25_16 <= x_1_133 >= threshold_ll_hi_1_116;
  rel_25_40 <= x_1_133 <= threshold_ul_low_1_63;
  bool_25_16 <= rel_25_16 and rel_25_40;
  rel_27_21 <= x_1_133 >= threshold_ul_hi_1_81;
  proc_if_25_13: process (bool_25_16, present_state_1_48, rel_27_21)
  is
  begin
    if bool_25_16 then
      next_state_join_25_13 <= std_logic_vector_to_unsigned("11");
    elsif rel_27_21 then
      next_state_join_25_13 <= std_logic_vector_to_unsigned("01");
    else 
      next_state_join_25_13 <= present_state_1_48;
    end if;
  end process proc_if_25_13;
  rel_31_17 <= x_1_133 >= threshold_ll_hi_1_116;
  rel_31_41 <= x_1_133 <= threshold_ul_low_1_63;
  bool_31_17 <= rel_31_17 and rel_31_41;
  rel_33_21 <= x_1_133 <= threshold_ll_low_1_98;
  proc_if_31_13: process (bool_31_17, present_state_1_48, rel_33_21)
  is
  begin
    if bool_31_17 then
      next_state_join_31_13 <= std_logic_vector_to_unsigned("11");
    elsif rel_33_21 then
      next_state_join_31_13 <= std_logic_vector_to_unsigned("10");
    else 
      next_state_join_31_13 <= present_state_1_48;
    end if;
  end process proc_if_31_13;
  proc_switch_6_5: process (next_state_join_19_13, next_state_join_25_13, next_state_join_31_13, next_state_join_9_13, present_state_1_48)
  is
  begin
    case present_state_1_48 is 
      when "00" =>
        next_state_join_6_5 <= next_state_join_9_13;
      when "11" =>
        next_state_join_6_5 <= next_state_join_19_13;
      when "10" =>
        next_state_join_6_5 <= next_state_join_25_13;
      when "01" =>
        next_state_join_6_5 <= next_state_join_31_13;
      when others =>
        next_state_join_6_5 <= present_state_1_48;
    end case;
  end process proc_switch_6_5;
  next_state <= unsigned_to_std_logic_vector(next_state_join_6_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_cabb49fa0c is
  port (
    present_state : in std_logic_vector((2 - 1) downto 0);
    switch_state : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_cabb49fa0c;
architecture behavior of sysgen_mcode_block_cabb49fa0c
is
  signal present_state_1_47: unsigned((2 - 1) downto 0);
  signal switch_state_join_5_5: boolean;
begin
  present_state_1_47 <= std_logic_vector_to_unsigned(present_state);
  proc_switch_5_5: process (present_state_1_47)
  is
  begin
    case present_state_1_47 is 
      when "00" =>
        switch_state_join_5_5 <= true;
      when "01" =>
        switch_state_join_5_5 <= false;
      when "10" =>
        switch_state_join_5_5 <= false;
      when "11" =>
        switch_state_join_5_5 <= true;
      when others =>
        switch_state_join_5_5 <= false;
    end case;
  end process proc_switch_5_5;
  switch_state <= boolean_to_vector(switch_state_join_5_5);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_7c66abb3c9 is
  port (
    next_state : in std_logic_vector((2 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    switch_state_i : in std_logic_vector((1 - 1) downto 0);
    present_state : out std_logic_vector((2 - 1) downto 0);
    switch_state_o : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_7c66abb3c9;
architecture behavior of sysgen_mcode_block_7c66abb3c9
is
  signal next_state_2_60: unsigned((2 - 1) downto 0);
  signal rst_2_72: boolean;
  signal switch_state_i_2_77: boolean;
  signal state_5_23_next: unsigned((2 - 1) downto 0);
  signal state_5_23: unsigned((2 - 1) downto 0) := "00";
  signal state_5_23_rst: std_logic;
  signal switch_state_6_30_next: boolean;
  signal switch_state_6_30: boolean := false;
  signal rel_12_9: boolean;
  signal state_join_12_5: unsigned((2 - 1) downto 0);
  signal state_join_12_5_rst: std_logic;
  signal switch_state_join_12_5: boolean;
begin
  next_state_2_60 <= std_logic_vector_to_unsigned(next_state);
  rst_2_72 <= ((rst) = "1");
  switch_state_i_2_77 <= ((switch_state_i) = "1");
  proc_state_5_23: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (state_5_23_rst = '1')) then
        state_5_23 <= "00";
      elsif (ce = '1') then 
        state_5_23 <= state_5_23_next;
      end if;
    end if;
  end process proc_state_5_23;
  proc_switch_state_6_30: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        switch_state_6_30 <= switch_state_6_30_next;
      end if;
    end if;
  end process proc_switch_state_6_30;
  rel_12_9 <= rst_2_72 = true;
  proc_if_12_5: process (next_state_2_60, rel_12_9, switch_state_i_2_77)
  is
  begin
    if rel_12_9 then
      state_join_12_5_rst <= '1';
    else 
      state_join_12_5_rst <= '0';
    end if;
    state_join_12_5 <= next_state_2_60;
    if rel_12_9 then
      switch_state_join_12_5 <= true;
    else 
      switch_state_join_12_5 <= switch_state_i_2_77;
    end if;
  end process proc_if_12_5;
  state_5_23_next <= next_state_2_60;
  state_5_23_rst <= state_join_12_5_rst;
  switch_state_6_30_next <= switch_state_join_12_5;
  present_state <= unsigned_to_std_logic_vector(state_5_23);
  switch_state_o <= boolean_to_vector(switch_state_6_30);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mux_52101f9c8d is
  port (
    sel : in std_logic_vector((1 - 1) downto 0);
    d0 : in std_logic_vector((16 - 1) downto 0);
    d1 : in std_logic_vector((16 - 1) downto 0);
    y : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mux_52101f9c8d;
architecture behavior of sysgen_mux_52101f9c8d
is
  signal sel_1_20: std_logic_vector((1 - 1) downto 0);
  signal d0_1_24: std_logic_vector((16 - 1) downto 0);
  signal d1_1_27: std_logic_vector((16 - 1) downto 0);
  type array_type_pipe_16_22 is array (0 to (1 - 1)) of std_logic_vector((16 - 1) downto 0);
  signal pipe_16_22: array_type_pipe_16_22 := (
    0 => "0000000000000000");
  signal pipe_16_22_front_din: std_logic_vector((16 - 1) downto 0);
  signal pipe_16_22_back: std_logic_vector((16 - 1) downto 0);
  signal pipe_16_22_push_front_pop_back_en: std_logic;
  signal unregy_join_6_1: std_logic_vector((16 - 1) downto 0);
begin
  sel_1_20 <= sel;
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  pipe_16_22_back <= pipe_16_22(0);
  proc_pipe_16_22: process (clk)
  is
    variable i: integer;
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (pipe_16_22_push_front_pop_back_en = '1')) then
        pipe_16_22(0) <= pipe_16_22_front_din;
      end if;
    end if;
  end process proc_pipe_16_22;
  proc_switch_6_1: process (d0_1_24, d1_1_27, sel_1_20)
  is
  begin
    case sel_1_20 is 
      when "0" =>
        unregy_join_6_1 <= d0_1_24;
      when others =>
        unregy_join_6_1 <= d1_1_27;
    end case;
  end process proc_switch_6_1;
  pipe_16_22_front_din <= unregy_join_6_1;
  pipe_16_22_push_front_pop_back_en <= '1';
  y <= pipe_16_22_back;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator VHDL source file.
 --
 -- Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
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
 -- text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
 -- reserved.
 -------------------------------------------------------------------
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity blr_xladdsub is 
   generic (
     core_name0: string := "";
     a_width: integer := 16;
     a_bin_pt: integer := 4;
     a_arith: integer := xlUnsigned;
     c_in_width: integer := 16;
     c_in_bin_pt: integer := 4;
     c_in_arith: integer := xlUnsigned;
     c_out_width: integer := 16;
     c_out_bin_pt: integer := 4;
     c_out_arith: integer := xlUnsigned;
     b_width: integer := 8;
     b_bin_pt: integer := 2;
     b_arith: integer := xlUnsigned;
     s_width: integer := 17;
     s_bin_pt: integer := 4;
     s_arith: integer := xlUnsigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     full_s_width: integer := 17;
     full_s_arith: integer := xlUnsigned;
     mode: integer := xlAddMode;
     extra_registers: integer := 0;
     latency: integer := 0;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     c_latency: integer := 0;
     c_output_width: integer := 17;
     c_has_c_in : integer := 0;
     c_has_c_out : integer := 0
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     b: in std_logic_vector(b_width - 1 downto 0);
     c_in : in std_logic_vector (0 downto 0) := "0";
     ce: in std_logic;
     clr: in std_logic := '0';
     clk: in std_logic;
     rst: in std_logic_vector(rst_width - 1 downto 0) := "0";
     en: in std_logic_vector(en_width - 1 downto 0) := "1";
     c_out : out std_logic_vector (0 downto 0);
     s: out std_logic_vector(s_width - 1 downto 0)
   );
 end blr_xladdsub;
 
 architecture behavior of blr_xladdsub is 
 component synth_reg
 generic (
 width: integer := 16;
 latency: integer := 5
 );
 port (
 i: in std_logic_vector(width - 1 downto 0);
 ce: in std_logic;
 clr: in std_logic;
 clk: in std_logic;
 o: out std_logic_vector(width - 1 downto 0)
 );
 end component;
 
 function format_input(inp: std_logic_vector; old_width, delta, new_arith,
 new_width: integer)
 return std_logic_vector
 is
 variable vec: std_logic_vector(old_width-1 downto 0);
 variable padded_inp: std_logic_vector((old_width + delta)-1 downto 0);
 variable result: std_logic_vector(new_width-1 downto 0);
 begin
 vec := inp;
 if (delta > 0) then
 padded_inp := pad_LSB(vec, old_width+delta);
 result := extend_MSB(padded_inp, new_width, new_arith);
 else
 result := extend_MSB(vec, new_width, new_arith);
 end if;
 return result;
 end;
 
 constant full_s_bin_pt: integer := fractional_bits(a_bin_pt, b_bin_pt);
 constant full_a_width: integer := full_s_width;
 constant full_b_width: integer := full_s_width;
 
 signal full_a: std_logic_vector(full_a_width - 1 downto 0);
 signal full_b: std_logic_vector(full_b_width - 1 downto 0);
 signal core_s: std_logic_vector(full_s_width - 1 downto 0);
 signal conv_s: std_logic_vector(s_width - 1 downto 0);
 signal temp_cout : std_logic;
 signal internal_clr: std_logic;
 signal internal_ce: std_logic;
 signal extra_reg_ce: std_logic;
 signal override: std_logic;
 signal logic1: std_logic_vector(0 downto 0);


 component blr_c_addsub_v12_0_i0
    port ( 
    a: in std_logic_vector(37 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(37 - 1 downto 0) 
 		  ); 
 end component;

 component blr_c_addsub_v12_0_i1
    port ( 
    a: in std_logic_vector(25 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(25 - 1 downto 0) 
 		  ); 
 end component;

 component blr_c_addsub_v12_0_i2
    port ( 
    a: in std_logic_vector(25 - 1 downto 0);
    clk: in std_logic:= '0';
    ce: in std_logic:= '0';
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(25 - 1 downto 0) 
 		  ); 
 end component;

 component blr_c_addsub_v12_0_i3
    port ( 
    a: in std_logic_vector(25 - 1 downto 0);
    s: out std_logic_vector(c_output_width - 1 downto 0);
    b: in std_logic_vector(25 - 1 downto 0) 
 		  ); 
 end component;

begin
 internal_clr <= (clr or (rst(0))) and ce;
 internal_ce <= ce and en(0);
 logic1(0) <= '1';
 addsub_process: process (a, b, core_s)
 begin
 full_a <= format_input (a, a_width, b_bin_pt - a_bin_pt, a_arith,
 full_a_width);
 full_b <= format_input (b, b_width, a_bin_pt - b_bin_pt, b_arith,
 full_b_width);
 conv_s <= convert_type (core_s, full_s_width, full_s_bin_pt, full_s_arith,
 s_width, s_bin_pt, s_arith, quantization, overflow);
 end process addsub_process;


 comp0: if ((core_name0 = "blr_c_addsub_v12_0_i0")) generate 
  core_instance0:blr_c_addsub_v12_0_i0
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp1: if ((core_name0 = "blr_c_addsub_v12_0_i1")) generate 
  core_instance1:blr_c_addsub_v12_0_i1
   port map ( 
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp2: if ((core_name0 = "blr_c_addsub_v12_0_i2")) generate 
  core_instance2:blr_c_addsub_v12_0_i2
   port map ( 
         a => full_a,
         clk => clk,
         ce => internal_ce,
         s => core_s,
         b => full_b
  ); 
   end generate;

 comp3: if ((core_name0 = "blr_c_addsub_v12_0_i3")) generate 
  core_instance3:blr_c_addsub_v12_0_i3
   port map ( 
         a => full_a,
         s => core_s,
         b => full_b
  ); 
   end generate;

latency_test: if (extra_registers > 0) generate
 override_test: if (c_latency > 1) generate
 override_pipe: synth_reg
 generic map (
 width => 1,
 latency => c_latency
 )
 port map (
 i => logic1,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o(0) => override);
 extra_reg_ce <= ce and en(0) and override;
 end generate override_test;
 no_override: if ((c_latency = 0) or (c_latency = 1)) generate
 extra_reg_ce <= ce and en(0);
 end generate no_override;
 extra_reg: synth_reg
 generic map (
 width => s_width,
 latency => extra_registers
 )
 port map (
 i => conv_s,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => s
 );
 cout_test: if (c_has_c_out = 1) generate
 c_out_extra_reg: synth_reg
 generic map (
 width => 1,
 latency => extra_registers
 )
 port map (
 i(0) => temp_cout,
 ce => extra_reg_ce,
 clr => internal_clr,
 clk => clk,
 o => c_out
 );
 end generate cout_test;
 end generate;
 
 latency_s: if ((latency = 0) or (extra_registers = 0)) generate
 s <= conv_s;
 end generate latency_s;
 latency0: if (((latency = 0) or (extra_registers = 0)) and
 (c_has_c_out = 1)) generate
 c_out(0) <= temp_cout;
 end generate latency0;
 tie_dangling_cout: if (c_has_c_out = 0) generate
 c_out <= "0";
 end generate tie_dangling_cout;
 end architecture behavior;

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

entity blr_xlcounter_free is 
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
 end blr_xlcounter_free;
 
 architecture behavior of blr_xlcounter_free is


 component blr_c_counter_binary_v12_0_i0
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
      load: in std_logic;
      l: in std_logic_vector(op_width - 1 downto 0);
      q: out std_logic_vector(op_width - 1 downto 0) 
 		  ); 
 end component;

 component blr_c_counter_binary_v12_0_i1
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      SINIT: in std_logic;
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


 comp0: if ((core_name0 = "blr_c_counter_binary_v12_0_i0")) generate 
  core_instance0:blr_c_counter_binary_v12_0_i0
   port map ( 
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        load => load(0),
        l => din,
        q => op_net
  ); 
   end generate;

 comp1: if ((core_name0 = "blr_c_counter_binary_v12_0_i1")) generate 
  core_instance1:blr_c_counter_binary_v12_0_i1
   port map ( 
        clk => clk,
        ce => core_ce,
        SINIT => core_sinit,
        q => op_net
  ); 
   end generate;

end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

-------------------------------------------------------------------
 -- System Generator VHDL source file.
 --
 -- Copyright(C) 2018 by Xilinx, Inc.  All rights reserved.  This
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
 -- text at all times.  (c) Copyright 1995-2018 Xilinx, Inc.  All rights
 -- reserved.
 -------------------------------------------------------------------
 library IEEE;
 use IEEE.std_logic_1164.all;
 use IEEE.std_logic_arith.all;

entity blr_xlmult is 
   generic (
     core_name0: string := "";
     a_width: integer := 4;
     a_bin_pt: integer := 2;
     a_arith: integer := xlSigned;
     b_width: integer := 4;
     b_bin_pt: integer := 1;
     b_arith: integer := xlSigned;
     p_width: integer := 8;
     p_bin_pt: integer := 2;
     p_arith: integer := xlSigned;
     rst_width: integer := 1;
     rst_bin_pt: integer := 0;
     rst_arith: integer := xlUnsigned;
     en_width: integer := 1;
     en_bin_pt: integer := 0;
     en_arith: integer := xlUnsigned;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     extra_registers: integer := 0;
     c_a_width: integer := 7;
     c_b_width: integer := 7;
     c_type: integer := 0;
     c_a_type: integer := 0;
     c_b_type: integer := 0;
     c_pipelined: integer := 1;
     c_baat: integer := 4;
     multsign: integer := xlSigned;
     c_output_width: integer := 16
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     b: in std_logic_vector(b_width - 1 downto 0);
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     core_ce: in std_logic := '0';
     core_clr: in std_logic := '0';
     core_clk: in std_logic := '0';
     rst: in std_logic_vector(rst_width - 1 downto 0);
     en: in std_logic_vector(en_width - 1 downto 0);
     p: out std_logic_vector(p_width - 1 downto 0)
   );
 end  blr_xlmult;
 
 architecture behavior of blr_xlmult is
 component synth_reg
 generic (
 width: integer := 16;
 latency: integer := 5
 );
 port (
 i: in std_logic_vector(width - 1 downto 0);
 ce: in std_logic;
 clr: in std_logic;
 clk: in std_logic;
 o: out std_logic_vector(width - 1 downto 0)
 );
 end component;


 component blr_mult_gen_v12_0_i0
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component blr_mult_gen_v12_0_i1
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component blr_mult_gen_v12_0_i2
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component blr_mult_gen_v12_0_i3
    port ( 
      b: in std_logic_vector(c_b_width - 1 downto 0);
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
 signal conv_a: std_logic_vector(c_a_width - 1 downto 0);
 signal tmp_b: std_logic_vector(c_b_width - 1 downto 0);
 signal conv_b: std_logic_vector(c_b_width - 1 downto 0);
 signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
 signal conv_p: std_logic_vector(p_width - 1 downto 0);
 -- synthesis translate_off
 signal real_a, real_b, real_p: real;
 -- synthesis translate_on
 signal rfd: std_logic;
 signal rdy: std_logic;
 signal nd: std_logic;
 signal internal_ce: std_logic;
 signal internal_clr: std_logic;
 signal internal_core_ce: std_logic;
 begin
 -- synthesis translate_off
 -- synthesis translate_on
 internal_ce <= ce and en(0);
 internal_core_ce <= core_ce and en(0);
 internal_clr <= (clr or rst(0)) and ce;
 nd <= internal_ce;
 input_process: process (a,b)
 begin
 tmp_a <= zero_ext(a, c_a_width);
 tmp_b <= zero_ext(b, c_b_width);
 end process;
 output_process: process (tmp_p)
 begin
 conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
 p_width, p_bin_pt, p_arith, quantization, overflow);
 end process;


 comp0: if ((core_name0 = "blr_mult_gen_v12_0_i0")) generate 
  core_instance0:blr_mult_gen_v12_0_i0
   port map ( 
        a => tmp_a,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

 comp1: if ((core_name0 = "blr_mult_gen_v12_0_i1")) generate 
  core_instance1:blr_mult_gen_v12_0_i1
   port map ( 
        a => tmp_a,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

 comp2: if ((core_name0 = "blr_mult_gen_v12_0_i2")) generate 
  core_instance2:blr_mult_gen_v12_0_i2
   port map ( 
        a => tmp_a,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

 comp3: if ((core_name0 = "blr_mult_gen_v12_0_i3")) generate 
  core_instance3:blr_mult_gen_v12_0_i3
   port map ( 
        a => tmp_a,
        p => tmp_p,
        b => tmp_b
  ); 
   end generate;

latency_gt_0: if (extra_registers > 0) generate
 reg: synth_reg
 generic map (
 width => p_width,
 latency => extra_registers
 )
 port map (
 i => conv_p,
 ce => internal_ce,
 clr => internal_clr,
 clk => clk,
 o => p
 );
 end generate;
 latency_eq_0: if (extra_registers = 0) generate
 p <= conv_p;
 end generate;
 end architecture behavior;

