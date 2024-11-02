`include "def.v"
`include "op_code.v"

module Execute(
	
	//input
	input	clk,
	input	reset,
	
	input	[`INT32-1:0]	PC,
	input	[4:0]	opcode,
	
	input	[4:0]	rD,
	
	input	[`INT32-1:0]	rA_data,
	input	[`INT32-1:0]	rB_data,
	
	input	[`LENGTH * `INT8-1:0]	vA_data,
	input	[`LENGTH * `INT8-1:0]	vB_data,
	
	input	[2:0]	strd_cyc,	//appropriate size
	
	//decoder signal
	input	ldr,
	input	[1:0]	b,	// b = 2'b01, beq = 2'b10, bgr = 2'b11v
	input	[1:0]	wb,
	input	[3:0]	alu,	//000
	input	setcc,
	input	mem_rw,
	input	mem_v,
	input	conv_en,
	
	//output
	output	wire	[4:0]	out_opcode,
	
	output	wire	[`LENGTH * `INT8-1:0]	conv_result,
	output	wire	[4:0]	conv_addr,	
	output	wire	conv_write,
	
	//value to store in memory
	output	wire	[`INT32-1:0]	s_write,
	output	wire	[`LENGTH * `INT8-1:0]	v_write,
	
	output	wire	[4:0]	out_rD,
	
	//alu result
	output	wire	[`INT32-1:0]	s_result,
	output	wire	[`LENGTH * `INT8-1:0]	v_result,
	
	output	wire	out_ldr,
	output	wire	[1:0]	out_wb,
	output	out_mem_rw,
	output	out_mem_v,
	
	//branch taken
	output	wire	b_taken,
	output	wire	[`INT32-1:0]	b_addr,
	
	//for tb
	output	wire	[9 * `INT16-1:0]	ext_A, ext_B,
	output	wire	[`INT16-1:0]	conv_res
);
	
	reg	[4:0]	rD_reg;
	//cc = {Greater, Equal};
	reg	[1:0]	cc;
	wire	[1:0]	cc_result;
	wire	[`INT32-1:0]	result, mul_result;
	
	assign	out_opcode = opcode;
	
	assign	out_rD	= rD;
	assign	s_write	= rB_data;
	assign	v_write	= vB_data;
	assign	out_ldr	= ldr;
	assign	out_wb	= wb;
	assign	out_mem_rw	= mem_rw;
	assign	out_mem_v	= mem_v;
	
	//In normal case, always rD_reg == 5'd16
	always @ (conv_en)
		if(conv_en)	rD_reg	<=	rD;
		else			rD_reg	<=	rD_reg;
	
	assign	conv_addr	= rD_reg;
	assign	b_addr		= s_result;
	
	//temp
	wire	[`LENGTH * `INT8-1:0]	pe_a = conv_en ? vA_data : 'd0;
	wire	[`LENGTH * `INT8-1:0]	pe_b = conv_en ? vB_data : 'd0;
	
	PE PE_i0(.clk(clk), .reset(reset), .conv_en(conv_en), .strd_cyc(strd_cyc), .in_a(pe_a), .in_b(pe_b), .out_en(), .out_vector(conv_result), .out_conv_en(conv_write), .ext_A(ext_A), .ext_B(ext_B), .conv_res(conv_res));
	
	
	sALU sALU_i0(.aluop(alu), .set_cc(setcc), .in_a(rA_data), .in_b(rB_data), .result(s_result), .cc(cc_result));
	
	
	always @ (cc_result)
		if(setcc)
			cc	<= cc_result;
		else
			cc <= cc;
	
	vALU vALU_i0(.aluop(alu), .in_s(rB_data), .in_a(vA_data), .in_b(vB_data), .result(v_result));
	
	assign b_taken	=	 (b == 2'b01)							? 1'b1 :
							((b == 2'b10) && (cc == 2'b01))	? 1'b1 :
							((b == 2'b11) && (cc == 2'b10))	? 1'b1 : 1'b0;
endmodule