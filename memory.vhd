library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

-- Entity declaration for the memory stage
-- This module handles memory read and write operations in the pipeline.
entity memory is
    generic (mem_size : integer := 65536);                                           -- Size of the memory in bytes
    port(                                                                                             
        clk         : in std_logic;                                                  -- Clock signal
        rst         : in std_logic;                                                  -- Reset signal
                                                                                                      
        control_in  : in std_logic_vector(MEMORY_STAGE_CONTROL_LEN-1 downto 0);      -- Control signals from the previous stage
        mem_addr    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Address for memory access
        mem_data    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Data to be written to memory
        alu_data    : in std_logic_vector(CPU_WORD-1 downto 0);                      -- Data from the ALU
        imm12_in    : in std_logic_vector(11 downto 0);                              -- Immediate 12 bit value input (wb_reg & imm8)
                                                                                                      
        control_out : out std_logic_vector(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);  -- Control signals for the next stage
        data_out    : out std_logic_vector(CPU_WORD-1 downto 0);                     -- Data output for the next stage (multiplexed)
        imm12_out   : out std_logic_vector(11 downto 0)                              -- Immediate value output for the next stage
    );
end memory;

architecture behavioural of memory is
    signal mem_out   : std_logic_vector(CPU_WORD-1 downto 0);  -- Data output from the RAM
    signal stage_out : std_logic_vector(CPU_WORD-1 downto 0);  -- Intermediate stage output
begin
    ram: entity work.ram
        generic map(size => 65536)                
        port map(
            write_en  => control_in(CONT_MEM_WR),
            addr      => mem_addr,
            data_in   => mem_data,
            data_out  => mem_out
        );
    
    -- Determine the output for the memory stage
    -- If CONT_MEM_RD (memory read) is high, use RAM output; 
    -- otherwise, pass data from previous stage (execute)
    stage_out <= mem_out when control_in(CONT_MEM_RD) = '1'
                 else alu_data;

    reset: process(rst)
    begin
        if rst = '0' then
            control_out <= (others => '0');
            data_out <= (others => '0'); 
            imm12_out <= (others => '0'); 
        end if;
    end process;

    -- Forwarding logic to pass signals to the next pipeline stage 
    -- on the rising edge of the clock
    forward: process(clk)
    begin
        if rising_edge(clk) then
            -- Forward control signals (subset of control_in) to the next stage
            control_out <= control_in(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);

            -- Forward selected data (memory or ALU) to the next stage
            data_out <= stage_out;

            -- Forward the immediate value to the next stage
            imm12_out <= imm12_in;
        end if;
    end process;
end behavioural;
