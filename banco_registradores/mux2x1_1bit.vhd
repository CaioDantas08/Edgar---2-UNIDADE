-- ===================================================================
-- MUX 2:1 de 1 bit
-- Seleciona entre a entrada externa (D) e a saida atual do
-- flip-flop (Q, realimentacao), de acordo com o write enable (we).
--
--   we = '1'  ->  S = D   (carrega o novo dado)
--   we = '0'  ->  S = Q   (mantem o valor armazenado)
-- ===================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux2x1_1bit is
    port (
        D  : in  std_logic;  -- dado novo (entrada externa)
        Q  : in  std_logic;  -- valor atual armazenado (realimentacao)
        we : in  std_logic;  -- write enable (seletor do mux)
        S  : out std_logic   -- saida do mux -> entrada D do flip-flop
    );
end mux2x1_1bit;

architecture dataflow of mux2x1_1bit is
begin
    S <= D when we = '1' else Q;
end dataflow;
