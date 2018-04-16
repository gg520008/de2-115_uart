library verilog;
use verilog.vl_types.all;
entity uart_fifo_design is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_data        : in     vl_logic_vector(1 downto 0);
        fpga_rxd        : in     vl_logic;
        fpga_txd        : out    vl_logic
    );
end uart_fifo_design;
