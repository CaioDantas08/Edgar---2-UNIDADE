-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_maquina_cafe is
end tb_maquina_cafe;

architecture simulacao of tb_maquina_cafe is

	component maquina_cafe
		Port (
        		botao: in std_logic_vector(2 downto 0);
                cafes: out std_logic_vector(7 downto 0)
        	);
     end component;
     
     signal t_botao : std_logic_vector(2 downto 0);
     signal t_cafes : std_logic_vector(7 downto 0);
     
begin
	
    
    UUT: maquina_cafe port map(
    	botao => t_botao,
        cafes => t_cafes
    );
    
    simular: process
    begin
    
    t_botao <= "001";
    wait for 10 ns;
    
    t_botao <= "010";
    wait for 10 ns;
    
    t_botao <= "011";
    wait for 10 ns;
    
    t_botao <= "100";
    wait for 10 ns;
    
    t_botao <= "101";
    wait for 10 ns;
    
    t_botao <= "110";
    wait for 10 ns;
    
    t_botao <= "111";
    wait for 10 ns;
    
    t_botao <= "000";
    wait for 10 ns;
    
    wait;
    
    
   end process;
   
   end simulacao;
    
     