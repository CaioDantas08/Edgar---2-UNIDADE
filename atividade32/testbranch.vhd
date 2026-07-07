library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_top_level is
end tb_top_level;

architecture behavior of tb_top_level is
    component top_level
        Port (
            CLOCK_50 : in  STD_LOGIC;
            SW       : in  STD_LOGIC_VECTOR(17 downto 0);
            KEY      : in  STD_LOGIC_VECTOR(1 downto 0);
            LEDR     : out STD_LOGIC_VECTOR(17 downto 0);
            LEDG     : out STD_LOGIC_VECTOR(8 downto 0);
            HEX0, HEX1, HEX2, HEX3, HEX4, HEX5, HEX6, HEX7 : out STD_LOGIC_VECTOR(6 downto 0)
        );
    end component;

    signal CLOCK_50 : STD_LOGIC := '0';
    signal SW       : STD_LOGIC_VECTOR(17 downto 0) := (others => '0');
    signal KEY      : STD_LOGIC_VECTOR(1 downto 0) := "11";
    signal LEDR     : STD_LOGIC_VECTOR(17 downto 0);
    signal LEDG     : STD_LOGIC_VECTOR(8 downto 0);
    signal H0, H1, H2, H3, H4, H5, H6, H7 : STD_LOGIC_VECTOR(6 downto 0);

    constant clk_period : time := 20 ns;

begin
    UUT: top_level port map (CLOCK_50, SW, KEY, LEDR, LEDG, H0, H1, H2, H3, H4, H5, H6, H7);

    clk_process :process
    begin
        CLOCK_50 <= '0';
        wait for clk_period/2;
        CLOCK_50 <= '1';
        wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        KEY(0) <= '0'; wait for 40 ns;
        KEY(0) <= '1'; wait for 40 ns;

        -- Teste: Divisão
        SW(17) <= '0';
        SW(15 downto 0) <= x"000F"; wait for 20 ns; -- A = 15
        KEY(1) <= '0'; wait for 40 ns; KEY(1) <= '1'; wait for 40 ns; 
        
        SW(15 downto 0) <= x"0005"; wait for 20 ns; -- B = 5
        KEY(1) <= '0'; wait for 40 ns; KEY(1) <= '1'; wait for 200 ns; 
        
        KEY(1) <= '0'; wait for 40 ns; KEY(1) <= '1'; wait for 40 ns;

        -- Teste: Média
        SW(17) <= '1';
        wait for 40 ns;
        SW(15 downto 0) <= x"03E8"; wait for 20 ns; -- Y = 1000
        KEY(1) <= '0'; wait for 40 ns; KEY(1) <= '1'; wait for 100 ns;

        wait;
    end process;
end behavior;
