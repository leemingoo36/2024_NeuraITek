	`include "def.v"

module Memory(
	
	input clk,
	input	reset,
	
	//convolution result
	input	[4:0]	opcode,
	
	input	[`LENGTH * `INT8-1:0]	conv_result,
	input	[4:0]	conv_addr,
	input	conv_write,
	
	//value to store in memory
	input	[`INT32-1:0]	s_write,
	input	[`LENGTH * `INT8-1:0]	v_write,
	input	[4:0]	rD,
	input	[`LENGTH * `INT8-1:0]	data_in,
	
	//alu result(memory address, s-v_wb)
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
	
	output	reg	[4:0]	out_rD,
	
	output	reg	[`INT32-1:0]	out_s_result,
	output	reg	[`LENGTH * `INT8-1:0]	out_v_result,
	
	//memory out
	output	wire	[`INT32-1:0]	out_smem,
	output	wire	[`LENGTH * `INT8-1:0]	out_vmem,
	
	output	reg	out_ldr,
	output	reg	[1:0]	out_wb

);
	Data_mem mem(.address(s_result[14:0]), .clock(clk), .data(data_in), .wren(mem_rw), .q(out_vmem));
	
	reg	[4:0]	temp_opcode;
	reg	[`LENGTH * `INT8-1:0]	temp_conv_result;
	reg	[4:0]	temp_conv_addr;
	reg	temp_conv_write;
	reg	[4:0]	temp_rD;
	reg	[`INT32-1:0]	temp_s_result;
	reg	[`LENGTH * `INT8-1:0]	temp_v_result;
	reg	temp_ldr;
	reg	[1:0]	temp_wb;
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			temp_opcode	<= 'd0;
			temp_conv_result	<=	'd0;
			temp_conv_addr		<=	'd0;
			temp_conv_write		<=	'd0;
			temp_rD				<=	'd0;
			temp_s_result		<=	'd0;
			temp_v_result		<=	'd0;
			temp_ldr				<=	'd0;
			temp_wb				<=	'd0;
		end
		else	begin
			temp_opcode	<=	opcode;
			temp_conv_result	<=	conv_result;
			temp_conv_addr		<=	conv_addr;
			temp_conv_write		<=	conv_write;
			temp_rD				<=	rD;
			temp_s_result		<=	s_result;
			temp_v_result		<=	v_result;
			temp_ldr				<=	ldr;
			temp_wb				<=	wb;
			end
	
	always @ (posedge clk or posedge reset)
		if(reset) begin
			out_opcode	<= 'd0;
			out_conv_result	<=	'd0;
			out_conv_addr		<=	'd0;
			out_conv_write		<=	'd0;
			out_rD				<=	'd0;
			out_s_result		<=	'd0;
			out_v_result		<=	'd0;
			out_ldr				<=	'd0;
			out_wb				<=	'd0;
		end
		else	begin
			out_opcode	<=	temp_opcode;
			out_conv_result	<=	temp_conv_result;
			out_conv_addr		<=	temp_conv_addr;
			out_conv_write		<=	temp_conv_write;
			out_rD				<=	temp_rD;
			out_s_result		<=	temp_s_result;
			out_v_result		<=	temp_v_result;
			out_ldr				<=	temp_ldr;
			out_wb				<=	temp_wb;
		end

	assign	out_smem	= ~mem_v ? out_vmem[`LENGTH * `INT8-1:(`LENGTH-4) * `INT8] : 'd0;
	
endmodule