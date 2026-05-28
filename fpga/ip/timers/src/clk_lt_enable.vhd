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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;


--
-- Unsigned Up Counter with Asynchronous Reset and Clock Enable
--
entity clk_lt_enable is
	port(  clk, clr, ce: in std_logic;
           dir : in std_logic_vector(1 downto 0);
           lt_clk_en : out std_logic);
end clk_lt_enable;
	    
architecture Behavioral of clk_lt_enable is
    signal lt_clk_en_i : std_logic; 
	signal tmp : signed(16 downto 0):="00000000000000000";
	constant DIVISOR : signed(16 downto 0):= "01100001101001111"; 
	--"00100100100111101111"; 149999 for clk=50MHz; formula:  3 x clock_period-1 


begin
    
    lt_clk_en <= lt_clk_en_i;

	process (clk, clr, ce)
	begin
		if (clr='1') then--or tmp >= DIVISOR) then
			tmp <= (others => '0');
            lt_clk_en_i <= '0';
		elsif (clk'event and clk='1') then
           if (tmp >= DIVISOR) then
			   tmp <= (others => '0');
			   lt_clk_en_i <= '1';
		   elsif (ce='1') then
		      lt_clk_en_i <= '0';

-- use below lines to measure live time  
              if( dir = "00") then  
                 tmp <= tmp + 1; --tmp <= tmp ;                           -- IDLE:    add 0  
              elsif (dir = "01") then --BUSY
                 tmp <= tmp - 1;   -- BUSY:    add 1   
              else  --PILE-UP
                 tmp <= tmp - 1;   -- PILE-UP: add 2 
              end if;

-- use below lines to measure dead time		      
--              if( dir = "00") then
--                 --tmp <= tmp + X"0001"; -- GH logic: count forward (in -1,0,1 pattern)
--                 tmp <= tmp;                         -- new logic: add 0 (do not count)  
--              elsif (dir = "01") then
--                 --tmp <= tmp - "0001";  -- count backward (in -1,0,1 pattern) 
--                 tmp <= tmp + "00000000000000000010";   --new logic: add 2  
--              else
--                 --tmp <= tmp ;          -- don't count (in -1,0,1 pattern)
--                 tmp <= tmp + "00000000000000000001";   -- new logic add 1 
--              end if;
		      --end if;
			end if;
		end if;
	end process;

end Behavioral;