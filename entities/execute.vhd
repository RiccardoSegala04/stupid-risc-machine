library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

-- Entity declaration for the execute stage
-- This module performs the execute stage of the RISC CPU pipeline.
entity execute is
    port(
        clk          : in std_logic;                                               -- Clock signal                            
        rst          : in std_logic;                                               -- Reset signal

        control_in   : in std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0);  -- Control signals from decode stage
        imm12_in     : in std_logic_vector(11 downto 0);                           -- 12-bit immediate value
        op1          : in std_logic_vector(CPU_WORD-1 downto 0);                   -- Operand 1 
        op2          : in std_logic_vector(CPU_WORD-1 downto 0);                   -- Operand 2 
        flags        : in std_logic_vector(CPU_WORD-1 downto 0);                   -- Processor status flags (flags register is a GPR)

        -- HECU
        hecu_bubble  : in std_logic;
        hecu_wb_sel  : out std_logic;
        hecu_wb_en   : out std_logic;
        hecu_wb_reg  : out std_logic_vector(3 downto 0);
        hecu_data    : out std_logic_vector(CPU_WORD-1 downto 0);
                                                                                                     
        flags_wr     : out std_logic;                                              -- Flag indicating if flags needs to be written
        flags_out    : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Updated processor status flags
        control_out  : out std_logic_vector(MEMORY_STAGE_CONTROL_LEN-1 downto 0);  -- Control signals for next stage
        wb_reg_out    : out std_logic_vector(3 downto 0);                          -- 12-bit immediate value for next stage (dreg + imm8)
        mem_data_out : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Data to be written to memory (op2)
        result       : out std_logic_vector(CPU_WORD-1 downto 0)                   -- Result of ALU operation
    );
end execute;

architecture behavioural of execute is
    signal alu_op    : std_logic_vector(ALU_OPCODE_LEN-1 downto 0); -- ALU opcode
    signal alu_in    : std_logic_vector(CPU_WORD-1 downto 0);       -- ALU multiplexed input (imm12 or op2)
    signal alu_out   : std_logic_vector(CPU_WORD-1 downto 0);       -- ALU output (latched)
    signal alu_flags : std_logic_vector(CPU_WORD-1 downto 0);       -- ALU flags output (latched)
begin
    alu: entity work.alu
        port map(
            op1       => op1,         -- First operand to the ALU
            op2       => alu_in,      -- Second operand to the ALU (multiplexed)
            opcode    => alu_op,      -- Operation code for the ALU
            flags_in  => flags,       -- Current processor flags
            output    => alu_out,     -- Result from the ALU
            flags_out => flags_out    -- Updated flags from the ALU
        );

    -- HECU
    hecu_wb_sel <= control_in(CONT_WB_SEL);
    hecu_wb_en  <= control_in(CONT_WB_EN);
    hecu_wb_reg <= imm12_in(3 downto 0);
    hecu_data   <= alu_out;

    -- Extract ALU operation code from control signals
    alu_op <= control_in(CONT_OP_ALU_3 downto CONT_OP_ALU_0);

    -- Determine ALU second input based on control signal
    -- If CONT_OUT_PC is set, use immediate value (relative branch); otherwise, use op2
    alu_in <= "0000" & imm12_in when control_in(CONT_ALU_IN2_SEL) = '1' else 
              op2;

    -- Forwarding logic to update outputs on rising edge of the clock
    forward: process(clk, rst)
    begin
        if rst = '0' then
            flags_wr <= '0'; 
            -- flags_out <= (others => '0');
            control_out <= (others => '0');
            wb_reg_out <= (others => '0');
            mem_data_out <= (others => '0');
            result <= (others => '0'); 
        elsif rising_edge(clk) then
            -- Pass through control signals for the next pipeline stage
            --control_out <= control_in(MEMORY_STAGE_CONTROL_LEN-1 downto 0) when hecu_bubble = '0' else (others => '0');

            if hecu_bubble = '0' then
                control_out <= control_in(MEMORY_STAGE_CONTROL_LEN-1 downto 0);
            else
                control_out <= (others => '0');
            end if;

            -- Combine destination register and immediate value for next stage
            wb_reg_out <= imm12_in(3 downto 0);

            -- Store the ALU result in the result output
            result <= alu_out;

            -- Set memory address and memory data outputs for memory stage
            mem_data_out <= op2;
        end if;
    end process;
end behavioural;
