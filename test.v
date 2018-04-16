//程序实现功能，每100ms 取一次值
//若有 全部发送

module test (clk,rst_n,empty, full, rdata, TI);
	parameter ASIZE = 8;
	reg [ASIZE-1:0] res;  //用来存放数据；和fifo位宽相同
	input clk;
	input rst_n;
	input empty;
	input full;
	input rdata;
	output TI;
	parameter cout = 24'd5000000;     //100ms
	reg read_flag <= 0	
always@(posedge clk or negedge rst_n)									//时钟节拍计数器
begin
	if(!rst_n)
		begin
			cnt <= 24'b0;
			read_flag <= 0;
		end 
		else 
		begin
			if(cnt == cout)
				begin
					read_flag <= 1;          //每隔100ms 
					cnt <= 24'b0;
				end
			else cnt <= cnt + 1'b1;
		end
end
		
always@(posedge clk or negedge rst_n)//
	begin
		if(!rst_n)
			begin
				//cnt<=16'b0;
			end 
			else 
				begin
					if (read_flag == 1'b1) TI <= 1     
					
				end
	end
	

		
/*
module fifo (rdata, full, empty, wdata,winc, wclk, rinc, rclk, rst_n);
  parameter DSIZE = 8;
  parameter ASIZE = 8;
  output [DSIZE-1:0] rdata;
  output full;
  output empty;
  input [DSIZE-1:0] wdata;
  input winc, wclk;
  input rinc, rclk, rst_n;
  wire [ASIZE-1:0] wptr, rptr;
//实例化各子模块，调用各子模块
  comp #(ASIZE) comp(.empty(empty),.full(full),.rptr(rptr),.wptr(wptr),
                     .rstate(rstate),.wstate(wstate), .rst_n(rst_n));
  
  brptr #(ASIZE) brptr(.rptr(rptr),.rstate(rstate),.rclk(rclk),
                       .empty(empty),.rst_n(rst_n),.rinc(rinc));
  
  bwptr #(ASIZE) bwptr (.wptr(wptr),.wstate(wstate),.wclk(wclk),
                        .full(full),.rst_n(rst_n),.winc(winc));
  
  fifomem #(DSIZE, ASIZE) fifomem (.rdata(rdata), .wdata(wdata),.waddr(wptr), 
                                   .raddr(rptr), .wclken(winc), .wclk(wclk));
							   */
endmodule
