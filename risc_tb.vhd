library ieee;
use ieee.std_logic_1164.all;

entity risc_tb is
end risc_tb;

architecture testbench of risc_tb is 
    signal clk : std_logic;
begin

    uut: entity work.risc port map (
        clk => clk
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
    
end testbench;
