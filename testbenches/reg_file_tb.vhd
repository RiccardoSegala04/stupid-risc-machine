library ieee;

use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.common_const.all;

entity reg_file_tb is
end entity;

architecture testbench of reg_file_tb is
        signal clk          : std_logic;                                          
        signal rst          : std_logic;                      

        signal out_pc       : std_logic;                      
        signal reg1addr     : std_logic_vector(3 downto 0);  
        signal reg2addr     : std_logic_vector(3 downto 0); 
        signal wb_reg_addr  : std_logic_vector(3 downto 0);   
        signal wb_reg_data  : std_logic_vector(15 downto 0); 
        signal flags_in     : std_logic_vector(15 downto 0);
        signal flags_wr     : std_logic;                   

        signal reg1data     : std_logic_vector(15 downto 0);
        signal reg2data     : std_logic_vector(15 downto 0);
        signal flags_out    : std_logic_vector(15 downto 0);  
        signal pc_value     : std_logic_vector(15 downto 0);  
begin

    uut : entity work.reg_file port map (
            clk         => clk,        
            rst         => rst,       
            out_pc      => out_pc,
            reg1addr    => reg1addr,   
            reg2addr    => reg2addr,   
            wb_reg_addr => wb_reg_addr,
            wb_reg_data => wb_reg_data,
            flags_in    => flags_in,   
            flags_wr    => flags_wr,   
            reg1data    => reg1data,   
            reg2data    => reg2data,   
            flags_out   => flags_out,  
            pc_value    => pc_value
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
        rst <= '0';
        wait for 25 ns;

        rst <= '1';
        wait for 10 ns;

        wb_reg_addr <= (others => '0');
        reg1addr <= std_logic_vector(to_unsigned(2, 4));
        reg2addr <= std_logic_vector(to_unsigned(3, 4));

        wait for 10 ns;

        wait;

    end process;

end testbench;

