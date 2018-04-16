/********************rec*************************
**模块名称：rec
**功能描述：uart的接收模块，接收采样率为波特率的16倍
************************************************/
module rec(rst_n,clk,clkout,Dataout,RXD,en);
input 			clk,RXD,rst_n;									//时钟与数据输入
output 			clkout,en;									//时钟输入、接收中断输出
output	[7:0]	Dataout;		 						//并行数据输出
reg 			StartF,RI;									//开始与接收中断标志
reg		[9:0] 	UartBuff;	 			 					//接收缓存区
reg		[3:0]	count,count_bit;							//位接收计数器
reg		[15:0] 	cnt;										//时钟节拍计数器
reg		[2:0]	bit_collect;								//采集数据缓存区
reg en;
wire 	clk_equ,bit1,bit2,bit3,bit4;						//连线
parameter cout = 325;										//时钟是48M所以16*9600的分频数为312.5,这里取整数
/*************波特率发生进程****************************/
always@(posedge clk or negedge rst_n)									//时钟节拍计数器
begin
			if(!rst_n)begin
			cnt<=16'b0;
			end 
			else begin
	if(clk_equ)
		cnt <= 16'd0;
	else 
		cnt<=cnt+1'b1;
end
end

assign clk_equ = (cnt == cout);								//采样时钟
assign clkout = clk_equ;

assign   bit1 = bit_collect[0]&bit_collect[1];				//对采样数据进行判断
assign   bit2 = bit_collect[1]&bit_collect[2];				//对采样数据进行判断
assign   bit3 = bit_collect[0]&bit_collect[2];				//对采样数据进行判断
assign   bit4 = bit1|bit2|bit3;								//对采样数据进行判断，只要有两次相同就可以

always@(posedge clk or negedge rst_n)
begin
			if(!rst_n)begin
			StartF<=1'b1;
			RI<=1'b0;
			count<=4'b0;
			count_bit<=4'b0;
			bit_collect<=3'b0;
			UartBuff<=10'b0;
			en<=1'b0;
			end			
			else begin
	if(clk_equ)
	begin
		if(!StartF)											//是否处于接收状态
		begin
			if(!RXD)
			begin	
				count <= 4'b0;								//复位计数器
				count_bit <=4'b0;
				RI<=1'b0;			
				StartF <= 1'b1;
				en<=1'b0;
			end
			else begin
			RI <= 1'b1;
			en<=1'b0;
			end
		end
		else 
		begin
			count <= count+1'b1;								//位接收状态加1
			if(count==4'd6)
				bit_collect[0] <= RXD;						//数据采集
			if(count==4'd7)
				bit_collect[1] <= RXD;						//数据采集 ，中间采集
			if(count==4'd8)
			begin
				bit_collect[2] <= RXD;						//数据采集
				UartBuff[count_bit] <= bit4;
				count_bit <= count_bit+1'b1;					//位计数器加1
				if((count_bit==4'd1)&&(UartBuff[0]==1'b1))	//判断开始位是否为0
				begin
					StartF <= 1'b0;//标志开始接收		
				end
				RI <= 1'b0;//中断标志位低	
				en<=1'b0;
			end	
			if(count_bit>4'd9)								//检测是否接收结束
			begin	
				RI <= 1'b1;					//中断标志为高标志转换结束
				StartF <= 1'b0;
				en<=1'b1;
			end
		end
	end
end
end
	
assign  Dataout = UartBuff[8:1];						    //取出数据位 
endmodule