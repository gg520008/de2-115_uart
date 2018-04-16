//对fifo存入ram
module contr_fifo_rec_ram(
				clk,
				rst_n,
				en,  //rec 信号
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
	
	input en;
	
	input rdfull;
	input rdempty;
	output reg rdreq;

	input wrfull;
	input wrempty;
	output reg wrreq;
	output reg [7:0] data;
	
	output reg [7:0] addr;     //给出ram地址
	output reg wren;           //若只写数据，==1
	
//定义状态常量	
parameter 	free=2'b00,
			write=2'b01,
			wat=2'b10,
			rfree=2'b00,
			wwrite=2'b01,
			wwtran=2'b10,
			wtran=2'b11,
			count1 = 999,
			countk = 999,
			countM = 499;   //计数500M， T = 10s
	
//定义中间寄存器
reg state;
reg [1:0] state1;
reg [1:0] state2;
reg [1:0] state_ram;

reg [9:0] cnt1 = 0;
reg [9:0] cntk = 0;
reg [9:0] cntm = 0;
reg chaoshi_flag =0;

reg en_1,en_2;	
wire data_en;

always@(posedge clk)
begin
	en_1<=en;
	en_2<=en_1;
	end
assign data_en=(~en_2)&en_1;  //posedge

//超时检测
always@(posedge clk or negedge rst_n)   //
begin
	if(!rst_n)begin
		cnt1 <= 0;
		cntk <= 0;
		cntm <= 0;
		chaoshi_flag <=0;
	end
	else
	begin
		cnt1 <= cnt1 + 1'b1;
		if(cnt1 == count1)	
		begin 
			cntk <= cntk + 1'b1;
			cnt1 <= 0;
		end
		if(cntk == countk)	
		begin 
			cntm <= cntm + 1'b1;
			cntk <= 0;
		end
		if(cntm == countM)	
		begin 
			//cntk <= cntk + 1'b1;
			cntm <= 0;
			chaoshi_flag <= !chaoshi_flag;   //超时标志翻转
		end
	end
end

always@(posedge clk or negedge rst_n)   //writeFSM fifo
begin
	if(!rst_n)begin
		state1=free;
		wrreq=1'b0;
		end
	else	
	case(state1)
			free:if(!data_en)begin
					state1=free;
					wrreq=1'b0;
					end
					else begin 
					state1=write;
					wrreq=1'b1;
					end
			write:if(!data_en&!wrfull)begin
					state1=free;
					wrreq=1'b0;
					end
					else begin
					state1=wat;
					wrreq=1'b0;
					end
			wat:if(!data_en)begin
					state1=free;
					wrreq=1'b0;
					end
					else begin
					state1=wat;
					wrreq=1'b0;
					end
		default: state1=free;
		endcase
end

always@(posedge clk or  negedge rst_n)  //readFSM from fifo
begin
	if(!rst_n)begin
			state2 <= rfree;
			//addr <= 0;
			data <= 0;
			rdreq <= 0;
		end
	else case(state2)
				rfree:	begin if(rdfull)begin //或者超时
							state2 <= wwrite;
							rdreq <= 1;
							//state_ram <= 1;      //写入ram
							//addr <= 0;         //初始化在RAM中的保存首地址
								end
						else state2 <= rfree;
						end
				wwrite:	begin
							if(rdempty) //读空
							begin
								rdreq <= 0;
								state2 <= rfree;
								//state_ram <= 0;
								//addr <= 0;
							end
							else begin
							state2 <= wwrite;
							rdreq <= 1;
							//addr <= addr + 1;   //地址后移一位
							end
						end

				default:state2=rfree;
			endcase
end 

always@(posedge clk or  negedge rst_n)  //write to ram
begin
	if(!rst_n)begin
			wren <= 0;
			addr <= 0;
			//state_ram <= 0;   //对RAM操作状态 00 静止；01 从fifo写入到ram ；10 从ram读到FIFO；
		end
	
	else 
	// case(state_ram) 
		// 0:begin
			// end
		// 1:begin
				case(state2)
						rfree:	begin if(rdfull)begin //或者超时
									wren <= 1;         //写信号
									addr <= 0;         //初始化在RAM中的保存首地址
										end
								//else state2 <= rfree;
								end
						wwrite:	begin
									if(rdempty) //读空
									begin
										wren <= 0;
										//state2 <= rfree;
										addr <= 5;
									end
									else begin
									//state2 <= wwrite;
									wren <= 1;
									addr <= addr + 1;   //地址后移一位
									end
								end
		
						default: wren <= 1; 
				endcase
							
			// end
		// 2:begin
			// end
		// default: begin end
					
	// endcase
end 

endmodule