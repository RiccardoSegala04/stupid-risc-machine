library ieee;
use ieee.std_logic_1164.all;

package common_const is
    
    -- OPCODES
    constant OP_ADC      : std_logic_vector(3 downto 0) := "0000";
    constant OP_SBC      : std_logic_vector(3 downto 0) := "0001";
    constant OP_AND      : std_logic_vector(3 downto 0) := "0010";
    constant OP_OR       : std_logic_vector(3 downto 0) := "0011";
    constant OP_NOT      : std_logic_vector(3 downto 0) := "0100";
    constant OP_SL       : std_logic_vector(3 downto 0) := "0101";
    constant OP_SR       : std_logic_vector(3 downto 0) := "0110";
    constant OP_CMP      : std_logic_vector(3 downto 0) := "0111";
    constant OP_JMP_ABS  : std_logic_vector(3 downto 0) := "1000";
    constant OP_JEQ_REL  : std_logic_vector(3 downto 0) := "1001";
    constant OP_JGT_REL  : std_logic_vector(3 downto 0) := "1010";
    constant OP_JLT_REL  : std_logic_vector(3 downto 0) := "1011";
    constant OP_LOAD_MEM : std_logic_vector(3 downto 0) := "1100";
    constant OP_LOAD_IMM : std_logic_vector(3 downto 0) := "1101";
    constant OP_STORE    : std_logic_vector(3 downto 0) := "1110";
    constant OP_NOP      : std_logic_vector(3 downto 0) := "1111";

    -- ALU OPERATIONS
    constant ALU_ADC : std_logic_vector(2 downto 0) := "000";
    constant ALU_SBC : std_logic_vector(2 downto 0) := "001";
    constant ALU_AND : std_logic_vector(2 downto 0) := "010";
    constant ALU_OR  : std_logic_vector(2 downto 0) := "011";
    constant ALU_NOT : std_logic_vector(2 downto 0) := "100";
    constant ALU_SL  : std_logic_vector(2 downto 0) := "101";
    constant ALU_SR  : std_logic_vector(2 downto 0) := "110";
    constant ALU_CMP : std_logic_vector(2 downto 0) := "111";

    -- CONTROL SIGNALS
    constant CONT_WB_SEL  : integer := 0;
    constant CONT_WB_EN   : integer := 1;
    constant CONT_ABS     : integer := 2;
    constant CONT_MEM_RD  : integer := 3;
    constant CONT_OP_MATH : integer := 4;
    constant CONT_OUT_PC  : integer := 5;

    -- REGISTER ADDRESSES
    constant REG_0     : std_logic_vector(3 downto 0) := "0000";
    constant REG_1     : std_logic_vector(3 downto 0) := "0001";
    constant REG_2     : std_logic_vector(3 downto 0) := "0010";
    constant REG_3     : std_logic_vector(3 downto 0) := "0011";
    constant REG_4     : std_logic_vector(3 downto 0) := "0100";
    constant REG_5     : std_logic_vector(3 downto 0) := "0101";
    constant REG_6     : std_logic_vector(3 downto 0) := "0110";
    constant REG_7     : std_logic_vector(3 downto 0) := "0111";
    constant REG_8     : std_logic_vector(3 downto 0) := "1000";
    constant REG_9     : std_logic_vector(3 downto 0) := "1001";
    constant REG_10    : std_logic_vector(3 downto 0) := "1010";
    constant REG_11    : std_logic_vector(3 downto 0) := "1011";
    constant REG_12    : std_logic_vector(3 downto 0) := "1100";
    constant REG_13    : std_logic_vector(3 downto 0) := "1101";
    constant REG_PC    : std_logic_vector(3 downto 0) := "1110";
    constant REG_FLAGS : std_logic_vector(3 downto 0) := "1111";

end package common_const;
