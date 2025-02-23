library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

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
    type ram_array is array (0 to size) of std_logic_vector(15 downto 0);

    signal addr0_int: integer range 0 to size-1;
    signal addr1_int: integer range 0 to size-1;
    signal mem : ram_array; 

    signal mem_ready : boolean := false;

    function hex_char_to_slv(hex_char: character) return std_logic_vector is
        variable result: std_logic_vector(3 downto 0);
    begin
        case hex_char is
            when '0' => result := "0000";
            when '1' => result := "0001";
            when '2' => result := "0010";
            when '3' => result := "0011";
            when '4' => result := "0100";
            when '5' => result := "0101";
            when '6' => result := "0110";
            when '7' => result := "0111";
            when '8' => result := "1000";
            when '9' => result := "1001";
            when 'A' | 'a' => result := "1010";
            when 'B' | 'b' => result := "1011";
            when 'C' | 'c' => result := "1100";
            when 'D' | 'd' => result := "1101";
            when 'E' | 'e' => result := "1110";
            when 'F' | 'f' => result := "1111";
            when others => result := "0000"; -- Default case (handle invalid input)
        end case;
        return result;
    end function;

    function hex_str_to_slv(hex_str : string(1 to 4)) return std_logic_vector is
        variable result : std_logic_vector(15 downto 0);
    begin
        for i in hex_str'range loop
            result((i-1) * 4 + 3 downto (i-1) * 4) := hex_char_to_slv(hex_str(i));
        end loop;

        return result;
    end function;

    -- Procedure to load memory from a HEX file
    procedure load_memory_from_file(signal memory : out ram_array; constant filename : string) is
        file mem_file        : text open read_mode is filename; -- Input file
        variable line_data   : line;  -- Line buffer
        variable char_buffer : string(1 to 4); -- 4-character buffer
        variable end_of_file : boolean;
        variable temp_word   : std_logic_vector(15 downto 0);
        variable index       : integer;
    begin
        index := 0;
        while not endfile(mem_file) loop
            readline(mem_file, line_data); -- Read a full line
            
            for i in 1 to line_data'length loop
                char_buffer((i-1) mod 4 + 1) := line_data.all(i); -- Store chars in buffer
                if (i mod 4 = 0) or (i = line_data'length) then
                    memory(index) <= hex_str_to_slv(char_buffer);
                    index := index+1;
                end if;
            end loop;
        end loop;
    end procedure;

begin

    addr0_int <= to_integer(unsigned(addr0)) when mem_ready = true;
    addr1_int <= to_integer(unsigned(addr1)) when mem_ready = true;
    out0 <= mem(addr0_int) when mem_ready = true;
    out1 <= mem(addr1_int) when mem_ready = true;

    process (addr0, addr1, write_en, in0) is
    begin
        if mem_ready = true then
            if write_en = '1' then
                mem(addr0_int) <= in0;
            end if;
        else
            load_memory_from_file(mem, "assembler/test.hex");
            mem_ready <= true;
            --out0 <= (others => '0');
            --out1 <= (others => '0');
        end if;
    end process;
end architecture;
