-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;

entity tb_conversor_ex_7seg is
end tb_conversor_ex_7seg;

architecture simulacao of tb_conversor_ex_7seg is

	component conversor_ex_7seg 
    	port(
    		hex : in std_logic_vector(3 downto 0);
            seg_7 : out std_logic_vector(6 downto 0)
        	);
   	end component;
    signal tb_hex :  std_logic_vector(3 downto 0);
    signal tb_seg_7 : std_logic_vector(6 downto 0);
    
    begin
    
    	UUT: conversor_ex_7seg port map(
        	hex => tb_hex,
            seg_7 => tb_seg_7
        );
        
   	simular : process
    begin
    	tb_hex <= "0000";
        wait for 10 ns;
        
        tb_hex <= "0001";
        wait for 10 ns;
        
        tb_hex <= "0010";
        wait for 10 ns;
        
        tb_hex <= "0011";
        wait for 10 ns;
        
        tb_hex <= "0100";
        wait for 10 ns;
        
        tb_hex <= "0101";
        wait for 10 ns;

		tb_hex <= "0110";
        wait for 10 ns;
        
        tb_hex <= "0111";
        wait for 10 ns;
        
        tb_hex <= "1000";
        wait for 10 ns;
        
        tb_hex <= "1001";
        wait for 10 ns;
        
        tb_hex <= "1010";
        wait for 10 ns;
        
        tb_hex <= "1011";
        wait for 10 ns;
        
        tb_hex <= "1100";
        wait for 10 ns;
        
        tb_hex <= "1101";
        wait for 10 ns;
        
        tb_hex <= "1110";
        wait for 10 ns;
        
        tb_hex <= "1111";
        wait for 10 ns;
        
        
        wait;
        
    end process;
end simulacao;