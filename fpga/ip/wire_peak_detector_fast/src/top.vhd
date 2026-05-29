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
    Port ( r1_blanking_time : in STD_LOGIC_VECTOR (31 downto 0);
           r2_time_over_threshold : in STD_LOGIC_VECTOR (31 downto 0);
           r3_xmin : in STD_LOGIC_VECTOR (31 downto 0);
           r4_xmax : in STD_LOGIC_VECTOR (31 downto 0);
           r5_flags : in STD_LOGIC_VECTOR (31 downto 0);
                     
           r1_blanking_time_out : out STD_LOGIC_VECTOR (31 downto 0);
           r2_time_over_threshold_out : out STD_LOGIC_VECTOR (31 downto 0);
           r3_xmin_out : out STD_LOGIC_VECTOR (31 downto 0);
           r4_xmax_out : out STD_LOGIC_VECTOR (31 downto 0);
           r5_flags_out : out STD_LOGIC_VECTOR (31 downto 0));
end top;

architecture Behavioral of top is
 
begin

   r1_blanking_time_out <= r1_blanking_time;
   r2_time_over_threshold_out <= r2_time_over_threshold;
   r3_xmin_out <= r3_xmin;
   r4_xmax_out <= r4_xmax;
   r5_flags_out <= r5_flags;

end Behavioral;
