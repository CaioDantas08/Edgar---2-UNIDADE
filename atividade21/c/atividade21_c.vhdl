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

  saida0 <= "000";
  saida1 <= "000";
  saida2 <= "000";
  saida3 <= "000";

	process(entrada, seletor)
    begin

      if seletor = "00" then saida0 <= entrada; 
      elsif seletor = "01" then saida1 <= entrada;
      elsif seletor = "10" then saida2 <= entrada;
      elsif seletor = "11" then saida3 <= entrada;
      end if;
   	end process;

end mapeamento;

