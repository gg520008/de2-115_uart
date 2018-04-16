library verilog;
use verilog.vl_types.all;
entity system_ctrl is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        sys_rst_n       : out    vl_logic
    );
end system_ctrl;
