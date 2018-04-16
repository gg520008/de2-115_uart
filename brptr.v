`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:00 03/27/2009 
// Design Name: 
// Module Name:    brptr 
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
module brptr (rptr,rstate,rclk,empty,rst_n,rinc);
  parameter size=4;
  output [size-1:0] rptr; 
  output rstate;
  input rclk,rst_n,empty,rinc;
  reg [size-1:0] rgray;
  reg [size:0] rbin5;
  wire [size:0] rbnext5;
  wire [size-1:0] rgnext,rbnext;
  wire [size-1:0] rptr;
  reg rstate;
  
  always @ (posedge rclk or negedge rst_n)
      begin
          if(!rst_n)  
              begin 
                  rbin5<=0;
                  rgray<=0;
                  rgray[size-1:0] <=0;
                  rstate <=0;          
              end
          else 
              begin 
                  rbin5<=rbnext5;
                  rgray<=rgnext;
                  rstate <= rbnext5[size];   //use the msb of bin as rstate
              end
      end 
//---------------------------------------------------------------
// increment the binary count if not empty
//---------------------------------------------------------------
  assign rbnext5 = !empty ? rbin5 + rinc : rbin5;
  assign rbnext = rbnext5[size-1:0];
  assign rgnext = (rbnext>>1) ^ rbnext; // binary-to-gray conversion
  assign rptr[size-1:0] = rgray[size-1:0];//use gray as the address of read data
endmodule

