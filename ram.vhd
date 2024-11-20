library ieee;
use ieee.std_logic_1164.all;

entity ram is
    generic (size : integer := 65536);
    port(
        write_en: in std_logic;
        addr: in std_logic_vector(15 downto 0);
        data_in: in std_logic_vector(15 downto 0);
        
        data_out: out std_logic_vector(15 downto 0);
    );
end entity ram;

architecture sram of ram is
begin
    process (addr, write_en, data_in) is
        type ram_array is array (0 to size) of
        std_logic_vector(7 downto 0);
        variable mem : ram_array;
    begin
        if write_en = '1' then
            mem(addr) := data_in;
        end if;
        data_out <= mem(addr);
    end process;
end architecture;