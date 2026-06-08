library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
 
-- Formatter Entity
-- Mathematical Function: y[n] = (Average(x[n...n-7]) * Invert) - dc_offset
-- Data Format: Q2.14 (16-bit signed, 2's complement, 14 fractional bits).
-- Decimal Range: -2.0 to +1.99994
entity Formatter is
    port (
        clk_dpp     : in  std_logic;
        reset_n     : in  std_logic;                    
        adc_data    : in  std_logic_vector(13 downto 0); -- Input signal x[n]
        --avg_select  : in  std_logic_vector(1 downto 0);  -- "00"=1x, "01"=2x, "10"=4x, "11"=8x
        --invert      : in  std_logic;                     -- '1' to negate signal
        --dc_offset   : in  std_logic_vector(15 downto 0); -- Q2.14 format offset
        r1_dc_offset  : in  std_logic_vector(31 downto 0);
        r2_flags      : in  std_logic_vector(31 downto 0);
        data_out    : out std_logic_vector(15 downto 0)  -- Output signal y[n] (Saturated)
    );
end entity;

architecture rtl of Formatter is
    type window_t is array (0 to 7) of signed(13 downto 0);
    signal samples : window_t := (others => (others => '0'));

    signal avg_select  : std_logic_vector(1 downto 0) := "00";
    signal invert      : std_logic := '0';
    signal dc_offset   : signed(15 downto 0) := (others => '0');
    signal p2_avg_q214 : signed(15 downto 0) := (others => '0');
    signal p2_invert   : std_logic := '0';
    signal p2_offset   : signed(15 downto 0) := (others => '0');
    signal p3_wide_res  : signed(23 downto 0) := (others => '0');
    signal p4_saturated : signed(15 downto 0) := (others => '0');

    -- Repeater Chain Signals
    signal p5_reg, p6_reg, p7_reg, p8_reg : std_logic_vector(15 downto 0) := (others => '0');

    -- Attributes to force the compiler to keep these as physical "stepping stones"
    attribute dont_touch : string;
    attribute dont_touch of p5_reg : signal is "true";
    attribute dont_touch of p6_reg : signal is "true";
    attribute dont_touch of p7_reg : signal is "true";
    attribute dont_touch of p8_reg : signal is "true";
    
    -- Prevent the tool from turning our repeaters into a RAM-based shift register
    attribute shreg_extract : string;
    attribute shreg_extract of p5_reg : signal is "no";
    attribute shreg_extract of p6_reg : signal is "no";
    attribute shreg_extract of p7_reg : signal is "no";
    attribute shreg_extract of p8_reg : signal is "no";

begin

    process(clk_dpp, reset_n)
        variable v_sum : signed(17 downto 0); 
    begin
        if reset_n = '0' then
            samples      <= (others => (others => '0'));
            avg_select   <= "00";
            invert       <= '0';
            dc_offset    <= (others => '0');
            p2_avg_q214  <= (others => '0');
            p3_wide_res  <= (others => '0');
            p4_saturated <= (others => '0');
            p5_reg       <= (others => '0');
            p6_reg       <= (others => '0');
            p7_reg       <= (others => '0');
            p8_reg       <= (others => '0');
            data_out     <= (others => '0');
            
        elsif rising_edge(clk_dpp) then
            
            -- STAGE 1: Barrier
            samples      <= (others => (others => '0'));
            --avg_select   <= "00";
            --invert       <= '0';  
            samples      <= signed(adc_data) & samples(0 to 6);
            dc_offset    <= signed(r1_dc_offset(15 downto 0));
            avg_select   <= r2_flags(2 downto 1);
            invert       <= r2_flags(0);

            -- STAGE 2: Averaging
            case avg_select is
                when "01"   => v_sum    := resize(samples(0), 18) + resize(samples(1), 18);
                               p2_avg_q214 <= resize(v_sum(17 downto 1), 15) & '0';
                when "10"   => v_sum    := resize(samples(0), 18) + resize(samples(1), 18) + 
                                        resize(samples(2), 18) + resize(samples(3), 18);
                               p2_avg_q214 <= resize(v_sum(17 downto 2), 15) & '0';
                when "11"   => v_sum    := resize(samples(0), 18) + resize(samples(1), 18) + 
                                        resize(samples(2), 18) + resize(samples(3), 18) +
                                        resize(samples(4), 18) + resize(samples(5), 18) + 
                                        resize(samples(6), 18) + resize(samples(7), 18);
                                p2_avg_q214 <= resize(v_sum(17 downto 3), 15) & '0';
                when others => p2_avg_q214 <= resize(samples(0), 15) & '0';
            end case;
            p2_invert <= invert;
            p2_offset <= dc_offset;

            -- STAGE 3: Math
            if p2_invert = '1' then
                p3_wide_res <= (-resize(p2_avg_q214, 24)) - resize(p2_offset, 24);
            else
                p3_wide_res <= resize(p2_avg_q214, 24) - resize(p2_offset, 24);
            end if;

            -- STAGE 4: Saturation Logic
            if p3_wide_res > 32767 then
                p4_saturated <= x"7FFF";
            elsif p3_wide_res < -32768 then
                p4_saturated <= x"8000";
            else
                p4_saturated <= p3_wide_res(15 downto 0);
            end if;

            -- STAGE 5-8: THE REPEATER CHAIN (Timing Fix)
            p5_reg   <= std_logic_vector(p4_saturated);
            p6_reg   <= p5_reg;
            p7_reg   <= p6_reg;
            p8_reg   <= p7_reg;
            data_out <= p8_reg;

        end if;
    end process;
end architecture;