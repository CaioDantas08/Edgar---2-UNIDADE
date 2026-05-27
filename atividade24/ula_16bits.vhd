
-- SOMADOR COMPLETO DE 1 BIT

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_completo_1bit is
    port (A, B, Cin : in std_logic; S, Cout : out std_logic);
end somador_completo_1bit;

architecture dataflow of somador_completo_1bit is
begin
    S    <= A xor B xor Cin;
    Cout <= ((A xor B) and Cin) or (A and B);
end dataflow;

--SOMADOR / SUBTRATOR DE 16 BITS

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity somador_subtrator_16bits is
    port (
        A, B : in  std_logic_vector(15 downto 0);
        OP   : in  std_logic; 
        S    : out std_logic_vector(15 downto 0);
        Cout : out std_logic
    );
end somador_subtrator_16bits;

architecture estrutural of somador_subtrator_16bits is
    component somador_completo_1bit is
        port (A, B, Cin : in std_logic; S, Cout : out std_logic);
    end component;
    
    signal carry : std_logic_vector(16 downto 0);
    signal B_ajustado : std_logic_vector(15 downto 0);
begin
    ajuste_B: for i in 0 to 15 generate
        B_ajustado(i) <= B(i) xor OP;
    end generate;
    
    carry(0) <= OP;
    
    gen_somadores: for i in 0 to 15 generate --cascateamento dos somadores
        fa: somador_completo_1bit port map (
            A => A(i), B => B_ajustado(i), Cin => carry(i),
            S => S(i), Cout => carry(i+1)
        );
    end generate;
    
    Cout <= carry(16);
end estrutural;

-- SHIFTER (DESLOCAMENTO DE 16 BITS)

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidade_shifter_16bits is
    port (
        A   : in  std_logic_vector(15 downto 0);
        dir : in  std_logic;
        S   : out std_logic_vector(15 downto 0)
    );
end unidade_shifter_16bits;

architecture comportamental of unidade_shifter_16bits is
begin
    process(A, dir)
    begin
        if dir = '0' then
            S <= A(14 downto 0) & '0'; -- Shift Left (<<)
        else
            S <= '0' & A(15 downto 1); -- Shift Right (>>)
        end if;
    end process;
end comportamental;

-- UNIDADE LÓGICA DE 16 BITS

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity unidade_logica_16bits is
    port (
        A, B : in  std_logic_vector(15 downto 0);
        op   : in  std_logic_vector(1 downto 0);
        S    : out std_logic_vector(15 downto 0)
    );
end unidade_logica_16bits;

architecture comportamental of unidade_logica_16bits is
begin
    process(A, B, op)
    begin
        case op is
            when "00" => S <= A and B;
            when "01" => S <= A or B;
            when "10" => S <= A xor B;
            when "11" => S <= A xnor B;
            when others => S <= (others => '0');
        end case;
    end process;
end comportamental;


-- ENTIDADE PRINCIPAL: ULA ESTRUTURAL 16 BITS

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ula_estrutural_16bits is
    port (
        A       : in  std_logic_vector(15 downto 0);
        B       : in  std_logic_vector(15 downto 0);
        seletor : in  std_logic_vector(2 downto 0);
        F       : out std_logic_vector(15 downto 0);
        Cout    : out std_logic;
        flag_Z  : out std_logic;
        flag_N  : out std_logic
    );
end ula_estrutural_16bits;

architecture estrutural of ula_estrutural_16bits is

    component somador_subtrator_16bits is
        port (A, B: in std_logic_vector(15 downto 0); OP: in std_logic; S: out std_logic_vector(15 downto 0); Cout: out std_logic);
    end component;

    component unidade_shifter_16bits is
        port (A: in std_logic_vector(15 downto 0); dir: in std_logic; S: out std_logic_vector(15 downto 0));
    end component;

    component unidade_logica_16bits is
        port (A, B: in std_logic_vector(15 downto 0); op: in std_logic_vector(1 downto 0); S: out std_logic_vector(15 downto 0));
    end component;

    signal fio_aritmetico : std_logic_vector(15 downto 0);
    signal fio_logico     : std_logic_vector(15 downto 0);
    signal fio_shifter    : std_logic_vector(15 downto 0);
    signal carry_soma     : std_logic;
    signal resultado_temp : std_logic_vector(15 downto 0);

begin

    
    inst_aritmetica: somador_subtrator_16bits port map (
        A => A, B => B, OP => seletor(0), S => fio_aritmetico, Cout => carry_soma
    );

   
    inst_shifter: unidade_shifter_16bits port map (
        A => A, dir => seletor(0), S => fio_shifter
    );


    inst_logica: unidade_logica_16bits port map (
        A => A, B => B, op => seletor(1 downto 0), S => fio_logico
    );

 
    with seletor select
        resultado_temp <= fio_aritmetico when "000",
                          fio_aritmetico when "001",
                          fio_shifter    when "010",
                          fio_shifter    when "011",
                          fio_logico     when others;

    F <= resultado_temp;
    
    
    Cout <= carry_soma when (seletor = "000" or seletor = "001") else '0';
    
    
    flag_Z <= '1' when resultado_temp = "0000000000000000" else '0';
    
    flag_N <= resultado_temp(15);

end estrutural;