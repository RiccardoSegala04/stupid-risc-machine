library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity memory_tb is
end entity;

architecture testbench of memory_tb is
    signal clk         : std_logic;
    signal control_in  : std_logic_vector(4 downto 0);
    signal mem_addr    : std_logic_vector(15 downto 0);
    signal mem_data    : std_logic_vector(15 downto 0);
    signal alu_data    : std_logic_vector(15 downto 0);
    signal imm12_in    : std_logic_vector(11 downto 0);

    signal control_out : std_logic_vector(2 downto 0);
    signal data_out    : std_logic_vector(15 downto 0);
    signal imm12_out   : std_logic_vector(11 downto 0);
begin

    uut: entity work.memory port map (
        clk         => clk,
        control_in  => control_in,
        mem_addr    => mem_addr,
        mem_data    => mem_data,   
        alu_data    => alu_data,   
        imm12_in    => imm12_in,  
        control_out => control_out,
        data_out    => data_out,  
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
        mem_addr <= (others => '0');
        mem_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait for 40 ns;

        control_in <= "01000";
        mem_addr <= (others => '0');
        mem_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait for 40 ns;

        control_in <= "00000";
        mem_addr <= (others => '0');
        mem_data <= (others => '1');
        alu_data <= (others => '0');
        imm12_in <= (others => '1');

        wait;
    end process;

end testbench;
