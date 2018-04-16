library verilog;
use verilog.vl_types.all;
entity rec is
    generic(
        cout            : integer := 325
    );
    port(
        rst_n           : in     vl_logic;
        clk             : in     vl_logic;
        clkout          : out    vl_logic;
        Dataout         : out    vl_logic_vector(7 downto 0);
        RXD             : in     vl_logic;
        en              : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of cout : constant is 1;
end rec;
