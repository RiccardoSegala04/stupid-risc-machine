library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity writeback is
    port(
        control_in  : in std_logic_vector(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);
        
        mem_data    : in std_logic_vector(CPU_WORD-1 downto 0);
        wb_reg_in   : in std_logic_vector(3 downto 0);

        wb_data     : out std_logic_vector(CPU_WORD-1 downto 0);
        wb_reg      : out std_logic_vector(3 downto 0)
    );
end writeback;

architecture behavioural of writeback is
begin

    wb_data <= mem_data;

    wb_reg <= 
            REG_0_LOGIC_VEC when control_in(CONT_WB_EN) = '0'
            else
              REG_PC_LOGIC_VEC when control_in(CONT_WB_SEL) = '1'
              else wb_reg_in(3 downto 0);

end behavioural;
