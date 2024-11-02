`include "def.v"

module PC_logic(
	
	input	[`INT32-1:0]	PC_inc,
	input	[`INT32-1:0]	b_addr,
	input	[`INT32-1:0]	j_addr,
	
	input	b_taken,
	input	jmp,
	
	output	wire	[`INT32-1:0]	out_PC
);
	
	assign	out_PC	=	b_taken	? b_addr :
								jmp		? j_addr : PC_inc;
	
endmodule
















































