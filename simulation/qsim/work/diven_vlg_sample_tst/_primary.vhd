library verilog;
use verilog.vl_types.all;
entity diven_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        en1             : in     vl_logic;
        rst_n           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end diven_vlg_sample_tst;
