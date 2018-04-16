/********************uart_test*************************
**模块名称：uart_test
**功能描述：uart的测试顶层模块
**************************************************/
module uart_tf(
				clock,					//系统时钟
				RXD,
				TXD,					//uart接收与发送引脚
				rst_n,rdata,
				senddata,recdata,RI,TI,WR,clksend,clkrec,full,winc,rinc,empty,en
				);
input clock;					 		//系统时钟(48MHz)
input RXD;								//uart接收引脚
input rst_n;
output TXD;							//uart发送引脚
input [7:0] senddata;						//发送一个字节的数据缓存区
input [7:0] recdata;						//接收缓存区
input RI,TI,WR;	//接收、发送中断以及写控制信号								
input clksend,clkrec;					//发送和接收的时钟频率
output full,winc,rinc;
input empty;
input [7:0] rdata;
input en;
control_fifo fifocontrol(
								 .rst_n(rst_n),
								 .clock(clock),
								 .full(full),
								 .empty(empty),
								 .winc(winc),
								 .rinc(rinc),
								 .en(en),
								 .WR(WR),
								 .TI(TI)
								 );
fifo fifo1(
           .rdata(senddata),
           .full(full), //
			  .empty(empty), //
			  .wdata(recdata),
			  .winc(winc),// 
			  .wclk(clock), 
			   .rinc(rinc), //
			  .rclk(clock), 
			   .rst_n(rst_n)
			 );
rec  uartrec(							//实例化一个uart接收模块
            .rst_n(rst_n),
            .clk(clock),
            .clkout(clkrec),
            .Dataout(recdata),
            .RXD(RXD),
				.en(en)
            );			
send   uartsend(						//实例化一个uart发送模块
               .rst_n(rst_n),
              .clk(clock),
              .clkout(clksend),
              .Datain(senddata),
              .TXD(TXD),
              .TI(TI),
             .WR(WR)
              );
endmodule