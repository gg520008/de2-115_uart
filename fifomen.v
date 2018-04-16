`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:57:51 03/27/2009 
// Design Name: 
// Module Name:    fifomen 
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
module fifomem (rdata, wdata, waddr, raddr, wclken, wclk);
  parameter DATASIZE = 8; // Memory data word width
  parameter ADDRSIZE = 8; // Number of memory address bits
  parameter DEPTH = 1<<ADDRSIZE; // DEPTH = 2**ADDRSIZE
  output [DATASIZE-1:0] rdata;
  input [DATASIZE-1:0] wdata;
  input [ADDRSIZE-1:0] waddr, raddr;
  input wclken, wclk;
  reg i;
  
 /* initial
   begin
	 MEM[0] = 0;
	 MEM[1] = 0;
	 MEM[2] = 0;
	 MEM[3] = 0;
	 MEM[4] = 0;
	 MEM[5] = 0;
	 MEM[6] = 0;
	 MEM[7] = 0;
	 MEM[8] = 0;
	 MEM[9] = 0;
	 MEM[10] = 0;
	 MEM[11] = 0;
	 MEM[12] = 0;
	 MEM[13] = 0;
	 MEM[14] = 0;
	 MEM[15] = 0;
	end*/
  
  
  
  
 /* `ifdef VENDORRAM
// instantiation of a vendor's dual-port RAM
      VENDOR_RAM MEM (.dout(rdata), .din(wdata),
                    .waddr(waddr), .raddr(raddr),
                    .wclken(wclken), .clk(wclk));
  `else*/
 
 reg [DATASIZE-1:0] MEM [0:DEPTH-1];
  assign rdata = MEM[raddr];
 
  always @(posedge wclk)
      if (wclken)
         MEM[waddr] <= wdata;
 //`endif
endmodule

