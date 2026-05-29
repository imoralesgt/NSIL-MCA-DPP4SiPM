----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2019 05:38:48 PM
-- Design Name: 
-- Module Name: t_ff - Behavioral
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

entity t_ff is
	port ( t, clk, rst: in std_logic;
	       q : out std_logic
	);
end t_ff;
	
architecture Behavioral of t_ff is
	signal temp: std_logic := '0';
begin
	process (clk, t, rst)
	begin
	   if (clk'event and clk='1') then
		  if rst='0' then
			 temp <= '0';
		  else
			 temp <= t xor temp;
		  end if;
	   end if;
	end process;
	q <= temp;
	
end Behavioral;
