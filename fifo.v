`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:02:26 03/27/2009 
// Design Name: 
// Module Name:    fifo2 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
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
endmodule

