-- ===================================================================
-- Flip-Flop tipo D, sensivel a borda de subida do clock
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity flipflop_d_1bit is
    port (
        D   : in  std_logic;
        clk : in  std_logic;
        Q   : out std_logic
    );
end flipflop_d_1bit;

architecture comportamental of flipflop_d_1bit is
begin
    process(clk)
    begin
        if rising_edge(clk) then
            Q <= D;
        end if;
    end process;
end comportamental;
