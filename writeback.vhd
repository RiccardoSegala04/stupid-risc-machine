library ieee;
use ieee.std_logic_1164.all;

entity writeback_stage is
    port(
        clk         : in std_logic;
        
        control_in  : in std_logic_vector(2 downto 0);
        
        mem_data    : in std_logic_vector(15 downto 0);
        imm_12      : in std_logic_vector(11 downto 0);

        wb_data     : out std_logic_vector(15 downto 0);
        wb_reg      : out std_logic_vector(3 downto 0);
    );
end writeback_stage;

architecture behavioural of writeback_stage is
    wb_data <= imm_12 when control_in(CONT_ABS) = '1'
               else mem_data;
    wb_reg <= 
            REG_0 when control_in(CONT_WB_EN) = '0'
            else
              REG_PC when control_in(CONT_WB_SEL) = '0'
              else imm12_in(3 downto 0);
begin

end behavioural
