`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:10:58 03/03/2010
// Design Name:   control_fifo
// Module Name:   D:/uart2/fifo_control_tf.v
// Project Name:  uart2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: control_fifo
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fifo_control_tf;

	// Inputs
	reg rst_n;
	reg clock;
	reg full;
	reg empty;
	reg en;
	reg TI;

	// Outputs
	wire winc;
	wire rinc;
	wire WR;

	// Instantiate the Unit Under Test (UUT)
	control_fifo uut (
		.rst_n(rst_n), 
		.clock(clock), 
		.full(full), 
		.empty(empty), 
		.winc(winc), 
		.rinc(rinc), 
		.en(en), 
		.WR(WR), 
		.TI(TI)
	);

	initial begin
		// Initialize Inputs
		rst_n = 0;
		clock = 0;
		full = 0;
		empty = 0;
		en = 0;
		TI = 0;

		// Wait 100 ns for global reset to finish
		#100;
		rst_n=1;
       en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;  	
      en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;
en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;
en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;
en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;
en=0;#104140;  
		 en=0;#104140;  
		 en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;  
		en=0;#104140;
		en=1;#104140;
		en=0;#104140; 
		en=0;#104140;		
	end
       always #10 clock=~clock;  
endmodule

