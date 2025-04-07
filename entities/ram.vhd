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
        
        memory(0) <= "0000000100011110";
memory(1) <= "0000000000101110";
memory(2) <= "0000000000111110";
memory(3) <= "0000000001001110";
memory(4) <= "1000010001000110";
memory(5) <= "0100000010111110";
memory(6) <= "1011010001000011";
memory(7) <= "0100001101000001";
memory(8) <= "0000000001101110";
memory(9) <= "1000011001100110";
memory(10) <= "0010000010111110";
memory(11) <= "1011011001100011";
memory(12) <= "0001001001010110";
memory(13) <= "0110010101010001";
memory(14) <= "0000000001101110";
memory(15) <= "0000000001111110";
memory(16) <= "0000000010001110";
memory(17) <= "0110011010011000";
memory(18) <= "0111011110101000";
memory(19) <= "1010100110011001";
memory(20) <= "0001000010101110";
memory(21) <= "1000101010100110";
memory(22) <= "0000000010111110";
memory(23) <= "1011101010100011";
memory(24) <= "1010100100000101";
memory(25) <= "0000000101111011";
memory(26) <= "0000000000001001";
memory(27) <= "0000000010011110";
memory(28) <= "1000100110010110";
memory(29) <= "0000010010111110";
memory(30) <= "1011100110010011";
memory(31) <= "1001100000000101";
memory(32) <= "0000000100001011";
memory(33) <= "0000000000001001";
memory(34) <= "0110011010011000";
memory(35) <= "0101100110010111";
memory(36) <= "0111011110101000";
memory(37) <= "0101101010100111";
memory(38) <= "1010100110010001";
memory(39) <= "0100100110011001";
memory(40) <= "0111011001111000";
memory(41) <= "0100011101110111";
memory(42) <= "0101011101111001";
memory(43) <= "0000100101101001";
memory(44) <= "0001100010001001";
memory(45) <= "0000000000000101";
memory(46) <= "1111111000111010";
memory(47) <= "0000000000001001";
memory(48) <= "0000000010101110";
memory(49) <= "1000101010100110";
memory(50) <= "0000010010111110";
memory(51) <= "1011101010100011";
memory(52) <= "0010000011011110";
memory(53) <= "1010100000000101";
memory(54) <= "0000000000111100";
memory(55) <= "0000000000001001";
memory(56) <= "0010001111011110";
memory(57) <= "0000000111001110";
memory(58) <= "0000000000001001";
memory(59) <= "0000000011001110";
memory(60) <= "0001001100111001";
memory(61) <= "0000000010101110";
memory(62) <= "1000101010100110";
memory(63) <= "1000000110111110";
memory(64) <= "1011101010100011";
memory(65) <= "1010001100000101";
memory(66) <= "1111110000011100";
memory(67) <= "0000000000001001";
memory(68) <= "0000101011011110";
memory(69) <= "0000000111001110";
memory(70) <= "0000000000001001";
memory(71) <= "0000000011001110";
memory(72) <= "0001001000101001";
memory(73) <= "0000000010101110";
memory(74) <= "1000101010100110";
memory(75) <= "0010000110111110";
memory(76) <= "1011101010100011";
memory(77) <= "1010001000000101";
memory(78) <= "1111101101001100";
memory(79) <= "0000000000001001";
memory(80) <= "0000000000000101";
memory(81) <= "0000000000001010";
memory(82) <= "0000000000001001";






        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
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
