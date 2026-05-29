----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/10/2020 05:19:34 PM
-- Design Name: 
-- Module Name: led_driver - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity led_driver is
    Port ( clk : in STD_LOGIC;
           led : out STD_LOGIC);
end led_driver;

architecture Behavioral of led_driver is
	signal tmp1 : unsigned(27 downto 0):=x"0000000";
	signal tmp2 : std_logic := '0';
	constant DIVISOR: unsigned(27 downto 0):= x"2FAF07F"; --49999999, for clk=50MHz and 1 sec blink

begin

	clock_proc: process(clk)
	begin
	  if(rising_edge(clk)) then
		if(tmp1 = DIVISOR) then
			tmp1 <= x"0000000";
			tmp2 <= not tmp2;
		else
			tmp1 <= tmp1 + 1;
        end if;
      end if;    
	end process;

	led <= tmp2;

end Behavioral;



