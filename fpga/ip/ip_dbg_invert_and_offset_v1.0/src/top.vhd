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
    Port ( adc_data: in STD_LOGIC_VECTOR (13 downto 0);
           outp : in STD_LOGIC_VECTOR (15 downto 0);
           
           adc_data_out : out STD_LOGIC_VECTOR (15 downto 0);
           outp_out : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is
 
begin

   adc_data_out <= adc_data(13)&adc_data(13 downto 0)&'0';
   outp_out <= outp;
   
end Behavioral;
