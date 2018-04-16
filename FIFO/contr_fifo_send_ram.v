//对fifo存入ram
module contr_fifo_send_ram(
				clk,
				rst_n,
				ti,  //rec 信号//
				rdfull,
				rdempty,
				rdreq,
				wrfull,
				wrempty,
				data,
				wrreq,
				addr,
				wren
				);
	input rst_n;
	input clk;
	
	input ti;
	
	input rdfull;
	input rdempty;
	output reg rdreq;

	input wrfull;
	input wrempty;
	output reg wrreq;
	output reg [7:0] data;
	
	output reg [7:0] addr;     //给出ram地址
	output reg wren;           //若只写数据，==1
	
	reg [1:0] state = 0;              // 0 :read ram and no send
								// 1 :read ram and send
								// 2 :write and no send

	reg [1:0] state2 = 0;
	parameter 	rfree=2'b00,
				wwrite=2'b01,
				wwtran=2'b10,
				wtran=2'b11;
	
	wire TI;
	assign TI = ti;
	// //ram
	
always @(posedge clk or negedge rst_n)
	begin
		if(!rst_n) begin 
			wren <= 0;          //read ram
			addr <= 0;
			data <= 0;
			state <= 0;
			state2 <= 0;
			// wrreq <= 0;          //0 no send
			
		end
		else
			begin
				case (state)
					0 : begin
						if (addr < 16)  // generate data ,for test data increase from 0 to 16
							begin
							
								addr <= addr + 1;
								wren <= 1;
							end
								
						else
							begin
								addr <= 0;                        // for test
								state <= 2;                      //暂停状态
								wren <= 0;
							end
						if (data < 16) data <= data + 1;		 //数据...
						else data <= 0;                          //数据...
						end                                      //数据...
							
					1 : begin
						// if (addr < 16 )  //addr between 0 and 16, enable write
							// begin
								case (state2)
										rfree:if(TI&&addr>=16)begin
													state2 <= rfree;
												    state <= 0;
													end
												else if(TI&&addr<16)begin
														state2=wwrite;
														end
												else state2 = rfree;  //
										wwrite:if(TI) begin
													state2=wwtran;
													end
												else begin
													state2=wtran;
													end
										wwtran:if(TI) begin
													state2=wwtran;
													end
												else   begin
													state2=wtran;
													end
										wtran:if(!TI)  begin
													state2=wtran;
													end
												else if(TI && addr<16) begin
															state2 <= rfree;         //完成一个字节发送
															addr  <= addr + 1;
															end
														else if(TI && addr >= 16) begin   //完成16字节发送
																state2 <= rfree;
																state <= 0;
																addr  <= 0;
																//若还要写 wren = 1;
																end
										default:state2=rfree;							
								endcase
						end
					2 : begin
							if(TI) state <= 1; //uart send is ready
						end
						//default : state <= 0;
				endcase
			
			end
	end
	
	// //uart
	// always@(posedge clock or  negedge rst_n)  //readFSM
// begin
		// if(!rst_n)begin
				// state2=rfree;
				// end
		// else case(state2)
					// rfree:if(TI&empty)begin
								// state2=rfree;
								// end
							// else if(TI&!empty)begin
									// state2=wwrite;
									// end
					// wwrite:if(TI) begin
								// state2=wwtran;
								// end
							// else begin
								// state2=wtran;
								// end
					// wwtran:if(TI) begin
								// state2=wwtran;
								// end
							// else   begin
								// state2=wtran;
								// end
					// wtran:if(!TI)  begin
								// state2=wtran;
								// end
							// else if(TI&!empty) begin
										// state2=wwrite;
										// end
									// else if(TI&empty)begin
											// state2=rfree;
											// end
				// default:state2=rfree;
				// endcase
// end 
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)begin
		wrreq=1'b0;
		// rinc=1'b0;
	end
	else begin
	case(state2)
			rfree:begin
					wrreq <= 1'b0;
					// rinc=1'b0;
					end
			wwrite:begin
					wrreq <= 1'b1;
					// rinc=1'b1;
					end
			wwtran:begin
					wrreq <= 1'b0;
					// rinc=1'b0;
					end
			wtran:begin
					wrreq <= 1'b0;
					// rinc=1'b0;
					end
			default:begin
						wrreq <= 1'b0;
						// rinc=1'b0;
					end
	endcase
	end
end	

endmodule





























