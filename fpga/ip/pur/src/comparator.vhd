----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2019 04:55:28 PM
-- Design Name: 
-- Module Name: comparator - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--
-- Unsigned N-Bit Window Comparator
--
entity comparator is
    generic(DATA_WIDTH : integer :=16);
    
	port(  a, b : in std_logic_vector(DATA_WIDTH-1 downto 0);
	       cmp : out std_logic);
end comparator;

architecture Behavioral of comparator is
begin
	cmp <= '1' when a = b else '0';
end Behavioral;

