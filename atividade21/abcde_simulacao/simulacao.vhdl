library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_demux_1x4 is
end tb_demux_1x4;

architecture simulacao of tb_demux_1x4 is

    component demux_1x4
        Port ( 
               entrada : in  STD_LOGIC_VECTOR(2 downto 0);
               seletor : in  STD_LOGIC_VECTOR(1 downto 0);
               saida0  : out STD_LOGIC_VECTOR(2 downto 0);
               saida1  : out STD_LOGIC_VECTOR(2 downto 0);
               saida2  : out STD_LOGIC_VECTOR(2 downto 0);
               saida3  : out STD_LOGIC_VECTOR(2 downto 0)
             );
    end component;

    signal t_entrada : STD_LOGIC_VECTOR(2 downto 0);
    signal t_seletor : STD_LOGIC_VECTOR(1 downto 0);
    signal t_saida0  : STD_LOGIC_VECTOR(2 downto 0);
    signal t_saida1  : STD_LOGIC_VECTOR(2 downto 0);
    signal t_saida2  : STD_LOGIC_VECTOR(2 downto 0);
    signal t_saida3  : STD_LOGIC_VECTOR(2 downto 0);

begin
    UUT: demux_1x4 port map (
        entrada => t_entrada,
        seletor => t_seletor,
        saida0  => t_saida0,
        saida1  => t_saida1,
        saida2  => t_saida2,
        saida3  => t_saida3
    );

    
    simular: process
    begin
        -- Usando 101 na  entrada para ver para onde ele vai quando mudamos o seletor
        t_entrada <= "101";

        -- Cenario 1: seletor em 00 (a saida0 deve ligar e mostrar 101, as outras ficam em 000)
        t_seletor <= "00";
        wait for 10 ns;

        -- Cenario 2: seletor em 01 (A saida1 deve ligar e mostrar 101)
        t_seletor <= "01";
        wait for 10 ns;

        -- Cenario 3: seletor em 10 (a saida2 deve ligar e mostrar 101)
        t_seletor <= "10";
        wait for 10 ns;

        -- Cenario 4: seletor em 11 (A saida3 deve ligar e mostrar 101)
        t_seletor <= "11";
        wait for 10 ns;
        
        wait for 10 ns;

        wait;
    end process;

end simulacao;