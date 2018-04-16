library verilog;
use verilog.vl_types.all;
entity contr_fifo_send_ram is
    generic(
        rfree           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        wwrite          : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        wwtran          : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        wtran           : vl_logic_vector(0 to 1) := (Hi1, Hi1)
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        ti              : in     vl_logic;
        rdfull          : in     vl_logic;
        rdempty         : in     vl_logic;
        rdreq           : out    vl_logic;
        wrfull          : in     vl_logic;
        wrempty         : in     vl_logic;
        data            : out    vl_logic_vector(7 downto 0);
        wrreq           : out    vl_logic;
        addr            : out    vl_logic_vector(7 downto 0);
        wren            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of rfree : constant is 1;
    attribute mti_svvh_generic_type of wwrite : constant is 1;
    attribute mti_svvh_generic_type of wwtran : constant is 1;
    attribute mti_svvh_generic_type of wtran : constant is 1;
end contr_fifo_send_ram;
