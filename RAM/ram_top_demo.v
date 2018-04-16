//edit by : li
//edit data : 2018 Apr.13
// 
module ram_top_demo (
				clk,
				rst_n,
				q
				);
	input clk;
	input rst_n;
	output [7:0] q;
	wire wren;
	wire [7:0] addr;
	wire [7:0] data;
	ram_control_demo ram_control_demo(
				.clk(clk),
				.rst_n(rst_n),
				.wren(wren),
				.addr(addr),
				.data(data)
	);

	my_ram my_ram_inst(
				.address(addr),
				.clock(clk),
				.data(data),
				.wren(wren),
				.q(q)
				
	);
endmodule
	
	
	
	
	
	
	
	
	
	
	
	