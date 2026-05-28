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
    Port ( r1_threshold : in STD_LOGIC_VECTOR (31 downto 0);
           r2_flags : in STD_LOGIC_VECTOR (31 downto 0);
           r3_threshold_gain : in STD_LOGIC_VECTOR (31 downto 0);
           r4_preset : in STD_LOGIC_VECTOR (31 downto 0);
           r5_b0 : in STD_LOGIC_VECTOR (31 downto 0);
           r6_a1 : in STD_LOGIC_VECTOR (31 downto 0);
           r7_threshold_low_gain : in STD_LOGIC_VECTOR (31 downto 0);
           
           r1_threshold_out : out STD_LOGIC_VECTOR (31 downto 0);
           r2_flags_out : out STD_LOGIC_VECTOR (31 downto 0);
           r3_threshold_gain_out : out STD_LOGIC_VECTOR (31 downto 0);
           r4_preset_out : out STD_LOGIC_VECTOR (31 downto 0);
           r5_b0_out : out STD_LOGIC_VECTOR (31 downto 0);
           r6_a1_out : out STD_LOGIC_VECTOR (31 downto 0);
           r7_threshold_low_gain_out : out STD_LOGIC_VECTOR (31 downto 0));
end top;

architecture Behavioral of top is
 
begin

   r1_threshold_out <= r1_threshold;
   r2_flags_out <= r2_flags;
   r3_threshold_gain_out <= r3_threshold_gain;
   r4_preset_out <= r4_preset;
   r5_b0_out <= r5_b0;
   r6_a1_out <= r6_a1;
   r7_threshold_low_gain_out <= r7_threshold_low_gain;

end Behavioral;
