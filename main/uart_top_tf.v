//edit by : li
//edit data : 2018 Apr.13
//fifo read and write top file test
`timescale 1ns/1ps  
module uart_top_tf ;
	reg clk;
	reg rst_n;
	reg rxd;
	wire txd;
	wire [7:0] q;
	initial begin
		clk = 1;
		rst_n = 0;
		rxd = 1;
#200.1
		rst_n = 1;
		end
			
	always # 10 clk = ~clk;   //50Mhz clock
	always # 104167 rxd =~rxd;
	
uart_top uart_top( 
				.clock(clk),					//系统时钟
				.RXD(rxd),
				.TXD(txd),					//uart接收与发送引脚
				.rst_n(rst_n)
				
	);
	
endmodule