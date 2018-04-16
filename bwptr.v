`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:59:19 03/27/2009 
// Design Name: 
// Module Name:    bwptr 
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
module bwptr (wptr,wstate,wclk,full,rst_n,winc);
  parameter size=4;
  output [size-1:0] wptr; 
  output wstate;
  input wclk,rst_n,full,winc;
  reg [size-1:0] wgray;
  reg [size:0] wbin5;
  wire [size:0] wbnext5;
  wire [size-1:0] wgnext,wbnext;
  wire [size-1:0] wptr;
  reg wstate;
  
  always @ (posedge wclk or negedge rst_n)
      begin
          if(!rst_n)  
              begin 
                  wbin5<=0;
                  wgray<=0;
                  wgray[size-1:0] <=0;
                  wstate <=0;         
              end
          else 
              begin 
                  wbin5<=wbnext5;
                  wgray<=wgnext;
                  wstate <= wbnext5[size];   //use the msb of bin as wstate
              end
      end 
//---------------------------------------------------------------
// increment the binary count if not full
//---------------------------------------------------------------
  assign wbnext5 = !full ? wbin5 + winc : wbin5;
  assign wbnext = wbnext5[size-1:0];
  assign wgnext = (wbnext>>1) ^ wbnext; // binary-to-gray conversion
  assign wptr[size-1:0] = wgray[size-1:0];//use gray as the address of write data
endmodule

