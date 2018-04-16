//对fifo进行写入
module wr_fifo(
			clk,
			rst_n,
			wrfull,
			wrempty,
			data,
			wrreq
			);

input clk;
input rst_n;
input wrfull;
input wrempty;
output reg [7:0] data;
output reg wrreq;
//定义中间寄存器
reg state;

always @(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			data <= 0;
			wrreq <= 0;
			state <= 0;
		end
	else
		begin
			case (state)
				0 : begin
					if (wrempty)
						begin
							state <= 1;
							wrreq <= 1;
							data <= 0;
						end
					    else
							state <= 0;
					end
				1 :begin
					if (wrfull)
						begin 
							state <= 0;
							data <= 0;
							wrreq <= 0;
						end
					else
						begin
							data <= data + 1;
							wrreq <= 1;
						end
					end
			endcase
		end
	end
	
endmodule
	
					
		
				
					
					
					
					
						
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
			