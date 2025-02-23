library ieee;

use ieee.std_logic_1164.all;
use work.common_const.all;

entity risc is
    port (
        clk: std_logic;
        rst: std_logic
    );
end risc;

architecture behavioural of risc is
    -- Fetch stage output signal
    signal fetch_operation : std_logic_vector(CPU_WORD-1 downto 0);
    
    -- Decode stage output signals
    signal decode_control       : std_logic_vector(EXECUTE_STAGE_CONTROL_LEN-1 downto 0);
    signal decode_reg1data      : std_logic_vector(CPU_WORD-1 downto 0);                 
    signal decode_reg2data      : std_logic_vector(CPU_WORD-1 downto 0);                 
    signal decode_flags_out     : std_logic_vector(CPU_WORD-1 downto 0);                 
    signal decode_pc_value      : std_logic_vector(CPU_WORD-1 downto 0);
    signal decode_imm12_out     : std_logic_vector(11 downto 0);
    signal decode_hecu_req_reg1 : std_logic_vector(3 downto 0); 
    signal decode_hecu_req_reg2 : std_logic_vector(3 downto 0); 


    -- Execute stage output signals
    signal execute_flags_wr     : std_logic;                                             
    signal execute_flags_out    : std_logic_vector(CPU_WORD-1 downto 0);                  
    signal execute_control_out  : std_logic_vector(MEMORY_STAGE_CONTROL_LEN-1 downto 0);  
    signal execute_imm12_out    : std_logic_vector(11 downto 0);                           
    signal execute_mem_data_out : std_logic_vector(CPU_WORD-1 downto 0);                 
    signal execute_result       : std_logic_vector(CPU_WORD-1 downto 0);
    signal execute_hecu_wb_sel  : std_logic;
    signal execute_hecu_wb_en   : std_logic;
    signal execute_hecu_wb_reg  : std_logic_vector(3 downto 0);
    signal execute_hecu_data    : std_logic_vector(CPU_WORD-1 downto 0);

    -- Memory stage output signals
    signal memory_control_out : std_logic_vector(WRITEBACK_STAGE_CONTROL_LEN-1 downto 0);
    signal memory_data_out    : std_logic_vector(CPU_WORD-1 downto 0);                   
    signal memory_imm12_out   : std_logic_vector(11 downto 0);                           
    signal memory_hecu_wb_sel  : std_logic;
    signal memory_hecu_wb_en   : std_logic;
    signal memory_hecu_wb_reg  : std_logic_vector(3 downto 0);
    signal memory_hecu_data    : std_logic_vector(CPU_WORD-1 downto 0);

    -- Writeback stage output signals
    signal writeback_wb_data : std_logic_vector(CPU_WORD-1 downto 0);
    signal writeback_wb_reg : std_logic_vector(3 downto 0);

    -- HECU
    signal hecu_exe_reg_dout : std_logic_vector(CPU_WORD-1 downto 0);
    signal hecu_mem_reg_dout : std_logic_vector(CPU_WORD-1 downto 0);
    signal hecu_reg1_sel     : std_logic_vector(1 downto 0);
    signal hecu_reg2_sel     : std_logic_vector(1 downto 0);

begin
    decode: entity work.decode port map (
        clk              => clk,
        rst              => rst,
        opcode           => fetch_operation(3 downto 0),
        reg1addr         => fetch_operation(11 downto 8),
        reg2addr         => fetch_operation(15 downto 12),
        curr_wb_reg_addr => writeback_wb_reg,
        new_wb_reg_addr  => fetch_operation(7 downto 4),
        wb_reg_data      => writeback_wb_data,
        flags_in         => execute_flags_out,
        flags_wr         => execute_flags_wr,
        hecu_mem_in      => hecu_mem_reg_dout,
        hecu_exe_in      => hecu_exe_reg_dout, 
        hecu_reg1_sel    => hecu_reg1_sel,
        hecu_reg2_sel    => hecu_reg2_sel,
        hecu_req_reg1    => decode_hecu_req_reg1,
        hecu_req_reg2    => decode_hecu_req_reg2,
        control_out      => decode_control,
        reg1data         => decode_reg1data,
        reg2data         => decode_reg2data,
        flags_out        => decode_flags_out,
        pc_value         => decode_pc_value,
        imm12_out        => decode_imm12_out
    );

    execute: entity work.execute port map (
        clk          => clk,
        rst          => rst,
        control_in   => decode_control,
        imm12_in     => decode_imm12_out,
        op1          => decode_reg1data,      
        op2          => decode_reg2data,     
        flags        => decode_flags_out,
        hecu_wb_sel  => execute_hecu_wb_sel,
        hecu_wb_en   => execute_hecu_wb_en,
        hecu_wb_reg  => execute_hecu_wb_reg,
        hecu_data    => execute_hecu_data, 
        flags_wr     => execute_flags_wr,   
        flags_out    => execute_flags_out,   
        control_out  => execute_control_out, 
        imm12_out    => execute_imm12_out,   
        mem_data_out => execute_mem_data_out,
        result       => execute_result      
    );

    memory: entity work.memory port map (
        clk         => clk,
        rst         => rst,
        control_in  => execute_control_out,
        pgm_addr    => decode_pc_value,
        pgm_data    => fetch_operation,
        ram_data    => execute_mem_data_out,
        alu_data    => execute_result,
        imm12_in    => execute_imm12_out,
        hecu_wb_sel  => memory_hecu_wb_sel,
        hecu_wb_en   => memory_hecu_wb_en,
        hecu_wb_reg  => memory_hecu_wb_reg,
        hecu_data    => memory_hecu_data, 
        control_out => memory_control_out,
        mem_data    => memory_data_out,
        imm12_out   => memory_imm12_out
    );

    writeback: entity work.writeback port map (
        control_in => memory_control_out,
        mem_data   => memory_data_out,
        imm12      => memory_imm12_out,
        wb_data    => writeback_wb_data,
        wb_reg     => writeback_wb_reg
    );

    hecu: entity work.hecu port map (
        req_reg1     => decode_hecu_req_reg1,
        req_reg2     => decode_hecu_req_reg2,
        exe_wb_sel   => execute_hecu_wb_sel,
        exe_wb_en    => execute_hecu_wb_en,
        exe_wb_reg   => execute_hecu_wb_reg,
        exe_reg_din  => execute_hecu_data,
        mem_wb_sel   => memory_hecu_wb_sel,
        mem_wb_en    => memory_hecu_wb_en,
        mem_wb_reg   => memory_hecu_wb_reg,
        mem_reg_din  => memory_hecu_data,
        exe_reg_dout => hecu_exe_reg_dout,
        mem_reg_dout => hecu_mem_reg_dout,
        reg1_sel     => hecu_reg1_sel,    
        reg2_sel     => hecu_reg2_sel    
    );
end architecture;
