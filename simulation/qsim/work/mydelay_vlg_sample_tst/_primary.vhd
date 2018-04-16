library verilog;
use verilog.vl_types.all;
entity mydelay_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        flagin          : in     vl_logic;
        rst_n           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end mydelay_vlg_sample_tst;
