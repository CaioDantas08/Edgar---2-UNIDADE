library ieee;
use ieee.std_logic_1164.all;

entity calculadora is
    port (
        A, B : in  std_logic_vector(7 downto 0);
        OP   : in  std_logic; 
        S    : out std_logic_vector(7 downto 0);
        Luz_soma, Luz_sub : out std_logic
    );
end entity;

architecture arch of calculadora is
    component somador_subtrator_8bits is
        port (A, B : in std_logic_vector(7 downto 0); OP : in std_logic;
              S : out std_logic_vector(7 downto 0); Cout : out std_logic);
    end component;
    
    signal resultado : std_logic_vector(7 downto 0);
    signal temp_cout : std_logic;
begin
    calc: somador_subtrator_8bits port map (A, B, OP, resultado, temp_cout);
    
    S <= resultado;
    
   
    Luz_soma <= '1' when OP = '0' else '0';
    Luz_sub  <= '1' when OP = '1' else '0';
end architecture;