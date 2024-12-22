entity reg_file_tb is
end entity;

architecture testbench of reg_file_tb is
    signal clk         : in std_logic;
    signal out_pc      : in std_logic;

    signal reg1addr    : in std_logic_vector(3 downto 0);
    signal reg2addr    : in std_logic_vector(3 downto 0);
    signal wb_reg_addr : in std_logic_vector(3 downto 0);
    signal wb_reg_data : in std_logic_vector(15 downto 0);
    signal flags_in    : in std_logic_vector(15 downto 0);
    signal flags_wr    : in std_logic;

    signal reg1data     : out std_logic_vector(15 downto 0);
    signal reg2data     : out std_logic_vector(15 downto 0);
    signal flags_out    : out std_logic_vector(15 downto 0)
begin
end testbench;

