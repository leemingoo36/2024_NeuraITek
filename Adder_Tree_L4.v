`include "def.v"

//16 multiplication result inputs to 8 sum outputs

module Adder_Tree_L4(
	input clk,
	input reset,
	
	input	[(`LENGTH * `INT16)/8-1:0]	in_a,
	
	output	wire	[(`LENGTH * `INT16)/16-1:0]	out_sums
);
	
//	wire	[(`LENGTH * `INT8)/8-1:0]		d_a = in_a;
//	reg	[(`LENGTH * `INT8)/8-1:0]		q_a;
//	
//	always @ (posedge clk or posedge reset)
//		if (reset)	q_a <= 'd0;
//		else			q_a <= d_a;
	
	wire	[(`LENGTH * `INT16)/16-1:0]	out_d;
	reg	[(`LENGTH * `INT16)/16-1:0]	out_q;
	
	assign	out_d[`index16_0]	= in_a[`index16_0] + in_a[`index16_1];
	
//	ksa_top i0(.c0(1'b0), .i_a(q_a[`index_0]), .i_b(q_a[`index_1]), .o_s(d_sum[`index_0]), .o_carry());
	
	always @ (posedge clk or posedge reset)
		if (reset)	out_q <= 'd0;
		else begin
			out_q	<= out_d;
		end
	
	assign out_sums = out_q;
	
endmodule