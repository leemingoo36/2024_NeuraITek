`include "def.v"

module Adder_Tree_L0(
	input	clk,
	input reset,
	input	wire	[`LENGTH * `INT16-1:0]	in_a,
	input	wire	[`LENGTH * `INT16-1:0]	in_b,
	
//	output	wire	[`INT8-1:0]	a,
//	output	wire	[`INT8-1:0]	b,
	output	wire	[(`LENGTH * `INT16)-1:0]	out_muls
);
	
	
	
	
	wire	[(`LENGTH * `INT16)*2-1:0]	d_muls;
	reg	[(`LENGTH * `INT16)*2-1:0]	q_muls;
	
	assign	d_muls[`index16_0]	=	in_a[`index16_0] * in_b[`index16_0];
	assign	d_muls[`index16_1]	=	in_a[`index16_1] * in_b[`index16_1];
	assign	d_muls[`index16_2]	=	in_a[`index16_2] * in_b[`index16_2];
	assign	d_muls[`index16_3]	=	in_a[`index16_3] * in_b[`index16_3];
	assign	d_muls[`index16_4]	=	in_a[`index16_4] * in_b[`index16_4];
	assign	d_muls[`index16_5]	=	in_a[`index16_5] * in_b[`index16_5];
	assign	d_muls[`index16_6]	=	in_a[`index16_6] * in_b[`index16_6];
	assign	d_muls[`index16_7]	=	in_a[`index16_7] * in_b[`index16_7];
	assign	d_muls[`index16_8]	=	in_a[`index16_8] * in_b[`index16_8];
	assign	d_muls[`index16_9]	=	in_a[`index16_9] * in_b[`index16_9];
	assign	d_muls[`index16_10]	=	in_a[`index16_10] * in_b[`index16_10];
	assign	d_muls[`index16_11]	=	in_a[`index16_11] * in_b[`index16_11];
	assign	d_muls[`index16_12]	=	in_a[`index16_12] * in_b[`index16_12];
	assign	d_muls[`index16_13]	=	in_a[`index16_13] * in_b[`index16_13];
	assign	d_muls[`index16_14]	=	in_a[`index16_14] * in_b[`index16_14];
	assign	d_muls[`index16_15]	=	in_a[`index16_15] * in_b[`index16_15];
	
	always @ (posedge clk or posedge reset)
		if(reset)	q_muls <= 'd0;
		else			q_muls <= d_muls;
	assign out_muls = q_muls[`LENGTH * `INT16-1:0];
	
//	wire	[(`LENGTH * `INT8)*2-1:0]	out_d = q_muls;
//	reg	[(`LENGTH * `INT8)-1:0]	out_q;
//	
//	always @ (posedge clk or posedge reset)
//		if(reset)	out_q	<=	'd0;
//		else
//			out_q <=	out_d[(`LENGTH * `INT8)-1:0];
	
	
//	assign a = in_a;
//	assign b = in_b;
endmodule