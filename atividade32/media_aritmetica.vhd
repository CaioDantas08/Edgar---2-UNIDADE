library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity media is
    Port (
        clk      : in  STD_LOGIC;
        rst      : in  STD_LOGIC;
        start    : in  STD_LOGIC;
        Y_in     : in  STD_LOGIC_VECTOR(15 downto 0);
        media_out: out STD_LOGIC_VECTOR(15 downto 0);
        done     : out STD_LOGIC
    );
end media;

architecture Behavioral of media is
    constant X_CONST : unsigned(15 downto 0) := to_unsigned(5678, 16);
    type state_type is (IDLE, CALC_SUM, SHIFT_DIV, FINISH);
    signal state, next_state : state_type;
    signal soma_temp : unsigned(16 downto 0); 
    signal reg_media : unsigned(15 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            state <= IDLE;
            soma_temp <= (others => '0');
            reg_media <= (others => '0');
        elsif rising_edge(clk) then
            state <= next_state;
            case state is
                when IDLE =>
                    if start = '1' then soma_temp <= (others => '0'); end if;
                when CALC_SUM =>
                    soma_temp <= resize(X_CONST, 17) + resize(unsigned(Y_in), 17);
                when SHIFT_DIV =>
                    reg_media <= soma_temp(16 downto 1);
                when others => null;
            end case;
        end if;
    end process;

    process(state, start)
    begin
        next_state <= state;
        done <= '1';
        case state is
            when IDLE =>
                if start = '1' then next_state <= CALC_SUM; end if;
            when CALC_SUM => next_state <= SHIFT_DIV;
            when SHIFT_DIV => next_state <= FINISH;
            when FINISH =>
                done <= '0';
                if start = '0' then next_state <= IDLE; end if;
        end case;
    end process;
    media_out <= std_logic_vector(reg_media);
end Behavioral;