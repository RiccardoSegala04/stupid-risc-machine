library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity memory_stage is
    generic (mem_size : integer := 65536);
    port(
        clk         : in std_logic;
        
        control_in  : in std_logic_vector(3 downto 0);
        mem_addr    : in std_logic_vector(15 downto 0);
        mem_data    : in std_logic_vector(15 downto 0);
        alu_data    : in std_logic_vector(15 downto 0);
        imm_12_in   : in std_logic_vector(11 downto 0);
        
        
        control_out : out std_logic_vector(2 downto 0);
        data_out    : out std_logic_vector(15 downto 0);
        imm_12_out  : out std_logic_vector(11 downto 0);
    );
end memory_stage;

architecture behavioural of memory_stage is
    signal mem_out : std_logic_vector(15 downto 0);
    signal stage_out : std_logic_vector(15 downto 0);
begin
    ram: entity work.ram
        generic map(ram_size => 65536)
        port map(
            write_en => not control_in(CONT_MEM_RD),
            addr =>  mem_addr,
            data_in => mem_data,
            data_out => mem_out
        );
    
    stage_out <= mem_out when control_in(CONT_MEM_RD) = '1'
                 else alu_data;

    forward: process(clk)
    begin
        if rising_edge(clk) then
            control_out <= control_in(2 downto 0);
            data_out <= stage_out;
            imm12_out <= imm12_in;
        end if;
    end process;
end behavioural;