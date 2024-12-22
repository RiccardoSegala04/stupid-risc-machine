library ieee;
use ieee.std_logic_1164.all;

entity ROM is
    generic (size : integer := 65536);
    port (
        addr : in integer range (0 to 15);
        data : out std_logic_vector (15 downto 0)
    );
end entity ROM;

architecture dataflow of ROM is
    type rom_array is array (0 to size) of
        std_logic_vector(15 downto 0);
    constant rom : rom_array := (   "01010101",
                                    "10101010",
                                    "00000111",
                                    "01011101",
                                    "01110101",
                                    "11111111",
                                    "00110111"
                                );
begin
    data <= rom(addr);
end architecture dataflow;