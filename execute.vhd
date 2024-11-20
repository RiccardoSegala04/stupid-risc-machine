library ieee;
use ieee.std_logic_1164.all;

entity execute_stage is
    port(
        clk          : in std_logic;
        control_in   : in std_logic_vector(4 downto 0);
        alu_op       : in std_logic_vector(2 downto 0);
        imm8_in      : in std_logic_vector(7 downto 0);
        dreg_in      : in std_logic_vector(3 downto 0);
        op1          : in std_logic_vector(15 downto 0); 
        op2          : in std_logic_vector(15 downto 0); 
        flags        : in std_logic_vector(15 downto 0);

        control_out  : out std_logic_vector(3 downto 0);
        imm8_out     : out std_logic_vector(7 downto 0);
        dreg_out     : out std_logic_vector(3 downto 0);
        result       : out std_logic_vector(15 downto 0)
    );
end execute_stage;

architecture behavioural of execute_stage is
    signal alu_in    : std_logic_vector(15 downto 0);
    signal alu_out   : std_logic_vector(15 downto 0);
    signal alu_flags : std_logc_vector(15 downto 0); 
begin
    alu: entity work.alu
        port map(
            op1       => op1,
            op2       => alu_in,
            alu_op    => opcode,
            flags     => flags_in,
            alu_out   => output,
            alu_flags => flags_out
        );

    operand_select: process
    begin
        alu_in <= op2;

        if control_in(3) then
            alu_in <= imm8_in;
        end if;
    end process;

    forward: process(clk)
    begin
        control_out <= control_in(2 downto 0);
        imm8_out <= imm8_in;
        dreg_out <= dreg_in;
        result <= alu_out;
    end process;
end behavioural;
