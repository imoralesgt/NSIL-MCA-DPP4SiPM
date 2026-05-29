----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/26/2021 10:10:31 AM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
    Port ( r1_preset : in STD_LOGIC_VECTOR (31 downto 0);
           r2_flags : in STD_LOGIC_VECTOR (31 downto 0);
           r3_delay : in STD_LOGIC_VECTOR (31 downto 0);
           
           r1_preset_out : out STD_LOGIC_VECTOR (31 downto 0);
           r2_flags_out : out STD_LOGIC_VECTOR (31 downto 0);
           r3_delay_out : out STD_LOGIC_VECTOR (31 downto 0));
end top;

architecture Behavioral of top is
 
begin

   r1_preset_out <= r1_preset;
   r2_flags_out <= r2_flags;
   r3_delay_out <= r3_delay;

end Behavioral;
