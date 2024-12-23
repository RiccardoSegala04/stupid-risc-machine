library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    generic (size : integer := 65536);
    port(
        write_en: in std_logic;
        addr: in std_logic_vector(15 downto 0);
        data_in: in std_logic_vector(15 downto 0);
        
        data_out: out std_logic_vector(15 downto 0)
    );
end entity ram;

architecture sram of ram is
    signal addr_int: integer;
begin

    addr_int <= 0; -- to_integer(unsigned(addr));

    process (addr, write_en, data_in) is
        type ram_array is array (0 to size) of
        std_logic_vector(15 downto 0);
        variable mem : ram_array;
    begin
        if write_en = '1' then
            mem(addr_int) := data_in;
        end if;
        data_out <= (others => '0'); -- mem(0);
    end process;
end architecture;
