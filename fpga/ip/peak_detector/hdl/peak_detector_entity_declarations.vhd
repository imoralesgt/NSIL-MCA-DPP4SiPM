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


entity peak_detector_xlregister is

   generic (d_width          : integer := 5;          -- Width of d input
            init_value       : bit_vector := b"00");  -- Binary init value string

   port (d   : in std_logic_vector (d_width-1 downto 0);
         rst : in std_logic_vector(0 downto 0) := "0";
         en  : in std_logic_vector(0 downto 0) := "1";
         ce  : in std_logic;
         clk : in std_logic;
         q   : out std_logic_vector (d_width-1 downto 0));

end peak_detector_xlregister;

architecture behavior of peak_detector_xlregister is

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
entity sysgen_reinterpret_b875eb6c7e is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_b875eb6c7e;
architecture behavior of sysgen_reinterpret_b875eb6c7e
is
  signal input_port_1_40: signed((16 - 1) downto 0);
  signal output_port_5_5_force: unsigned((16 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_signed(input_port);
  output_port_5_5_force <= signed_to_unsigned(input_port_1_40);
  output_port <= unsigned_to_std_logic_vector(output_port_5_5_force);
end behavior;

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


entity convert_func_call_peak_detector_xlconvert is
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
end convert_func_call_peak_detector_xlconvert ;

architecture behavior of convert_func_call_peak_detector_xlconvert is
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


entity peak_detector_xlconvert  is
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

end peak_detector_xlconvert ;

architecture behavior of peak_detector_xlconvert  is

    component synth_reg
        generic (width       : integer;
                 latency     : integer);
        port (i       : in std_logic_vector(width-1 downto 0);
              ce      : in std_logic;
              clr     : in std_logic;
              clk     : in std_logic;
              o       : out std_logic_vector(width-1 downto 0));
    end component;

    component convert_func_call_peak_detector_xlconvert 
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
      convert : convert_func_call_peak_detector_xlconvert 
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


entity peak_detector_xldelay is
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

end peak_detector_xldelay;

architecture behavior of peak_detector_xldelay is
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
entity sysgen_inverter_9774281692 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_9774281692;
architecture behavior of sysgen_inverter_9774281692
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
entity sysgen_inverter_688b9e2638 is
  port (
    ip : in std_logic_vector((1 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_inverter_688b9e2638;
architecture behavior of sysgen_inverter_688b9e2638
is
  signal ip_1_26: unsigned((1 - 1) downto 0);
  type array_type_op_mem_22_20 is array (0 to (1 - 1)) of unsigned((1 - 1) downto 0);
  signal op_mem_22_20: array_type_op_mem_22_20 := (
    0 => "0");
  signal op_mem_22_20_front_din: unsigned((1 - 1) downto 0);
  signal op_mem_22_20_back: unsigned((1 - 1) downto 0);
  signal op_mem_22_20_push_front_pop_back_en: std_logic;
  signal internal_ip_12_1_bitnot: unsigned((1 - 1) downto 0);
begin
  ip_1_26 <= std_logic_vector_to_unsigned(ip);
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
  internal_ip_12_1_bitnot <= std_logic_vector_to_unsigned(not unsigned_to_std_logic_vector(ip_1_26));
  op_mem_22_20_push_front_pop_back_en <= '0';
  op <= unsigned_to_std_logic_vector(internal_ip_12_1_bitnot);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_cf4561827f is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_cf4561827f;
architecture behavior of sysgen_logical_cf4561827f
is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal fully_2_1_bit: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  fully_2_1_bit <= d0_1_24 or d1_1_27;
  y <= fully_2_1_bit;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_b63f181d40 is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_b63f181d40;
architecture behavior of sysgen_logical_b63f181d40
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
entity sysgen_mcode_block_c5ef7f85b2 is
  port (
    x : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    e : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_c5ef7f85b2;
architecture behavior of sysgen_mcode_block_c5ef7f85b2
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
entity sysgen_mcode_block_47e1e3b3e3 is
  port (
    x_p : in std_logic_vector((16 - 1) downto 0);
    x_m : in std_logic_vector((16 - 1) downto 0);
    hyst : in std_logic_vector((16 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_47e1e3b3e3;
architecture behavior of sysgen_mcode_block_47e1e3b3e3
is
  signal x_p_1_38: signed((16 - 1) downto 0);
  signal x_m_1_43: signed((16 - 1) downto 0);
  signal hyst_1_48: signed((16 - 1) downto 0);
  signal rst_1_54: boolean;
  signal y_i_2_21_next: boolean;
  signal y_i_2_21: boolean := false;
  signal y_i_2_21_rst: std_logic;
  signal x_lo_i_3_24_next: signed((16 - 1) downto 0);
  signal x_lo_i_3_24: signed((16 - 1) downto 0) := "0000000000000000";
  signal x_hi_i_4_24_next: signed((16 - 1) downto 0);
  signal x_hi_i_4_24: signed((16 - 1) downto 0) := "0000000000000000";
  signal cast_8_14: signed((17 - 1) downto 0);
  signal cast_8_20: signed((17 - 1) downto 0);
  signal x_hi_i_8_5_addsub: signed((17 - 1) downto 0);
  signal cast_9_14: signed((17 - 1) downto 0);
  signal cast_9_20: signed((17 - 1) downto 0);
  signal x_lo_i_9_5_addsub: signed((17 - 1) downto 0);
  signal cast_14_12: signed((17 - 1) downto 0);
  signal rel_14_12: boolean;
  signal cast_16_17: signed((17 - 1) downto 0);
  signal rel_16_17: boolean;
  signal y_i_join_14_9: boolean;
  signal rel_11_8: boolean;
  signal y_i_join_11_5: boolean;
  signal y_i_join_11_5_rst: std_logic;
  signal x_lo_i_3_24_next_x_000000: signed((16 - 1) downto 0);
  signal x_hi_i_4_24_next_x_000000: signed((16 - 1) downto 0);
begin
  x_p_1_38 <= std_logic_vector_to_signed(x_p);
  x_m_1_43 <= std_logic_vector_to_signed(x_m);
  hyst_1_48 <= std_logic_vector_to_signed(hyst);
  rst_1_54 <= ((rst) = "1");
  proc_y_i_2_21: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (y_i_2_21_rst = '1')) then
        y_i_2_21 <= false;
      elsif (ce = '1') then 
        y_i_2_21 <= y_i_2_21_next;
      end if;
    end if;
  end process proc_y_i_2_21;
  proc_x_lo_i_3_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        x_lo_i_3_24 <= x_lo_i_3_24_next;
      end if;
    end if;
  end process proc_x_lo_i_3_24;
  proc_x_hi_i_4_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        x_hi_i_4_24 <= x_hi_i_4_24_next;
      end if;
    end if;
  end process proc_x_hi_i_4_24;
  cast_8_14 <= s2s_cast(x_m_1_43, 14, 17, 14);
  cast_8_20 <= s2s_cast(hyst_1_48, 14, 17, 14);
  x_hi_i_8_5_addsub <= cast_8_14 + cast_8_20;
  cast_9_14 <= s2s_cast(x_m_1_43, 14, 17, 14);
  cast_9_20 <= s2s_cast(hyst_1_48, 14, 17, 14);
  x_lo_i_9_5_addsub <= cast_9_14 - cast_9_20;
  cast_14_12 <= s2s_cast(x_p_1_38, 14, 17, 14);
  rel_14_12 <= cast_14_12 > x_hi_i_8_5_addsub;
  cast_16_17 <= s2s_cast(x_p_1_38, 14, 17, 14);
  rel_16_17 <= cast_16_17 < x_lo_i_9_5_addsub;
  proc_if_14_9: process (rel_14_12, rel_16_17, y_i_2_21)
  is
  begin
    if rel_14_12 then
      y_i_join_14_9 <= true;
    elsif rel_16_17 then
      y_i_join_14_9 <= false;
    else 
      y_i_join_14_9 <= y_i_2_21;
    end if;
  end process proc_if_14_9;
  rel_11_8 <= rst_1_54 = true;
  proc_if_11_5: process (rel_11_8, y_i_join_14_9)
  is
  begin
    if rel_11_8 then
      y_i_join_11_5_rst <= '1';
    else 
      y_i_join_11_5_rst <= '0';
    end if;
    y_i_join_11_5 <= y_i_join_14_9;
  end process proc_if_11_5;
  y_i_2_21_next <= y_i_join_14_9;
  y_i_2_21_rst <= y_i_join_11_5_rst;
  x_lo_i_3_24_next_x_000000 <= std_logic_vector_to_signed(convert_type(signed_to_std_logic_vector(x_lo_i_9_5_addsub), 17, 14, xlSigned, 16, 14, xlSigned, xlRound, xlSaturate));
  x_lo_i_3_24_next <= x_lo_i_3_24_next_x_000000;
  x_hi_i_4_24_next_x_000000 <= std_logic_vector_to_signed(convert_type(signed_to_std_logic_vector(x_hi_i_8_5_addsub), 17, 14, xlSigned, 16, 14, xlSigned, xlRound, xlSaturate));
  x_hi_i_4_24_next <= x_hi_i_4_24_next_x_000000;
  y <= boolean_to_vector(y_i_2_21);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_002d07903e is
  port (
    x_p : in std_logic_vector((16 - 1) downto 0);
    x_m : in std_logic_vector((16 - 1) downto 0);
    hyst : in std_logic_vector((16 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_002d07903e;
architecture behavior of sysgen_mcode_block_002d07903e
is
  signal x_p_1_38: signed((16 - 1) downto 0);
  signal x_m_1_43: signed((16 - 1) downto 0);
  signal hyst_1_48: signed((16 - 1) downto 0);
  signal rst_1_54: boolean;
  signal y_i_2_21_next: boolean;
  signal y_i_2_21: boolean := false;
  signal y_i_2_21_rst: std_logic;
  signal x_lo_i_3_24_next: signed((16 - 1) downto 0);
  signal x_lo_i_3_24: signed((16 - 1) downto 0) := "0000000000000000";
  signal x_hi_i_4_24_next: signed((16 - 1) downto 0);
  signal x_hi_i_4_24: signed((16 - 1) downto 0) := "0000000000000000";
  signal cast_9_14: signed((17 - 1) downto 0);
  signal cast_9_20: signed((17 - 1) downto 0);
  signal x_lo_i_9_5_addsub: signed((17 - 1) downto 0);
  signal rel_14_12: boolean;
  signal cast_16_17: signed((17 - 1) downto 0);
  signal rel_16_17: boolean;
  signal y_i_join_14_9: boolean;
  signal rel_11_8: boolean;
  signal y_i_join_11_5: boolean;
  signal y_i_join_11_5_rst: std_logic;
  signal x_lo_i_3_24_next_x_000000: signed((16 - 1) downto 0);
begin
  x_p_1_38 <= std_logic_vector_to_signed(x_p);
  x_m_1_43 <= std_logic_vector_to_signed(x_m);
  hyst_1_48 <= std_logic_vector_to_signed(hyst);
  rst_1_54 <= ((rst) = "1");
  proc_y_i_2_21: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (y_i_2_21_rst = '1')) then
        y_i_2_21 <= false;
      elsif (ce = '1') then 
        y_i_2_21 <= y_i_2_21_next;
      end if;
    end if;
  end process proc_y_i_2_21;
  proc_x_lo_i_3_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        x_lo_i_3_24 <= x_lo_i_3_24_next;
      end if;
    end if;
  end process proc_x_lo_i_3_24;
  proc_x_hi_i_4_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        x_hi_i_4_24 <= x_hi_i_4_24_next;
      end if;
    end if;
  end process proc_x_hi_i_4_24;
  cast_9_14 <= s2s_cast(x_m_1_43, 14, 17, 14);
  cast_9_20 <= s2s_cast(hyst_1_48, 14, 17, 14);
  x_lo_i_9_5_addsub <= cast_9_14 - cast_9_20;
  rel_14_12 <= x_p_1_38 > x_m_1_43;
  cast_16_17 <= s2s_cast(x_p_1_38, 14, 17, 14);
  rel_16_17 <= cast_16_17 < x_lo_i_9_5_addsub;
  proc_if_14_9: process (rel_14_12, rel_16_17, y_i_2_21)
  is
  begin
    if rel_14_12 then
      y_i_join_14_9 <= true;
    elsif rel_16_17 then
      y_i_join_14_9 <= false;
    else 
      y_i_join_14_9 <= y_i_2_21;
    end if;
  end process proc_if_14_9;
  rel_11_8 <= rst_1_54 = true;
  proc_if_11_5: process (rel_11_8, y_i_join_14_9)
  is
  begin
    if rel_11_8 then
      y_i_join_11_5_rst <= '1';
    else 
      y_i_join_11_5_rst <= '0';
    end if;
    y_i_join_11_5 <= y_i_join_14_9;
  end process proc_if_11_5;
  y_i_2_21_next <= y_i_join_14_9;
  y_i_2_21_rst <= y_i_join_11_5_rst;
  x_lo_i_3_24_next_x_000000 <= std_logic_vector_to_signed(convert_type(signed_to_std_logic_vector(x_lo_i_9_5_addsub), 17, 14, xlSigned, 16, 14, xlSigned, xlRound, xlSaturate));
  x_lo_i_3_24_next <= x_lo_i_3_24_next_x_000000;
  x_hi_i_4_24_next <= x_m_1_43;
  y <= boolean_to_vector(y_i_2_21);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_0df92f27ed is
  port (
    start : in std_logic_vector((1 - 1) downto 0);
    preset : in std_logic_vector((10 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_0df92f27ed;
architecture behavior of sysgen_mcode_block_0df92f27ed
is
  signal start_1_25: boolean;
  signal preset_1_32: signed((10 - 1) downto 0);
  signal rst_1_40: boolean;
  signal count_en_i_3_28_next: boolean;
  signal count_en_i_3_28: boolean := false;
  signal count_en_i_3_28_rst: std_logic;
  signal count_i_4_25_next: unsigned((10 - 1) downto 0);
  signal count_i_4_25: unsigned((10 - 1) downto 0) := "0000000000";
  signal cast_9_19: unsigned((11 - 1) downto 0);
  signal count_i_9_9_addsub: unsigned((11 - 1) downto 0);
  signal rel_8_8: boolean;
  signal count_i_join_8_5: unsigned((11 - 1) downto 0);
  signal cast_20_16: signed((12 - 1) downto 0);
  signal cast_20_27: signed((12 - 1) downto 0);
  signal rel_20_16: boolean;
  signal count_en_i_join_20_13: boolean;
  signal rel_16_13: boolean;
  signal count_en_i_join_16_9: boolean;
  signal count_i_join_16_9: unsigned((11 - 1) downto 0);
  signal rel_12_8: boolean;
  signal count_en_i_join_12_5: boolean;
  signal count_en_i_join_12_5_rst: std_logic;
  signal count_i_join_12_5: unsigned((11 - 1) downto 0);
  signal cast_count_i_4_25_next: unsigned((10 - 1) downto 0);
begin
  start_1_25 <= ((start) = "1");
  preset_1_32 <= std_logic_vector_to_signed(preset);
  rst_1_40 <= ((rst) = "1");
  proc_count_en_i_3_28: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (count_en_i_3_28_rst = '1')) then
        count_en_i_3_28 <= false;
      elsif (ce = '1') then 
        count_en_i_3_28 <= count_en_i_3_28_next;
      end if;
    end if;
  end process proc_count_en_i_3_28;
  proc_count_i_4_25: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        count_i_4_25 <= count_i_4_25_next;
      end if;
    end if;
  end process proc_count_i_4_25;
  cast_9_19 <= u2u_cast(count_i_4_25, 0, 11, 0);
  count_i_9_9_addsub <= cast_9_19 + std_logic_vector_to_unsigned("00000000001");
  rel_8_8 <= count_en_i_3_28 = true;
  proc_if_8_5: process (count_i_4_25, count_i_9_9_addsub, rel_8_8)
  is
  begin
    if rel_8_8 then
      count_i_join_8_5 <= count_i_9_9_addsub;
    else 
      count_i_join_8_5 <= u2u_cast(count_i_4_25, 0, 11, 0);
    end if;
  end process proc_if_8_5;
  cast_20_16 <= u2s_cast(count_i_join_8_5, 0, 12, 0);
  cast_20_27 <= s2s_cast(preset_1_32, 0, 12, 0);
  rel_20_16 <= cast_20_16 = cast_20_27;
  proc_if_20_13: process (rel_20_16)
  is
  begin
    if rel_20_16 then
      count_en_i_join_20_13 <= false;
    else 
      count_en_i_join_20_13 <= true;
    end if;
  end process proc_if_20_13;
  rel_16_13 <= start_1_25 = true;
  proc_if_16_9: process (count_en_i_join_20_13, count_i_join_8_5, rel_16_13)
  is
  begin
    if rel_16_13 then
      count_en_i_join_16_9 <= true;
      count_i_join_16_9 <= std_logic_vector_to_unsigned("00000000000");
    else 
      count_en_i_join_16_9 <= count_en_i_join_20_13;
      count_i_join_16_9 <= count_i_join_8_5;
    end if;
  end process proc_if_16_9;
  rel_12_8 <= rst_1_40 = true;
  proc_if_12_5: process (count_en_i_join_16_9, count_i_join_16_9, count_i_join_8_5, rel_12_8)
  is
  begin
    if rel_12_8 then
      count_en_i_join_12_5_rst <= '1';
    else 
      count_en_i_join_12_5_rst <= '0';
    end if;
    count_en_i_join_12_5 <= count_en_i_join_16_9;
    if rel_12_8 then
      count_i_join_12_5 <= count_i_join_8_5;
    else 
      count_i_join_12_5 <= count_i_join_16_9;
    end if;
  end process proc_if_12_5;
  count_en_i_3_28_next <= count_en_i_join_16_9;
  count_en_i_3_28_rst <= count_en_i_join_12_5_rst;
  cast_count_i_4_25_next <= u2u_cast(count_i_join_12_5, 0, 10, 0);
  count_i_4_25_next <= cast_count_i_4_25_next;
  y <= boolean_to_vector(count_en_i_3_28);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_56dc5679ac is
  port (
    input_port : in std_logic_vector((1 - 1) downto 0);
    output_port : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_56dc5679ac;
architecture behavior of sysgen_reinterpret_56dc5679ac
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

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_1b1787ae46 is
  port (
    x_in : in std_logic_vector((16 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    xmax : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_1b1787ae46;
architecture behavior of sysgen_mcode_block_1b1787ae46
is
  signal x_in_1_29: signed((16 - 1) downto 0);
  signal rst_1_35: boolean;
  signal xmax_i_2_24_next: signed((16 - 1) downto 0);
  signal xmax_i_2_24: signed((16 - 1) downto 0) := "0000000000000000";
  signal xmax_i_2_24_rst: std_logic;
  signal rel_9_12: boolean;
  signal xmax_i_join_9_9: signed((16 - 1) downto 0);
  signal rel_6_8: boolean;
  signal xmax_i_join_6_5: signed((16 - 1) downto 0);
  signal xmax_i_join_6_5_rst: std_logic;
begin
  x_in_1_29 <= std_logic_vector_to_signed(x_in);
  rst_1_35 <= ((rst) = "1");
  proc_xmax_i_2_24: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (xmax_i_2_24_rst = '1')) then
        xmax_i_2_24 <= "0000000000000000";
      elsif (ce = '1') then 
        xmax_i_2_24 <= xmax_i_2_24_next;
      end if;
    end if;
  end process proc_xmax_i_2_24;
  rel_9_12 <= x_in_1_29 > xmax_i_2_24;
  proc_if_9_9: process (rel_9_12, x_in_1_29, xmax_i_2_24)
  is
  begin
    if rel_9_12 then
      xmax_i_join_9_9 <= x_in_1_29;
    else 
      xmax_i_join_9_9 <= xmax_i_2_24;
    end if;
  end process proc_if_9_9;
  rel_6_8 <= rst_1_35 = true;
  proc_if_6_5: process (rel_6_8, xmax_i_join_9_9)
  is
  begin
    if rel_6_8 then
      xmax_i_join_6_5_rst <= '1';
    else 
      xmax_i_join_6_5_rst <= '0';
    end if;
    xmax_i_join_6_5 <= xmax_i_join_9_9;
  end process proc_if_6_5;
  xmax_i_2_24_next <= xmax_i_join_9_9;
  xmax_i_2_24_rst <= xmax_i_join_6_5_rst;
  xmax <= signed_to_std_logic_vector(xmax_i_2_24);
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


entity peak_detector_xlslice is
    generic (
        new_msb      : integer := 9;           -- position of new msb
        new_lsb      : integer := 1;           -- position of new lsb
        x_width      : integer := 16;          -- Width of x input
        y_width      : integer := 8);          -- Width of y output
    port (
        x : in std_logic_vector (x_width-1 downto 0);
        y : out std_logic_vector (y_width-1 downto 0));
end peak_detector_xlslice;

architecture behavior of peak_detector_xlslice is
begin
    y <= x(new_msb downto new_lsb);
end  behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_constant_490670a1f6 is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_490670a1f6;
architecture behavior of sysgen_constant_490670a1f6
is
begin
  op <= "0000000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_3383358711 is
  port (
    x_p : in std_logic_vector((16 - 1) downto 0);
    x_m : in std_logic_vector((16 - 1) downto 0);
    count_m : in std_logic_vector((10 - 1) downto 0);
    rst : in std_logic_vector((1 - 1) downto 0);
    pulse_acc : out std_logic_vector((1 - 1) downto 0);
    dbg_count : out std_logic_vector((10 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_3383358711;
architecture behavior of sysgen_mcode_block_3383358711
is
  signal x_p_1_52: signed((16 - 1) downto 0);
  signal x_m_1_57: signed((16 - 1) downto 0);
  signal count_m_1_62: signed((10 - 1) downto 0);
  signal rst_1_71: boolean;
  signal pulse_acc_i_3_29_next: boolean;
  signal pulse_acc_i_3_29: boolean := false;
  signal count_i_4_25_next: unsigned((10 - 1) downto 0);
  signal count_i_4_25: unsigned((10 - 1) downto 0) := "0000000000";
  signal count_i_4_25_rst: std_logic;
  signal cast_10_8: signed((11 - 1) downto 0);
  signal cast_10_18: signed((11 - 1) downto 0);
  signal rel_10_8: boolean;
  signal pulse_acc_i_join_10_5: boolean;
  signal cast_21_23: unsigned((11 - 1) downto 0);
  signal count_i_21_13_addsub: unsigned((11 - 1) downto 0);
  signal rel_20_13: boolean;
  signal count_i_join_20_9: unsigned((11 - 1) downto 0);
  signal rel_16_8: boolean;
  signal count_i_join_16_5: unsigned((11 - 1) downto 0);
  signal count_i_join_16_5_rst: std_logic;
  signal cast_count_i_4_25_next: unsigned((10 - 1) downto 0);
begin
  x_p_1_52 <= std_logic_vector_to_signed(x_p);
  x_m_1_57 <= std_logic_vector_to_signed(x_m);
  count_m_1_62 <= std_logic_vector_to_signed(count_m);
  rst_1_71 <= ((rst) = "1");
  proc_pulse_acc_i_3_29: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if (ce = '1') then
        pulse_acc_i_3_29 <= pulse_acc_i_3_29_next;
      end if;
    end if;
  end process proc_pulse_acc_i_3_29;
  proc_count_i_4_25: process (clk)
  is
  begin
    if (clk'event and (clk = '1')) then
      if ((ce = '1') and (count_i_4_25_rst = '1')) then
        count_i_4_25 <= "0000000000";
      elsif (ce = '1') then 
        count_i_4_25 <= count_i_4_25_next;
      end if;
    end if;
  end process proc_count_i_4_25;
  cast_10_8 <= u2s_cast(count_i_4_25, 0, 11, 0);
  cast_10_18 <= s2s_cast(count_m_1_62, 0, 11, 0);
  rel_10_8 <= cast_10_8 > cast_10_18;
  proc_if_10_5: process (rel_10_8)
  is
  begin
    if rel_10_8 then
      pulse_acc_i_join_10_5 <= true;
    else 
      pulse_acc_i_join_10_5 <= false;
    end if;
  end process proc_if_10_5;
  cast_21_23 <= u2u_cast(count_i_4_25, 0, 11, 0);
  count_i_21_13_addsub <= cast_21_23 + std_logic_vector_to_unsigned("00000000001");
  rel_20_13 <= x_p_1_52 > x_m_1_57;
  proc_if_20_9: process (count_i_21_13_addsub, count_i_4_25, rel_20_13)
  is
  begin
    if rel_20_13 then
      count_i_join_20_9 <= count_i_21_13_addsub;
    else 
      count_i_join_20_9 <= u2u_cast(count_i_4_25, 0, 11, 0);
    end if;
  end process proc_if_20_9;
  rel_16_8 <= rst_1_71 = true;
  proc_if_16_5: process (count_i_join_20_9, rel_16_8)
  is
  begin
    if rel_16_8 then
      count_i_join_16_5_rst <= '1';
    else 
      count_i_join_16_5_rst <= '0';
    end if;
    count_i_join_16_5 <= count_i_join_20_9;
  end process proc_if_16_5;
  pulse_acc_i_3_29_next <= pulse_acc_i_join_10_5;
  cast_count_i_4_25_next <= u2u_cast(count_i_join_16_5, 0, 10, 0);
  count_i_4_25_next <= cast_count_i_4_25_next;
  count_i_4_25_rst <= count_i_join_16_5_rst;
  pulse_acc <= boolean_to_vector(pulse_acc_i_3_29);
  dbg_count <= unsigned_to_std_logic_vector(count_i_4_25);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_651d1f2bea is
  port (
    input_port : in std_logic_vector((10 - 1) downto 0);
    output_port : out std_logic_vector((10 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_651d1f2bea;
architecture behavior of sysgen_reinterpret_651d1f2bea
is
  signal input_port_1_40: unsigned((10 - 1) downto 0);
  signal output_port_5_5_force: signed((10 - 1) downto 0);
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
entity sysgen_constant_02102ce1a2 is
  port (
    op : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_02102ce1a2;
architecture behavior of sysgen_constant_02102ce1a2
is
begin
  op <= "0111111111111111";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_c0c21a113c is
  port (
    d0 : in std_logic_vector((1 - 1) downto 0);
    d1 : in std_logic_vector((1 - 1) downto 0);
    d2 : in std_logic_vector((1 - 1) downto 0);
    d3 : in std_logic_vector((1 - 1) downto 0);
    y : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_c0c21a113c;
architecture behavior of sysgen_logical_c0c21a113c
is
  signal d0_1_24: std_logic_vector((1 - 1) downto 0);
  signal d1_1_27: std_logic_vector((1 - 1) downto 0);
  signal d2_1_30: std_logic_vector((1 - 1) downto 0);
  signal d3_1_33: std_logic_vector((1 - 1) downto 0);
  type array_type_latency_pipe_5_26 is array (0 to (1 - 1)) of std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26: array_type_latency_pipe_5_26 := (
    0 => "0");
  signal latency_pipe_5_26_front_din: std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26_back: std_logic_vector((1 - 1) downto 0);
  signal latency_pipe_5_26_push_front_pop_back_en: std_logic;
  signal fully_2_1_bit: std_logic_vector((1 - 1) downto 0);
begin
  d0_1_24 <= d0;
  d1_1_27 <= d1;
  d2_1_30 <= d2;
  d3_1_33 <= d3;
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
  fully_2_1_bit <= d0_1_24 and d1_1_27 and d2_1_30 and d3_1_33;
  latency_pipe_5_26_front_din <= fully_2_1_bit;
  latency_pipe_5_26_push_front_pop_back_en <= '1';
  y <= latency_pipe_5_26_back;
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_mcode_block_6672ae6d55 is
  port (
    x : in std_logic_vector((16 - 1) downto 0);
    y : in std_logic_vector((16 - 1) downto 0);
    z : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_mcode_block_6672ae6d55;
architecture behavior of sysgen_mcode_block_6672ae6d55
is
  signal x_1_20: signed((16 - 1) downto 0);
  signal y_1_23: signed((16 - 1) downto 0);
  signal rel_3_6: boolean;
  signal z_join_3_3: signed((16 - 1) downto 0);
begin
  x_1_20 <= std_logic_vector_to_signed(x);
  y_1_23 <= std_logic_vector_to_signed(y);
  rel_3_6 <= x_1_20 > y_1_23;
  proc_if_3_3: process (rel_3_6, x_1_20, y_1_23)
  is
  begin
    if rel_3_6 then
      z_join_3_3 <= y_1_23;
    else 
      z_join_3_3 <= x_1_20;
    end if;
  end process proc_if_3_3;
  z <= signed_to_std_logic_vector(z_join_3_3);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_44eeae6177 is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_44eeae6177;
architecture behavior of sysgen_relational_44eeae6177
is
  signal a_1_31: signed((16 - 1) downto 0);
  signal b_1_34: signed((16 - 1) downto 0);
  signal result_20_3_rel: boolean;
  signal dout_28_3_convert: unsigned((1 - 1) downto 0);
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
  result_20_3_rel <= a_1_31 <= b_1_34;
  dout_28_3_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(result_20_3_rel)), 0, 1, 0);
  op <= unsigned_to_std_logic_vector(dout_28_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_relational_5cd29e6abc is
  port (
    a : in std_logic_vector((16 - 1) downto 0);
    b : in std_logic_vector((16 - 1) downto 0);
    op : out std_logic_vector((1 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_relational_5cd29e6abc;
architecture behavior of sysgen_relational_5cd29e6abc
is
  signal a_1_31: signed((16 - 1) downto 0);
  signal b_1_34: signed((16 - 1) downto 0);
  signal result_22_3_rel: boolean;
  signal dout_28_3_convert: unsigned((1 - 1) downto 0);
begin
  a_1_31 <= std_logic_vector_to_signed(a);
  b_1_34 <= std_logic_vector_to_signed(b);
  result_22_3_rel <= a_1_31 >= b_1_34;
  dout_28_3_convert <= u2u_cast(std_logic_vector_to_unsigned(boolean_to_vector(result_22_3_rel)), 0, 1, 0);
  op <= unsigned_to_std_logic_vector(dout_28_3_convert);
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_reinterpret_bae48be5e4 is
  port (
    input_port : in std_logic_vector((16 - 1) downto 0);
    output_port : out std_logic_vector((16 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_bae48be5e4;
architecture behavior of sysgen_reinterpret_bae48be5e4
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
entity sysgen_constant_4171fa8991 is
  port (
    op : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_constant_4171fa8991;
architecture behavior of sysgen_constant_4171fa8991
is
begin
  op <= "10000000000000";
end behavior;

library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity sysgen_logical_38a5424d30 is
  port (
    d0 : in std_logic_vector((14 - 1) downto 0);
    d1 : in std_logic_vector((14 - 1) downto 0);
    y : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_logical_38a5424d30;
architecture behavior of sysgen_logical_38a5424d30
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
entity sysgen_reinterpret_49837bee95 is
  port (
    input_port : in std_logic_vector((14 - 1) downto 0);
    output_port : out std_logic_vector((14 - 1) downto 0);
    clk : in std_logic;
    ce : in std_logic;
    clr : in std_logic);
end sysgen_reinterpret_49837bee95;
architecture behavior of sysgen_reinterpret_49837bee95
is
  signal input_port_1_40: signed((14 - 1) downto 0);
  signal output_port_5_5_force: unsigned((14 - 1) downto 0);
begin
  input_port_1_40 <= std_logic_vector_to_signed(input_port);
  output_port_5_5_force <= signed_to_unsigned(input_port_1_40);
  output_port <= unsigned_to_std_logic_vector(output_port_5_5_force);
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

entity peak_detector_xlcmult is 
   generic (
     core_name0: string := "";
     a_width: integer := 4;
     a_bin_pt: integer := 2;
     a_arith: integer := xlSigned;
     b_width: integer := 4;
     b_bin_pt: integer := 2;
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
     multsign: integer := xlSigned;
     quantization: integer := xlTruncate;
     overflow: integer := xlWrap;
     extra_registers: integer := 0;
     c_a_width: integer := 7;
     c_b_width: integer := 7;
     c_a_type: integer := 0;
     c_b_type: integer := 0;
     c_type: integer := 0;
     const_bin_pt: integer := 1;
     zero_const : integer := 0;
     c_output_width: integer := 16
   );
   port (
     a: in std_logic_vector(a_width - 1 downto 0);
     ce: in std_logic;
     clr: in std_logic;
     clk: in std_logic;
     core_ce: in std_logic:= '0';
     core_clr: in std_logic:= '0';
     core_clk: in std_logic:= '0';
     rst: in std_logic_vector(rst_width - 1 downto 0);
     en: in std_logic_vector(en_width - 1 downto 0);
     p: out std_logic_vector(p_width - 1 downto 0)
   );
 end peak_detector_xlcmult;
 
 architecture behavior of peak_detector_xlcmult is
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
 signal tmp_a: std_logic_vector(c_a_width - 1 downto 0);
 signal tmp_p: std_logic_vector(c_output_width - 1 downto 0);
 signal conv_p: std_logic_vector(p_width - 1 downto 0);
 -- synthesis translate_off
 signal real_a, real_p: real;
 -- synthesis translate_on
 signal nd: std_logic;
 signal internal_ce: std_logic;
 signal internal_clr: std_logic;
 signal internal_core_ce: std_logic;


 component peak_detector_mult_gen_v12_0_i0
    port ( 
      clk: in std_logic;
      ce: in std_logic;
      sclr: in std_logic;
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

 component peak_detector_mult_gen_v12_0_i1
    port ( 
      p: out std_logic_vector(c_output_width - 1 downto 0);
      a: in std_logic_vector(c_a_width - 1 downto 0) 
 		  ); 
 end component;

begin
 -- synthesis translate_off
 -- synthesis translate_on
 input_process: process(a)
 variable tmp_p_bin_pt, tmp_p_arith: integer;
 begin
 tmp_a <= zero_ext(a, c_a_width);
 end process;
 output_process: process(tmp_p)
 begin
 conv_p <= convert_type(tmp_p, c_output_width, a_bin_pt+b_bin_pt, multsign,
 p_width, p_bin_pt, p_arith, quantization, overflow);
 end process;
 internal_ce <= ce and en(0);
 internal_core_ce <= core_ce and en(0);
 internal_clr <= (clr or rst(0)) and ce;
 nd <= internal_ce;


 comp0: if ((core_name0 = "peak_detector_mult_gen_v12_0_i0")) generate 
  core_instance0:peak_detector_mult_gen_v12_0_i0
   port map ( 
      sclr => internal_clr,
      clk => clk,
      ce => internal_ce,
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

 comp1: if ((core_name0 = "peak_detector_mult_gen_v12_0_i1")) generate 
  core_instance1:peak_detector_mult_gen_v12_0_i1
   port map ( 
      p => tmp_p,
      a => tmp_a
  ); 
   end generate;

latency_gt_0: if (extra_registers > 0) and (zero_const = 0)
 generate
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
 latency0: if ( (extra_registers = 0) and (zero_const = 0) )
 generate
 p <= conv_p;
 end generate latency0;
 zero_constant: if (zero_const = 1)
 generate
 p <= integer_to_std_logic_vector(0,p_width,p_arith);
 end generate zero_constant;
 end architecture behavior;

