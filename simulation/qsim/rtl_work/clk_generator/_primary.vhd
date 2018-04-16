library verilog;
use verilog.vl_types.all;
entity clk_generator is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        clk_bps         : out    vl_logic;
        clk_smp         : out    vl_logic
    );
end clk_generator;
