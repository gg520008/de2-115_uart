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



fifo fifo_rec(
              .rdata(fifo_data_rec),
              .full(full_rec), //
			  .empty(empty_rec), //
			  .wdata(recdata),
			  .winc(winc_rec),// 
			  .wclk(clock), 
			   .rinc(rinc_rec), //
			  .rclk(clock), 
			   .rst_n(rst_n)
			 );
control_fifo fifocontrol_rec(
								 .rst_n(rst_n),
								 .clock(clock),
								 .full(full_rec),
								 .empty(empty_rec),
								 .winc(winc_rec),
								 .rinc(rinc_rec),
								 .en(en_rec),
								 .WR(wr_rec),
								 .TI(TI_rec)
								 );
rec  uartrec(							//实例化一个uart接收模块
            .rst_n(rst_n),
            .clk(clock),
            .clkout(clkrec),
            .Dataout(recdata),
            .RXD(RXD),
				.en(en_rec)
            );	
//带fifo 的发送器	

fifo fifo_send(
				.rdata(senddata),
				.full(full_send), //
				.empty(empty_send), //
				.wdata(fifo_data_send),
				.winc(winc_send),// 
				.wclk(clock), 
				.rinc(rinc_send), //
				.rclk(clock), 
				.rst_n(rst_n)
				);
control_fifo fifocontrol_send(
								 .rst_n(rst_n),
								 .clock(clock),
								 .full(full_send),
								 .empty(empty_send),
								 .winc(winc_send),
								 .rinc(rinc_send),
								 .en(en_send),
								 .WR(wr_send),
								 .TI(TI_send)
								 );
send   uartsend(						//实例化一个uart发送模块
               .rst_n(rst_n),
              .clk(clock),
              .clkout(clksend),
              .Datain(senddata),
              .TXD(TXD),
              .TI(TI_send),
             .WR(wr_send)
              );	
endmodule