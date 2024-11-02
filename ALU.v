`include "def.v"
`include "op_code.v"

module sALU(	
	input	wire	[3:0]	aluop,
	input	set_cc,	//CMP inst
	
	input	wire	[`INT32-1:0]	in_a,
	input	wire	[`INT32-1:0]	in_b,
	
	output	wire	[`INT32-1:0] result,
	output	wire	[1:0] cc
);
	
	//Scalar KSA
	wire	s	= (aluop == `subss) ? 1'b1 : 1'b0;
	wire	[`INT32-1:0]	result_ksa_s;
	wire	[`INT32-1:0]	result_mul_s;
	
	ksa ksa_i(.sub(s), .set_cc(set_cc), .in_a(in_a), .in_b(in_b), .result(result_ksa_s), .cc(cc));
	multiplier	#(.int(`INT32))	m(.in_a(in_a), .in_b(in_b), .result(result_mul_s));
	
	assign	result =	(aluop == `mulss) ? result_mul_s : result_ksa_s;
	
endmodule






module vALU(
	input wire	[3:0]	aluop,
	input wire	[`INT32-1:0]	in_s,
	input wire	[`LENGTH * `INT8-1:0]	in_a,
	input wire	[`LENGTH * `INT8-1:0]	in_b,
	
	output	wire	[`LENGTH * `INT8-1:0]	result
);
	
	//Vector KSA
	wire sub	=	((aluop == `subvs) || (aluop == `subvv)) ? 1'b1 : 1'b0;
	wire s	=	(aluop == `subvs) ? 1'b1 : 1'b0;
	
	//If datapath is too long, then delete mux and add ksa for sub.
//	wire [`VECTOR_SIZ * `DATA_WIDTH-1:0] result_simd;
	SIMD ksa_v(.aluop(aluop), .sub(sub), .s(s), .in_a(in_a), .in_b(in_b), .in_s(in_s), .result(result));
	
endmodule

//Only 16-vector processing. Later will be edited.
module SIMD(
	input	[3:0]	aluop,
	
	input sub,
	input s,
	
	input wire	[`LENGTH * `INT8-1:0]	in_a,
	input wire	[`LENGTH * `INT8-1:0]	in_b,
	input wire	[`INT32 - 1:0]				in_s,
	
	output wire [`LENGTH * `INT8-1:0]	result
);
	
	wire	[`LENGTH * `INT8-1:0]	result_ksa;
	wire	[`LENGTH * `INT8-1:0]	result_mul;
	wire	[`LENGTH * `INT8-1:0]	result_relu;
	wire	[`LENGTH * `INT8-1:0]	val_b	=	sub ? {~in_b[`index_15], ~in_b[`index_14], ~in_b[`index_13], ~in_b[`index_12], ~in_b[`index_11], ~in_b[`index_10], ~in_b[`index_9], ~in_b[`index_8], ~in_b[`index_7], ~in_b[`index_6], ~in_b[`index_5], ~in_b[`index_4], ~in_b[`index_3], ~in_b[`index_2], ~in_b[`index_1], ~in_b[`index_0]} : in_b;//ERROR. each indexes sign convertion needed.
	wire	[`INT8 - 1:0]				val_s	=	sub ? ~in_s[`INT8-1:0] : in_s[`INT8-1:0];
	wire												val_c =	sub ? 1'b1 : 1'b0;
	
	
	assign result_ksa[`index_0] = in_a[`index_0] + (s ? val_s : val_b[`index_0]);
	assign result_ksa[`index_1] = in_a[`index_1] + (s ? val_s : val_b[`index_1]);
	assign result_ksa[`index_2] = in_a[`index_2] + (s ? val_s : val_b[`index_2]);
	assign result_ksa[`index_3] = in_a[`index_3] + (s ? val_s : val_b[`index_3]);
	assign result_ksa[`index_4] = in_a[`index_4] + (s ? val_s : val_b[`index_4]);
	assign result_ksa[`index_5] = in_a[`index_5] + (s ? val_s : val_b[`index_5]);
	assign result_ksa[`index_6] = in_a[`index_6] + (s ? val_s : val_b[`index_6]);
	assign result_ksa[`index_7] = in_a[`index_7] + (s ? val_s : val_b[`index_7]);
	assign result_ksa[`index_8] = in_a[`index_8] + (s ? val_s : val_b[`index_8]);
	assign result_ksa[`index_9] = in_a[`index_9] + (s ? val_s : val_b[`index_9]);
	assign result_ksa[`index_10] = in_a[`index_10] + (s ? val_s : val_b[`index_10]);
	assign result_ksa[`index_11] = in_a[`index_11] + (s ? val_s : val_b[`index_11]);
	assign result_ksa[`index_12] = in_a[`index_12] + (s ? val_s : val_b[`index_12]);
	assign result_ksa[`index_13] = in_a[`index_13] + (s ? val_s : val_b[`index_13]);
	assign result_ksa[`index_14] = in_a[`index_14] + (s ? val_s : val_b[`index_14]);
	assign result_ksa[`index_15] = in_a[`index_15] + (s ? val_s : val_b[`index_15]);
	/*ksa_top ksa_i00(.c0(val_c), .i_a(in_a[`index_0]), .i_b((s ? val_s : val_b[`index_0])), .o_s(result_ksa[`index_0]), .o_carry());
	ksa_top ksa_i01(.c0(val_c), .i_a(in_a[`index_1]), .i_b((s ? val_s : val_b[`index_1])), .o_s(result_ksa[`index_1]), .o_carry());
	ksa_top ksa_i02(.c0(val_c), .i_a(in_a[`index_2]), .i_b((s ? val_s : val_b[`index_2])), .o_s(result_ksa[`index_2]), .o_carry());
	ksa_top ksa_i03(.c0(val_c), .i_a(in_a[`index_3]), .i_b((s ? val_s : val_b[`index_3])), .o_s(result_ksa[`index_3]), .o_carry());
	ksa_top ksa_i04(.c0(val_c), .i_a(in_a[`index_4]), .i_b((s ? val_s : val_b[`index_4])), .o_s(result_ksa[`index_4]), .o_carry());
	ksa_top ksa_i05(.c0(val_c), .i_a(in_a[`index_5]), .i_b((s ? val_s : val_b[`index_5])), .o_s(result_ksa[`index_5]), .o_carry());
	ksa_top ksa_i06(.c0(val_c), .i_a(in_a[`index_6]), .i_b((s ? val_s : val_b[`index_6])), .o_s(result_ksa[`index_6]), .o_carry());
	ksa_top ksa_i07(.c0(val_c), .i_a(in_a[`index_7]), .i_b((s ? val_s : val_b[`index_7])), .o_s(result_ksa[`index_7]), .o_carry());
	ksa_top ksa_i08(.c0(val_c), .i_a(in_a[`index_8]), .i_b((s ? val_s : val_b[`index_8])), .o_s(result_ksa[`index_8]), .o_carry());
	ksa_top ksa_i09(.c0(val_c), .i_a(in_a[`index_9]), .i_b((s ? val_s : val_b[`index_9])), .o_s(result_ksa[`index_9]), .o_carry());
	ksa_top ksa_i10(.c0(val_c), .i_a(in_a[`index_10]), .i_b((s ? val_s : val_b[`index_10])), .o_s(result_ksa[`index_10]), .o_carry());
	ksa_top ksa_i11(.c0(val_c), .i_a(in_a[`index_11]), .i_b((s ? val_s : val_b[`index_11])), .o_s(result_ksa[`index_11]), .o_carry());
	ksa_top ksa_i12(.c0(val_c), .i_a(in_a[`index_12]), .i_b((s ? val_s : val_b[`index_12])), .o_s(result_ksa[`index_12]), .o_carry());
	ksa_top ksa_i13(.c0(val_c), .i_a(in_a[`index_13]), .i_b((s ? val_s : val_b[`index_13])), .o_s(result_ksa[`index_13]), .o_carry());
	ksa_top ksa_i14(.c0(val_c), .i_a(in_a[`index_14]), .i_b((s ? val_s : val_b[`index_14])), .o_s(result_ksa[`index_14]), .o_carry());
	ksa_top ksa_i15(.c0(val_c), .i_a(in_a[`index_15]), .i_b((s ? val_s : val_b[`index_15])), .o_s(result_ksa[`index_15]), .o_carry());*/
	
	multiplier	#(.int(`INT8))	m00(.in_a(in_a[`index_0]), .in_b(s ? val_s : val_b[`index_0]), .result(result_mul[`index_0]));
	multiplier	#(.int(`INT8))	m01(.in_a(in_a[`index_1]), .in_b(s ? val_s : val_b[`index_1]), .result(result_mul[`index_1]));
	multiplier	#(.int(`INT8))	m02(.in_a(in_a[`index_2]), .in_b(s ? val_s : val_b[`index_2]), .result(result_mul[`index_2]));
	multiplier	#(.int(`INT8))	m03(.in_a(in_a[`index_3]), .in_b(s ? val_s : val_b[`index_3]), .result(result_mul[`index_3]));
	multiplier	#(.int(`INT8))	m04(.in_a(in_a[`index_4]), .in_b(s ? val_s : val_b[`index_4]), .result(result_mul[`index_4]));
	multiplier	#(.int(`INT8))	m05(.in_a(in_a[`index_5]), .in_b(s ? val_s : val_b[`index_5]), .result(result_mul[`index_5]));
	multiplier	#(.int(`INT8))	m06(.in_a(in_a[`index_6]), .in_b(s ? val_s : val_b[`index_6]), .result(result_mul[`index_6]));
	multiplier	#(.int(`INT8))	m07(.in_a(in_a[`index_7]), .in_b(s ? val_s : val_b[`index_7]), .result(result_mul[`index_7]));
	multiplier	#(.int(`INT8))	m08(.in_a(in_a[`index_8]), .in_b(s ? val_s : val_b[`index_8]), .result(result_mul[`index_8]));
	multiplier	#(.int(`INT8))	m09(.in_a(in_a[`index_9]), .in_b(s ? val_s : val_b[`index_9]), .result(result_mul[`index_9]));
	multiplier	#(.int(`INT8))	m10(.in_a(in_a[`index_10]), .in_b(s ? val_s : val_b[`index_10]), .result(result_mul[`index_10]));
	multiplier	#(.int(`INT8))	m11(.in_a(in_a[`index_11]), .in_b(s ? val_s : val_b[`index_11]), .result(result_mul[`index_11]));
	multiplier	#(.int(`INT8))	m12(.in_a(in_a[`index_12]), .in_b(s ? val_s : val_b[`index_12]), .result(result_mul[`index_12]));
	multiplier	#(.int(`INT8))	m13(.in_a(in_a[`index_13]), .in_b(s ? val_s : val_b[`index_13]), .result(result_mul[`index_13]));
	multiplier	#(.int(`INT8))	m14(.in_a(in_a[`index_14]), .in_b(s ? val_s : val_b[`index_14]), .result(result_mul[`index_14]));
	multiplier	#(.int(`INT8))	m15(.in_a(in_a[`index_15]), .in_b(s ? val_s : val_b[`index_15]), .result(result_mul[`index_15]));
	
	ReLU	l00(.in_a(in_a[`index_0]), .result(result_relu[`index_0]));
	ReLU	l01(.in_a(in_a[`index_1]), .result(result_relu[`index_1]));
	ReLU	l02(.in_a(in_a[`index_2]), .result(result_relu[`index_2]));
	ReLU	l03(.in_a(in_a[`index_3]), .result(result_relu[`index_3]));
	ReLU	l04(.in_a(in_a[`index_4]), .result(result_relu[`index_4]));
	ReLU	l05(.in_a(in_a[`index_5]), .result(result_relu[`index_5]));
	ReLU	l06(.in_a(in_a[`index_6]), .result(result_relu[`index_6]));
	ReLU	l07(.in_a(in_a[`index_7]), .result(result_relu[`index_7]));
	ReLU	l08(.in_a(in_a[`index_8]), .result(result_relu[`index_8]));
	ReLU	l09(.in_a(in_a[`index_9]), .result(result_relu[`index_9]));
	ReLU	l10(.in_a(in_a[`index_10]), .result(result_relu[`index_10]));
	ReLU	l11(.in_a(in_a[`index_11]), .result(result_relu[`index_11]));
	ReLU	l12(.in_a(in_a[`index_12]), .result(result_relu[`index_12]));
	ReLU	l13(.in_a(in_a[`index_13]), .result(result_relu[`index_13]));
	ReLU	l14(.in_a(in_a[`index_14]), .result(result_relu[`index_14]));
	ReLU	l15(.in_a(in_a[`index_15]), .result(result_relu[`index_15]));
	
	assign	result	= (aluop == `mulvs) ? result_mul :
								(aluop == `relu) ? result_relu : result_ksa;
	
endmodule

module ksa(
	input	sub,
	input set_cc,
	
	input	wire	[`INT32-1:0]	in_a,
	input	wire	[`INT32-1:0]	in_b,
	
	output	wire	[`INT32-1:0]	result,
	output	wire	[1:0]	cc
);
	
	wire	[`INT32-1:0]	val_b	=	sub ? ~in_b : in_b;
	wire						val_c	=	sub ? 1'b1 : 1'b0;
	
	//for tb
	//assign result = 'd0;
	assign	result = sub ? in_a - in_b: in_a + in_b;
	
// This ksa module causes error in same value subtraction.
//	ksa_top ksa_i0(.c0(val_c), .i_a(in_a), .i_b(val_b), .o_s(result), .o_carry());
	
	//equal == 01; a > b == 10; else == 00;
	assign	cc	=	~set_cc ? 2'b00 :
						result == 'd0 ? 2'b01 :
						result[31] == 0 ? 2'b10 : 'd0;
	
endmodule

module multiplier #(parameter int=`INT8) (
	input	[int-1:0]	in_a,
	input	[int-1:0]	in_b,
	
	output	wire	[int-1:0]	result
);
	
//	wire	[2 * `DATA_WIDTH-1:0]	result64	= in_a * in_b;
	
	assign	result	= in_a * in_b;
	
endmodule

module ReLU(
	
	input	[`INT8-1:0]	in_a,
	
	output	[`INT8-1:0]	result
	
);
	
	assign	result	=	(in_a > 0) ? in_a : 'd0;
	
endmodule