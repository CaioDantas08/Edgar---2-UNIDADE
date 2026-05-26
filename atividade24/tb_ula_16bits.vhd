library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_ula_16bits is
end entity;

architecture sim of tb_ula_16bits is
    signal A, B, F : std_logic_vector(15 downto 0);
    signal M, S1, S0 : std_logic;
begin
    uut: entity work.ula_16bits port map (A, B, M, S1, S0, F);
    
    process
    begin
        -- Valores de teste
        A <= x"0005";  -- 5
        B <= x"0003";  -- 3
        
        M <= '0'; S1 <= '0'; S0 <= '0'; wait for 10 ns;
        
        M <= '0'; S1 <= '0'; S0 <= '1'; wait for 10 ns;
        
        M <= '0'; S1 <= '1'; S0 <= '0'; wait for 10 ns;
        
        M <= '0'; S1 <= '1'; S0 <= '1'; wait for 10 ns;
        
        M <= '1'; S1 <= '0'; S0 <= '0'; wait for 10 ns;
        
        M <= '1'; S1 <= '0'; S0 <= '1'; wait for 10 ns;
        
        M <= '1'; S1 <= '1'; S0 <= '0'; wait for 10 ns;
        
        M <= '1'; S1 <= '1'; S0 <= '1'; wait for 10 ns;
        
        wait;
    end process;
end architecture;