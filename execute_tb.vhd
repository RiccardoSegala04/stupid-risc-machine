library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity execute_tb is
end entity;

architecture testbench of execute_tb is 
    signal clk          : std_logic;
    signal control_in   : std_logic_vector(5 downto 0);
    signal alu_op       : std_logic_vector(2 downto 0);
    signal imm8_in      : std_logic_vector(7 downto 0);
    signal dreg_in      : std_logic_vector(3 downto 0);
    signal op1          : std_logic_vector(15 downto 0); 
    signal op2          : std_logic_vector(15 downto 0); 
    signal flags        : std_logic_vector(15 downto 0);

    signal control_out  : std_logic_vector(2 downto 0);
    signal imm12_out    : std_logic_vector(11 downto 0);
    signal mem_addr_out : std_logic_vector(15 downto 0);
    signal mem_data_out : std_logic_vector(15 downto 0);
    signal result       : std_logic_vector(15 downto 0);
begin

    uut: entity work.execute port map (
        clk => clk,
        control_in => control_in,
        alu_op => alu_op,
        imm8_in => imm8_in,
        dreg_in => dreg_in,
        op1 => op1,
        op2 => op2,
        flags => flags,
        control_out => control_out,
        imm12_out => imm12_out,
        mem_addr_out => mem_addr_out,
        mem_data_out => mem_data_out,
        result => result
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
        flags <= (others => '0');
        op1 <= "0000000000001010";
        op2 <= "0000000000000010";
        dreg_in <= "0000";
        imm8_in <= "00000001";
        alu_op <= ALU_ADC;
        control_in <= "000000";

        wait for 10 ns;
        wait;
    end process;
end testbench;
