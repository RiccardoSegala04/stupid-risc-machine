library ieee;
use ieee.std_logic_1164.all;

entity fetch is
    generic (rom_size : integer := 65536);
    port(
        clk : in std_logic;
        rst : in std_logic;     

        rom_addr : in std_logic_vector(15 downto 0);

        rom_data : out std_logic_vector(15 downto 0)
    );
end fetch;

architecture behavioural of fetch is
    signal rom_out : std_logic_vector(15 downto 0);
begin
    rom: entity work.rom
    generic map(size => rom_size)
    port map(
        addr => rom_addr,
        data => rom_out
    );

    reset: process(rst)
    begin
        if rst = '0' then
            rom_data <= (others => '0');
        end if;
    end process;


    forward: process(clk)
    begin
        if rising_edge(clk) then
            rom_data <= rom_out;
        end if;
    end process;
end behavioural;
