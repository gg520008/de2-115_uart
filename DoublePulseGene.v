module DoublePulseGene(clk,rst_n,pulse2start1,pulse2end1,pulse2start2,pulse2end2,startclock,gpio);
input clk;
input rst_n;
input [31:0]pulse2start1;
input [31:0]pulse2end1;
input [31:0]pulse2start2;
input [31:0]pulse2end2;
input startclock;
output reg [5:0]gpio;

reg startint1 = 0;
reg startint2 = 0;

reg [40:0]counter;                       //32 位记满约 86s
reg [31:0]counter1;
reg startflag;
reg startflag1 ;
reg startflag2;
//always @(posedge clk or negedge rst_n)
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				startint1 <= 0;
				startint2 <= 0;
			end
		else 
			begin
				startint1 <= startclock;
				startint2 <= startint1;
				startflag = (~startint1) & startint2; 
			end
	end

//assign startflag = (~startint1) & startint2;         //下降沿


always @(posedge clk)
	begin
		if(!rst_n)
			begin
				counter1 <= 0;
			end
		else 
			begin
				if (startflag == 1) counter1[26:0] <= 0;
				else if (counter1[26:0]== 26'd25000000)  //delay 500ms
					begin startflag1 <= 1; counter1[26:0] <= 0 ; end
				else if(startflag2 == 0) startflag1 <= 0;
				else counter1[26:0] <= counter1[26:0] + 1'b1;          // 1 min 左右
			end
	end
		
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n)
			begin
				counter = 0;
			end
		else if (startflag) counter <= 0;
		else counter <= counter + 1'b1;          // 1 min 左右
	end
	
always @(posedge clk )
	begin 
		if (counter == pulse2start1) /* (startflag1)*/  begin gpio <= 6'b111111; startflag2 <= 1;end

		else if(counter == pulse2end1) 
			begin
				gpio <= 6'b000000;
				startflag2 <= 1;
			end
		else if(counter == pulse2start2) 
			begin
				gpio <= 6'b111111;
				startflag2 <= 1;
			end
		else if(counter == pulse2end2) 
			begin
				gpio <= 6'b000000;
				startflag2 <= 0;
			end
		else if(counter > pulse2end2)
			begin
				
				gpio <= 6'b000000;
			end
		else ;

	end
	
endmodule
	
	
	
	
	