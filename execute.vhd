library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity execute is
    port(
        clk          : in std_logic;
<<<<<<< Updated upstream
        control_in   : in std_logic_vector(5 downto 0);
        alu_op       : in std_logic_vector(2 downto 0);
=======
        control_in   : in std_logic_vector(10 downto 0);
>>>>>>> Stashed changes
        imm8_in      : in std_logic_vector(7 downto 0);
        dreg_in      : in std_logic_vector(3 downto 0);
        op1          : in std_logic_vector(15 downto 0); 
        op2          : in std_logic_vector(15 downto 0); 
        flags        : in std_logic_vector(15 downto 0);

<<<<<<< Updated upstream
        control_out  : out std_logic_vector(2 downto 0);
=======
        flags_wr     : out std_logic;
        flags_out    : out std_logic_vector(15 downto 0);
        control_out  : out std_logic_vector(4 downto 0);
>>>>>>> Stashed changes
        imm12_out    : out std_logic_vector(11 downto 0);
        mem_addr_out : out std_logic_vector(15 downto 0);
        mem_data_out : out std_logic_vector(15 downto 0);
        result       : out std_logic_vector(15 downto 0)
    );
end execute;

architecture behavioural of execute is
    signal alu_in    : std_logic_vector(15 downto 0);
    signal alu_out   : std_logic_vector(15 downto 0);
    signal alu_flags : std_logic_vector(15 downto 0); 
begin
    alu: entity work.alu
        port map(
            op1       => op1,
            op2       => op2,
            opcode    => alu_op,
            flags_in  => flags,
            output    => alu_out,
            flags_out => alu_flags
        );

    alu_in <= "00000000" & imm8_in when control_in(CONT_OUT_PC) = '1' else 
              op2;

    forward: process(clk)
    begin
        if rising_edge(clk) then
<<<<<<< Updated upstream
            control_out <= control_in(2 downto 0);
            imm12_out <= dreg_in & imm8_in;
=======
            control_out <= control_in(4 downto 0);
            imm12_out <= wb_reg_in & imm8_in;
>>>>>>> Stashed changes
            result <= alu_out;
            mem_addr_out <= op2;
            mem_data_out <= op1;
        end if;
    end process;
end behavioural;
