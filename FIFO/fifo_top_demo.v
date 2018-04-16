//edit by : li
//edit data : 2018 Apr.13
//fifo read and write top file 
module fifo_top_demo (
				clk,
				rst_n,
				q
				);
	input clk;
	input rst_n;
	output [7:0] q; //输出数据
	wire wrfull;    //写满信号
	wire wrempty;
	wire [7:0] data; //fifo输入数据
	wire wrreq;     //写请求信号
	wire rdfull;    //
	wire rdempty;
	wire rdreq;     //读请求信号
	wr_fifo wr_fifo(
					.clk(clk),
					.rst_n(rst_n),
					.wrfull(wrfull),
					.wrempty(wrempty),
					.data(data),
					.wrreq(wrreq)
	);

	rd_fifo rd_fifo(
					.clk(clk),
					.rst_n(rst_n),
					.rdfull(rdfull),
					.rdempty(rdempty),
					.rdreq(rdreq)
	);

	my_fifo my_fifo_inst(
					.data(data),
					.rdclk(clk),
					.rdreq(rdreq),
					.wrclk(clk),
					.wrreq(wrreq),         //write request
					.q(q),
					.rdempty(rdempty),      //读空信号
					.rdfull(rdfull),
					.wrempty(wrempty),
					.wrfull(wrfull)
	);
endmodule
	
	
	
	