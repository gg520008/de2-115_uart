
/********************send*************************
**模块名称：send
**功能描述：UART的发送程序
**************************************************/
module send(
			rst_n,
			clk,									//时钟
			clkout,									//输出
			Datain,									//需要发送的一个字节数据
			TXD,									//uart发送引脚	
			TI,										//发送中断
			WR										//写控制信号
			);
input			clk,rst_n;								//输入时钟
input			WR;									//写信号
input	[7:0]	Datain;								//发送的一字节数据
output			clkout;								//输出时钟
output			TXD,TI;								//串行数据,发送中断

reg		[9:0]	Datainbuf,Datainbuf2;				//发送数据缓存
reg 			WR_ctr,TI,txd_reg;					//写标志、中断标志、一位发送寄存器
reg		[3:0]	bincnt;								//发送数据计数器
reg		[15:0]	cnt;								//计数器

wire			clk_equ;							//分频时钟

parameter cout = 5207;								//根据具体的时钟来设定分频系数
													//这里是50M时钟，波特率选择是9600，所以分频系数为50000000/9600= 5208；												
/*************波特率发生进程****************************/
always@(posedge clk)										
begin
	if(!rst_n)begin
	cnt=16'b0;
	end
	else begin
	if(clk_equ)
		cnt = 16'd0;
	else 
		cnt=cnt+1'b1;
		end
end

assign clk_equ = (cnt == cout);
assign clkout = clk_equ;

/*************读数据到缓存进程****************************/
always@(posedge clk)
begin
	if(!rst_n)begin
	 WR_ctr=1'b0;
	 Datainbuf=10'b0;
	end
	else begin
	if(WR)	
	begin
		Datainbuf = {1'b1,Datain[7:0],1'b0};		//读入数据，并把缓存组成一帧数据，10位
		WR_ctr = 1'b1;								//置开始标志位
	end
	else if(TI==0)
		WR_ctr = 1'b0;
		end
end
	
/*************主程序进程****************************/
always@(posedge clk)
begin
	if(!rst_n)begin
	 bincnt=4'b1010;   //初始值为10
	 Datainbuf2=10'b0;
	 TI=1'b1;
	 txd_reg=1'b1;
	 end
	else begin
	if(clk_equ)
	begin
		if(WR_ctr==1||bincnt<4'd10)						//发送条件判断，保证发送数据的完整性.组帧完毕或发送位计数器小于10
			begin
				if(bincnt<4'd10)
					begin
						Datainbuf2 = Datainbuf>>bincnt;			//移位输出
						txd_reg =  Datainbuf2[0];				//从最低位开始发送				
						bincnt = bincnt+4'd1;					//发送数据位计数
						TI = 1'b0;
					end
				else
					bincnt = 4'd0;
			end
		else
			begin											//发送完毕或者处于等待状态时TXD和TI为高
				txd_reg = 1'b1;
				TI = 1'b1;
			end 
	end	
		end
end
	
assign TXD = txd_reg;									//TXD连续输出

endmodule