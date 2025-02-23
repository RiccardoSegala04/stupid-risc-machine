library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.common_const.all;

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is
    signal opcode    : std_logic_vector(3 downto 0);
    signal op1       : std_logic_vector(15 downto 0);
    signal op2       : std_logic_vector(15 downto 0);
    signal flags_in  : std_logic_vector(15 downto 0);
    signal output    : std_logic_vector(15 downto 0);
    signal flags_out : std_logic_vector(15 downto 0);
begin

    uut: entity work.alu port map (
        opcode => opcode,
        op1 => op1,
        op2 => op2,
        flags_in => flags_in,
        output => output,
        flags_out => flags_out
    );

    process
    begin
        flags_in <= (others => '0');
        op1 <= "0000000000001010";
        op2 <= "0000000000000001";
        opcode <= ALU_ADC;

        wait for 10 ns;
        wait;
    end process;

end testbench;
