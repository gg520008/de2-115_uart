module send_uart(clk,rst_n,rs232_tx,tx_data,tx_int);
input clk;
input rst_n;
//input mid_flag;

//output baud_start;
output rs232_tx;
input[7:0]tx_data;
input tx_int;

reg int0,int1,int2;
wire mid_flag;
wire baud_start;

baud_select baud_send(
						  .clk(clk),
						  .rst_n(rst_n),
						  .baud_start(baud_start),
						  .mid_flag(mid_flag)
						  );


always @(posedge clk or negedge rst_n)
	begin 
		if(!rst_n)
			begin
				int0<=1'b0;
				int1<=1'b0;
				int2<=1'b0;
			end
		else begin
				int0<=tx_int;
				int1<=int0;
				int2<=int1;
			end
    end
wire int_lock=~int1&int2;       //下降沿
reg	baud_start_t,send_en;
reg [7:0]data;	
reg[3:0]num;
always @(posedge clk or negedge rst_n)
	begin 
		if(!rst_n)
				begin
					baud_start_t<=1'b0;
					send_en<=1'b0;
					data<=8'd0;
				end
		else if(int_lock)
				begin
					baud_start_t<=1'b1;
					send_en<=1'b1;
					data<=tx_data;	
				end
		else if(num==4'd11)
				begin
					baud_start_t<=1'b0;
					send_en<=1'b0;
					data<=8'd0;
				end
	end
assign baud_start=baud_start_t;

reg rs232_tx_r;
always @(posedge clk or negedge rst_n)
	begin 
		if(!rst_n)
			begin
				num<=1'b0;
				rs232_tx_r<=1'b0;
			end
		else if(send_en)
			begin
				if(mid_flag)
					begin
						num<=num+1'b1;
						case(num)
							4'd0:rs232_tx_r<=1'b0;	
							4'd1:rs232_tx_r<=data[0];
							4'd2:rs232_tx_r<=data[1];
							4'd3:rs232_tx_r<=data[2];
							4'd4:rs232_tx_r<=data[3];
							4'd5:rs232_tx_r<=data[4];
							4'd6:rs232_tx_r<=data[5];
							4'd7:rs232_tx_r<=data[6];
							4'd8:rs232_tx_r<=data[7];
							4'd9:rs232_tx_r<=1'b1;	
							default:;
						endcase
					end
				else if(num==4'd11)
						num<=-4'd0;
			end
	end
assign rs232_tx=rs232_tx_r;
endmodule