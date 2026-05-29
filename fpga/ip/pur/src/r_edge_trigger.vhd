----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2020 08:54:28 AM
-- Design Name: 
-- Module Name: rf_edge_trigger - Behavioral
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

entity r_edge_trigger is
    Port ( clk : in std_logic;
           x : in std_logic;
           trigger : out std_logic);
end r_edge_trigger;

architecture Behavioral of r_edge_trigger is

    signal x_meta : std_logic;
    signal x_last : std_logic;
    signal x_current : std_logic;

begin

    --step 1. sync x with clock (if already sync then process cn be replaced with 'x_current <= x')
    process (clk) is
        begin
            if rising_edge(clk) then
              x_meta <= x;
              x_current <= x_meta;
        end if;
    end process;
    
    --step 2. delay the current value 'x_current' by one clock cycle.
    x_last <= x_current when rising_edge(clk);
    
    --step 3. detect changes '0' (last) to '1' (current)
    process(x_current, x_last)
    begin
        if    (x_current = '1' and x_last = '0') then
            trigger <= '1';
        else
            trigger <= '0';
        end if;    
    end process;

end Behavioral;
