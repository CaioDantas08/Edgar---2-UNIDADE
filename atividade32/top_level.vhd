library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level is
    Port (
        CLOCK_50 : in  STD_LOGIC;
        SW       : in  STD_LOGIC_VECTOR(17 downto 0);
        KEY      : in  STD_LOGIC_VECTOR(1 downto 0);
        LEDR     : out STD_LOGIC_VECTOR(17 downto 0);
        LEDG     : out STD_LOGIC_VECTOR(8 downto 0);
        HEX0, HEX1, HEX2, HEX3 : out STD_LOGIC_VECTOR(6 downto 0);
        HEX4, HEX5, HEX6, HEX7 : out STD_LOGIC_VECTOR(6 downto 0)
    );
end top_level;

architecture Structural of top_level is
    signal rst, enter : STD_LOGIC;
    signal enter_prev : STD_LOGIC := '1';
    signal enter_pulse : STD_LOGIC := '0';
    
    signal A_val, B_val, Y_val : STD_LOGIC_VECTOR(15 downto 0);
    signal div_quociente, div_resto, med_resultado : STD_LOGIC_VECTOR(15 downto 0);
    signal div_start, med_start : STD_LOGIC := '0';
    signal div_done, med_done, err_b, err_z : STD_LOGIC;
    
    signal display_val : STD_LOGIC_VECTOR(15 downto 0);
    signal initial_letter : STD_LOGIC_VECTOR(6 downto 0);
    
    type top_state_t is (ST_WAIT_A, ST_WAIT_B, ST_DIV_CALC, ST_DIV_DONE, ST_WAIT_Y, ST_MED_CALC, ST_MED_DONE);
    signal top_state : top_state_t := ST_WAIT_A;
    
    component divisao 
        Port ( clk, rst, start : in STD_LOGIC; A_in, B_in : in STD_LOGIC_VECTOR(15 downto 0); quociente, resto : out STD_LOGIC_VECTOR(15 downto 0); erro_b_maior, erro_zero, done : out STD_LOGIC); 
    end component;
    
    component media 
        Port ( clk, rst, start : in STD_LOGIC; Y_in : in STD_LOGIC_VECTOR(15 downto 0); media_out : out STD_LOGIC_VECTOR(15 downto 0); done : out STD_LOGIC); 
    end component;
    
    component conversor_ex_7seg 
        Port ( hex : in STD_LOGIC_VECTOR(3 downto 0); 
               seg_7 : out STD_LOGIC_VECTOR(6 downto 0)); 
    end component;

begin
    rst <= not KEY(0); 
    enter <= not KEY(1); 
    
    process(CLOCK_50)
    begin
        if rising_edge(CLOCK_50) then
            enter_pulse <= '0';
            if enter = '1' and enter_prev = '0' then
                enter_pulse <= '1';
            end if;
            enter_prev <= enter;
        end if;
    end process;

    U_DIV: divisao port map (CLOCK_50, rst, div_start, A_val, B_val, div_quociente, div_resto, err_b, err_z, div_done);
    U_MED: media port map (CLOCK_50, rst, med_start, Y_val, med_resultado, med_done);
    
    H0: conversor_ex_7seg port map (hex => display_val(3 downto 0), seg_7 => HEX0);
    H1: conversor_ex_7seg port map (hex => display_val(7 downto 4), seg_7 => HEX1);
    H2: conversor_ex_7seg port map (hex => display_val(11 downto 8), seg_7 => HEX2);
    H3: conversor_ex_7seg port map (hex => display_val(15 downto 12), seg_7 => HEX3);

    process(CLOCK_50, rst)
    begin
        if rst = '1' then
            if SW(17) = '0' then top_state <= ST_WAIT_A;
            else top_state <= ST_WAIT_Y; end if;
            div_start <= '0'; med_start <= '0';
        elsif rising_edge(CLOCK_50) then
            case top_state is
                when ST_WAIT_A =>
                    if SW(17) = '1' then top_state <= ST_WAIT_Y; end if;
                    display_val <= SW(15 downto 0);
                    if enter_pulse = '1' then
                        A_val <= SW(15 downto 0);
                        top_state <= ST_WAIT_B;
                    end if;
                when ST_WAIT_B =>
                    display_val <= SW(15 downto 0);
                    if enter_pulse = '1' then
                        B_val <= SW(15 downto 0);
                        div_start <= '1';
                        top_state <= ST_DIV_CALC;
                    end if;
                when ST_DIV_CALC =>
                    if div_done = '0' then 
                        div_start <= '0';
                        top_state <= ST_DIV_DONE;
                    end if;
                when ST_DIV_DONE =>
                    display_val <= div_quociente; 
                    if enter_pulse = '1' then top_state <= ST_WAIT_A; end if;

                when ST_WAIT_Y =>
                    if SW(17) = '0' then top_state <= ST_WAIT_A; end if;
                    display_val <= SW(15 downto 0);
                    if enter_pulse = '1' then
                        Y_val <= SW(15 downto 0);
                        med_start <= '1';
                        top_state <= ST_MED_CALC;
                    end if;
                when ST_MED_CALC =>
                    if med_done = '0' then
                        med_start <= '0';
                        top_state <= ST_MED_DONE;
                    end if;
                when ST_MED_DONE =>
                    display_val <= med_resultado;
                    if enter_pulse = '1' then top_state <= ST_WAIT_Y; end if;
            end case;
        end if;
    end process;

    LEDR(0) <= err_z;   
    LEDR(1) <= err_b;
    LEDG(0) <= div_done and med_done; 

    -- Letra E conforme o seu código original
    initial_letter <= "0110000" when top_state = ST_WAIT_Y else "1111111";
    HEX7 <= initial_letter;
    
    HEX4 <= (others => '1'); HEX5 <= (others => '1'); HEX6 <= (others => '1');
end Structural;