//edit by : li
//edit data : 2018 Apr.13
// 
module ram_control_demo (
				clk,
				rst_n,
				wren,
				addr,
				data
				);
	input clk;
	input rst_n;
	output reg wren;          //read and write signal
	output reg [7:0] addr;    //address signal
	output reg [7:0] data;    //
	reg state;
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin 
			wren <= 0;
			addr <= 0;
			data <= 0;
			state <= 0;
		end
			else
			begin
				case (state)
					0 : begin
						if (addr < 255)  // generate data ,for test data increase from 0 to 255
							begin
							
								addr <= addr + 1;
								wren <= 1;
							end
								
						else
							begin
								addr <= 0;
								state <= 1;
								wren <= 0;
							end
						if (data < 255) data <= data + 1;
						else data <= 0;
						end
							
					1 : begin
						if (addr < 255)  //addr between 0 and 255, enable write
						begin 
							addr <= addr + 1;
							wren <= 0;            //read
							end
						else begin
							state <= 0;  //clear 0
							addr <= 0;
						end
						end
						default : state <= 0;
				endcase

			end
	end
endmodule
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	