library verilog;
use verilog.vl_types.all;
entity diven is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        en1             : in     vl_logic;
        diven           : out    vl_logic
    );
end diven;
