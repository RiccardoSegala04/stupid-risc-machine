library ieee;
use ieee.std_logic_1164.all;

use work.common_const.all;

entity control_unit is
    port(
        clk         : in std_logic;
        opcode      : in std_logic_vector(3 downto 0);
        control_out : out std_logic_vector(5 downto 0);

        )