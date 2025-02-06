library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

-- Entity declaration for the control unit.
-- The control unit generates control signals based on the opcode and flags.
entity control is
    port(
        opcode      : in std_logic_vector(3 downto 0);                            -- Opcode to determine the operation type.
        flags       : in std_logic_vector(15 downto 0);                           -- Flags (e.g., for condition checking).
                                                                                                        
        control_out : out std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0)  -- Control signal output for the execute stage.
    );
end entity;

architecture behavioural of control is
    -- Define constant control signal patterns for specific operations.
    constant CTRL_MOV      : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0) := "00000000011";
    constant CTRL_LOAD_MEM : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0) := "00000001011";
    constant CTRL_LOAD_IMM : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0) := "00000000111";
    constant CTRL_STORE    : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0) := "00000010000";
    constant CTRL_NOP      : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0) := (others => '0');

    -- Signal for branch enable, used for conditional branches.
    signal branch_enable   : std_logic;
begin
    -- Process triggered on the rising edge of the clock.
    process(opcode, flags)
    begin
        -- Check if the MSB (Most Significant Bit) of the opcode is '0'.
        -- Used to distinguish mathematical operations
        if opcode(3) = '0' then
            -- Generate control signals for mathematical operations based on opcode.
            -- ALU opcode matches with the last 3 LSB of the current
            control_out <= opcode(2 downto 0) & "0" & "11" & "00" & "0" & "11" ;
        else
            -- Case statement to handle specific opcodes.
            case opcode is
                when OP_MOV =>
                    -- Generate control signals for MOV instruction.
                    control_out <= CTRL_MOV;

                when OP_JEQ_REL =>
                    -- Generate control signals for JEQ_REL (Jump if Equal Relative).
                    -- TODO: Set the branch condition based on flags.
                    branch_enable <= '0'; 
                    control_out <= "000" & "1" & "00" & "00" & "0" & branch_enable & "0";

                when OP_JGT_REL =>  
                    -- Generate control signals for JGT_REL (Jump if Greater Relative).
                    -- TODO: Set the branch condition based on flags.
                    branch_enable <= '0'; 
                    control_out <= "000" & "1" & "00" & "00" & "0" & branch_enable & "0";

                when OP_JLT_REL => 
                    -- Generate control signals for JLT_REL (Jump if Less Than Relative).
                    -- TODO: Set the branch condition based on flags.
                    branch_enable <= '0'; 
                    control_out <= "000" & "1" & "00" & "00" & "0" & branch_enable & "0";

                when OP_LOAD_MEM =>
                    -- Generate control signals for LOAD_MEM (Load from Memory).
                    control_out <= CTRL_LOAD_MEM;

                when OP_LOAD_IMM =>
                    -- Generate control signals for LOAD_IMM (Load Immediate Value).
                    control_out <= CTRL_LOAD_IMM;

                when OP_STORE =>
                    -- Generate control signals for STORE (Store to Memory).
                    control_out <= CTRL_STORE;

                when OP_NOP =>
                    -- Generate control signals for NOP (No Operation).
                    control_out <= CTRL_NOP;

                when others =>
                    -- Default case (optional, for completeness).
                    control_out <= CTRL_NOP;

            end case;
        end if;
    end process;

end behavioural;
