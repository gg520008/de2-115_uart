//对fifo进行读出
module rd_fifo(
				clk,
				rst_n,
				rdfull,
				rdempty,
				rdreq
				);
			
			input clk;
			input rst_n;
			input rdfull;
			input rdempty;
			output reg rdreq;
			reg state;
			
			always @ (posedge clk or negedge rst_n)
				begin
					if(!rst_n)
					begin
						rdreq <= 0;
						state <= 0;
					end
						else
						case(state)
						0 : begin
								if(rdfull)
								begin
									rdreq <= 1;
									state <= 1;
								end
									else
									state <= 0;
							end
						1 : begin
							if (rdempty)
							begin
								rdreq <= 0;
								state <= 0;
							end
						else
						begin
							rdreq <= 1;
							state <= 1;
						end
					end
					endcase
				end
endmodule
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				
				