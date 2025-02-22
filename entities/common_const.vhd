library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common_const is

    -- CPU GENERAL
    constant CPU_WORD                    : integer := 16;
    constant CPU_OPCODE_LEN              : integer := 4;
    constant CPU_CONTROL_LEN             : integer := 11;

    -- ALU GENERAL
    constant ALU_OPCODE_LEN              : integer := 4;

    -- CONTROL GENERAL
    constant EXECUTE_STAGE_CONTROL_LEN   : integer := CPU_CONTROL_LEN;
    constant MEMORY_STAGE_CONTROL_LEN    : integer := 5;
    constant WRITEBACK_STAGE_CONTROL_LEN : integer := 3;
    
    -- OPCODES
    constant OP_ADC      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0000";
    constant OP_SBC      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0001";
    constant OP_AND      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0010";
    constant OP_OR       : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0011";
    constant OP_XOR      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0100";
    constant OP_NOT      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0101";
    constant OP_SL       : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0110";
    constant OP_SR       : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0111";
    constant OP_MUL      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1000";
    constant OP_ADD      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1001";
    constant OP_JEQ_REL  : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1010";
    constant OP_JGT_REL  : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1011";
    constant OP_JLT_REL  : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1100";
    constant OP_LOAD_MEM : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1101";
    constant OP_LOAD_IMM : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1110";
    constant OP_STORE    : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "1111";

    -- ALU OPCODES
    constant ALU_ADC      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0000";
    constant ALU_SBC      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0001";
    constant ALU_AND      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0010";
    constant ALU_OR       : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0011";
    constant ALU_NOT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0100";
    constant ALU_SL       : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0101";
    constant ALU_SR       : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0110";
    constant ALU_MUL      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0111";
    constant ALU_ADD      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1000";
    constant ALU_SEQ      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1001";
    constant ALU_SGT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1010";
    constant ALU_SLT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1011";
    constant ALU_ADD_IMM4 : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1100";

    -- CONTROL SIGNALS
    constant CONT_WB_SEL      : integer := 0;
    constant CONT_WB_EN       : integer := 1;
    constant CONT_IMM         : integer := 2;
    constant CONT_MEM_RD      : integer := 3;
    constant CONT_MEM_WR      : integer := 4;
    constant CONT_OUT_PC      : integer := 5;
    constant CONT_ALU_IN2_SEL : integer := 6;
    constant CONT_OP_ALU_0    : integer := 7;
    constant CONT_OP_ALU_1    : integer := 8;
    constant CONT_OP_ALU_2    : integer := 9;
    constant CONT_OP_ALU_3    : integer := 10;

    -- CONTROL SIGNALS FLAGS
    constant CF_WB_SEL      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000000001";
    constant CF_WB_EN       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000000010";
    constant CF_IMM         : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000000100";
    constant CF_MEM_RD      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000001000";
    constant CF_MEM_WR      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000010000";
    constant CF_OUT_PC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00000100000";
    constant CF_ALU_IN2_SEL : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "00001000000";

    constant CF_OP_ADC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADC      & "0000000";
    constant CF_OP_SBC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SBC      & "0000000";
    constant CF_OP_AND      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_AND      & "0000000";
    constant CF_OP_OR       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_OR       & "0000000";
    constant CF_OP_NOT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_NOT      & "0000000";
    constant CF_OP_SL       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SL       & "0000000";
    constant CF_OP_SR       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SR       & "0000000";
    constant CF_OP_MUL      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_MUL      & "0000000";
    constant CF_OP_ADD      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADD      & "0000000";
    constant CF_OP_SEQ      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SEQ      & "0000000";
    constant CF_OP_SGT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SGT      & "0000000";
    constant CF_OP_SLT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SLT      & "0000000";
    constant CF_OP_ADD_IMM4 : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADD_IMM4 & "0000000";

    -- REGISTER ADDRESSES
    constant REG_0_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0000";
    constant REG_1_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0001";
    constant REG_2_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0010";
    constant REG_3_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0011";
    constant REG_4_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0100";
    constant REG_5_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0101";
    constant REG_6_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0110";
    constant REG_7_LOGIC_VEC     : std_logic_vector(3 downto 0) := "0111";
    constant REG_8_LOGIC_VEC     : std_logic_vector(3 downto 0) := "1000";
    constant REG_9_LOGIC_VEC     : std_logic_vector(3 downto 0) := "1001";
    constant REG_10_LOGIC_VEC    : std_logic_vector(3 downto 0) := "1010";
    constant REG_11_LOGIC_VEC    : std_logic_vector(3 downto 0) := "1011";
    constant REG_12_LOGIC_VEC    : std_logic_vector(3 downto 0) := "1100";
    constant REG_13_LOGIC_VEC    : std_logic_vector(3 downto 0) := "1101";
    constant REG_PC_LOGIC_VEC    : std_logic_vector(3 downto 0) := "1110";
    constant REG_FLAGS_LOGIC_VEC : std_logic_vector(3 downto 0) := "1111";

    constant REG_0     : integer := 0;
    constant REG_1     : integer := 1;
    constant REG_2     : integer := 2;
    constant REG_3     : integer := 3;
    constant REG_4     : integer := 4;
    constant REG_5     : integer := 5;
    constant REG_6     : integer := 6;
    constant REG_7     : integer := 7;
    constant REG_8     : integer := 8;
    constant REG_9     : integer := 9;
    constant REG_10    : integer := 10;
    constant REG_11    : integer := 11;
    constant REG_12    : integer := 12;
    constant REG_13    : integer := 13;
    constant REG_PC    : integer := 14;
    constant REG_FLAGS : integer := 15;

end package common_const;
