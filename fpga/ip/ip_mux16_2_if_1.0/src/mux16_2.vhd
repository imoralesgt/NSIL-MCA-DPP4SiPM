library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;


    entity mux16_2 is
    port(
      inp1      : in  std_logic_vector(15 downto 0);
      inp2      : in  std_logic_vector(15 downto 0);
	  inp3      : in  std_logic_vector(15 downto 0);
      inp4      : in  std_logic_vector(15 downto 0);
      inp5      : in  std_logic_vector(15 downto 0);
      inp6      : in  std_logic_vector(15 downto 0);
	  inp7      : in  std_logic_vector(15 downto 0);
      inp8      : in  std_logic_vector(15 downto 0);
   	  
	  inp9      : in  std_logic_vector(15 downto 0);
      inp10      : in  std_logic_vector(15 downto 0);
	  inp11     : in  std_logic_vector(15 downto 0);
      inp12     : in  std_logic_vector(15 downto 0);
      inp13     : in  std_logic_vector(15 downto 0);
      inp14     : in  std_logic_vector(15 downto 0);
	  inp15     : in  std_logic_vector(15 downto 0);
      inp16     : in  std_logic_vector(15 downto 0);
	  
	  
      sel1      : in  std_logic_vector(3 downto 0);
	  sel2      : in  std_logic_vector(3 downto 0);
      outp1     : out std_logic_vector(15 downto 0);
	  outp2     : out std_logic_vector(15 downto 0);
	  trig     : out std_logic_vector(15 downto 0)
	);
    end mux16_2;
	
    architecture rtl of mux16_2 is
      -- declarative part: empty
    signal outp1_p	: std_logic_vector(15 downto 0);
    begin
    
    trig <= outp1_p;
    outp1 <= outp1_p;
    
    
    p_mux1 : process(inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,inp11,inp12,inp13,inp14,inp15,inp16,sel1)
    begin
      case sel1 is
        when "0000" => outp1_p <= inp1 ;
        when "0001" => outp1_p <= inp2 ;
		when "0010" => outp1_p <= inp3 ;
		when "0011" => outp1_p <= inp4 ;
		when "0100" => outp1_p <= inp5 ;
        when "0101" => outp1_p <= inp6 ;
		when "0110" => outp1_p <= inp7 ;
		when "0111" => outp1_p <= inp8 ;
		when "1000" => outp1_p <= inp9 ;
        when "1001" => outp1_p <= inp10 ;
		when "1010" => outp1_p <= inp11;
		when "1011" => outp1_p <= inp12;
		when "1100" => outp1_p <= inp13;
        when "1101" => outp1_p <= inp14;
		when "1110" => outp1_p <= inp15;
		when "1111" => outp1_p <= inp16;
		
		
		
      end case;
    end process p_mux1;
	
	
	p_mux2 : process(inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,inp11,inp12,inp13,inp14,inp15,inp16,sel2)
    begin
      case sel2 is
        when "0000" => outp2 <= inp1 ;
        when "0001" => outp2 <= inp2 ;
		when "0010" => outp2 <= inp3 ;
		when "0011" => outp2 <= inp4 ;
		when "0100" => outp2 <= inp5 ;
        when "0101" => outp2 <= inp6 ;
		when "0110" => outp2 <= inp7 ;
		when "0111" => outp2 <= inp8 ;
		when "1000" => outp2 <= inp9 ;
        when "1001" => outp2 <= inp10 ;
		when "1010" => outp2 <= inp11;
		when "1011" => outp2 <= inp12;
		when "1100" => outp2 <= inp13;
        when "1101" => outp2 <= inp14;
		when "1110" => outp2 <= inp15;
		when "1111" => outp2 <= inp16;
      end case;
    end process p_mux2;
	
	
	
	
	
    end rtl;
    