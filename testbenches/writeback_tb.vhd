library ieee;
use ieee.std_logic_1164.all;

entity writeback_tb is
end entity;

architecture testbench of writeback_tb is
    signal rst         : std_logic;                             
    signal control_in  : std_logic_vector(2 downto 0);
    signal mem_data    : std_logic_vector(15 downto 0);
    signal imm_12      : std_logic_vector(11 downto 0);

    signal wb_data     : std_logic_vector(15 downto 0);
    signal wb_reg      : std_logic_vector(3 downto 0);
begin

    process
    begin

        rst <= '0';
        wait for 20 ns;
        rst <= '1';

        control_in <= "011";
        mem_data <= (others => '1');
        imm_12 <= (others => '0');
        wait for 20 ns;
        wait;
    end process;

end testbench;
