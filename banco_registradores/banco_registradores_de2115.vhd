-- ===================================================================
-- Top-level para a placa DE2-115 (prototipagem)
--
-- Mapeamento das chaves/botoes (simplificado para caber nas 18
-- chaves disponiveis na placa):
--
--   SW(17 downto 15) -> endereco_escrita  (0 a 7)
--   SW(14 downto 12) -> endereco_leitura  (0 a 7)
--   SW(11)            -> we (habilita escrita)
--   SW(7  downto 0)   -> dado_entrada(7 downto 0)
--                         (os 8 bits superiores do dado sao fixados
--                          em '0'; ajuste este mapeamento se quiser
--                          testar os 16 bits completos, por exemplo
--                          usando os KEY(3 downto 1) para alternar
--                          um byte alto separado)
--   KEY(0)            -> clock manual (botao "step", ativo em
--                         nivel baixo na DE2-115, por isso invertido)
--   LEDR(15 downto 0) -> dado_saida (valor lido do registrador
--                         selecionado por endereco_leitura)
--
-- Como testar na placa:
--   1) Ajuste SW(17 downto 15) com o endereco de escrita desejado.
--   2) Ajuste SW(7 downto 0) com o dado a ser escrito.
--   3) Ligue SW(11) = 1 (habilita escrita).
--   4) Pressione e solte KEY(0) uma vez -> ocorre 1 borda de subida
--      e o dado e gravado no registrador selecionado.
--   5) Desligue SW(11) = 0.
--   6) Ajuste SW(14 downto 12) com o endereco de leitura desejado.
--   7) O valor lido aparece imediatamente em LEDR (leitura e
--      combinacional, nao precisa de clock).
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity banco_registradores_de2115 is
    port (
        SW   : in  std_logic_vector(17 downto 0);
        KEY  : in  std_logic_vector(3 downto 0);
        LEDR : out std_logic_vector(17 downto 0)
    );
end banco_registradores_de2115;

architecture estrutural of banco_registradores_de2115 is

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

    signal clk_manual   : std_logic;
    signal dado_entrada : std_logic_vector(15 downto 0);
    signal dado_saida   : std_logic_vector(15 downto 0);

begin

    -- KEY e ativo baixo na DE2-115: solto = '1', pressionado = '0'.
    -- Invertendo, temos uma borda de subida no exato momento em que
    -- o botao e pressionado.
    clk_manual <= not KEY(0);

    dado_entrada <= "00000000" & SW(7 downto 0);

    BANCO : banco_registradores port map (
        clk              => clk_manual,
        we               => SW(11),
        endereco_escrita => SW(17 downto 15),
        endereco_leitura => SW(14 downto 12),
        dado_entrada     => dado_entrada,
        dado_saida       => dado_saida
    );

    LEDR(15 downto 0)  <= dado_saida;
    LEDR(17 downto 16) <= "00";

end estrutural;
