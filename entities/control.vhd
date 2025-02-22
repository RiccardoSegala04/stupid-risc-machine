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

            when others =>
                control_out <= (others => '0');

        end case;
    end process;

end behavioural;
