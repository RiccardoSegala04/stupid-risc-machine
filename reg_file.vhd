library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

-- Entity declaration for the register file
-- This module implements a 16-register file with read and write functionality.
-- It also handles special registers like the program counter (PC) and flags.
entity reg_file is

    port (
        clk         : in std_logic;                        -- Clock signal                                          
        out_pc      : in std_logic;                        -- Control signal to output PC on reg1data (used for branches)
                                                                                                                    
        reg1addr    : in std_logic_vector(3 downto 0);     -- Address of the first register to read
        reg2addr    : in std_logic_vector(3 downto 0);     -- Address of the second register to read
        wb_reg_addr : in std_logic_vector(3 downto 0);     -- Address of the register to write (write-back)
        wb_reg_data : in std_logic_vector(15 downto 0);    -- Data to write to the write-back register
        flags_in    : in std_logic_vector(15 downto 0);    -- Flags input to be written to the flags register
        flags_wr    : in std_logic;                        -- Control signal to enable writing to the flags register
                                                                                                                    
        reg1data     : out std_logic_vector(15 downto 0);  -- Data output from the first read register
        reg2data     : out std_logic_vector(15 downto 0);  -- Data output from the second read register
        flags_out    : out std_logic_vector(15 downto 0)   -- Output of the flags register
    );

end entity;

-- Behavioral architecture for the register file
architecture behavioural of reg_file is
begin
    -- Output the current state of the flags register
    flags_out <= reg_array(REG_FLAGS);

    process(clk)
        -- Define the register array
        type reg_array is array(0 to 15) of std_logic_vector(15 downto 0);
        variable registers : reg_array;
    begin
        if rising_edge(clk) then
            -- Output selected registers
            reg1data <= registers(reg1addr);
            reg2data <= registers(reg2addr);

            -- If out_pc is high, override reg1data with the value of the PC register
            if out_pc = '1' then
                reg1data <= registers(REG_PC);
            end if;
        
            -- Write to the flags register if flags_wr is high
            -- (execute stage wants to write the flags register)
            if flags_wr = '1' then
                registers(REG_FLAGS) <= flags_in;
            end if;

            -- Write data to the write-back register specified by wb_reg_addr
            registers(wb_reg_addr) <= wb_reg_data;

            -- Ensure register 0 (REG_0) always contains 0 (hardwired zero)
            registers(REG_0) <= (others => 0);

        end if;
    end process;

end behavioural;
