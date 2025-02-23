library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use work.common_const.all;

-- Entity declaration for the register file
-- This module implements a 16-register file with read and write functionality.
-- It also handles special registers like the program counter (PC) and flags.
entity reg_file is

    port (
        clk           : in std_logic;                        -- Clock signal                                          
        rst           : in std_logic;                        -- Reset signal

        out_pc        : in std_logic;                        -- Control signal to output PC on reg1data (used for branches)
        reg1addr      : in std_logic_vector(3 downto 0);     -- Address of the first register to read
        reg2addr      : in std_logic_vector(3 downto 0);     -- Address of the second register to read
        wb_reg_addr   : in std_logic_vector(3 downto 0);     -- Address of the register to write (write-back)
        wb_reg_data   : in std_logic_vector(CPU_WORD-1 downto 0);    -- Data to write to the write-back register
        flags_in      : in std_logic_vector(CPU_WORD-1 downto 0);    -- Flags input to be written to the flags register
        flags_wr      : in std_logic;                        -- Control signal to enable writing to the flags register

        -- HECU
        hecu_pc_new   : in std_logic_vector(CPU_WORD-1 downto 0);
        hecu_pc_wr    : in std_logic;
                                                                                               
        reg1data      : out std_logic_vector(CPU_WORD-1 downto 0);  -- Data output from the first read register
        reg2data      : out std_logic_vector(CPU_WORD-1 downto 0);  -- Data output from the second read register
        flags_out     : out std_logic_vector(CPU_WORD-1 downto 0);  -- Output of the flags register
        pc_value      : out std_logic_vector(CPU_WORD-1 downto 0)   -- Output for the program counter (GPR)
    );

end entity;

-- Behavioral architecture for the register file
architecture behavioural of reg_file is
    signal reg1addr_int : integer range 0 to 15;
    signal reg2addr_int : integer range 0 to 15;
    signal wb_reg_addr_int : integer range 0 to 15;
    type reg_array is array(0 to CPU_WORD-1) of std_logic_vector(CPU_WORD-1 downto 0);
    signal registers : reg_array;
begin

    reg1addr_int <= to_integer(unsigned(reg1addr));
    reg2addr_int <= to_integer(unsigned(reg2addr));
    wb_reg_addr_int <= to_integer(unsigned(wb_reg_addr));
    
    reg1data <= (others => '0') when reg1addr = REG_0_LOGIC_VEC else registers(reg1addr_int) when out_pc = '0' else registers(REG_PC);
    reg2data <= (others => '0') when reg2addr = REG_0_LOGIC_VEC else registers(reg2addr_int);
    flags_out <= registers(REG_FLAGS) when rst = '1' else (others => '0') ;

    -- Ensure register 0 (REG_0) always contains 0 (hardwired zero)
    process(clk, rst)
        -- Define the register array
    begin

        if rst = '0' then
            --reg1data <= (others => '0');
            --reg2data <= (others => '0');
            --flags_out <= (others => '0');
            --pc_value <= (others => '0');

            -- for k in 0 to registers'length-1 loop
            --     registers(k) := (others => '0');
            -- end loop;

            registers(REG_PC) <= (others => '0');
            registers(REG_FLAGS) <= (others => '0');

        elsif rising_edge(clk) then 

            -- Write to the flags register if flags_wr is high
            -- (execute stage wants to write the flags register)
            --if flags_wr = '1' then
            registers(REG_FLAGS) <= flags_in;
            --end if;

            --registers(REG_PC) <= hecu_pc_new when hecu_pc_wr = '1' else std_logic_vector(unsigned(registers(REG_PC)) + 1);
            if hecu_pc_wr = '1' then
                registers(REG_PC) <= hecu_pc_new;
            else
                registers(REG_PC) <= std_logic_vector(unsigned(registers(REG_PC)) + 1);
            end if;
            
            -- Write data to the write-back register specified by wb_reg_addr
            registers(wb_reg_addr_int) <= wb_reg_data;

            
            -- Output the PC for the fetch stage
            -- Output the current state of the flags register

        --elsif falling_edge(clk) then
        end if;
    end process;
    pc_value <= registers(REG_PC) when rst = '1' else (others => '0');


end behavioural;
