library verilog;
use verilog.vl_types.all;
entity mydelay_vlg_check_tst is
    port(
        flagout         : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end mydelay_vlg_check_tst;
