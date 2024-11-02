`include "def.v"

module Fetch(
	input clk,
	input	reset,
	input	wire	[`INT32-1:0]	PC,
	
	input	b_taken,
	input	jmp,
	
	output	wire	[`INT32-1:0]	Inst,
	output	reg	[`INT32-1:0]	out_PC,
	output	wire	[`INT32-1:0]	PC_inc
	
);
	
	assign	PC_inc	= PC + 1;
	
	reg	[`INT32-1:0]	temp_PC;
	wire	[`INT32-1:0]	Inst_ctrl;
	
	assign	Inst = (b_taken || jmp) ? 32'd0 : Inst_ctrl;
	
	always @ (posedge clk or posedge reset) begin
		temp_PC	<= PC;
	end
	
	always @ (posedge clk or posedge reset) begin
		out_PC	<= temp_PC;
	end
		
	
	
	Inst_mem inst(.address(PC[7:0]), .clock(clk), .data(), .wren(0), .q(Inst_ctrl));
	
endmodule
