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
    Port (           
           peak_amp_rdy_fast_out : out STD_LOGIC_VECTOR (15 downto 0);
           rejectn_out : out STD_LOGIC_VECTOR (15 downto 0);
           peak_amp_rdy_slow_out : out STD_LOGIC_VECTOR (15 downto 0);
           peak_det_signal_out : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is
 
begin

   peak_det_signal_out <= "0000000000000000";
   
   peak_amp_rdy_slow_out <= "0000000000000000";
   peak_amp_rdy_fast_out <= "0000000000000000";
   rejectn_out           <= "0000000000000000";
   
   
   

end Behavioral;
