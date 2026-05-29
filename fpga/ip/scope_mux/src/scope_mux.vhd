library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

    entity scope_mux is
    port(
        inp1    : in  std_logic_vector(15 downto 0);
        inp2    : in  std_logic_vector(15 downto 0);
        inp3    : in  std_logic_vector(15 downto 0);
        inp4    : in  std_logic_vector(15 downto 0);
        inp5    : in  std_logic_vector(15 downto 0);
        inp6    : in  std_logic_vector(15 downto 0);
        inp7    : in  std_logic_vector(15 downto 0);
        inp8    : in  std_logic_vector(15 downto 0);
        
        inp9    : in  std_logic_vector(15 downto 0);
        inp10   : in  std_logic_vector(15 downto 0);
        inp11   : in  std_logic_vector(15 downto 0);
        inp12   : in  std_logic_vector(15 downto 0);
        inp13   : in  std_logic_vector(15 downto 0);
        inp14   : in  std_logic_vector(15 downto 0);
        inp15   : in  std_logic_vector(15 downto 0);
        inp16   : in  std_logic_vector(15 downto 0);
        
        sel     : in  std_logic_vector(31 downto 0);
        
        ch1   : out std_logic_vector(15 downto 0);
        ch2   : out std_logic_vector(15 downto 0);
        trigger    : out std_logic_vector(15 downto 0)
        );
    end scope_mux;
	
    architecture rtl of scope_mux is
    -- declarative part: empty
    signal sel1_i   : std_logic_vector(3 downto 0);    
    signal sel2_i   : std_logic_vector(3 downto 0);    
    signal sel3_i   : std_logic_vector(3 downto 0);  
      
    begin
    
    sel1_i <= sel(3 downto 0); 
    sel2_i <= sel(7 downto 4); 
    sel3_i <= sel(11 downto 8); 
      
    p_mux1 : process(inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,inp11,inp12,inp13,inp14,inp15,inp16,sel1_i)
    begin
      case sel1_i is
        when "0000" => ch1 <= inp1 ;
        when "0001" => ch1 <= inp2 ;
		when "0010" => ch1 <= inp3 ;
		when "0011" => ch1 <= inp4 ;
		when "0100" => ch1 <= inp5 ;
        when "0101" => ch1 <= inp6 ;
		when "0110" => ch1 <= inp7 ;
		when "0111" => ch1 <= inp8 ;
		when "1000" => ch1 <= inp9 ;
        when "1001" => ch1 <= inp10 ;
		when "1010" => ch1 <= inp11;
		when "1011" => ch1 <= inp12;
		when "1100" => ch1 <= inp13;
        when "1101" => ch1 <= inp14;
		when "1110" => ch1 <= inp15;
		when "1111" => ch1 <= inp16;
      end case;
    end process p_mux1;
	
	p_mux2 : process(inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,inp11,inp12,inp13,inp14,inp15,inp16,sel2_i)
    begin
      case sel2_i is
        when "0000" => ch2 <= inp1 ;
        when "0001" => ch2 <= inp2 ;
		when "0010" => ch2 <= inp3 ;
		when "0011" => ch2 <= inp4 ;
		when "0100" => ch2 <= inp5 ;
        when "0101" => ch2 <= inp6 ;
		when "0110" => ch2 <= inp7 ;
		when "0111" => ch2 <= inp8 ;
		when "1000" => ch2 <= inp9 ;
        when "1001" => ch2 <= inp10 ;
		when "1010" => ch2 <= inp11;
		when "1011" => ch2 <= inp12;
		when "1100" => ch2 <= inp13;
        when "1101" => ch2 <= inp14;
		when "1110" => ch2 <= inp15;
		when "1111" => ch2 <= inp16;
      end case;
    end process p_mux2;

	p_mux3 : process(inp1,inp2,inp3,inp4,inp5,inp6,inp7,inp8,inp9,inp10,inp11,inp12,inp13,inp14,inp15,inp16,sel3_i)
    begin
      case sel3_i is
        when "0000" => trigger <= inp1 ;
        when "0001" => trigger <= inp2 ;
		when "0010" => trigger <= inp3 ;
		when "0011" => trigger <= inp4 ;
		when "0100" => trigger <= inp5 ;
        when "0101" => trigger <= inp6 ;
		when "0110" => trigger <= inp7 ;
		when "0111" => trigger <= inp8 ;
		when "1000" => trigger <= inp9 ;
        when "1001" => trigger <= inp10 ;
		when "1010" => trigger <= inp11;
		when "1011" => trigger <= inp12;
		when "1100" => trigger <= inp13;
        when "1101" => trigger <= inp14;
		when "1110" => trigger <= inp15;
		when "1111" => trigger <= inp16;
      end case;
    end process p_mux3;
    
end rtl;
    