----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2019 05:17:18 PM
-- Design Name: 
-- Module Name: counter - Behavioral
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

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--
-- Unsigned Up Counter with Asynchronous Reset and Clock Enable
--
entity counter is
    generic(DATA_WIDTH : integer :=32);
	port(  clk, clr, ce : in std_logic;
	       q : out std_logic_vector(DATA_WIDTH-1 downto 0));
end counter;
	    
architecture Behavioral of counter is
	signal tmp: std_logic_vector(DATA_WIDTH-1 downto 0);
begin
	process (clk, clr, ce)
	begin
		if (clr='1') then
			tmp <= (others => '0');
		elsif (clk'event and clk='1') then
			if (ce='1') then
				tmp <= tmp + 1;
			end if;
		end if;
	end process;
	Q <= tmp;
end Behavioral;