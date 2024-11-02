`include "def.v"

//16 multiplication result inputs to 8 sum outputs

module Adder_Tree_L2(
	input clk,
	input reset,
	
	input	[(`LENGTH * `INT16)/2-1:0]	in_a,
	
	output	wire	[(`LENGTH * `INT16)/4-1:0]	out_sums
);

//	wire	[(`LENGTH * `INT8)/2-1:0]		d_a = in_a;
//	reg	[(`LENGTH * `INT8)/2-1:0]		q_a;
//	
//	always @ (posedge clk or posedge reset)
//		if (reset)	q_a <= 'd0;
//		else			q_a <= d_a;
	
	wire	[(`LENGTH * `INT16)/4-1:0]	out_d;
	reg	[(`LENGTH * `INT16)/4-1:0]	out_q;
	
	assign	out_d[`index16_0]	= in_a[`index16_0] + in_a[`index16_1];
	assign	out_d[`index16_1]	= in_a[`index16_2] + in_a[`index16_3];
	assign	out_d[`index16_2]	= in_a[`index16_4] + in_a[`index16_5];
	assign	out_d[`index16_3]	= in_a[`index16_6] + in_a[`index16_7];
	
//	ksa_top i0(.c0(1'b0), .i_a(in_a[`index_0]), .i_b(in_a[`index_1]), .o_s(out_d[`index_0]), .o_carry());
//	ksa_top i1(.c0(1'b0), .i_a(in_a[`index_2]), .i_b(in_a[`index_3]), .o_s(out_d[`index_1]), .o_carry());
//	ksa_top i2(.c0(1'b0), .i_a(in_a[`index_4]), .i_b(in_a[`index_5]), .o_s(out_d[`index_2]), .o_carry());
//	ksa_top i3(.c0(1'b0), .i_a(in_a[`index_6]), .i_b(in_a[`index_7]), .o_s(out_d[`index_3]), .o_carry());
	
	always @ (posedge clk or posedge reset)
		if (reset)	out_q <= 'd0;
		else begin
			out_q	<= out_d;
		end
	
	assign out_sums = out_q;
	
endmodule