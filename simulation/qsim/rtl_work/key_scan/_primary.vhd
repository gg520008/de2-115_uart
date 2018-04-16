library verilog;
use verilog.vl_types.all;
entity key_scan is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        key_data        : in     vl_logic_vector(1 downto 0);
        key_flag        : out    vl_logic;
        key_value       : out    vl_logic_vector(1 downto 0)
    );
end key_scan;
