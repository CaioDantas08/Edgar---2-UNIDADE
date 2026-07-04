-- Code your testbench here
-- ===================================================================
-- Testbench do Banco de Registradores
-- Pronto para uso no EDA Playground (Tools: GHDL / ModelSim)
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_banco_registradores is
end tb_banco_registradores;

architecture simulacao of tb_banco_registradores is

    component banco_registradores is
        port (
            clk              : in  std_logic;
            we               : in  std_logic;
            endereco_escrita : in  std_logic_vector(2 downto 0);
            endereco_leitura : in  std_logic_vector(2 downto 0);
            dado_entrada     : in  std_logic_vector(15 downto 0);
            dado_saida       : out std_logic_vector(15 downto 0)
        );
    end component;

    signal t_clk          : std_logic := '0';
    signal t_we           : std_logic := '0';
    signal t_end_escrita  : std_logic_vector(2 downto 0)  := (others => '0');
    signal t_end_leitura  : std_logic_vector(2 downto 0)  := (others => '0');
    signal t_dado_entrada : std_logic_vector(15 downto 0) := (others => '0');
    signal t_dado_saida   : std_logic_vector(15 downto 0);

begin

    UUT: banco_registradores port map (
        clk              => t_clk,
        we               => t_we,
        endereco_escrita => t_end_escrita,
        endereco_leitura => t_end_leitura,
        dado_entrada     => t_dado_entrada,
        dado_saida       => t_dado_saida
    );

    -- gerador de clock: periodo de 20 ns
    clock_gen: process
    begin
        t_clk <= '0'; wait for 10 ns;
        t_clk <= '1'; wait for 10 ns;
    end process;

    estimulos: process
    begin

        -- Escreve 0x00AA no registrador 0
        t_end_escrita  <= "000";
        t_dado_entrada <= x"00AA";
        t_we           <= '1';
        wait for 20 ns;

        -- Escreve 0x1234 no registrador 3
        t_end_escrita  <= "011";
        t_dado_entrada <= x"1234";
        t_we           <= '1';
        wait for 20 ns;

        -- Escreve 0xFFFF no registrador 7
        t_end_escrita  <= "111";
        t_dado_entrada <= x"FFFF";
        t_we           <= '1';
        wait for 20 ns;

        -- Desativa a escrita
        t_we <= '0';
        wait for 20 ns;

        -- Le registrador 0 (espera 0x00AA)
        t_end_leitura <= "000";
        wait for 20 ns;

        -- Le registrador 3 (espera 0x1234)
        t_end_leitura <= "011";
        wait for 20 ns;

        -- Le registrador 7 (espera 0xFFFF)
        t_end_leitura <= "111";
        wait for 20 ns;

        -- Le registrador 1, nunca escrito (espera 0x0000)
        t_end_leitura <= "001";
        wait for 20 ns;

        -- Tenta escrever no registrador 0 SEM habilitar we (nao deve mudar)
        t_end_escrita  <= "000";
        t_dado_entrada <= x"9999";
        t_we           <= '0';
        wait for 20 ns;

        t_end_leitura <= "000"; -- deve continuar 0x00AA
        wait for 20 ns;

        wait;
    end process;

end simulacao;
