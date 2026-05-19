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

    saida0 <= entrada when seletor = "00" else "000";
    
    saida1 <= entrada when seletor = "01" else "000";
    
    
    saida2 <= entrada when seletor = "10" else "000";
   
    saida3 <= entrada when seletor = "11" else "000";

end mapeamento;

