library verilog;
use verilog.vl_types.all;
entity fifo_vlg_check_tst is
    port(
        empty           : in     vl_logic;
        full            : in     vl_logic;
        rdata           : in     vl_logic_vector(7 downto 0);
        sampler_rx      : in     vl_logic
    );
end fifo_vlg_check_tst;
