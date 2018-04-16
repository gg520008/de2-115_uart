library verilog;
use verilog.vl_types.all;
entity fifo is
    port(
        rdata           : out    vl_logic_vector(7 downto 0);
        full            : out    vl_logic;
        empty           : out    vl_logic;
        wdata           : in     vl_logic_vector(7 downto 0);
        winc            : in     vl_logic;
        wclk            : in     vl_logic;
        rinc            : in     vl_logic;
        rclk            : in     vl_logic;
        rst_n           : in     vl_logic
    );
end fifo;
