library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity reg_file is

    port (
        clk         : in std_logic;
        out_pc      : in std_logic;

        reg1addr    : in std_logic_vector(3 downto 0);
        reg2addr    : in std_logic_vector(3 downto 0);
        wb_reg_addr : in std_logic_vector(3 downto 0);
        wb_reg_data : in std_logic_vector(15 downto 0);
        flags_in    : in std_logic_vector(15 downto 0);
        flags_wr    : in std_logic;

        reg1data     : out std_logic_vector(15 downto 0);
        reg2data     : out std_logic_vector(15 downto 0);
        flags_out    : out std_logic_vector(15 downto 0)
    );

end entity;

architecture behavioural of reg_file is
begin
    flags_out <= reg_array(REG_FLAGS);

    process(clk)
        type reg_array is array(0 to 15) of std_logic_vector(15 downto 0);
        variable registers : reg_array;
    begin
        if rising_edge(clk) then

            -- Output selected registers
            reg1data <= registers(reg1addr);
            reg2data <= registers(reg2addr);

            -- If out_pc is high, the first output becomes PC
            if out_pc = '1' then
                reg1data <= registers(REG_PC);
            end if;
        
            -- Check if alu needs to write the flags register
            if flags_wr = '1' then
                registers(REG_FLAGS) <= flags_in;
            end if;

            -- Write the writeback register
            registers(wb_reg_addr) <= wb_reg_data;

            -- REG_0 must contain 0
            registers(REG_0) <= (others => 0);

        end if;
    end process;

end behavioural;
