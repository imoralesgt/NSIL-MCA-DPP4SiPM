library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

--https://www.fpga4student.com/2017/08/how-to-generate-clock-enable-signal.html

entity clock_1KHz_enable is
	port(	clk, clr, ce : in std_logic;
			clk_1kHz_en : out std_logic);
end clock_1KHz_enable;
architecture Behavioral of clock_1KHz_enable is

	signal clk_1kHz_en_i  : std_logic;
	signal tmp : std_logic_vector(15 downto 0):=x"0000";
	constant DIVISOR: std_logic_vector(15 downto 0):= x"C34F"; --49999, for clk=50MHz

begin

	process(clk,clr)
	begin
        if (clr='1') then
            tmp <= (others => '0');
			clk_1kHz_en_i <= '0';
        elsif(rising_edge(clk)) then
            if(tmp = DIVISOR) then
                clk_1kHz_en_i <= '1';
                tmp <= x"0000";
            else
                clk_1kHz_en_i <= '0';
                if(ce = '1') then
                    tmp <= tmp + x"0001";
                else
                    tmp <= tmp;
                end if;
            end if;
        end if;
end process;

	clk_1kHz_en <= clk_1kHz_en_i;
	
end Behavioral;




