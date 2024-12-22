library ieee;
use ieee.std_logic_1164.all;

entity fetch_stage is
    generic (rom_size : integer := 65536);
    port(
        clk : in std_logic;
        
        rom_addr : in std_logic_vector(15 downto 0);

        rom_data : out std_logic_vector(15 downto 0);
    );
end fetch_stage;

architecture behavioural of fetch_stage is
    signal rom_out : out std_logic_vector(15 downto 0);
begin
    rom: entity work.rom
    generic map(size => rom_size);
    port map(
        addr => rom_addr,
        data => rom_out
    );


    forward: process(clk)
    begin
        if rising_edge(clk) then
            rom_data <= rom_out;
        end if;
    end process;
end behavioural;