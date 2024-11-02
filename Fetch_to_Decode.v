`include "def.v"

module Fetch_to_Decode(
	
	input	clk,
	input	reset,
	
	input	b_taken,
	input	jmp,
	
	input	wire	[`INT32-1:0]	Inst,
	input	wire	[`INT32-1:0]	PC,
	
	output	reg	[`INT32-1:0]	out_Inst,
	output	reg	[`INT32-1:0]	out_PC
);
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			out_Inst	<= 'd0;
			out_PC	<=	'd0;
			end
		else 
			if(~b_taken && ~jmp) begin
				out_Inst	<=	Inst;
				out_PC	<=	PC;
				end
			else begin
				out_Inst	<= 'd0;
				out_PC	<= 'd0;
				end
	
endmodule