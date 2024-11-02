`include "def.v"

module Decode_to_Execute(
	input	clk,
	input	reset,
	
	input	wire	[`INT32-1:0]	PC,
	
	input	wire	[4:0]	opcode,
	input	wire	[4:0]	rD,
	input	wire	[`INT32-1:0]	rA_data,
	input	wire	[`INT32-1:0]	rB_data,
	
	input	wire	[`LENGTH * `INT8-1:0]	vA_data,
	input	wire	[`LENGTH * `INT8-1:0]	vB_data,
	
	input	wire	[2:0]	strd_cyc,
	
	input	wire	ldr,
	input	wire	[1:0]	b,
	input	wire	[1:0]	wb,
	input	wire	[3:0]	alu,
	input wire	setcc,
	input	wire	mem_rw,
	input	wire	mem_v,
	input	wire	conv_en,
	
	input	wire	b_taken,
	
	
	//output
	output	reg	[`INT32-1:0]	out_PC,
	
	output	reg	[4:0]	out_opcode,//?
	output	reg	[4:0]	out_rD,
	output	reg	[`INT32-1:0]	out_rA_data,
	output	reg	[`INT32-1:0]	out_rB_data,
	
	output	reg	[`LENGTH * `INT8-1:0]	out_vA_data,
	output	reg	[`LENGTH * `INT8-1:0]	out_vB_data,
	
	output	reg	[2:0]	out_strd,
	
	output	reg	out_ldr,
	output	reg	[1:0]	out_b,
	output	reg	[1:0]	out_wb,
	output	reg	[3:0]	out_alu,
	output	reg	out_setcc,
	output	reg	out_mem_rw,
	output	reg	out_mem_v,
	output	reg	out_conv_en
);
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			out_PC		<=	'd0;
			out_opcode	<=	'd0;
			out_rD		<=	'd0;
			out_rA_data	<=	'd0;
			out_rB_data	<=	'd0;
			out_vA_data	<=	'd0;
			out_vB_data	<=	'd0;
			out_strd		<=	'd0;
			out_ldr		<=	'd0;
			out_b			<=	'd0;
			out_wb		<=	'd0;
			out_alu		<=	'd0;
			out_setcc	<=	'd0;
			out_mem_rw	<=	'd0;
			out_mem_v	<=	'd0;
			out_conv_en	<=	'd0;
			end
		else
			if(~b_taken) begin
				out_PC		<=	PC;
				out_opcode	<=	opcode;
				out_rD		<=	rD;
				out_rA_data	<=	rA_data;
				out_rB_data	<=	rB_data;
				out_vA_data	<=	vA_data;
				out_vB_data	<=	vB_data;
				out_strd		<=	strd_cyc;
				out_ldr		<=	ldr;
				out_b			<=	b;
				out_wb		<=	wb;
				out_alu		<=	alu;
				out_setcc	<=	setcc;
				out_mem_rw	<=	mem_rw;
				out_mem_v	<=	mem_v;
				out_conv_en	<=	conv_en;
				end
			else begin
				out_PC		<=	'd0;
				out_opcode	<=	'd0;
				out_rD		<=	'd0;
				out_rA_data	<=	'd0;
				out_rB_data	<=	'd0;
				out_vA_data	<=	'd0;
				out_vB_data	<=	'd0;
				out_strd		<=	'd0;
				out_ldr		<=	'd0;
				out_b			<=	'd0;
				out_wb		<=	'd0;
				out_alu		<=	'd0;
				out_setcc	<=	'd0;
				out_mem_rw	<=	'd0;
				out_mem_v	<=	'd0;
				out_conv_en	<=	'd0;
				end
endmodule