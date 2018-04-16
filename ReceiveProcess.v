//`define ID 1'b0101

module ReceiveProcess(clock,rst_n,Data0,Data1,Data2,Data3,Data4,		Data5 ,
Data6 ,
Data7 ,
Data8 ,
Data9 ,
Data10 ,pulse1start,pulse1end,pulse2start1,pulse2end1,pulse2start2,pulse2end2);
input clock;
input rst_n;

input [7:0]Data0 ;    //header
input [7:0]Data1 ;    //function
input [7:0]Data2 ;
input [7:0]Data3 ;
input [7:0]Data4 ;
input [7:0]Data5 ;
input [7:0]Data6 ;
input [7:0]Data7 ;
input [7:0]Data8 ;
input [7:0]Data9 ;
input [7:0]Data10 ;     //check

output reg [31:0]pulse1start;
output reg [31:0]pulse1end;

output reg [31:0]pulse2start1;
output reg [31:0]pulse2end1;
output reg [31:0]pulse2start2;
output reg [31:0]pulse2end2;

always@(posedge clock or negedge rst_n)
	begin
		if(!rst_n);
		else 
		begin
		//pulse1end[7:0] <= Data3;
			if(Data0 == 8'b01010101)
			begin
				if(Data1 == 8'b00010001) //single pulse
				begin
					pulse1start[31:24] <= Data2; // 
					pulse1start[23:16] <= Data3; // 
					pulse1start[15:8] <= Data4; // 
					pulse1start[7:0] <= Data5; // 
					
				    pulse1end[31:24] <= Data6; // 
					pulse1end[23:16] <= Data7; // 
					pulse1end[15:8] <= Data8; // 
					pulse1end[7:0] <= Data9; // 
				end
				
			   else if(Data1 == 8'b00010010)   //double pulse
				begin
				   pulse2start1 <= 0;
					
					pulse2end1[31:24] <= 0; // 
					pulse2end1[23:16] <= Data2; // 
					pulse2end1[15:8] <= Data3; // 
					pulse2end1[7:0] <= Data4; // 
					
				    pulse2start2[31:24] <= 0; // 
					pulse2start2[23:16] <= Data5; // 
					pulse2start2[15:8] <= Data6; // 
					pulse2start2[7:0] <= Data7; // 
					
						pulse2end2[31:24] <= 0; // 
						pulse2end2[23:16] <= Data8; // 
						pulse2end2[15:8] <= Data9; // 
						pulse2end2[7:0] <= Data10; // 
				end
			end
			
		end
		
	end

endmodule
	
	
	