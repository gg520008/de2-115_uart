library verilog;
use verilog.vl_types.all;
entity fifo_read_write is
    generic(
        F_IDLE          : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        F_ENABLE        : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        F_READ          : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        F_STOP          : vl_logic_vector(0 to 1) := (Hi1, Hi0)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_flag        : in     vl_logic;
        key_value       : in     vl_logic_vector(1 downto 0);
        rxd_flag        : in     vl_logic;
        rxd_data        : in     vl_logic_vector(7 downto 0);
        txd_flag        : in     vl_logic;
        txd_en          : out    vl_logic;
        txd_data        : out    vl_logic_vector(7 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of F_IDLE : constant is 1;
    attribute mti_svvh_generic_type of F_ENABLE : constant is 1;
    attribute mti_svvh_generic_type of F_READ : constant is 1;
    attribute mti_svvh_generic_type of F_STOP : constant is 1;
end fifo_read_write;
