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

	with seletor select
        saida0 <= entrada when "00",
        	"000"   when others;

    with seletor select 
    	saida1 <= entrada when "01",
        	"000" when others;
   
    with seletor select 
    	saida2 <= entrada when "10",
        	"000" when others;
            
    with seletor select 
    	saida3 <= entrada when "11",
        	"000" when others;
    
end mapeamento;

