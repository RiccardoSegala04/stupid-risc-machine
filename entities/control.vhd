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
    -- Define constant control signal patterns for specific operations. TODO
begin
    -- Process triggered on the rising edge of the clock.
    process(opcode, flags)
    begin
        -- TODO Case statement to handle specific opcodes.
        case opcode is

            -- when OP_MOV =>
            --     -- Generate control signals for MOV instruction.
            --     control_out <= CTRL_MOV;

            when OP_ADC =>
                -- Generate control signals for ADC instruction.
                control_out <= CF_OP_ADC or
                               CF_WB_EN;
            when OP_SBC =>
                -- Generate control signals for SBC instruction.
                control_out <= CF_OP_SBC or
                               CF_WB_EN;
            when OP_AND =>
                -- Generate control signals for AND instruction.
                control_out <= CF_OP_AND or
                               CF_WB_EN;
            when OP_OR =>
                -- Generate control signals for OR instruction.
                control_out <= CF_OP_OR or
                               CF_WB_EN;
            when OP_NOT =>
                -- Generate control signals for NOT instruction.
                control_out <= CF_OP_NOT or
                               CF_WB_EN;
            when OP_SL =>
                -- Generate control signals for SL instruction.
                control_out <= CF_OP_SL or
                               CF_WB_EN or
                               CF_ALU_IN2_SEL;
            when OP_SR =>
                -- Generate control signals for SR instruction.
                control_out <= CF_OP_SR or
                               CF_WB_EN or
                               CF_ALU_IN2_SEL;
            when OP_MUL =>
                -- Generate control signals for MUL instruction.
                control_out <= CF_OP_MUL or
                               CF_WB_EN;
            when OP_ADD =>
                -- Generate control signals for ADD instruction.
                control_out <= CF_OP_ADD or
                               CF_WB_EN;
            when OP_JEQ_REL =>
                -- Generate control signals for JEQ instruction.
                control_out <= CF_OP_SEQ or
                               CF_OUT_PC or
                               CF_ALU_IN2_SEL or
                               CF_WB_EN or
                               CF_WB_SEL;
            when OP_JGT_REL =>
                -- Generate control signals for JGT instruction.
                control_out <= CF_OP_SGT or
                               CF_OUT_PC or
                               CF_ALU_IN2_SEL or
                               CF_WB_EN or
                               CF_WB_SEL;
            when OP_JLT_REL =>
                -- Generate control signals for JLT instruction.
                control_out <= CF_OP_SLT or
                               CF_OUT_PC or
                               CF_ALU_IN2_SEL or
                               CF_WB_EN or
                               CF_WB_SEL;
            when OP_LOAD_MEM =>
                -- Generate control signals for LOAD_MEM instruction.
                control_out <= CF_OP_ADD or
                               CF_MEM_RD or
                               CF_WB_EN;
            when OP_LOAD_IMM =>
                -- Generate control signals for LOAD_IMM instruction.
                control_out <= CF_OP_FW_IMM8 or -- It doesn't matter
                               CF_ALU_IN2_SEL or
                               CF_WB_EN;
            when OP_STORE =>
                -- Generate control signals for STORE instruction.
                control_out <= CF_OP_ADD_IMM4 or 
                               CF_ALU_IN2_SEL or
                               CF_MEM_WR;

            when others =>
                control_out <= (others => '0');

        end case;
    end process;

end behavioural;
