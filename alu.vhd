library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port(
        opcode: in std_logic_vector(2 downto 0);
        op1: in std_logic_vector(15 downto 0);
        op2: in std_logic_vector(15 downto 0);
        flags_in: in std_logic_vector(15 downto 0);

        -- carry overflow negative zero - - - -

        output: out std_logic_vector(15 downto 0);
        flags_out: out std_logic_vector(15 downto 0)
    );
end alu;

architecture behavioural of alu is
    signal result : unsigned(16 downto 0);
    signal op1u   : unsigned(15 downto 0);
    signal op2u   : unsigned(15 downto 0);
begin
    process (op1, op2, opcode)
    begin
        op1u <= unsigned(op1);
        op2u <= unsigned(op2);

        case opcode is
            when "000" => 
                result <= resize(op1u + op2u, 17);
            when "001" => 
                result <= resize(op1u - op2u, 17);
            when "010" => 
                result <= resize(op1u and op2u, 17);
            when "011" => 
                result <= resize(op1u or op2u, 17);
            when "100" => 
                result <= resize(not op1u, 17);
            when "101" => 
                result <= op1u(15 downto 0) & '0';
            when "110" => 
                result <= '0' & op1u(15 downto 0);
            when "111" => 
                result <= (others => '0');
            when others => 
                result <= (others => 'X');
        end case;
    end process;

    output <= std_logic_vector(result(15 downto 0));
    flags_out <= (others => '0');

end behavioural;
