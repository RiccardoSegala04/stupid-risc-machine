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
    constant CONT_WB_SEL  : integer := 5;
    constant CONT_WB_EN   : integer := 4;
    constant CONT_ABS     : integer := 3;
    constant CONT_MEM_RD  : integer := 2;
    constant CONT_OP_MATH : integer := 1;
    constant CONT_OUT_PC  : integer := 0;

end package common_const;
