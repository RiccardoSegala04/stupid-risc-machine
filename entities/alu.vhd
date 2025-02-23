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
    signal op1s   : signed(CPU_WORD-1 downto 0);
    signal op2s   : signed(CPU_WORD-1 downto 0);

    signal carry  : unsigned(0 downto 0);
begin

    op1u <= unsigned(op1);
    op2u <= unsigned(op2);
    op1s <= signed(op1);
    op2s <= signed(op2);
    carry <= to_unsigned(1, 1) when flags_in(FLAGS_CARRY) = '1' 
                               else to_unsigned(0, 1);

    process (op1u, op2u, op1s, op2s, opcode)
    begin
        case opcode is
            when ALU_ADC => 
                result <= resize(op1u + op2u + carry, CPU_WORD+1);
                flags_out(FLAGS_CARRY) <= result(CPU_WORD);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

                if (op1s(CPU_WORD-1) = op2s(CPU_WORD-1)) then
                    if (op1s(CPU_WORD-1) /= result(CPU_WORD-1)) then
                        flags_out(FLAGS_OVERFLOW) <= '1';
                    else
                        flags_out(FLAGS_OVERFLOW) <= '0';
                    end if;
                else
                    flags_out(FLAGS_OVERFLOW) <= '0';
                end if;

            when ALU_SBC => 
                result <= resize(op1u - op2u - carry, CPU_WORD+1);
                if op1u < (op2u + carry) then
                    flags_out(FLAGS_CARRY) <= '1';
                else
                    flags_out(FLAGS_CARRY) <= '0';
                end if;
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

                if (op1s(CPU_WORD-1) /= op2s(CPU_WORD-1)) then  
                    if (op1s(CPU_WORD-1) /= result(CPU_WORD-1)) then  
                        flags_out(FLAGS_OVERFLOW) <= '1';
                    else
                        flags_out(FLAGS_OVERFLOW) <= '0';
                    end if;
                else
                    flags_out(FLAGS_OVERFLOW) <= '0';
                end if;

            when ALU_AND => 
                result <= resize(op1u and op2u, CPU_WORD+1);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_OR  => 
                result <= resize(op1u or op2u, CPU_WORD+1);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_NOT => 
                result <= resize(not op1u, CPU_WORD+1);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_SL  => 
                result <= op1u(CPU_WORD-1 downto 0) & '0';
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_SR  => 
                result <= '0' & op1u(CPU_WORD-1 downto 0);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_MUL => 
                result <= resize(op1u * op2u, CPU_WORD+1);
                if result = 0 then
                    flags_out(FLAGS_ZERO) <= '1'; 
                else
                    flags_out(FLAGS_ZERO) <= '0'; 
                end if;
                flags_out(FLAGS_NEGATIVE) <= result(CPU_WORD-1);

            when ALU_ADD => 
                result <= resize(op1u + op2u, CPU_WORD+1);
            when ALU_SEQ => 
                if flags_in(FLAGS_ZERO) = '1' then
                    result <= unsigned(op1s + resize(signed(op2(11 downto 0)), CPU_WORD));
                else
                    result <= resize(op1u, CPU_WORD+1);
                end if;

            when ALU_SGT =>                       
                if ((flags_in(FLAGS_NEGATIVE) xor flags_in(FLAGS_OVERFLOW)) or flags_in(FLAGS_ZERO)) = '0'  then
                    result <= unsigned(op1s + resize(signed(op2(11 downto 0)), CPU_WORD));
                else
                    result <= resize(op1u, CPU_WORD+1);
                end if;
                result <= resize(op1u, CPU_WORD+1);
            when ALU_SLT =>                       
                if (flags_in(FLAGS_NEGATIVE) xor flags_in(FLAGS_OVERFLOW)) = '1' then
                    result <= unsigned(op1s + resize(signed(op2(11 downto 0)), CPU_WORD));
                else
                    result <= resize(op1u, CPU_WORD+1);
                end if;
            when ALU_ADD_IMM4 => 
                result <= resize(op1u + unsigned(op2(3 downto 0)), CPU_WORD+1);
            when ALU_FW_IMM8 =>
                result <= unsigned("000000000" & op2(11 downto 4));
            when others => 
                result <= (others => 'X');
        end case;
    end process;

    output <= std_logic_vector(result(CPU_WORD-1 downto 0));
    flags_out <= (others => '0');

end behavioural;
