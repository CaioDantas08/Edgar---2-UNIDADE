library ieee;
use ieee.std_logic_1164.all;

entity somador_completo_1bit is
    port (
        A, B, Cin : in  std_logic;
        S, Cout   : out std_logic
    );
end entity;

architecture dataflow of somador_completo_1bit is
begin
    S    <= A xor B xor Cin;
    Cout <= ((A xor B) and Cin) or (A and B);
end architecture;