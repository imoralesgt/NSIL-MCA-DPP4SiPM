----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/14/2020 12:41:31 PM
-- Design Name: 
-- Module Name: ip_pur_fsm - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
--   Initially, the module is in IDLE state and reject_n is not active (high).
--   On the rising edge of the input signal 'amp_rdy', internal signal 'trigger' is pulsed (its duration is 1 clock) and
--   module goes into the BUSY state. In the BUSY state a guarding timer is started and running. The timer measures guarding time, 
--   which is defined by the input port 'pur_preset'. During the guarding time system can not accept any new amp_rdy signals.
--   Also the signal which initiated transition into the BUSY state, must be rejeced. In the BUSY state reject_n is kept inactive (high)
--   If the guarding time elapses before new trigger arrives (new amp_rdy), then module goes back into the IDLE state.
--   If new trigger arrives before guarding time elapses (new amp_rdy), then the guarding timer is restarted and module goes into the PILE_UP state.
--   In the PILE_UP state, reject is kept active (low). If any new trigger arrives, then guarding timer is restarted (time is measured from 0). 
--   From the PIL_UP state, the module can go only into the IDLE state when guarding time elapses (timer reaching pur_preset). 
--   The module can be disabled (reject_n is keept highall time) if input port r2_flags is low.  
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
use IEEE.NUMERIC_STD.ALL;
use work.pur_pkg.all;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pur is
    generic(PUR_COUNTER_WIDTH : integer :=8);
    port ( clk : in std_logic;
           reset_n : in std_logic;
           amp_rdy : in std_logic;
           r2_flags : in std_logic_vector(31 downto 0);
           r1_preset : in std_logic_vector(31 downto 0); 
           reject_n : out std_logic;
           lt_dir : out std_logic_vector(1 downto 0));
end pur;

architecture Behavioral of pur is
    TYPE state_type IS (IDLE, BUSY, PILE_UP);
    SIGNAL sm_current_state, sm_next_state :  state_type;
    signal trigger : std_logic;
    signal counter_terminal_count : std_logic;
    signal counter_out : std_logic_vector( PUR_COUNTER_WIDTH-1 downto 0);
    signal sm_reject_n : std_logic;
    signal sm_counter_en : std_logic;
    signal sm_counter_clr : std_logic;
    signal sm_lt_dir : std_logic_vector(1 downto 0);
    signal pur_en : std_logic;
    signal pur_preset : std_logic_vector (PUR_COUNTER_WIDTH-1 downto 0);
begin
    pur_en <= r2_flags(0);
    pur_preset <= r1_preset (PUR_COUNTER_WIDTH-1 downto 0);
    
    reject_n <= sm_reject_n; -- or (not pur_en);
    lt_dir <= sm_lt_dir;
    
-- sequential current state process and registered outputs
current_state_process: process (clk, reset_n)
    begin
        if(reset_n = '0') then
            sm_current_state <= IDLE ;
        elsif(rising_edge(clk))then
            sm_current_state <= sm_next_state;
        end if;
    end process current_state_process;
    
-- combinatorial next-state logic
next_state_process:process(sm_current_state, trigger, counter_terminal_count,pur_en)
begin
    sm_next_state <= sm_current_state;              --default is staying in current state
    case sm_current_state is
        when IDLE =>
            if trigger = '1' then --and pur_en = '1' then
                sm_next_state <= BUSY;
            end if;         
        when BUSY => 
             if counter_terminal_count = '1' then   --guarding time elapsed
                sm_next_state <= IDLE;
             elsif trigger = '1' then               --pulses overlaping detected 
                sm_next_state <= PILE_UP;             
             end if;
        when PILE_UP => 
             if counter_terminal_count = '1' then   --guarding time elapsed
                sm_next_state <= IDLE;
             end if;
        when others =>
             sm_next_state <= IDLE;
     end case;
 end process;  
    
-- combinatorial output logic
output_process:process(sm_current_state, trigger)
begin
    case sm_current_state is
        when IDLE =>
            sm_reject_n <= '1';         --reject is inactive
            sm_counter_en <=  '0';      --timer is disabled (stopped)
            sm_counter_clr <=  '1';     --clear timer
            sm_lt_dir <= "00";         --live time: count forward

        when BUSY => 
            sm_reject_n <= '1';         --reject is inactive
            sm_counter_en <=  '1';      --timer is enabled (running)
            if(trigger = '1') then             
                sm_counter_clr <= '1';  --new pulse arrived: restart timer
            else 
                sm_counter_clr <= '0';
            end if; 
            sm_lt_dir <= "01";         --live time: count backward  
                      
        when PILE_UP => 
            sm_reject_n <= '0';         --reject is active
            sm_counter_en <=  '1';      --timer is enabled (running)
            if(trigger = '1') then             
                sm_counter_clr <= '1';  --new pulse arrived: restart timer
            else 
                sm_counter_clr <= '0';
            end if;
            sm_lt_dir <= "01";         --live time: count backward
            
        when others =>
            sm_reject_n <= '1';
            sm_counter_en <=  '0';
            sm_counter_clr <=  '1';
            sm_lt_dir <= "00";         --live time: count forward
                         
     end case;
 end process;
 
--instantiate comparator and generate terminal count output 
comparator_inst: comparator
    generic map(DATA_WIDTH => PUR_COUNTER_WIDTH)
	port map(a=>counter_out, b=>pur_preset, cmp => counter_terminal_count);	

--instantiate counter
counter_inst: counter
    generic map(DATA_WIDTH => PUR_COUNTER_WIDTH)
	port map(clk=>clk, clr=>sm_counter_clr, ce=>sm_counter_en, q=>counter_out);

--instantiate rising edge trigger (its duration is one clock)
trigger_inst: r_edge_trigger
    port map( clk => clk, x => amp_rdy, trigger => trigger);	      
end Behavioral;
