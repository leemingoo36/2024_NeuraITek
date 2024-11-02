`include "def.v"

module Adder_Tree_L5(
	input	clk,
	input	reset,
	
	//when output is required, last accumulation operand(in_a) is entered with accum=0.
	//ex) 1+2+3+4 => accum : 1 1 1 0(6+4 and out 10) 1(new accumulation start) 1 1 0 ...
	input	accum,
	input out_en,
	
	input	wire	[(`LENGTH * `INT16)/16-1:0]	in_a,
	
	//out_s has 1 clk delay between in_a
	output	wire	[(`LENGTH * `INT16)/16-1:0]	out_s
	
);
	
//	wire	[(`LENGTH * `INT8)/8-1:0]	d_a = in_a;
//	reg	[(`LENGTH * `INT8)/8-1:0]	q_a;
//	
	wire	[(`LENGTH * `INT16)/16-1:0]	out_d;	//d_psum
	reg	[(`LENGTH * `INT16)/16-1:0]	out_q;
//	
//	always @ (posedge clk or posedge reset)
//		if(reset)	q_a <= 'd0;
//		else			q_a <= d_a;
//	
//	wire	[(`LENGTH * `INT8)/16-1:0]	in_b = accum ? q_psum : 'd0;
	
	
	assign	out_d	= in_a + (accum ? out_q : 'd0);//??
	
	
//	ksa_top i0(.c0(1'b0), .i_a(q_a), .i_b(in_b), .o_s(d_psum), .o_carry());
	
	always @ (posedge clk or posedge reset)
		if (reset)	out_q <= 'd0;
		else begin
			out_q	<= out_d;
		end
	
	assign out_s = out_en ? out_q : 'd0;
	
endmodule