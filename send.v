
/********************send*************************
**ģ�����ƣ�send
**����������UART�ķ��ͳ���
**************************************************/
module send(
			rst_n,
			clk,									//ʱ��
			clkout,									//���
			Datain,									//��Ҫ���͵�һ���ֽ�����
			TXD,									//uart��������	
			TI,										//�����ж�
			WR										//д�����ź�
			);
input			clk,rst_n;								//����ʱ��
input			WR;									//д�ź�
input	[7:0]	Datain;								//���͵�һ�ֽ�����
output			clkout;								//���ʱ��
output			TXD,TI;								//��������,�����ж�

reg		[9:0]	Datainbuf,Datainbuf2;				//�������ݻ���
reg 			WR_ctr,TI,txd_reg;					//д��־���жϱ�־��һλ���ͼĴ���
reg		[3:0]	bincnt;								//�������ݼ�����
reg		[15:0]	cnt;								//������

wire			clk_equ;							//��Ƶʱ��

parameter cout = 5207;								//���ݾ����ʱ�����趨��Ƶϵ��
													//������50Mʱ�ӣ�������ѡ����9600�����Է�Ƶϵ��Ϊ50000000/9600= 5208��												
/*************�����ʷ�������****************************/
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

/*************�����ݵ��������****************************/
always@(posedge clk)
begin
	if(!rst_n)begin
	 WR_ctr=1'b0;
	 Datainbuf=10'b0;
	end
	else begin
	if(WR)	
	begin
		Datainbuf = {1'b1,Datain[7:0],1'b0};		//�������ݣ����ѻ������һ֡���ݣ�10λ
		WR_ctr = 1'b1;								//�ÿ�ʼ��־λ
	end
	else if(TI==0)
		WR_ctr = 1'b0;
		end
end
	
/*************���������****************************/
always@(posedge clk)
begin
	if(!rst_n)begin
	 bincnt=4'b1010;   //��ʼֵΪ10
	 Datainbuf2=10'b0;
	 TI=1'b1;
	 txd_reg=1'b1;
	 end
	else begin
	if(clk_equ)
	begin
		if(WR_ctr==1||bincnt<4'd10)						//���������жϣ���֤�������ݵ�������.��֡��ϻ���λ������С��10
			begin
				if(bincnt<4'd10)
					begin
						Datainbuf2 = Datainbuf>>bincnt;			//��λ���
						txd_reg =  Datainbuf2[0];				//�����λ��ʼ����				
						bincnt = bincnt+4'd1;					//��������λ����
						TI = 1'b0;
					end
				else
					bincnt = 4'd0;
			end
		else
			begin											//������ϻ��ߴ��ڵȴ�״̬ʱTXD��TIΪ��
				txd_reg = 1'b1;
				TI = 1'b1;
			end 
	end	
		end
end
	
assign TXD = txd_reg;									//TXD�������

endmodule