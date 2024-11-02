`include "op_code.v"
`include "def.v"

module Inst_decoder(
	input wire	[`INT32-1:0]	Inst,
	
	output reg	[11:0]	out_offset,
	output reg	[4:0]	rB_addr,
	output reg	[4:0]	rA_addr,
	output reg	[4:0]	rD_addr,
	output reg	[4:0]	out_opcode,
	
	//contorl 
	output reg	ldr,
	output reg	ldri,
	output reg	strv,
	output reg	jmp,
	output reg	[`INT32-1:0]	jmp_addr,
	output reg	[1:0] b,	// b = 2'b01, beq = 2'b10, bgr = 2'b11
	output reg	[1:0]	wb,
	output reg	unary,
	output reg	[3:0] alu,
	output reg	setcc,
	output reg	mem_en,
	output reg	mem_rw,	//r,w = 0,1
	output reg	mem_v,
	output reg	conv_en,
	output reg	[2:0]	strd_cyc
);
	
	wire	[11:0]	offset	= Inst[31:20];
	wire	[4:0]		rB			= Inst[19:15];
	wire	[4:0]		rA			= Inst[14:10];
	wire	[4:0]		rD			= Inst[9:5];
	wire	[4:0]		opcode	= Inst[4:0];
	wire	[2:0]		strd_cycle	= Inst[31:29];
	
	always @ (*)//opcode)
		jmp_addr	<= {5'b00000, offset, rB, rA, rD};
	
	always @ (Inst) begin//opcode) begin
		casex(opcode)
			`NOP	:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						'd0;
			`LOADV:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b1,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd2,	1'b0,		1'b1,		1'b0,		1'b1,		1'b0,		3'd0};
			`LOADS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b1,	1'b0,	1'b0,	1'b0,	2'd0,	2'b01,	1'b0,		4'd2,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`LOADI:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b1,	1'b0,	1'b0,	2'd0,	2'b01,	1'b1,		4'd0,	1'b0,		1'b0,		1'b0,		1'b0,		1'b0,		3'd0};
			`STOREV:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b1,	1'b0,	2'd0,	2'b00,	1'b0,		4'd2,	1'b0,		1'b1,		1'b1,		1'b1,		1'b0,		3'd0};
			`STORES:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b00,	1'b1,		4'd2,	1'b0,		1'b1,		1'b1,		1'b0,		1'b0,		3'd0};
						
			`B:		{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,			wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'b01,	2'b00,	1'b0,		4'd0,	1'b0,		1'b0,		1'b0,		1'b0,		1'b0,		3'd0};
			`BEQ:		{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,			wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'b10,	2'b00,	1'b0,		4'd0,	1'b0,		1'b0,		1'b0,		1'b0,		1'b0,		3'd0};
			`BGT:		{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,			wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'b11,	2'b00,	1'b0,		4'd0,	1'b0,		1'b0,		1'b0,		1'b0,		1'b0,		3'd0};
			`JUMP:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,			wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b1,	2'b00,	2'b00,	1'b0,		4'd0,	1'b0,		1'b0,		1'b0,		1'b0,		1'b0,		3'd0};
						
			`ADDV:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd8,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`ADDVS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd1,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`ADDSS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b01,	1'b0,		4'd2,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`SUBV:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd9,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`SUBVS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd3,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`SUBSS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b01,	1'b0,		4'd4,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`MULV:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,		setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b00,	1'b0,		4'd10,	1'b0,		1'b1,		1'b0,		1'b0,		1'b1,		strd_cycle};
			`MULVS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b0,		4'd5,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`MULSS:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b01,	1'b0,		4'd6,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`CMP:		{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b00,	1'b0,		4'd4,	1'b1,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			`ReLU:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						{offset,			rB,		rA,		rD,		opcode,		1'b0,	1'b0,	1'b0,	1'b0,	2'd0,	2'b10,	1'b1,		4'd7,	1'b0,		1'b1,		1'b0,		1'b0,		1'b0,		3'd0};
			default:	{out_offset,	rB_addr, rA_addr, rD_addr, out_opcode, ldr,	ldri, strv, jmp,	b,		wb,		unary,	alu,	setcc,	mem_en,	mem_rw,	mem_v,	conv_en,	strd_cyc} =
						'd0;
		endcase
	end
	
	
endmodule
