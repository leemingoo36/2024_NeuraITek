`include "op_code.v"
`include "def.v"

module NPU(
	
	input	clk,
	input	reset,
	
	output	[`INT32-1:0]	Decode_pc,
	output	[4:0]	Execute_op,
	

	//for tb
	
	output	[`INT16-1:0]	conv_res,
	
	output	conv_write,
	output	[`LENGTH * `INT8-1:0]	conv_v
);
	wire	[`INT32-1:0]	PC_inc;
	wire	[`INT32-1:0]	b_addr;
	wire	[`INT32-1:0]	j_addr;
	wire	b_taken;
	wire	jmp;
	wire	[`INT32-1:0]	PC0;
	
	PC_logic					PC_logic_i0(.PC_inc(PC_inc), .b_addr(b_addr), .j_addr(j_addr), .b_taken(b_taken), .jmp(jmp), .out_PC(PC0));
	
	
	wire	[`INT32-1:0]	PC1;
	
	WriteBack_to_Fetch	pipe_0(.clk(clk), .reset(reset), .b_taken(b_taken), .jmp(jmp), .PC(PC0), .out_PC(PC1));
	
	
	wire	[`INT32-1:0]	Inst0;
	wire	[`INT32-1:0]	PC2;
	
	Fetch						Fetch_i0(.clk(clk), .PC(PC1), .b_taken(b_taken), .jmp(jmp), .Inst(Inst0), .out_PC(PC2), .PC_inc(PC_inc));
	
	
	wire	[`INT32-1:0]	Inst1;
	wire	[`INT32-1:0]	PC3;
	
	Fetch_to_Decode 		pipe_1(.clk(clk), .reset(reset), .b_taken(b_taken), .jmp(jmp), .Inst(Inst0), .PC(PC2), .out_Inst(Inst1), .out_PC(PC3));
	
	
	wire	[`LENGTH * `INT8-1:0]	wb_conv_result;
	wire	[4:0]	wb_conv_addr;
	wire	wb_conv_write;
	wire	[4:0]	wb_rD;
	wire	wb_s;
	wire	wb_v;
	wire	[`INT32-1:0]	wb_s_data;
	wire	[`LENGTH * `INT8-1:0]	wb_v_data;
	
	wire	[`INT32-1:0]	PC4;
	wire	[4:0]	rD0;
	wire	[`INT32-1:0]	rA0;
	wire	[`INT32-1:0]	rB0;
	wire	[`LENGTH * `INT8-1:0]	vA0;
	wire	[`LENGTH * `INT8-1:0]	vB0;
	wire	[2:0]	strd_cyc0;
	wire	ldr0;
	wire	[1:0]	b0;
	wire	[1:0]	wb0;
	wire	[3:0]	alu0;
	wire	setcc0;
	wire	mem_rw0;
	wire	mem_v0;
	wire	conv_en0;
	
	
	Decode					Decode_i0(.clk(clk), .reset(reset), .Inst(Inst1), .PC(PC3), .conv_result(wb_conv_result), .conv_addr(wb_conv_addr), .conv_write(wb_conv_write), .rD(wb_rD), .s_write(wb_s), .v_write(wb_v), .swrite_data(wb_s_data), .vwrite_data(wb_v_data),
												.out_PC(PC4), .opcode(Decode_op), .out_rD(rD0), .rA_data(rA0), .rB_data(rB0), .vA_data(vA0), .vB_data(vB0), .strd_cyc(strd_cyc0), .ldr(ldr0), .jmp(jmp), .jmp_addr(j_addr), .b(b0), .wb(wb0), .alu(alu0), .setcc(setcc0), .mem_rw(mem_rw0), .mem_v(mem_v0), .conv_en(conv_en0), .A_addr(rA_addr), .B_addr(rB_addr), .out_offBAD());
	assign	Decode_pc = PC4;
//	assign	Decode_vA = vA0[127:56];
//	assign	Decode_vB = vB0[127:56];
	
	wire	[`INT32-1:0]	PC5;
	wire	[4:0]	rD1;
	wire	[`INT32-1:0]	rA1;
	wire	[`INT32-1:0]	rB1;
	wire	[`LENGTH * `INT8-1:0]	vA1;
	wire	[`LENGTH * `INT8-1:0]	vB1;
	wire	[2:0]	strd_cyc1;
	wire	ldr1;
	wire	[1:0]	b1;
	wire	[1:0]	wb1;
	wire	[3:0]	alu1;
	wire	setcc1;
	wire	mem_rw1;
	wire	mem_v1;
	wire	conv_en1;
	
	wire	[4:0]	opcode0;
	
	Decode_to_Execute		pipe_2(.clk(clk), .reset(reset), .PC(PC4), .opcode(Decode_op), .rD(rD0), .rA_data(rA0), .rB_data(rB0), .vA_data(vA0), .vB_data(vB0), .strd_cyc(strd_cyc0), .ldr(ldr0), .b(b0), .wb(wb0), .alu(alu0), .setcc(setcc0), .mem_rw(mem_rw0), .mem_v(mem_v0), .conv_en(conv_en0), .b_taken(b_taken), 
											.out_PC(PC5), .out_opcode(opcode0), .out_rD(rD1), .out_rA_data(rA1), .out_rB_data(rB1), .out_vA_data(vA1), .out_vB_data(vB1), .out_strd(strd_cyc1), .out_ldr(ldr1), .out_b(b1), .out_wb(wb1), .out_alu(alu1), .out_setcc(setcc1), .out_mem_rw(mem_rw1), .out_mem_v(mem_v1), .out_conv_en(conv_en1));
	
	assign	DtoE_op = opcode0;
	
	wire	[`LENGTH * `INT8-1:0]	conv_result0;
	wire	[4:0]	conv_addr0;
	wire	conv_write0;
	wire	[`INT32-1:0]	s_write0;
	wire	[`LENGTH * `INT8-1:0]	v_write0;
	wire	[4:0]	rD2;
	wire	[`INT32-1:0]	s_result0;
	wire	[`LENGTH * `INT8-1:0]	v_result0;
	wire	ldr2;
	wire	[1:0]	wb2;
	wire	mem_rw2;
	wire	mem_v2;
	
	wire	[4:0]	opcode1;

	Execute					Execute_i0(.clk(clk), .reset(reset), .PC(PC5), .opcode(opcode0), .rD(rD1), .rA_data(rA1), .rB_data(rB1), .vA_data(vA1), .vB_data(vB1), .strd_cyc(strd_cyc1), .ldr(ldr1), .b(b1), .wb(wb1), .alu(alu1), .setcc(setcc1), .mem_rw(mem_rw1), .mem_v(mem_v1), .conv_en(conv_en1),
												.out_opcode(opcode1), .conv_result(conv_result0), .conv_addr(conv_addr0), .conv_write(conv_write0), .s_write(s_write0), .v_write(v_write0), .out_rD(rD2), .s_result(s_result0), .v_result(v_result0), .out_ldr(ldr2), .out_wb(wb2), .out_mem_rw(mem_rw2), .out_mem_v(mem_v2), .b_taken(b_taken), .b_addr(b_addr),	.conv_res(conv_res));
	assign	Execute_op = opcode0;
	
	wire	[`LENGTH * `INT8-1:0]	conv_result1;
	wire	[4:0]	conv_addr1;
	wire	conv_write1;
	wire	[`INT32-1:0]	s_write1;
	wire	[`LENGTH * `INT8-1:0]	v_write1;
	wire	[4:0]	rD3;
	wire	[`INT32-1:0]	s_result1;
	wire	[`LENGTH * `INT8-1:0]	v_result1;
	wire	ldr3;
	wire	[1:0]	wb3;
	wire	mem_rw3;
	wire	mem_v3;
	
	wire	[4:0]	opcode2;
	
	Execute_to_Memory		pipe_3(.clk(clk), .reset(reset), .opcode(opcode1), .conv_result(conv_result0), .conv_addr(conv_addr0), .conv_write(conv_write0), .s_write(s_write0), .v_write(v_write0), .rD(rD2), .s_result(s_result0), .v_result(v_result0), .ldr(ldr2), .wb(wb2), .mem_rw(mem_rw2), .mem_v(mem_v2),
											.out_opcode(opcode2), .out_conv_result(conv_result1), .out_conv_addr(conv_addr1), .out_conv_write(conv_write1), .out_s_write(s_write1), .out_v_write(v_write1), .out_rD(rD3), .out_s_result(s_result1), .out_v_result(v_result1), .out_ldr(ldr3), .out_wb(wb3), .out_mem_rw(mem_rw3), .out_mem_v(mem_v3));

	wire	[`LENGTH * `INT8-1:0]	conv_result2;
	wire	[4:0]	conv_addr2;
	wire	conv_write2;
	wire	[4:0]	rD4;
	wire	[`INT32-1:0]	s_result2;
	wire	[`LENGTH * `INT8-1:0]	v_result2;
	wire	[`INT32-1:0]	smem0;
	wire	[`LENGTH * `INT8-1:0]	vmem0;
	wire	ldr4;
	wire	[1:0]	wb4;
	
	wire	[`LENGTH * `INT8-1:0]	data_in = mem_v3 ? v_write1 : {s_write1, 96'd0};
	Memory					Memory_i0(.clk(clk), .reset(reset), .opcode(opcode2), .conv_result(conv_result1), .conv_addr(conv_addr1), .conv_write(conv_write1), .s_write(s_write1), .v_write(v_write1), .rD(rD3), .data_in(data_in), .s_result(s_result1), .v_result(v_result1), .ldr(ldr3), .wb(wb3), .mem_rw(mem_rw2), .mem_v(mem_v3),
											.out_opcode(), .out_conv_result(conv_result2), .out_conv_addr(conv_addr2), .out_conv_write(conv_write2), .out_rD(rD4), .out_s_result(s_result2), .out_v_result(v_result2), .out_smem(smem0), .out_vmem(vmem0), .out_ldr(ldr4), .out_wb(wb4));

	wire	[`LENGTH * `INT8-1:0]	conv_result3;
	wire	[4:0]	conv_addr3;
	wire	conv_write3;
	wire	[4:0]	rD5;
	wire	[`INT32-1:0]	s_result3;
	wire	[`LENGTH * `INT8-1:0]	v_result3;
	wire	[`INT32-1:0]	smem1;
	wire	[`LENGTH * `INT8-1:0]	vmem1;
	wire	ldr5;
	wire	[1:0]	wb5;

	Memory_to_WriteBack	pipe_4(.clk(clk), .reset(reset), .conv_result(conv_result2), .conv_addr(conv_addr2), .conv_write(conv_write2), .rD(rD4), .s_result(s_result2), .v_result(v_result2), .smem(smem0), .vmem(vmem0), .ldr(ldr4), .wb(wb4),
											.out_conv_result(conv_result3), .out_conv_addr(conv_addr3), .out_conv_write(conv_write3), .out_rD(rD5), .out_s_result(s_result3), .out_v_result(v_result3), .out_smem(smem1), .out_vmem(vmem1), .out_ldr(ldr5), .out_wb(wb5));
	
	WriteBack				WriteBack_i0(.conv_result(conv_result3), .conv_addr(conv_addr3), .conv_write(conv_write3), .rD(rD5), .s_result(s_result3), .v_result(v_result3), .smem(smem1), .vmem(vmem1), .ldr(ldr5), .wb(wb5),
												.out_conv_result(wb_conv_result), .out_conv_addr(wb_conv_addr), .out_conv_write(wb_conv_write), .swrite_data(wb_s_data), .vwrite_data(wb_v_data), .out_rD(wb_rD), .s_write(wb_s), .v_write(wb_v));
	
	assign	conv_write = wb_conv_write;
	assign	conv_v = wb_conv_result;
endmodule
