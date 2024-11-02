`include "def.v"

//to increase clk
module WriteBack_to_Fetch(
	
	input	clk,
	input	reset,
	
	input	b_taken,
	input	jmp,
	
	input	wire	[`INT32-1:0]	PC,
	
	output	reg	[`INT32-1:0]	out_PC
	
);
	
	always @(posedge clk or posedge reset)
		if(reset)
			out_PC	<=	'd0;
		else
			out_PC	<=	PC;
	
endmodule
