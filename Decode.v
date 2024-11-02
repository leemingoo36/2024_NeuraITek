`include "def.v"
`include "op_code.v"

module Decode(
	input	clk,
	input	reset,
	
	//from pipeline_reg
	input	wire	[`INT32-1:0]	Inst,
	input wire	[`INT32-1:0]	PC,
	
	//from write_back to regfile
	input	wire	[`LENGTH * `INT8-1:0]	conv_result,
	input	wire	[4:0]	conv_addr,
	input	wire	conv_write,
	
	input	wire	[4:0]	rD,
	input	wire	s_write,
	input	wire	v_write,
	input	wire	[`INT32-1:0]	swrite_data,
	input	wire	[`LENGTH * `INT8-1:0]	vwrite_data,
	
	//output
	output	wire	[`INT32-1:0]	out_PC,
	
	
	output	wire	[4:0]	opcode,
	output	wire	[4:0]	out_rD,
	output	wire	[`INT32-1:0]	rA_data,
	output	wire	[`INT32-1:0]	rB_data,
	
	output	wire	[`LENGTH * `INT8-1:0]	vA_data,
	output	wire	[`LENGTH * `INT8-1:0]	vB_data,
	
	output	wire	[2:0]	strd_cyc,
	
	output	wire	ldr,
	output	wire	jmp,
	output	wire	[`INT32-1:0]	jmp_addr,
	output	wire	[1:0]	b,
	output	wire	[1:0]	wb,// 01: scalar/ 10: vector
	output	wire	[3:0]	alu,
	output	wire	setcc,
	output	wire	mem_rw,
	output	wire	mem_v,
	output	wire	conv_en,
	
	//tb
	output	wire	[4:0]	A_addr,
	output	wire	[4:0]	B_addr,
	output	wire	[26:0]	out_offBAD
//	output	reg	[16:0]	out_offB,
//	output	reg	[21:0]	out_offBA,
//	output	reg	[26:0]	out_offBAD,
//	output	reg	[16:0]	out_offD
	//control
);
	
	wire	[11:0]	offset;
	wire	[4:0]		rB_addr;
	wire	[4:0]		rA_addr;
	
	assign	out_PC = PC;
	assign	A_addr = rA_addr;
	assign	B_addr = rB_addr;
	
	wire	ldri;
	wire	strv;
	wire	unary;
	
	Inst_decoder decoder(.Inst(Inst), .out_offset(offset), .rB_addr(rB_addr), .rA_addr(rA_addr), .rD_addr(out_rD), .out_opcode(opcode), .ldr(ldr), .ldri(ldri), .strv(strv), .jmp(jmp), .jmp_addr(jmp_addr), .b(b), .wb(wb), .unary(unary), .alu(alu), .setcc(setcc), .mem_en(), .mem_rw(mem_rw), .mem_v(mem_v), .conv_en(conv_en), .strd_cyc(strd_cyc));
	
	wire	[16:0]	in_offB	=	{offset, rB_addr};
	wire	[21:0]	in_offBA	=	{offset, rB_addr, rA_addr};
	wire	[26:0]	in_offBAD=	{offset, rB_addr, rA_addr, out_rD};
	wire	[16:0]	in_offD	=	{offset, out_rD};
	
	assign	out_offBAD = in_offBAD;
	
	//Scalar register file///////////////////////////////////////////////////////
	
	wire	[`INT32-1:0]	sA;
	wire	[`INT32-1:0]	sB;
	
	
	Reg_file	Reg(.clk(clk), .reset(reset), .rA_addr(rA_addr), .rB_addr(rB_addr), .rD_addr(rD), .write_data(swrite_data), .reg_write(s_write), .rA_data(sA), .rB_data(sB));
	
	
	wire	[`INT32-1:0]	sA0	= ldri ? {10'd0, in_offBA} : sA;
	wire	[`INT32-1:0]	sA1	= (b != 2'd0) ? PC : sA0;
	assign	rA_data	= sA1;
	
	wire	[`INT32-1:0]	sB0	= ldr ? {15'd0, in_offB} : sB;
	wire	[`INT32-1:0]	sB1	= (b[0] || b[1] || jmp) ? {5'b11111, in_offBAD} : sB0;//signExt needed to b(jmp) imm
	wire	[`INT32-1:0]	sB2	= unary ? 32'd0 : sB1;
	wire	[`INT32-1:0]	sB3	= strv ? {15'd0, in_offD} : sB2;
	assign	rB_data	= sB3;
	
	/////////////////////////////////////////////////////////////////////////////
	
	//Vector register file///////////////////////////////////////////////////////
	
	wire	[`LENGTH * `INT8-1:0]	vB;
	
	vReg_file	vReg(.clk(clk), .reset(reset), .rA_addr(rA_addr), .rB_addr(rB_addr), .rD_addr(rD), .write_data(vwrite_data), .reg_write(v_write), .conv_result(conv_result), .conv_addr(conv_addr), .conv_write(conv_write), .rA_data(vA_data), .rB_data(vB));
	
	
	wire	[`LENGTH * `INT8-1:0]	vB0	= unary ? 'd0 : vB;
	assign	vB_data	= vB0;
	
	/////////////////////////////////////////////////////////////////////////////
	
endmodule
