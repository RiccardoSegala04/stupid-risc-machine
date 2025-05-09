library ieee;

use ieee.std_logic_1164.all;
use work.common_const.all;

-- Entity declaration for the decode module.
-- The decode module handles instruction decoding, control signal generation,
-- register file access, and flag management in the CPU.
entity decode is
    port (
        clk         : in std_logic;                               -- Clock signal                                          
        rst         : in std_logic;                               -- Reset signal

        opcode       : in std_logic_vector(3 downto 0);           -- Opcode to determine the operation type.
        reg1addr     : in std_logic_vector(3 downto 0);           -- Address of the first register to read
        reg2addr     : in std_logic_vector(3 downto 0);           -- Address of the second register to read
        curr_wb_reg_addr  : in std_logic_vector(3 downto 0);      -- Address of the register to write (from write-back stage)
        new_wb_reg_addr   : in std_logic_vector(3 downto 0);      -- Address of the register to write (from fetch stage)
        wb_reg_data  : in std_logic_vector(CPU_WORD-1 downto 0);  -- Data to write to the write-back register
        flags_in     : in std_logic_vector(CPU_WORD-1 downto 0);  -- Flags input to be written to the flags register
        flags_wr     : in std_logic;                              -- Control signal to enable writing to the flags register

        -- HECU
        hecu_mem_in   : in std_logic_vector(CPU_WORD-1 downto 0);
        hecu_exe_in   : in std_logic_vector(CPU_WORD-1 downto 0);
        hecu_wb_in    : in std_logic_vector(CPU_WORD-1 downto 0);
        hecu_reg1_sel : in std_logic_vector(1 downto 0);
        hecu_reg2_sel : in std_logic_vector(1 downto 0);
        hecu_pc_new   : in std_logic_vector(CPU_WORD-1 downto 0);
        hecu_pc_wr    : in std_logic;


        hecu_req_reg1 : out std_logic_vector(3 downto 0); 
        hecu_req_reg2 : out std_logic_vector(3 downto 0);
        hecu_out_pc   : out std_logic;
                                                                                                                    
        control_out  : out std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0); -- Control signal output for the execute stage.
        reg1data     : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Data output from the first read register
        reg2data     : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Data output from the second read register
        flags_out    : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Output of the flags register
        pc_value     : out std_logic_vector(CPU_WORD-1 downto 0);                  -- Output for the program counter (GPR)
        imm12_out    : out std_logic_vector(11 downto 0)                           -- 12 bit immediate value to forward to the next stage
    );
end entity;

architecture behavioural of decode is
    -- Internal signal to hold the current state of the flags.
    signal flags_internal : std_logic_vector(CPU_WORD-1 downto 0);

    -- Internal signal to hold the control signals generated by the control unit.
    signal control_internal : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0);

    signal reg1file : std_logic_vector(CPU_WORD-1 downto 0);
    signal reg2file : std_logic_vector(CPU_WORD-1 downto 0);
begin

    -- Instantiate the control unit.
    -- This generates control signals based on the opcode and flags.
    control: entity work.control port map (
        opcode      => opcode,
        flags       => flags_in,
        control_out => control_internal
    );

    -- Instantiate the register file.
    -- This handles register read and write operations and updates the flags register.
    reg_file: entity work.reg_file port map (
        clk         => clk,
        rst         => rst,
        out_pc      => control_internal(CONT_OUT_PC),
        reg1addr    => reg1addr,
        reg2addr    => reg2addr,
        wb_reg_addr => curr_wb_reg_addr,
        wb_reg_data => wb_reg_data,
        flags_in    => flags_in,
        flags_wr    => flags_wr,   
        reg1data    => reg1file,
        reg2data    => reg2file,
        flags_out   => flags_out,
        pc_value    => pc_value,
        hecu_pc_new => hecu_pc_new,
        hecu_pc_wr  => hecu_pc_wr
        );

    hecu_req_reg1 <= reg1addr;
    hecu_req_reg2 <= reg2addr;

    hecu_out_pc <= control_internal(CONT_OUT_PC);

    -- Process to update outputs at every clock edge.
    process(clk, rst)
    begin
        if rst = '0' then
            control_out <= CF_OP_ADD;
            imm12_out <= (others => '0'); 
            --flags_out <= (others => '0');
        elsif rising_edge(clk) then
            -- Pass the internal control signals to the external control_out port.
            control_out <= control_internal;

            -- Pass the internal flags to the external flags_out port.
            --flags_out <= flags_internal;

            -- Pass the immediate 12 bit value to the next stage
            imm12_out <= reg2addr & reg1addr & new_wb_reg_addr;
            
            with hecu_reg1_sel select
                reg1data <= reg1file when HECU_SEL_REG,
                hecu_exe_in when HECU_SEL_EXE,
                hecu_mem_in when HECU_SEL_MEM,
                hecu_wb_in  when HECU_SEL_WB,
                (others => 'X') when others;
            with hecu_reg2_sel select
                reg2data <= reg2file when HECU_SEL_REG,
                hecu_exe_in when HECU_SEL_EXE,
                hecu_mem_in when HECU_SEL_MEM,
                hecu_wb_in  when HECU_SEL_WB,
                (others => 'X') when others;

        end if;
    end process;

end behavioural;
