library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ram is
    generic (size : integer := 65536);
    port(
        write_en: in std_logic;
        addr0:    in std_logic_vector(15 downto 0);
        addr1:    in std_logic_vector(15 downto 0);
        in0:      in std_logic_vector(15 downto 0);
        
        out0: out std_logic_vector(15 downto 0);
        out1: out std_logic_vector(15 downto 0)
    );
end entity ram;

architecture sram of ram is
    signal addr0_int: integer;
    signal addr1_int: integer;

    type ram_array is array (0 to 1) of
    std_logic_vector(15 downto 0);
    signal mem : ram_array := ("0010000100010000", "0000000000000000");
begin

    addr0_int <= 0; -- to_integer(unsigned(addr0));
    addr1_int <= 0; -- to_integer(unsigned(addr1));

    process (addr0, addr1, write_en, in0) is
    begin
        if write_en = '1' then
            mem(addr0_int) <= in0;
        end if;
        out0 <= mem(0);
        out1 <= mem(0);
    end process;
end architecture;
