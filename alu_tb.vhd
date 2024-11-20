library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end alu_tb;

architecture testbench of alu_tb is
    signal opcode    : std_logic_vector(2 downto 0);
    signal op1       : std_logic_vector(15 downto 0);
    signal op2       : std_logic_vector(15 downto 0);
    signal flags_in  : std_logic_vector(15 downto 0);
    signal output    : std_logic_vector(15 downto 0);
    signal flags_out : std_logic_vector(15 downto 0);

    component alu
        port (
            opcode    : in std_logic_vector(2 downto 0);
            op1       : in std_logic_vector(15 downto 0);
            op2       : in std_logic_vector(15 downto 0);
            flags_in  : in std_logic_vector(15 downto 0);
            output    : out std_logic_vector(15 downto 0);
            flags_out : out std_logic_vector(15 downto 0)
        );
    end component;
begin

    uut: alu port map (
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

        for op in 0 to 7 loop
            opcode <= std_logic_vector(to_unsigned(op, 3));
            wait for 10 ns;
        end loop;
        wait;
    end process;

end testbench;
