library ieee;
use ieee.std_logic_1164.all;

entity tb_calculadora is
end entity;

architecture sim of tb_calculadora is
    signal A, B, S : std_logic_vector(7 downto 0);
    signal OP, Luz_soma, Luz_sub : std_logic;
begin
    uut: entity work.calculadora port map (A, B, OP, S, Luz_soma, Luz_sub);
    
    process
    begin
        A <= "00001010"; B <= "00000101"; OP <= '0'; wait for 10 ns;
        
        OP <= '1'; wait for 10 ns;
        
        A <= "11111111"; B <= "00000001"; OP <= '0'; wait for 10 ns;
        
        A <= "00000000"; B <= "00000001"; OP <= '1'; wait for 10 ns;
        
        wait;
    end process;
end architecture;