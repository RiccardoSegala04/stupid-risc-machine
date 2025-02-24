library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.common_const.all;

entity hecu is
    port(
        req_reg1     : in std_logic_vector(CPU_REG_ADDR_LEN-1 downto 0);
        req_reg2     : in std_logic_vector(CPU_REG_ADDR_LEN-1 downto 0);

        exe_wb_sel   : in std_logic;
        exe_wb_en    : in std_logic;
        exe_wb_reg   : in std_logic_vector(CPU_REG_ADDR_LEN-1 downto 0);
        exe_reg_din  : in std_logic_vector(CPU_WORD-1 downto 0);
        

        mem_wb_sel   : in std_logic;
        mem_wb_en    : in std_logic;
        mem_wb_reg   : in std_logic_vector(CPU_REG_ADDR_LEN-1 downto 0);
        mem_reg_din  : in std_logic_vector(CPU_WORD-1 downto 0);

        wb_wb_reg   : in std_logic_vector(CPU_REG_ADDR_LEN-1 downto 0);
        wb_reg_din  : in std_logic_vector(CPU_WORD-1 downto 0);

        exe_reg_dout : out std_logic_vector(CPU_WORD-1 downto 0);
        mem_reg_dout : out std_logic_vector(CPU_WORD-1 downto 0);
        wb_reg_dout  : out std_logic_vector(CPU_WORD-1 downto 0);

        exe_bubble   : out std_logic;
        pc_wr        : out std_logic;

        reg1_sel     : out std_logic_vector(1 downto 0);
        reg2_sel     : out std_logic_vector(1 downto 0)
    );
end entity;

architecture behavioural of hecu is
    
begin
    exe_reg_dout <= exe_reg_din;
    mem_reg_dout <= mem_reg_din;
    wb_reg_dout <= wb_reg_din;

    pc_wr <= '1' when exe_wb_en = '1' and ((exe_wb_reg = REG_PC_LOGIC_VEC) or (exe_wb_sel = '1')) else '0';

    reg1_sel <= HECU_SEL_EXE when (exe_wb_reg = req_reg1 and exe_wb_reg /= REG_0_LOGIC_VEC) and (exe_wb_sel = '0') and (exe_wb_en = '1') else
                HECU_SEL_MEM when (mem_wb_reg = req_reg1) and (mem_wb_sel = '0') and (mem_wb_en = '1') else
                HECU_SEL_WB  when (wb_wb_reg  = req_reg1) else
                HECU_SEL_REG;
    
    reg2_sel <= HECU_SEL_EXE when (exe_wb_reg = req_reg2 and exe_wb_reg /= REG_0_LOGIC_VEC) and (exe_wb_sel = '0') and (exe_wb_en = '1') else
                HECU_SEL_MEM when (mem_wb_reg = req_reg2) and (mem_wb_sel = '0') and (mem_wb_en = '1') else
                HECU_SEL_WB  when (wb_wb_reg  = req_reg2) else
                HECU_SEL_REG;

    
    -- reg1_sel <= HECU_SEL_MEM;
    -- reg2_sel <= HECU_SEL_MEM;

end behavioural;
