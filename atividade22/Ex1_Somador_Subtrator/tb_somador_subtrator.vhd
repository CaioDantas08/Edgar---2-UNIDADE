library ieee;
use ieee.std_logic_1164.all;

entity tb_somador_subtrator is
end entity;

architecture sim of tb_somador_subtrator is
    signal A, B, S : std_logic_vector(7 downto 0);
    signal OP, Cout : std_logic;
begin
    uut: entity work.somador_subtrator_8bits port map (A, B, OP, S, Cout);
    
    process
    begin
        A <= "00110010"; 
        B <= "00011110";  
        OP <= '0';
        wait for 10 ns;
        
        OP <= '1';
        wait for 10 ns;
        
        A <= "11001000";  
        B <= "01100100"; 
        OP <= '0';
        wait for 10 ns;
        
        OP <= '1';
        wait for 10 ns;
        
        A <= "00000000";
        B <= "00000001";
        OP <= '1';
        wait for 10 ns;
        
        A <= "11111111";
        B <= "00000001";
        OP <= '0';
        wait for 10 ns;
        
        wait;
    end process;
end architecture;
