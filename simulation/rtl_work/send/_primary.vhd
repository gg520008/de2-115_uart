library verilog;
use verilog.vl_types.all;
entity send is
    generic(
        cout            : integer := 5207
    );
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        clkout          : out    vl_logic;
        Datain          : in     vl_logic_vector(7 downto 0);
        TXD             : out    vl_logic;
        TI              : out    vl_logic;
        WR              : in     vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of cout : constant is 1;
end send;
