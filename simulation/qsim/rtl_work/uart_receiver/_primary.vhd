library verilog;
use verilog.vl_types.all;
entity uart_receiver is
    generic(
        R_IDLE          : vl_logic := Hi0;
        R_SAMPLE        : vl_logic := Hi1
    );
    port(
        clk             : in     vl_logic;
        clk_smp         : in     vl_logic;
        rst_n           : in     vl_logic;
        rxd             : in     vl_logic;
        rxd_flag        : out    vl_logic;
        rxd_data        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of R_IDLE : constant is 1;
    attribute mti_svvh_generic_type of R_SAMPLE : constant is 1;
end uart_receiver;
