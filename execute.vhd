library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity execute is
    port(
        clk          : in std_logic;
        control_in   : in std_logic_vector(9 downto 0);
        imm8_in      : in std_logic_vector(7 downto 0);
        wb_reg_in    : in std_logic_vector(3 downto 0);
        op1          : in std_logic_vector(15 downto 0); 
        op2          : in std_logic_vector(15 downto 0); 
        flags_in     : in std_logic_vector(15 downto 0);

        flags_wr     : out std_logic;
        flags_out    : out std_logic_vector(15 downto 0);
        control_out  : out std_logic_vector(3 downto 0);
        imm12_out    : out std_logic_vector(11 downto 0);
        mem_addr_out : out std_logic_vector(15 downto 0);
        mem_data_out : out std_logic_vector(15 downto 0);
        result       : out std_logic_vector(15 downto 0)
    );
end execute;

architecture behavioural of execute is
    signal alu_in    : std_logic_vector(15 downto 0);
    signal alu_out   : std_logic_vector(15 downto 0);
    signal alu_op    : std_logic_vector(2 downto 0);
begin

    alu_op <= control_in(CONT_OP_ALU_2 downto CONT_OP_ALU_0);

    flags_wr <= control_in(CONT_WR_FLAG);

    alu_in <= "0000" & wb_reg_in & imm8_in when control_in(CONT_OUT_PC) = '1' else op2;

    alu: entity work.alu
        port map(
            op1       => op1,
            op2       => alu_in,
            opcode    => alu_op,
            flags_in  => flags,
            output    => alu_out,
            flags_out => flags_out
        );

    forward: process(clk)
    begin
        if rising_edge(clk) then
            control_out <= control_in(2 downto 0);
            imm12_out <= wb_reg_in & imm8_in;
            result <= alu_out;
            mem_addr_out <= op2;
            mem_data_out <= op1;
        end if;
    end process;
end behavioural;
