library verilog;
use verilog.vl_types.all;
entity contr_fifo_rec_ram is
    generic(
        free            : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        write           : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        wat             : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        rfree           : vl_logic_vector(0 to 1) := (Hi0, Hi0);
        wwrite          : vl_logic_vector(0 to 1) := (Hi0, Hi1);
        wwtran          : vl_logic_vector(0 to 1) := (Hi1, Hi0);
        wtran           : vl_logic_vector(0 to 1) := (Hi1, Hi1);
        count1          : integer := 999;
        countk          : integer := 999;
        countM          : integer := 499
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        en              : in     vl_logic;
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
    attribute mti_svvh_generic_type of free : constant is 1;
    attribute mti_svvh_generic_type of write : constant is 1;
    attribute mti_svvh_generic_type of wat : constant is 1;
    attribute mti_svvh_generic_type of rfree : constant is 1;
    attribute mti_svvh_generic_type of wwrite : constant is 1;
    attribute mti_svvh_generic_type of wwtran : constant is 1;
    attribute mti_svvh_generic_type of wtran : constant is 1;
    attribute mti_svvh_generic_type of count1 : constant is 1;
    attribute mti_svvh_generic_type of countk : constant is 1;
    attribute mti_svvh_generic_type of countM : constant is 1;
end contr_fifo_rec_ram;
