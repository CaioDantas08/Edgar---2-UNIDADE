library ieee;
use ieee.std_logic_1164.all;

entity somador_subtrator_8bits is
    port (
        A, B : in  std_logic_vector(7 downto 0);
        OP   : in  std_logic; 
        S    : out std_logic_vector(7 downto 0);
        Cout : out std_logic
    );
end entity;

architecture estrutural of somador_subtrator_8bits is
    component somador_completo_1bit is
        port (A, B, Cin : in std_logic; S, Cout : out std_logic);
    end component;
    
    signal carry : std_logic_vector(8 downto 0);
    signal B_ajustado : std_logic_vector(7 downto 0);
begin
   
    B_ajustado(0) <= B(0) xor OP;
    B_ajustado(1) <= B(1) xor OP;
    B_ajustado(2) <= B(2) xor OP;
    B_ajustado(3) <= B(3) xor OP;
    B_ajustado(4) <= B(4) xor OP;
    B_ajustado(5) <= B(5) xor OP;
    B_ajustado(6) <= B(6) xor OP;
    B_ajustado(7) <= B(7) xor OP;
    
    carry(0) <= OP;
    
    gen: for i in 0 to 7 generate
        fa: somador_completo_1bit port map (
            A    => A(i),
            B    => B_ajustado(i),
            Cin  => carry(i),
            S    => S(i),
            Cout => carry(i+1)
        );
    end generate;
    
    Cout <= carry(8);
end architecture;