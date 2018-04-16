module mydelay(clk,rst_n,flagin,flagout);
input clk;
input rst_n;
input flagin;
output reg flagout;
reg [32:0] counter;
reg flagset;

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			flagset <= 0;
			flagout <= 0;
			counter <= 0;
		end
	
	else begin
			if (flagin)
				begin
					flagset <= 1;
					flagout <= 0;
				end
			else if (counter == 25000000) //500 ms,delay 500ms until all received datas are update
				begin
					flagset <= 0;
					counter <= 0;
					flagout <= 1;
				end
			else if (flagset) 
				begin
					counter <= counter + 1'b1;
					flagout <= 0;
				end
			else flagout <= 0;
			
	     end
end

endmodule




