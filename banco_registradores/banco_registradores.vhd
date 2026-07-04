-- ===================================================================
-- Banco de Registradores
--   8 registradores de 16 bits cada
--   Leitura:  combinacional, via endereco_leitura  (MUX 8:1)
--   Escrita:  sincrona (borda de subida do clk), via endereco_escrita
--             habilitada apenas quando we = '1'
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity banco_registradores is
    port (
        clk              : in  std_logic;
        we               : in  std_logic;                     -- habilita escrita
        endereco_escrita : in  std_logic_vector(2 downto 0);   -- 0 a 7
        endereco_leitura : in  std_logic_vector(2 downto 0);   -- 0 a 7
        dado_entrada     : in  std_logic_vector(15 downto 0);
        dado_saida       : out std_logic_vector(15 downto 0)
    );
end banco_registradores;

architecture estrutural of banco_registradores is

    component registrador_16bits is
        port (
            D   : in  std_logic_vector(15 downto 0);
            we  : in  std_logic;
            clk : in  std_logic;
            Q   : out std_logic_vector(15 downto 0)
        );
    end component;

    type array_regs is array (0 to 7) of std_logic_vector(15 downto 0);
    signal Q_regs  : array_regs;
    signal we_regs : std_logic_vector(7 downto 0);

begin

    -- Decodificador de escrita: habilita apenas o registrador endereçado
    decodificador: for i in 0 to 7 generate
        we_regs(i) <= we when (to_integer(unsigned(endereco_escrita)) = i) else '0';
    end generate;

    -- Os 8 registradores de 16 bits
    gen_regs: for i in 0 to 7 generate
        reg_i: registrador_16bits port map (
            D   => dado_entrada,
            we  => we_regs(i),
            clk => clk,
            Q   => Q_regs(i)
        );
    end generate;

    -- MUX 8:1 de leitura (equivalente ao mux desenhado no diagrama de blocos)
    dado_saida <= Q_regs(to_integer(unsigned(endereco_leitura)));

end estrutural;
