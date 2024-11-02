`include "def.v"

module Execute_to_Memory(
	input	clk,
	input	reset,
	
	input	[4:0]	opcode,
	
	input	[`LENGTH * `INT8-1:0]	conv_result,
	input	[4:0]	conv_addr,
	input	conv_write,
	
	input	[`INT32-1:0]	s_write,
	input	[`LENGTH * `INT8-1:0]	v_write,
	
	input	[4:0]	rD,
	
	input	[`INT32-1:0]	s_result,
	input	[`LENGTH * `INT8-1:0]	v_result,
	
	input	ldr,
	input	[1:0]	wb,
	input	mem_rw,
	input	mem_v,
	
	output	reg	[4:0]	out_opcode,
	
	output	reg	[`LENGTH * `INT8-1:0]	out_conv_result,
	output	reg	[4:0]	out_conv_addr,
	output	reg	out_conv_write,
	
	output	reg	[`INT32-1:0]	out_s_write,
	output	reg	[`LENGTH * `INT8-1:0]	out_v_write,
	
	output	reg	[4:0]	out_rD,
	
	output	reg	[`INT32-1:0]	out_s_result,
	output	reg	[`LENGTH * `INT8-1:0]	out_v_result,
	
	output	reg	out_ldr,
	output	reg	[1:0]	out_wb,
	output	reg	out_mem_rw,
	output	reg	out_mem_v
);
	
	
	always @ (posedge clk or posedge reset)
		if(reset)
			out_s_result <= 'd0;
		else
			out_s_result <= s_result;
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			out_opcode			<=	'd0;
			out_conv_result	<= 'd0;
			out_conv_addr		<=	'd0;
			out_conv_write		<= 'd0;
			out_s_write			<= 'd0;
			out_v_write			<=	'd0;
			out_rD				<=	'd0;
//			out_s_result		<= 'd0;
			out_v_result		<= 'd0;
			out_ldr				<=	1'b0;
			out_wb				<=	2'b00;
			out_mem_rw			<= 1'b0;
			out_mem_v			<= 1'b0;
			end
		else begin
			out_opcode			<=	opcode;
			out_conv_result	<= conv_result;
			out_conv_addr		<=	conv_addr;
			out_conv_write		<= conv_write;
			out_s_write			<= s_write;
			out_v_write			<=	v_write;
			out_rD				<=	rD;
//			out_s_result		<= s_result;
			out_v_result		<= v_result;
			out_ldr				<=	ldr;
			out_wb				<=	wb;
			out_mem_rw			<= mem_rw;
			out_mem_v			<= mem_v;
			end
			
			
	
	
endmodule