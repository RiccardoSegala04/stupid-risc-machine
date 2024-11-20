library ieee;
use ieee.std_logic_1164.all;

package common_const is
    -- ALU OPERATIONS
    constant ALU_ADC : std_logic_vector(2 downto 0) := "000";
    constant ALU_SBC : std_logic_vector(2 downto 0) := "001";
    constant ALU_AND : std_logic_vector(2 downto 0) := "010";
    constant ALU_OR  : std_logic_vector(2 downto 0) := "011";
    constant ALU_NOT : std_logic_vector(2 downto 0) := "100";
    constant ALU_SL  : std_logic_vector(2 downto 0) := "101";
    constant ALU_SR  : std_logic_vector(2 downto 0) := "110";
    constant ALU_CMP : std_logic_vector(2 downto 0) := "111";

end package common_const;
