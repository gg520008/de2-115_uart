library verilog;
use verilog.vl_types.all;
entity fifo_vlg_sample_tst is
    port(
        rclk            : in     vl_logic;
        rinc            : in     vl_logic;
        rst_n           : in     vl_logic;
        wclk            : in     vl_logic;
        wdata           : in     vl_logic_vector(7 downto 0);
        winc            : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end fifo_vlg_sample_tst;
