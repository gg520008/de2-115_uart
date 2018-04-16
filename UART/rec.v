/********************rec*************************
**ģ�����ƣ�rec
**����������uart�Ľ���ģ�飬���ղ�����Ϊ�����ʵ�16��
************************************************/
module rec(rst_n,clk,clkout,Dataout,RXD,en);
input 			clk,RXD,rst_n;									//ʱ������������
output 			clkout,en;									//ʱ�����롢�����ж����
output	[7:0]	Dataout;		 						//�����������
reg 			StartF,RI;									//��ʼ������жϱ�־
reg		[9:0] 	UartBuff;	 			 					//���ջ�����
reg		[3:0]	count,count_bit;							//λ���ռ�����
reg		[15:0] 	cnt;										//ʱ�ӽ��ļ�����
reg		[2:0]	bit_collect;								//�ɼ����ݻ�����
reg en;
wire 	clk_equ,bit1,bit2,bit3,bit4;						//����
parameter cout = 325;										//ʱ����48M����16*9600�ķ�Ƶ��Ϊ312.5,����ȡ����
/*************�����ʷ�������****************************/
always@(posedge clk or negedge rst_n)									//ʱ�ӽ��ļ�����
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

assign clk_equ = (cnt == cout);								//����ʱ��
assign clkout = clk_equ;

assign   bit1 = bit_collect[0]&bit_collect[1];				//�Բ������ݽ����ж�
assign   bit2 = bit_collect[1]&bit_collect[2];				//�Բ������ݽ����ж�
assign   bit3 = bit_collect[0]&bit_collect[2];				//�Բ������ݽ����ж�
assign   bit4 = bit1|bit2|bit3;								//�Բ������ݽ����жϣ�ֻҪ��������ͬ�Ϳ���

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
		if(!StartF)											//�Ƿ��ڽ���״̬
		begin
			if(!RXD)
			begin	
				count <= 4'b0;								//��λ������
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
			count <= count+1'b1;								//λ����״̬��1
			if(count==4'd6)
				bit_collect[0] <= RXD;						//���ݲɼ�
			if(count==4'd7)
				bit_collect[1] <= RXD;						//���ݲɼ� ���м�ɼ�
			if(count==4'd8)
			begin
				bit_collect[2] <= RXD;						//���ݲɼ�
				UartBuff[count_bit] <= bit4;
				count_bit <= count_bit+1'b1;					//λ��������1
				if((count_bit==4'd1)&&(UartBuff[0]==1'b1))	//�жϿ�ʼλ�Ƿ�Ϊ0
				begin
					StartF <= 1'b0;//��־��ʼ����		
				end
				RI <= 1'b0;//�жϱ�־λ��	
				en<=1'b0;
			end	
			if(count_bit>4'd9)								//����Ƿ���ս���
			begin	
				RI <= 1'b1;					//�жϱ�־Ϊ�߱�־ת������
				StartF <= 1'b0;
				en<=1'b1;
			end
		end
	end
end
end
	
assign  Dataout = UartBuff[8:1];						    //ȡ������λ 
endmodule