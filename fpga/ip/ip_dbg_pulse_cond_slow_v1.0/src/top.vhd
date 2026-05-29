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
    Port ( impulse : in STD_LOGIC_VECTOR (15 downto 0);
           rect : in STD_LOGIC_VECTOR (15 downto 0);
           shaper : in STD_LOGIC_VECTOR (15 downto 0);
           blr : in STD_LOGIC_VECTOR (15 downto 0);
           dc_stab : in STD_LOGIC_VECTOR (15 downto 0);
           dc_stab_acc : in STD_LOGIC_VECTOR (15 downto 0);
           
           impulse_out : out STD_LOGIC_VECTOR (15 downto 0);
           rect_out : out STD_LOGIC_VECTOR (15 downto 0);
           shaper_out : out STD_LOGIC_VECTOR (15 downto 0);
           blr_out : out STD_LOGIC_VECTOR (15 downto 0);
           dc_stab_out : out STD_LOGIC_VECTOR (15 downto 0);
           dc_stab_acc_out : out STD_LOGIC_VECTOR (15 downto 0));
end top;

architecture Behavioral of top is
 
begin

   impulse_out <= impulse;
   rect_out <= rect;
   shaper_out <= shaper;
   blr_out <= blr;
   dc_stab_out <= dc_stab;
   dc_stab_acc_out <= dc_stab_acc;

end Behavioral;
