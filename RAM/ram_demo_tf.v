//edit by : li
//edit data : 2018 Apr.13
// 
`timescale 1ns/1ps
module	ram_demo_tf;
	reg clk;
	reg rst_n;
	wire [7:0] q;
	initial begin
		clk = 1;
		rst_n = 0;
#200.1
		rst_n = 1;
		end
			
	always # 10 clk = ~clk; 
	
ram_top_demo ram_top_demo (
				.clk(clk),
				.rst_n(rst_n),
				.q(q)
);

endmodule