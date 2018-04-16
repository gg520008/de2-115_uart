library verilog;
use verilog.vl_types.all;
entity uart_transfer is
    generic(
        T_IDLE          : vl_logic := Hi0;
        T_SEND          : vl_logic := Hi1
    );
    port(
        clk             : in     vl_logic;
        clk_bps         : in     vl_logic;
        rst_n           : in     vl_logic;
        txd_en          : in     vl_logic;
        txd_data        : in     vl_logic_vector(7 downto 0);
        txd_flag        : out    vl_logic;
        txd             : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T_IDLE : constant is 1;
    attribute mti_svvh_generic_type of T_SEND : constant is 1;
end uart_transfer;
