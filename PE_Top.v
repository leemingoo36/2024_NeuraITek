`include "def.v"

module PE_Top(
	input	clk,
	input	reset,
	
	input	wire	[`LENGTH * `INT8-1:0]	in_a,
	input	wire	[`LENGTH * `INT8-1:0]	in_b,
	
	input accum,
	input	en,

	//output	wire	[31:0]	out_d34
	output	wire	[(`LENGTH * `INT16)/16-1:0]	res_conv,
	output	wire	[9 * `INT16-1:0]	ext_A, ext_B,
	output	wire	[`LENGTH * `INT8 - 1:0]	 d
);
	
	wire	[`LENGTH * `INT16-1:0]	ext_a;//zeroExt, patch
	wire	[`LENGTH * `INT16-1:0]	ext_b;//signExt, filter
	
	assign ext_A = ext_a[255:112];
	assign ext_B = ext_b[255:112];
	
	zeroExt #(.int(`INT8), .length(`LENGTH)) z(.in_a(in_a), .out_a(ext_a));
	signExt #(.int(`INT8), .length(`LENGTH)) s(.in_a(in_b), .out_a(ext_b));
	
	wire	[`LENGTH * `INT16-1:0]	d01;
	Adder_Tree_L0 i0(.clk(clk), .reset(reset), .in_a(ext_a), .in_b(ext_b), .out_muls(d01));
	wire	[`LENGTH * `INT16 / 2-1:0]	d12;
	Adder_Tree_L1 i1(.clk(clk), .reset(reset), .in_a(d01), .out_sums(d12));
	wire	[`LENGTH * `INT16 / 4-1:0]	d23;
	Adder_Tree_L2 i2(.clk(clk), .reset(reset), .in_a(d12), .out_sums(d23));
	wire	[`LENGTH * `INT16 / 8-1:0]	d34;
	Adder_Tree_L3 i3(.clk(clk), .reset(reset), .in_a(d23), .out_sums(d34));
	wire	[`LENGTH * `INT16 / 16-1:0]	d45;
	Adder_Tree_L4 i4(.clk(clk), .reset(reset), .in_a(d34), .out_sums(d45));
//	wire	[`LENGTH * `INT8 / 16-1:0]	fin_sum;qq
	Adder_Tree_L5 i5(.clk(clk), .reset(reset), .accum(accum), .out_en(en), .in_a(d45), .out_s(res_conv));//fin_sum));
	
	//assign out_d34 = d34[31:0];
	
//	assign	res_conv = fin_sum;
	//for tb
	assign d = d12;
	
endmodule