library verilog;
use verilog.vl_types.all;
entity mydelay is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        flagin          : in     vl_logic;
        flagout         : out    vl_logic
    );
end mydelay;
