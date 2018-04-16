library verilog;
use verilog.vl_types.all;
entity uart_top is
    port(
        clock           : in     vl_logic;
        RXD             : in     vl_logic;
        TXD             : out    vl_logic;
        rst_n           : in     vl_logic
    );
end uart_top;
