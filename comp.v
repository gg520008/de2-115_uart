`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:00:35 03/27/2009 
// Design Name: 
// Module Name:    comp 
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
module comp (empty,full,rptr,wptr,rstate,wstate,rst_n);
  parameter size=4 ;
  input [size-1:0] rptr,wptr;	
  input rstate,wstate,rst_n;
  output empty,full;
  reg empty,full;
  
  always @ ( wptr or rptr)
    if (!rst_n) 
        begin 
            empty<=1;
            full<=0;
        end      
    else if((rptr==wptr)&&(rstate!=wstate)) //if address are the same but state are not the same.full is true
         full<=1;
      
    else if ((rptr==wptr)&&(rstate==wstate)) //if state and address both are the same ,empty is true  
         empty<=1;
    else 
    	begin
         	  empty <=0;
            full <=0;
        end
endmodule

