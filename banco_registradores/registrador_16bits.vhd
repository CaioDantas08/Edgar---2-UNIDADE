-- ===================================================================
-- Registrador de 16 bits
-- Formado por 16 instancias do registrador_1bit, todas compartilhando
-- o mesmo clock e o mesmo write enable.
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity registrador_16bits is
    port (
        D   : in  std_logic_vector(15 downto 0);
        we  : in  std_logic;
        clk : in  std_logic;
        Q   : out std_logic_vector(15 downto 0)
    );
end registrador_16bits;

architecture estrutural of registrador_16bits is

    component registrador_1bit is
        port (
            D, we, clk : in  std_logic;
            Q          : out std_logic
        );
    end component;

begin

    gen_bits: for i in 0 to 15 generate
        bit_i: registrador_1bit port map (
            D   => D(i),
            we  => we,
            clk => clk,
            Q   => Q(i)
        );
    end generate;

end estrutural;
