`include "def.v"

module Memory_to_WriteBack(
	
	input clk,
	input	reset,
	
	//convolution result
	input	[`LENGTH * `INT8-1:0]	conv_result,
	input	[4:0]	conv_addr,
	input	conv_write,
	
	input	[4:0]	rD,
		
	//alu result
	input	[`INT32-1:0]	s_result,
	input	[`LENGTH * `INT8-1:0]	v_result,
	
	input	[`INT32-1:0]	smem,
	input	[`LENGTH * `INT8-1:0]	vmem,
	
	input	ldr,
	input	[1:0]	wb,
	
	//write-back sig
	
	output	reg	[`LENGTH * `INT8-1:0]	out_conv_result,
	output	reg	[4:0]	out_conv_addr,
	output	reg	out_conv_write,
	
	output	reg	[4:0]	out_rD,
	
	output	reg	[`INT32-1:0]	out_s_result,
	output	reg	[`LENGTH * `INT8-1:0]	out_v_result,
	
	output	reg	[`INT32-1:0]	out_smem,
	output	reg	[`LENGTH * `INT8-1:0]	out_vmem,
	
	output	reg	out_ldr,
	output	reg	[1:0]	out_wb
);
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			out_conv_result	<= 'd0;
			out_conv_addr		<= 'd0;
			out_conv_write		<= 'd0;
			out_rD				<= 'd0;
			out_s_result		<= 'd0;
			out_v_result		<= 'd0;
			out_smem				<= 'd0;
			out_vmem				<=	'd0;
			out_ldr				<=	'd0;
			out_wb				<=	'd0;
			end
		else begin
			out_conv_result	<= conv_result;
			out_conv_addr		<= conv_addr;
			out_conv_write		<= conv_write;
			out_rD				<= rD;
			out_s_result		<= s_result;
			out_v_result		<= v_result;
			out_smem				<= smem;
			out_vmem				<= vmem;
			out_ldr				<= ldr;
			out_wb				<=	wb;
			end
endmodule