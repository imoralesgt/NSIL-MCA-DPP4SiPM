----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09/24/2019 06:59:15 PM
-- Design Name: 
-- Module Name: fsm_auto_mode - Behavioral
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

entity fsm_auto_mode is
    port ( auto_start, tc, clk : in std_logic;
           clr, en, bram_seg : out std_logic);
end fsm_auto_mode;

architecture Behavioral of fsm_auto_mode is

--Insert the following in the architecture before the begin keyword
   --Use descriptive names for the states, like st1_reset, st2_search
   type state_type is (st1_idle, st2_clear, st3_count);
   signal state, next_state : state_type;
   --Declare internal signals for all outputs of the state-machine
   signal bram_seg_i, en_i, clr_i, tff_t, tff_clk : std_logic;
   --other outputs

   component t_ff
      port(  t, clk, rst: in std_logic;
             q : out std_logic);  
   end component; 
     
begin

    clr <= clr_i;
    en <= en_i;
    bram_seg <= bram_seg_i;
    
--instantiate t-flip flop
--for every new run (preset is reached), BRAMSEG is toggled
--this means that data is swapped between two BRAM memory segments
t_ff_inst: t_ff
	port map(t=>tff_t, clk=>tff_clk, rst=>auto_start, q=>bram_seg_i);


--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (clk, auto_start)
   begin
      if (clk'event and clk = '1') then
         if (auto_start = '0') then
            state <= st1_idle;
         else
            state <= next_state;
         -- assign other outputs to internal signals
         end if;
      end if;
   end process;

   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state)
   begin
      --insert statements to decode internal output signals
      --below is simple example
      if state = st1_idle then
         clr_i <= '0';
		 en_i <= '0';
		 tff_t <= '0';
		 tff_clk <= '0';
      elsif state = st2_clear then
         clr_i <= '1';
		 en_i <= '0';
		 tff_t <= '1';
		 tff_clk <= '0';		 
      elsif state = st3_count then
         clr_i <= '0';
		 en_i <= '1';
		 tff_t <= '1';
		 tff_clk <= '1';		 
      else
         clr_i <= '0';
		 en_i <= '0';
		 tff_t <= '0';
		 tff_clk <= '0';		 
      end if;
   end process;

   NEXT_STATE_DECODE: process (state, tc)
   begin
      --declare default state for next_state to avoid latches
      next_state <= state;  --default is to stay in current state
      --insert statements to decode next_state
      --below is a simple example
      case (state) is
         when st1_idle =>
               next_state <= st2_clear;
         when st2_clear =>
               next_state <= st3_count;
         when st3_count =>
            if tc = '1' then
               next_state <= st2_clear;
            end if;
         when others =>
            next_state <= st1_idle;
      end case;
   end process;	
--	
-- end auto-measurement state machine
--

end Behavioral;
