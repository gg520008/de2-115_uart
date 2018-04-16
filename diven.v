module diven(clk,rst_n,en1,diven);
input clk;
input rst_n;
input en1;
output reg diven;
reg [3:0] counter;

reg enint1 = 0;
reg enint2 = 0;

always@(posedge clk or negedge rst_n)	
begin
	if(!rst_n) 
	begin
		enint1 <= 0;
		enint2 <= 0;
	end
	else 
	begin
		enint1 <= en1;
		enint2 <= enint1;
	end
end
 
wire enflag = ~enint1 & enint2;

always@(posedge clk or negedge rst_n)	
begin
	//enint <= en;
	if(!rst_n) diven <= 0;
	
	
		
	else if ( enflag)     //xiajiangyan
		 begin 
			counter <= counter + 1;
			diven <= 0;
			
		   if (counter == 9) diven <= 1;
			if (counter == 10) 
		   begin 
				
			   counter <= 0;
			end
		end
			
	else ;	
end




endmodule

