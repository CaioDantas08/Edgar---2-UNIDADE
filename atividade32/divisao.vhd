library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity divisao is
    Port (
        clk         : in  STD_LOGIC;
        rst         : in  STD_LOGIC;
        start       : in  STD_LOGIC;
        A_in        : in  STD_LOGIC_VECTOR(15 downto 0);
        B_in        : in  STD_LOGIC_VECTOR(15 downto 0);
        quociente   : out STD_LOGIC_VECTOR(15 downto 0);
        resto       : out STD_LOGIC_VECTOR(15 downto 0);
        erro_b_maior: out STD_LOGIC;
        erro_zero   : out STD_LOGIC;
        done        : out STD_LOGIC
    );
end divisao;

architecture Behavioral of divisao is
    type state_type is (IDLE, CHECK, SUBTRACT, ADJUST, FINISH);
    signal state, next_state : state_type;
    
    signal reg_A, reg_B : signed(16 downto 0); 
    signal cont_quociente : unsigned(15 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
            reg_A <= (others => '0');
            reg_B <= (others => '0');
            cont_quociente <= (others => '0');
        elsif rising_edge(clk) then
            state <= next_state;
            case state is
                when IDLE =>
                    if start = '1' then
                        reg_A <= signed('0' & A_in);
                        reg_B <= signed('0' & B_in);
                        cont_quociente <= (others => '0');
                    end if;
                when SUBTRACT =>
                    reg_A <= reg_A - reg_B;
                    cont_quociente <= cont_quociente + 1;
                when others => null;
            end case;
        end if;
    end process;

    process(state, start, reg_A, reg_B, B_in, A_in, cont_quociente)
    begin
        next_state <= state;
        erro_b_maior <= '1'; 
        erro_zero    <= '1'; 
        done         <= '1'; 
        
        case state is
            when IDLE =>
                if start = '1' then next_state <= CHECK; end if;
            when CHECK =>
                if unsigned(B_in) = 0 then
                    erro_zero <= '0';
                    next_state <= FINISH;
                elsif unsigned(B_in) > unsigned(A_in) then
                    erro_b_maior <= '0';
                    next_state <= FINISH;
                else
                    next_state <= SUBTRACT;
                end if;
            when SUBTRACT =>
                if (reg_A - reg_B) < 0 then
                    next_state <= ADJUST;
                elsif (reg_A - reg_B) = 0 then
                    next_state <= FINISH;
                else
                    next_state <= SUBTRACT;
                end if;
            when ADJUST =>
                resto <= std_logic_vector(reg_A(15 downto 0));
                quociente <= std_logic_vector(cont_quociente - 1);
                next_state <= FINISH;
            when FINISH =>
                done <= '0'; 
                if reg_A = 0 then
                    resto <= (others => '0');
                    quociente <= std_logic_vector(cont_quociente);
                end if;
                if start = '0' then next_state <= IDLE; end if;
        end case;
    end process;
end Behavioral;