`include "def.v"

module WriteBack(
	
	input	[`LENGTH * `INT8-1:0]	conv_result,
	input	[4:0]	conv_addr,
	input	conv_write,
	
	input	[4:0]	rD,
	
	input	[`INT32-1:0]	s_result,
	input	[`LENGTH * `INT8-1:0] v_result,
	
	input	[`INT32-1:0]	smem,
	input	[`LENGTH * `INT8-1:0]	vmem,
	
	input	ldr,
	input	[1:0]	wb,
	
	//output
	output	wire	[`LENGTH * `INT8-1:0]	out_conv_result,
	output	wire	[4:0]	out_conv_addr,
	output	wire	out_conv_write,
	
	output	wire	[`INT32-1:0]	swrite_data,
	output	wire	[`LENGTH * `INT8-1:0]	vwrite_data,
	
	output	wire	[4:0]	out_rD,
	
	output	wire	s_write,
	output	wire	v_write
	
	
	//for tb
);
	
	assign	out_rD	= rD;
	
	assign	swrite_data	=	(ldr)	? smem : s_result;
	assign	vwrite_data	=	(ldr) ? vmem : v_result;
	
	assign	out_conv_result	= conv_result;
	assign	out_conv_addr		= conv_addr;
	assign	out_conv_write		= conv_write;
	
	assign	s_write	= wb[0];
	assign	v_write	= wb[1];
	
endmodule