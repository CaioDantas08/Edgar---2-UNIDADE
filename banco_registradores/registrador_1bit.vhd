-- ===================================================================
-- Registrador de 1 bit = MUX 2:1 + Flip-Flop D
--
-- Celula basica que, repetida 16 vezes, forma um registrador de
-- 16 bits (ver registrador_16bits.vhd). Mesma estrutura do diagrama:
--
--   D ---> [MUX 2:1] ---> [Flip-Flop D] ---> Q
--            ^                                |
--   we ------|                                |
--            |________________________________|
--                    (realimentacao de Q)
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registrador_1bit is
    port (
        D   : in  std_logic;
        we  : in  std_logic;
        clk : in  std_logic;
        Q   : out std_logic
    );
end registrador_1bit;

architecture estrutural of registrador_1bit is

    component mux2x1_1bit is
        port (
            D, Q, we : in  std_logic;
            S        : out std_logic
        );
    end component;

    component flipflop_d_1bit is
        port (
            D, clk : in  std_logic;
            Q      : out std_logic
        );
    end component;

    signal D_interno : std_logic; -- saida do mux -> entrada do FF
    signal Q_interno : std_logic; -- saida do FF -> realimenta o mux

begin

    MUX : mux2x1_1bit port map (
        D  => D,
        Q  => Q_interno,
        we => we,
        S  => D_interno
    );

    FF : flipflop_d_1bit port map (
        D   => D_interno,
        clk => clk,
        Q   => Q_interno
    );

    Q <= Q_interno;

end estrutural;
