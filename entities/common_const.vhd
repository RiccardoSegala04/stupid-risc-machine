library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package common_const is

    -- CPU GENERAL
    constant CPU_WORD                    : integer := 16;
    constant CPU_OPCODE_LEN              : integer := 4;
    constant CPU_CONTROL_LEN             : integer := 10;
    constant CPU_REG_ADDR_LEN            : integer := 4;

    -- ALU GENERAL
    constant ALU_OPCODE_LEN              : integer := 4;

    -- CONTROL GENERAL
    constant EXECUTE_STAGE_CONTROL_LEN   : integer := CPU_CONTROL_LEN;
    constant MEMORY_STAGE_CONTROL_LEN    : integer := 4;
    constant WRITEBACK_STAGE_CONTROL_LEN : integer := 2;
    
    -- OPCODES
    constant OP_ADC      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0000";
    constant OP_SBC      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0001";
    constant OP_AND      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0010";
    constant OP_OR       : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0011";
    constant OP_XOR      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0100";
    -- constant OP_NOT      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0101";
    constant OP_CMP      : std_logic_vector(CPU_OPCODE_LEN-1 downto 0) := "0101";
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
    -- constant ALU_NOT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0100";
    constant ALU_CMP      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0100";
    constant ALU_SL       : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0101";
    constant ALU_SR       : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0110";
    constant ALU_MUL      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "0111";
    constant ALU_ADD      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1000";
    constant ALU_SEQ      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1001";
    constant ALU_SGT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1010";
    constant ALU_SLT      : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1011";
    constant ALU_ADD_IMM4 : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1100";
    constant ALU_FW_IMM8  : std_logic_vector(ALU_OPCODE_LEN-1 downto 0) := "1101";

    -- FLAGS
    constant FLAGS_CARRY    : integer := 0;
    constant FLAGS_ZERO     : integer := 1;
    constant FLAGS_NEGATIVE : integer := 2;
    constant FLAGS_OVERFLOW : integer := 3;

    -- CONTROL SIGNALS
    constant CONT_WB_SEL      : integer := 0;
    constant CONT_WB_EN       : integer := 1;
    constant CONT_MEM_RD      : integer := 2;
    constant CONT_MEM_WR      : integer := 3;
    constant CONT_OUT_PC      : integer := 4;
    constant CONT_ALU_IN2_SEL : integer := 5;
    constant CONT_OP_ALU_0    : integer := 6;
    constant CONT_OP_ALU_1    : integer := 7;
    constant CONT_OP_ALU_2    : integer := 8;
    constant CONT_OP_ALU_3    : integer := 9;

    -- CONTROL SIGNALS FLAGS
    constant CF_WB_SEL      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000000001";
    constant CF_WB_EN       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000000010";
    constant CF_MEM_RD      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000000100";
    constant CF_MEM_WR      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000001000";
    constant CF_OUT_PC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000010000";
    constant CF_ALU_IN2_SEL : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := "0000100000";

    constant CF_OP_ADC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADC      & "000000";
    constant CF_OP_SBC      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SBC      & "000000";
    constant CF_OP_AND      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_AND      & "000000";
    constant CF_OP_OR       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_OR       & "000000";
--    constant CF_OP_NOT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_NOT      & "000000";
    constant CF_OP_CMP      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_CMP      & "000000";
    constant CF_OP_SL       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SL       & "000000";
    constant CF_OP_SR       : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SR       & "000000";
    constant CF_OP_MUL      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_MUL      & "000000";
    constant CF_OP_ADD      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADD      & "000000";
    constant CF_OP_SEQ      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SEQ      & "000000";
    constant CF_OP_SGT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SGT      & "000000";
    constant CF_OP_SLT      : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_SLT      & "000000";
    constant CF_OP_ADD_IMM4 : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_ADD_IMM4 & "000000";
    constant CF_OP_FW_IMM8  : std_logic_vector(CPU_CONTROL_LEN-1 downto 0) := ALU_FW_IMM8  & "000000";

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

    -- HECU
    constant HECU_SEL_REG : std_logic_vector(1 downto 0) := "00";
    constant HECU_SEL_MEM : std_logic_vector(1 downto 0) := "01";
    constant HECU_SEL_EXE : std_logic_vector(1 downto 0) := "10";
    constant HECU_SEL_WB  : std_logic_vector(1 downto 0) := "11";

end package common_const;
