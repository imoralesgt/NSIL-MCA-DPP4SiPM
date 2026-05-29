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
    Port ( r1_b0 : in STD_LOGIC_VECTOR (31 downto 0);
           r2_na_inv : in STD_LOGIC_VECTOR (31 downto 0);
           r3_na : in STD_LOGIC_VECTOR (31 downto 0);
           r4_nb : in STD_LOGIC_VECTOR (31 downto 0);
           r5_b20 : in STD_LOGIC_VECTOR (31 downto 0);
           r6_dc_offset_1 : in STD_LOGIC_VECTOR (31 downto 0);
           r7_b2 : in STD_LOGIC_VECTOR (31 downto 0);
           r8_b1 : in STD_LOGIC_VECTOR (31 downto 0);
           r9_aa20 : in STD_LOGIC_VECTOR (31 downto 0);
           r10_flags : in STD_LOGIC_VECTOR (31 downto 0);
           r11_dc_offset_2 : in STD_LOGIC_VECTOR (31 downto 0);
           
           r1_b0_out : out STD_LOGIC_VECTOR (31 downto 0);
           r2_na_inv_out : out STD_LOGIC_VECTOR (31 downto 0);
           r3_na_out : out STD_LOGIC_VECTOR (31 downto 0);
           r4_nb_out : out STD_LOGIC_VECTOR (31 downto 0);
           r5_b20_out : out STD_LOGIC_VECTOR (31 downto 0);
           r6_dc_offset_1_out : out STD_LOGIC_VECTOR (31 downto 0);
           r7_b2_out : out STD_LOGIC_VECTOR (31 downto 0);
           r8_b1_out : out STD_LOGIC_VECTOR (31 downto 0);
           r9_aa20_out : out STD_LOGIC_VECTOR (31 downto 0);
           r10_flags_out : out STD_LOGIC_VECTOR (31 downto 0);
           r11_dc_offset_2_out : out STD_LOGIC_VECTOR (31 downto 0));
end top;

architecture Behavioral of top is
 
begin

   r1_b0_out <= r1_b0;
   r2_na_inv_out <= r2_na_inv;
   r3_na_out <= r3_na;
   r4_nb_out <= r4_nb;
   r5_b20_out <= r5_b20;
   r6_dc_offset_1_out <= r6_dc_offset_1;
   r7_b2_out <= r7_b2;
   r8_b1_out <= r8_b1;
   r9_aa20_out <= r9_aa20;
   r10_flags_out <= r10_flags;
   r11_dc_offset_2_out <= r11_dc_offset_2;

end Behavioral;
