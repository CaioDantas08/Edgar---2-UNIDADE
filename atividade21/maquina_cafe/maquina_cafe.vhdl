-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;


entity maquina_cafe is
	port (
    		botao : in std_logic_vector(2 downto 0);
            cafes : out std_logic_vector(7 downto 0)
        );
        
end maquina_cafe;

architecture funcionamento of maquina_cafe is
begin

	process(botao) --sempre que um botao for apertado ele roda
    begin
    	
        cafes <= "00000000";
        
        case botao is
        	
            when "001" => cafes(0) <= '1';
            when "010" => cafes(1) <= '1';
            when "011" => cafes(2) <= '1';
            when "100" => cafes(3) <= '1';
            when "101" => cafes(4) <= '1';
            when "110" => cafes(5) <= '1';
            when "111" => cafes(6) <= '1';
           	when "000" => cafes(7) <= '1';
            when others => null;
        end case;
        
     end process;
     
end funcionamento;