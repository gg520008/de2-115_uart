//-------------------------------------
// Authors: Pan, Alberto.
// Function: To process the RS232 signal
// Date: March 2014
//-------------------------------------

module baud_select(clk,rst_n,baud_start,mid_flag);
input clk;
input rst_n;
input baud_start;
output mid_flag;

//parameter 	bps9600 	= 5207,	//9600bps
//    		 	bps19200 	= 2603,	//19200bps
//				bps38400 	= 1301,	//38400bps
//				bps57600 	= 867,	//57600bps
//				bps115200	= 433;	//115200bps
//
//parameter 	bps9600_2 	= 2603,
//				bps19200_2	= 1301,
//				bps38400_2	= 650,
//				bps57600_2	= 433,
//				bps115200_2 = 216;  

`define		BPS_PARA		5207
`define		BPS_PARA_2		2603
//***************************************************************************
reg[12:0]cont;
always @(posedge clk or negedge rst_n)      //时钟上升沿或复位下降沿执行如下操作 50m 20ns
	if(!rst_n)cont<= 13'd0;                   //2^13 > 5207
	else if((cont==`BPS_PARA)||!baud_start)cont<= 13'b0_0000_0000_0000;
	else cont<=cont+1'b1;
	
//***************************************************************************
reg mid_flag_1; 
always @(posedge clk or negedge rst_n)
	if(!rst_n)mid_flag_1<=1'b0;
	else if((cont==`BPS_PARA_2))mid_flag_1<=1'b1;
	else mid_flag_1<=1'b0;
assign mid_flag=mid_flag_1;
endmodule 
//***************************************************************************

	
	
	
	
	
		
		
		
									
