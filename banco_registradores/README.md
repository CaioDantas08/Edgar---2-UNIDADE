# Banco de Registradores — Atividade 3.1

8 registradores de 16 bits, construídos "por dentro" (MUX 2:1 + Flip-Flop D
em cada bit), conforme os diagramas discutidos em aula.

## Arquivos

| Arquivo | Descrição |
|---|---|
| `mux2x1_1bit.vhd` | MUX 2:1 de 1 bit (seleciona D ou Q pela `we`) |
| `flipflop_d_1bit.vhd` | Flip-Flop D, sensível à borda de subida |
| `registrador_1bit.vhd` | Célula de 1 bit = MUX + Flip-Flop (estrutural) |
| `registrador_16bits.vhd` | 16 × `registrador_1bit` (generate) |
| `banco_registradores.vhd` | 8 × `registrador_16bits` + decodificador de escrita + MUX 8:1 de leitura |
| `tb_banco_registradores.vhd` | Testbench para simulação |
| `banco_registradores_de2115.vhd` | Top-level para a placa DE2-115 |

Hierarquia: `banco_registradores` → `registrador_16bits` → `registrador_1bit`
→ `mux2x1_1bit` + `flipflop_d_1bit`.

## Como simular no EDA Playground

1. Acesse https://www.edaplayground.com
2. Em **Language**: VHDL. Em **Tools & Simulators**: `GHDL` (ou ModelSim, se disponível).
3. Cole o conteúdo de `tb_banco_registradores.vhd` na caixa **Testbench**.
4. Na caixa **Design**, cole (nesta ordem, um após o outro, no mesmo arquivo
   ou em arquivos separados usando o botão "+" para adicionar arquivos):
   - `mux2x1_1bit.vhd`
   - `flipflop_d_1bit.vhd`
   - `registrador_1bit.vhd`
   - `registrador_16bits.vhd`
   - `banco_registradores.vhd`
5. Marque a opção **Open EPWave after run** para ver as formas de onda.
6. Clique em **Run**.

Também é possível rodar localmente com GHDL:

```bash
ghdl -a --std=93 mux2x1_1bit.vhd flipflop_d_1bit.vhd registrador_1bit.vhd \
                 registrador_16bits.vhd banco_registradores.vhd \
                 tb_banco_registradores.vhd
ghdl -e --std=93 tb_banco_registradores
ghdl -r --std=93 tb_banco_registradores --vcd=onda.vcd --stop-time=200ns
gtkwave onda.vcd   # (opcional, para visualizar as formas de onda)
```

### O que o testbench verifica
- Escreve `0x00AA` no registrador 0, `0x1234` no registrador 3 e
  `0xFFFF` no registrador 7.
- Lê os três registradores de volta e confirma os valores.
- Lê o registrador 1 (nunca escrito).
- Tenta escrever no registrador 0 com `we = '0'` e confirma que o
  valor **não** muda (continua `0x00AA`).

Todos os casos foram validados com GHDL antes da entrega.

## Como prototipar na placa DE2-115 (Quartus)

1. Crie um projeto no Quartus e adicione todos os arquivos `.vhd`
   **exceto** o testbench (`tb_banco_registradores.vhd` não entra na síntese).
2. Defina `banco_registradores_de2115` como **Top-Level Entity**.
3. Faça o *pin assignment* (Assignments → Pin Planner) usando o arquivo
   `.qsf`/mapeamento padrão da DE2-115 para `SW`, `KEY` e `LEDR`
   (esses nomes já seguem a convenção usual dos exemplos da Altera/Terasic
   para essa placa).
4. Compile e programe a placa.

### Como testar na placa
1. Ajuste `SW(17 downto 15)` = endereço de escrita (0 a 7).
2. Ajuste `SW(7 downto 0)` = dado a escrever (8 bits).
3. Ligue `SW(11) = 1` (habilita escrita).
4. Pressione e solte `KEY(0)` **uma vez** → grava o dado (borda de subida manual).
5. Desligue `SW(11) = 0`.
6. Ajuste `SW(14 downto 12)` = endereço de leitura (0 a 7).
7. O valor lido aparece imediatamente em `LEDR(15 downto 0)`
   (a leitura é combinacional, não depende do clock).

> **Nota:** por limitação de 18 chaves na placa, o dado de entrada foi
> reduzido a 8 bits nesta demonstração (os 8 bits superiores ficam em
> `'0'`). Se quiser demonstrar os 16 bits completos, altere o
> mapeamento em `banco_registradores_de2115.vhd` — por exemplo,
> usando `KEY(3 downto 1)` para alternar entre "byte baixo" e
> "byte alto" antes de pressionar `KEY(0)`.
