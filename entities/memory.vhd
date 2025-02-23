library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

-- Entity declaration for the memory stage
-- This module handles memory read and write operations in the pipeline.
entity memory is
    generic (ram_size : integer := 65536);                                           -- Size of the memory in bytes
    port(                                                                                             
        clk         : in std_logic;                                                  -- Clock signal
        rst         : in std_logic;                                                  -- Reset signal

        control_in  : in std_logic_vector(MEMORY_STAGE_CONTROL_LEN-1 downto 0);      -- Control signals from the previous stage
        pgm_addr    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Address for program memory access (fetch)
        ram_data    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Data to be written to memory
        alu_data    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Data from the ALU
        imm12_in    : in std_logic_vector(11 downto 0);                              -- Immediate 12 bit value input (wb_reg & imm8)

        -- HECU
        hecu_wb_sel  : out std_logic;
        hecu_wb_en   : out std_logic;
        hecu_wb_reg  : out std_logic_vector(3 downto 0);
        hecu_data    : out std_logic_vector(CPU_WORD-1 downto 0);

        control_out : out std_logic_vector(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);  -- Control signals for the next stage

        pgm_data    : out std_logic_vector(15 downto 0);                             -- Next instruction to be executed (fetch)
        mem_data    : out std_logic_vector(CPU_WORD-1 downto 0);                     -- Data output for the next stage (multiplexed)
        imm12_out   : out std_logic_vector(11 downto 0)                              -- Immediate value output for the next stage
    );
end memory;

architecture behavioural of memory is
    signal pgm_out : std_logic_vector(15 downto 0);
    signal ram_out   : std_logic_vector(CPU_WORD-1 downto 0);  -- Data output from the RAM
    signal stage_out : std_logic_vector(CPU_WORD-1 downto 0);  -- Intermediate stage output
begin
    ram: entity work.ram
        generic map(size => 65536)                
        port map(
            write_en  => control_in(CONT_MEM_WR),
            addr0     => alu_data,
            out0      => ram_out,
            addr1     => pgm_addr,
            out1      => pgm_out,
            in0       => ram_data
        );

    -- HECU
    hecu_wb_sel <= control_in(CONT_WB_SEL);
    hecu_wb_en  <= control_in(CONT_WB_EN);
    hecu_wb_reg <= imm12_in(3 downto 0);
    hecu_data   <= stage_out;

    -- Determine the output for the memory stage
    -- If CONT_MEM_RD (memory read) is high, use RAM output; 
    -- otherwise, pass data from previous stage (execute)
    stage_out <= ram_out when control_in(CONT_MEM_RD) = '1'
                 else alu_data;

    -- Forwarding logic to pass signals to the next pipeline stage 
    -- on the rising edge of the clock
    forward: process(clk, rst)
    begin
        if rst = '0' then
            control_out <= (others => '0');
            mem_data <= (others => '0'); 
            imm12_out <= (others => '0'); 
            pgm_data <= "0000000000001111"; 
        elsif rising_edge(clk) then
            -- Forward control signals (subset of control_in) to the next stage
            control_out <= control_in(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);

            -- Forward selected data (memory or ALU) to the next stage
            mem_data <= stage_out;

            -- Forward the immediate value to the next stage
            imm12_out <= imm12_in;

            -- Forward the requested data from the program memory (fetch)
            pgm_data <= pgm_out;
        end if;
    end process;
end behavioural;
