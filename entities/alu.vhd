library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.common_const.all;

entity alu is
    port(
        opcode: in std_logic_vector(ALU_OPCODE_LEN-1 downto 0);
        op1: in std_logic_vector(CPU_WORD-1 downto 0);
        op2: in std_logic_vector(CPU_WORD-1 downto 0);
        flags_in: in std_logic_vector(CPU_WORD-1 downto 0);

        output: out std_logic_vector(CPU_WORD-1 downto 0);
        flags_out: out std_logic_vector(CPU_WORD-1 downto 0)
    );
end alu;

architecture behavioural of alu is
    signal result : unsigned(CPU_WORD downto 0);
    signal op1u   : unsigned(CPU_WORD-1 downto 0);
    signal op2u   : unsigned(CPU_WORD-1 downto 0);
begin

    op1u <= unsigned(op1);
    op2u <= unsigned(op2);

    process (op1u, op2u, opcode)
    begin
        case opcode is
            when ALU_ADC => 
                result <= resize(op1u + op2u, CPU_WORD+1);
            when ALU_SBC => 
                result <= resize(op1u - op2u, CPU_WORD+1);
            when ALU_AND => 
                result <= resize(op1u and op2u, CPU_WORD+1);
            when ALU_OR  => 
                result <= resize(op1u or op2u, CPU_WORD+1);
            when ALU_NOT => 
                result <= resize(not op1u, CPU_WORD+1);
            when ALU_SL  => 
                result <= op1u(CPU_WORD-1 downto 0) & '0';
            when ALU_SR  => 
                result <= '0' & op1u(CPU_WORD-1 downto 0);
            when ALU_CMP => 
                result <= (others => '0');

            when ALU_ADD => 
                result <= resize(op1u + op2u, CPU_WORD+1);
            when ALU_SEQ => 
                result <= resize(op1u, CPU_WORD+1);
            when ALU_SGT =>                       
                result <= resize(op1u, CPU_WORD+1);
            when ALU_SLT =>                       
                result <= resize(op1u, CPU_WORD+1);
            when ALU_IMM_LOW => 
                result <= (others => '0'); 
            when ALU_ADD_IMM4 => 
                result <= (others => '0');
            when others => 
                result <= (others => 'X');
        end case;
    end process;

    output <= std_logic_vector(result(CPU_WORD-1 downto 0));
    flags_out <= (others => '0');

end behavioural;
