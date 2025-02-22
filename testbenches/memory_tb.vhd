library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity memory_tb is
end entity;

architecture testbench of memory_tb is
        signal clk         : std_logic;                                                  -- Clock signal
        signal rst         : std_logic;                                                  -- Reset signal

        signal control_in  : std_logic_vector(MEMORY_STAGE_CONTROL_LEN-1 downto 0);      -- Control signals from the previous stage
        signal pgm_addr    : std_logic_vector(15 downto 0);                              -- Address for program memory access (fetch)
        signal ram_data    : std_logic_vector(CPU_WORD-1 downto 0);                      -- Data to be written to memory
        signal alu_data    : std_logic_vector(CPU_WORD-1 downto 0);                      -- Data from the ALU
        signal imm12_in    : std_logic_vector(11 downto 0);                              -- Immediate 12 bit value input (wb_reg & imm8)

        signal control_out :  std_logic_vector(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);  -- Control signals for the next stage

        signal pgm_data    :  std_logic_vector(15 downto 0);                             -- Next instruction to be executed (fetch)
        signal mem_data    :  std_logic_vector(CPU_WORD-1 downto 0);                     -- Data output for the next stage (multiplexed)
        signal imm12_out   :  std_logic_vector(11 downto 0);                              -- Immediate value output for the next stage
begin

    uut: entity work.memory port map (

        clk         => clk,
        rst         => rst,       
        control_in  => control_in,
        pgm_addr    => pgm_addr, 
        ram_data    => ram_data,   
        alu_data    => alu_data,   
        imm12_in    => imm12_in,   
        control_out => control_out,
        pgm_data    => pgm_data,   
        mem_data    => mem_data,   
        imm12_out   => imm12_out
    );

    clk_switch: process
    begin
        for i in 0 to 10 loop
            clk <= '0';
            wait for 20 ns;
            clk <= '1';
            wait for 20 ns;
        end loop;
        wait;
    end process;

    process
    begin

        control_in <= "10000";
        pgm_addr <= (others => '0');
        ram_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait for 40 ns;

        control_in <= "01000";
        ram_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait for 40 ns;

        control_in <= "00000";
        ram_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait;
    end process;

end testbench;
