library ieee;

use ieee.std_logic_1164.all;
use work.common_const.all;

entity decode_tb is
end entity;

architecture testbench of decode_tb is
        signal clk               : std_logic;                               
        signal rst               : std_logic;                               

        signal opcode            : std_logic_vector(3 downto 0);           
        signal reg1addr          : std_logic_vector(3 downto 0);           
        signal reg2addr          : std_logic_vector(3 downto 0);           
        signal curr_wb_reg_addr  : std_logic_vector(3 downto 0);      
        signal new_wb_reg_addr   : std_logic_vector(3 downto 0);      
        signal wb_reg_data       : std_logic_vector(CPU_WORD-1 downto 0);  
        signal flags_in          : std_logic_vector(CPU_WORD-1 downto 0);  
        signal flags_wr          : std_logic;                              

        signal control_out       : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0); 
        signal reg1data          : std_logic_vector(CPU_WORD-1 downto 0);                  
        signal reg2data          : std_logic_vector(CPU_WORD-1 downto 0);                  
        signal flags_out         : std_logic_vector(CPU_WORD-1 downto 0);                  
        signal pc_value          : std_logic_vector(CPU_WORD-1 downto 0);                  
        signal imm12_out         : std_logic_vector(11 downto 0);
begin

    uut: entity work.decode port map (
        clk               =>    clk,             
        rst               =>    rst,             
        opcode            =>    opcode,          
        reg1addr          =>    reg1addr,        
        reg2addr          =>    reg2addr,        
        curr_wb_reg_addr  =>    curr_wb_reg_addr,
        new_wb_reg_addr   =>    new_wb_reg_addr, 
        wb_reg_data       =>    wb_reg_data,     
        flags_in          =>    flags_in,        
        flags_wr          =>    flags_wr,        
        control_out       =>    control_out,     
        reg1data          =>    reg1data,        
        reg2data          =>    reg2data,        
        flags_out         =>    flags_out,       
        pc_value          =>    pc_value,        
        imm12_out         =>    imm12_out       
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
        wait for 20 ns;


        opcode <= (others => '0');
        reg1addr <= "0010";
        reg2addr <= "0011";
        curr_wb_reg_addr <= (others => '0');       
        new_wb_reg_addr <= (others => '0');       
        wb_reg_data <= (others => '0');           
        flags_in <= (others => '0');              
        flags_wr <= '0';

        wait for 40 ns;


        wait;
    end process;
end testbench;
