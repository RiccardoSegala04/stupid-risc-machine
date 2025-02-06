library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity writeback is
    port(
        control_in  : in std_logic_vector(2 downto 0);
        
        mem_data    : in std_logic_vector(CPU_WORD-1 downto 0);
        imm12      : in std_logic_vector(11 downto 0);

        wb_data     : out std_logic_vector(CPU_WORD-1 downto 0);
        wb_reg      : out std_logic_vector(3 downto 0)
    );
end writeback;

architecture behavioural of writeback is
begin

    wb_data <= ("00000000" & imm12(11 downto 4)) when control_in(CONT_IMM) = '1'
               else mem_data;

    wb_reg <= 
            REG_0_LOGIC_VEC when control_in(CONT_WB_EN) = '0'
            else
              REG_PC_LOGIC_VEC when control_in(CONT_WB_SEL) = '0'
              else imm12(11 downto 8);

end behavioural;
