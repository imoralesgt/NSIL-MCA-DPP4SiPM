----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/16/2020 07:31:41 PM
-- Design Name: 
-- Module Name: 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

package pur_pkg is 
    type vector16_array is array (natural range <>) of std_logic_vector(15 downto 0);
    type vector32_array is array (natural range <>) of std_logic_vector(31 downto 0);
    
    component counter
        generic(DATA_WIDTH : integer :=32);
        port(  clk, clr, ce : in std_logic;
               q : out std_logic_vector(DATA_WIDTH-1 downto 0));
    end component;
    
    component comparator
        generic(DATA_WIDTH : integer :=16);
        
        port(  a, b : in std_logic_vector(DATA_WIDTH-1 downto 0);
               cmp : out std_logic);
    end component;   

    component r_edge_trigger
        port ( clk : in std_logic;
               x : in std_logic;
               trigger : out std_logic);
    end component;
 
    component pur is
        generic(PUR_COUNTER_WIDTH : integer :=8);
        port ( clk : in std_logic;
               reset_n : in std_logic;
               amp_rdy : in std_logic;
               pur_en : in std_logic;
               pur_preset : in std_logic_vector (PUR_COUNTER_WIDTH-1 downto 0);
               reject_n : out std_logic;
               lt_dir : out std_logic_vector(1 downto 0));
    end component;      
    
end package pur_pkg;
