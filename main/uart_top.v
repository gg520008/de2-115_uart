/********************uart_test*************************
**模块名称：uart_test
**功能描述：uart的测试顶层模块
**************************************************/
module uart_top(
				clock,					//系统时钟
				RXD,
				TXD,					//uart接收与发送引脚
				rst_n
				);
input clock;					 		//系统时钟(48MHz)
input RXD;								//uart接收引脚
input rst_n;
output TXD;		
					//uart发送引脚
//wire [7:0] senddata;						//发送一个字节的数据缓存区
//wire [7:0] recdata;						//接收缓存区
//wire RI,TI,WR;	//接收、发送中断以及写控制信号	
wire clksend,clkrec;					//发送和接收的时钟频率
//wire full_rec,full_send,winc,rinc;
//wire empty;
//wire [7:0] rdata;
//wire en;
wire [7:0] recdata;
wire en_rec;
wire empty_rec;
wire full_rec;
wire rinc_rec;
wire winc_rec;
wire wr_rec;
wire TI_rec;
wire [7:0] fifo_data_rec;

wire [7:0]senddata;
wire en_send;
wire empty_send;
wire full_send;
wire rinc_send;
wire winc_send;
wire wr_send;
wire TI_send;
wire [7:0]fifo_data_send;

wire rdreq_rec;
wire rdempty_rec;
wire rdfull_rec;
wire wrreq_rec;


wire wrfull_rec;
wire wrempty_rec;
wire [7:0] addr_rec;
wire wren_rec;


rec  uartrec(							//实例化一个uart接收模块
            .rst_n(rst_n),
            .clk(clock),
            .clkout(clkrec),
            .Dataout(recdata),
            .RXD(RXD),
			.en(en_rec)
            );	
//带fifo 的发送器	
my_fifo rec_fifo (
			.rdclk(clock),
			.data(recdata),
			.rdreq(rdreq_rec),
			.wrclk(clock),
			.wrreq(wrreq_rec),
			.q(fifo_data_rec),
			.rdempty(rdempty_rec),
			.rdfull(rdfull_rec),
			.wrempty(wrempty_rec),
			.wrfull(wrfull_rec)
			);
my_ram my_ram_rec (
			.clock(clock),
			.address(addr_rec),
			.data(fifo_data_rec),
			.wren(wren_rec)
			//.q
			);
contr_fifo_rec_ram contr_fifo_rec_ram(
			.clk(clock),
			.rst_n(rst_n),
			.en(en_rec),  //rec 信号
			.rdfull(rdfull_rec),
			.rdempty(rdempty_rec),
			.rdreq(rdreq_rec),
			.wrfull(wrfull_rec),
			.wrempty(wrempty_rec),
			//.data(),
			.wrreq(wrreq_rec),
			.addr(addr_rec),
			.wren(wren_rec)
			);
///////////////////////////////////////////////////////////////////
wire [7:0] addr_send;
wire wren_send;
wire rdreq_send;
wire wrreq_send;
wire rdempty_send;
wire rdfull_send;
wire wrempty_send;
wire wrfull_send;
		
send   uartsend(						//实例化一个uart发送模块
				.rst_n(rst_n),
				.clk(clock),
				.clkout(clksend),
				.Datain(senddata),
				.TXD(TXD),
				.TI(TI_send),
				.WR(wr_send)
				);
// my_fifo send_fifo (
			// .rdclk(clock),
			// .data(fifo_ram),
			// .rdreq(rdreq_send),
			// .wrclk(clock),
			// .wrreq(wrreq_send),
			// .q(senddata),
			// .rdempty(rdempty_send),
			// .rdfull(rdfull_send),
			// .wrempty(wrempty_send),
			// .wrfull(wrfull_send)
			// );

my_ram my_ram_send (
	// my_ram my_ram_inst (
			.clock(clock),
			.address(addr_send),
			.data(fifo_data_send),
			.wren(wren_send),
			.q(senddata)
			);
contr_fifo_send_ram contr_fifo_send_ram(
			.clk(clock),
			.rst_n(rst_n),
			.ti(TI_send),  //rec 信号
			.rdfull(rdfull_send),
			.rdempty(rdempty_send),
			.rdreq(rdreq_send),
			.wrfull(wrfull_send),
			.wrempty(wrempty_send),
			.data(fifo_data_send),
			.wrreq(wr_send),
			.addr(addr_send),
			.wren(wren_send)
			);
endmodule