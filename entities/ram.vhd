library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

use work.common_const.all;


entity ram is
    generic (size : integer := 32);
    port(
        rst:      in std_logic;
        clk:      in std_logic;

        write_en: in std_logic;
        addr0:    in std_logic_vector(15 downto 0);
        addr1:    in std_logic_vector(15 downto 0);
        in0:      in std_logic_vector(15 downto 0);
        
        out0: out std_logic_vector(15 downto 0);
        out1: out std_logic_vector(15 downto 0)

        --LED       : out std_logic_vector(0 to 15);
        --JC : out std_logic_vector(0 to 7);
        --JD : out std_logic_vector(0 to 7)
    );
end entity ram;

architecture sram of ram is
    type ram_array is array (0 to size) of std_logic_vector(15 downto 0);

    signal addr0_int: integer range 0 to 65535;--size-1;
    signal addr1_int: integer range 0 to 65535;
    signal mem : ram_array;
    
        
    --signal tx_cont: std_logic_vector(CPU_WORD-1 downto 0); 
    --signal tx_feed: std_logic_vector(CPU_WORD-1 downto 0); 
    --signal tx_byte: std_logic_vector(CPU_WORD-1 downto 0); 
    --signal rx_cont: std_logic_vector(CPU_WORD-1 downto 0); 
    --signal rx_feed: std_logic_vector(CPU_WORD-1 downto 0); 
    --signal rx_byte: std_logic_vector(CPU_WORD-1 downto 0); 
    
    --constant JC_ADDR: integer := 128 - 1;
    --constant JD_ADDR: integer := 128 - 2;
    --constant JCD_ADDR: integer := 128 - 3;
    
    
    --signal mem_ready : boolean := false;

    procedure init_mem(signal memory : out ram_array) is
    begin
        memory(0) <= "0000000101011110";
        memory(1) <= "0000000101101110";
        memory(2) <= "1111111101111110";
        memory(3) <= "0110000000011001";
        memory(4) <= "0000001100101110";
        memory(5) <= "1110001001001001";
        memory(6) <= "0000000000000101";
        memory(7) <= "0000000011001010";
        memory(8) <= "0000000000101110";
        memory(9) <= "1000001000100110";
        memory(10) <= "1111111111011110";
        memory(11) <= "1101001000100011";
        memory(12) <= "0000001000000101";
        memory(13) <= "1111111111111011";
        memory(14) <= "0111001000101001";
        memory(15) <= "0000000100101110";
        memory(16) <= "0000000000000101";
        memory(17) <= "1111111100101010";
        memory(18) <= "0010011001101001";
        memory(19) <= "0000000100101110";
        memory(20) <= "1111111100111110";
        memory(21) <= "1000001100110110";
        memory(22) <= "1111111111011110";
        memory(23) <= "1101001100110011";
        memory(24) <= "0001001000101000";
        memory(25) <= "0011000100011001";
        memory(26) <= "0000000100000101";
        memory(27) <= "1111111111011011";
        memory(28) <= "0000000000001001";
        memory(29) <= "0000001001011001";
        memory(30) <= "0000010011101001";
        memory(31) <= "0000000000001001";
    end procedure;
begin

    --uart: entity work.UART_PERIPH
    --generic map(g_CLKS_PER_BIT => 868)
    --port map(
    --    clk       => clk,
    --    rst       => rst,
    --    RX_Serial => UART_RXD,
    --    TX_Serial => UART_TXD,
    --    tx_cont   => tx_cont,
    --    tx_feed   => tx_feed,
    --    tx_byte   => tx_byte,
    --    rx_cont   => rx_cont,
    --    rx_feed   => rx_feed,
    --    rx_byte   => rx_byte,
    --    LED => LED
    --);

    
    addr0_int <= to_integer(unsigned(addr0));
    addr1_int <= to_integer(unsigned(addr1));

    
    --out0 <= mem(addr0_int);
    
    out0 <= mem(addr0_int mod size);
            --"00000000" & JC when addr0_int = JC_ADDR else
            --"00000000" & JD when addr0_int = JD_ADDR else
            --        JC & JD when addr0_int = JCD_ADDR else
            
    out1 <= mem(addr1_int mod size);
    
    --JD <= mem(JD_ADDR)(7 downto 0);
    --LED(0 to 7) <= mem(JD_ADDR)(7 downto 0);
    
    process (addr0, addr1, write_en, in0) is
    begin
        if rst = '0' then
            init_mem(mem);
        elsif write_en = '1' then
            --if addr0_int = JC_ADDR then
            --    JC <= in0(7 downto 0);
            --elsif addr0_int = JD_ADDR then
            --    JD_val <= in0(7 downto 0);
            --    LED(0 to 7) <= in0(7 downto 0);         
            --elsif addr0_int = JCD_ADDR then
            --    JC <= in0(7 downto 0);
            --    --JD <= in0(15 downto 8);
            --else
                mem(addr0_int mod size) <= in0;
            --end if;
        end if;
    end process;
end architecture;
