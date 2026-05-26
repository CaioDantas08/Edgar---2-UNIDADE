library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ula_16bits is
    port (
        A, B : in  std_logic_vector(15 downto 0);
        M, S1, S0 : in  std_logic;
        F : out std_logic_vector(15 downto 0)
    );
end entity;

architecture arch of ula_16bits is
begin
    process(A, B, M, S1, S0)
        variable soma_sub : signed(15 downto 0);
        variable shift_left, shift_right : std_logic_vector(15 downto 0);
    begin
        if M = '0' then
            -- PARTE ARITMÉTICA (M = 0)
            if S1 = '0' and S0 = '0' then
                -- SOMA: A + B
                F <= std_logic_vector(signed(A) + signed(B));
                
            elsif S1 = '0' and S0 = '1' then
                -- SUBTRAÇÃO: A - B
                F <= std_logic_vector(signed(A) - signed(B));
                
            elsif S1 = '1' and S0 = '0' then
                -- SHIFT LEFT: A << 1
                F <= A(14 downto 0) & '0';
                
            else  -- S1 = '1' and S0 = '1'
                -- SHIFT RIGHT: A >> 1
                F <= '0' & A(15 downto 1);
            end if;
            
        else
            -- PARTE LÓGICA (M = 1)
            if S1 = '0' and S0 = '0' then
                -- AND
                F <= A and B;
                
            elsif S1 = '0' and S0 = '1' then
                -- OR
                F <= A or B;
                
            elsif S1 = '1' and S0 = '0' then
                -- XOR
                F <= A xor B;
                
            else  -- S1 = '1' and S0 = '1'
                -- XNOR
                F <= A xnor B;
            end if;
            
        end if;
    end process;
end architecture;