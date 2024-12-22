library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity control_unit is
    port(
        clk         : in std_logic;
        opcode      : in std_logic_vector(3 downto 0);
        flags       : in std_logic_vector(15 downto 0);

        control_out : out std_logic_vector(10 downto 0)
    );
end entity;

architecture behavioural of control_unit is

control_out(CONT_WB_SEL)
control_out(CONT_WB_EN)
control_out(CONT_IMM)
control_out(CONT_MEM_RD)
control_out(CONT_WR_FLAG)
control_out(CONT_RD_FLAG)
control_out(CONT_OP_ALU_0)
control_out(CONT_OP_ALU_1)
control_out(CONT_OP_ALU_2)
control_out(CONT_OUT_PC)

begin
    mario: process(clk)
    begin
        if rising_edge(clk) then
            if opcode(3) = '0' then
                control_out <= opcode(2 downto 0) & "0" & "11" & "00" & "0" & "11" ;
            else
                case opcode is
                    when OP_MOV =>
                        control_out <= "000" & "0" & "00" & "00" & "0" & "11";
                    when OP_JEQ_REL =>
                        control_out <= "000" & "1" & "00" & "00" & "0" & ("1" if flags(FLAG_ZERO) = 1 else "0") & "0";
                    when OP_JGT_REL =>  -- TODO CHANGE CONDITION #PORCODDIO
                        control_out <= "000" & "1" & "00" & "00" & "0" & ("1" if flags(FLAG_ZERO) = 1 else "0") & "0";
                    when OP_JLT_REL =>  -- TODO CHANGE CONDITION #PORCODDIO
                        control_out <= "000" & "1" & "00" & "00" & "0" & ("1" if flags(FLAG_ZERO) = 1 else "0") & "0";
                    when OP_LOAD_MEM =>
                        control_out <= "000" & "0" & "00" & "01" & "0" & "11";
                    when OP_LOAD_IMM =>
                        control_out <= "000" & "0" & "00" & "00" & "1" & "11";
                    when OP_STORE =>
                        control_out <= "000" & "0" & "00" & "10" & "0" & "00";
                    when OP_NOP =>
                        control_out <= (others => '0');
                end case;
            end if;
        end if;
    end process;

end behavioural;