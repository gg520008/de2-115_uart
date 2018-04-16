`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    17:07:37 01/15/2010 
// Design Name: 
// Module Name:    control_fifo 
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
module control_fifo(rst_n,clock,full,empty,winc,rinc,en,WR,TI);
input full,empty,rst_n,clock,en,TI;
output winc,rinc,WR;
reg en_1,en_2;
parameter free=2'b00,
          write=2'b01,
          wat=2'b10,
			 rfree=2'b00,
          wwrite=2'b01,
          wwtran=2'b10,
			 wtran=2'b11;
reg [1:0] state1;
reg [1:0] state2;
reg winc,rinc,WR;
wire data_en,TIti;
always@(posedge clock)
begin
	en_1<=en;
	en_2<=en_1;
	end
assign data_en=(~en_2)&en_1;
always@(posedge clock or negedge rst_n)//writeFSM
begin
		if(!rst_n)begin
			state1=free;
			winc=1'b0;
			end
		else	case(state1)
					free:if(!data_en)begin
							state1=free;
							winc=1'b0;
							end
							else begin 
							state1=write;
							winc=1'b1;
							end
					write:if(!data_en&!full)begin
							state1=free;
							winc=1'b0;
							end
							else begin
							state1=wat;
							winc=1'b0;
							end
					wat:if(!data_en)begin
							state1=free;
							winc=1'b0;
							end
							else begin
							state1=wat;
							winc=1'b0;
							end
				default: state1=free;
				endcase
end
always@(posedge clock or  negedge rst_n)  //readFSM
begin
		if(!rst_n)begin
				state2=rfree;
				end
		else case(state2)
					rfree:if(TI&empty)begin
								state2=rfree;
								end
							else if(TI&!empty)begin
									state2=wwrite;
									end
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
							else if(TI&!empty) begin
										state2=wwrite;
										end
									else if(TI&empty)begin
											state2=rfree;
											end
				default:state2=rfree;
				endcase
end 
///////////
always@(posedge clock or negedge rst_n)
begin
			if(!rst_n)begin
			WR=1'b0;
			rinc=1'b0;
			end
			else begin
			case(state2)
					rfree:begin
							WR=1'b0;
							rinc=1'b0;
							end
					wwrite:begin
							WR=1'b1;
							rinc=1'b1;
							end
					wwtran:begin
							WR=1'b0;
							rinc=1'b0;
							end
					wtran:begin
							WR=1'b0;
							rinc=1'b0;
							end
					default:begin
								WR=1'b0;
								rinc=1'b0;
								end
								endcase
					end
end				
endmodule
