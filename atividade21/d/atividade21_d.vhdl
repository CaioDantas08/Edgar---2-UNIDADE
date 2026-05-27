library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux_1x4 is
    Port ( 
           entrada : in  STD_LOGIC_VECTOR(2 downto 0);
           seletor : in  STD_LOGIC_VECTOR(1 downto 0);
           saida0  : out STD_LOGIC_VECTOR(2 downto 0);
           saida1  : out STD_LOGIC_VECTOR(2 downto 0);
           saida2  : out STD_LOGIC_VECTOR(2 downto 0);
           saida3  : out STD_LOGIC_VECTOR(2 downto 0)
         );
end demux_1x4;

architecture mapeamento of demux_1x4 is
begin

	process(entrada, seletor)
    begin

    saida0 <= "000";
    saida1 <= "000";
    saida2 <= "000";
    saida3 <= "000";

	case seletor is
    	when "00" => saida0 <= entrada;
        when "01" => saida1 <= entrada;
        when "10" => saida2 <= entrada;
        when "11" => saida3 <= entrada;
        when others => null;
    end case;    
   	end process;

end mapeamento;

