library ieee;
use ieee.std_logic_1164.all;

entity ROM is
    generic (size : integer := 65536);
    port (
        addr : in std_logic_vector(15 downto 0);
        data : out std_logic_vector (15 downto 0)
    );
end entity ROM;

architecture dataflow of ROM is
    type rom_array is array (0 to size) of
        std_logic_vector(15 downto 0);
    constant rom_mem : rom_array := (   "0101010101010101",
                                        "1010101010101010",
                                        "0000011100000111",
                                        "0101110101011101",
                                        "0111010101110101",
                                        "1111111111111111",
                                        "0011011100110111"
                                    );
    signal addr_int : integer;
begin
    data <= rom_mem(0);
end architecture dataflow;
