`include "def.v"

module PE(
	input	clk,
	input	reset,
	
	input	conv_en,
	input	[2:0]	strd_cyc,
	
	input	wire	[`LENGTH * `INT8-1:0]	in_a,
	input	wire	[`LENGTH * `INT8-1:0]	in_b,
	
	output	out_en,
	
	output	wire	[`LENGTH * `INT8-1:0]	out_vector,
	output	wire	out_conv_en,
	
	//for tb
	output	wire	[9 * `INT16-1:0]	ext_A, ext_B,
	output	wire	[`INT16-1:0]	conv_res
);
	
	wire	q_accum;
	wire	q_out_en;
	
	PE_C	c(.clk(clk), .reset(reset), .conv_en(conv_en), .stride_cycle(strd_cyc), .force_wb(), .buff_full(), .out_accum(q_accum), .out_en(q_out_en), .wb_en()); //.curr_s(curr_s));
	
	assign out_en	= q_out_en;
	wire	[`INT16-1:0]	res_conv;
	assign conv_res = res_conv;
	
	PE_Top	dt(.clk(clk), .reset(reset), .in_a(in_a), .in_b(in_b), .accum(q_accum), .en(1'b1), .res_conv(res_conv), .ext_A(ext_A), .ext_B(ext_B), .d(d));
	
	Shift_reg_queue queue(.clk(clk), .reset(reset), .strd_cyc(strd_cyc), .in_valid(q_out_en), .out_block(), .in_data(res_conv), .out_vector(out_vector), .out_en(out_conv_en), .q(q));//, .Execute_pxl_vector(Execute_pxl_vector));// .out_data0(out_data0), .out_data1(out_data1), .out_data2(out_data2), .out_data3(out_data3), .out_data4(out_data4), .out_data5(out_data5), .out_data6(out_data6), .out_data7(out_data7), .out_data8(out_data8), .out_data9(out_data9), .out_data10(out_data10), .out_data11(out_data11), .out_data12(out_data12), .out_data13(out_data13), .out_data14(out_data14), .out_data15(out_data15), .out_vector(), .out_en(out_conv_en), .out_curr_state(curr), .out_next_state(next), .out_level(lv));
	
endmodule