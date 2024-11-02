`timescale 1ns/10ps
`include "def.v"
`include "op_code.v"

module NPU_tb;
	
	reg	clk;
	reg	reset;
	wire	[31:0]	Decode_pc;
	wire	[4:0]	Execute_op;
	
	
	wire	[71:0]	Execute_vA, Execute_vB;
	
	wire	[15:0]	conv_res;
	wire	conv_write;
	wire	[`LENGTH * `INT8 - 1:0]	conv_v;
	
	wire	[`INT8-1:0]	i15	= conv_v[`index_15];
	wire	[`INT8-1:0]	i14	= conv_v[`index_14];
	wire	[`INT8-1:0]	i13	= conv_v[`index_13];
	wire	[`INT8-1:0]	i12	= conv_v[`index_12];
	wire	[`INT8-1:0]	i11	= conv_v[`index_11];
	wire	[`INT8-1:0]	i10	= conv_v[`index_10];
	wire	[`INT8-1:0]	i9	= conv_v[`index_9];
	wire	[`INT8-1:0]	i8	= conv_v[`index_8];
	wire	[`INT8-1:0]	i7	= conv_v[`index_7];
	wire	[`INT8-1:0]	i6	= conv_v[`index_6];
	wire	[`INT8-1:0]	i5	= conv_v[`index_5];
	wire	[`INT8-1:0]	i4	= conv_v[`index_4];
	wire	[`INT8-1:0]	i3	= conv_v[`index_3];
	wire	[`INT8-1:0]	i2	= conv_v[`index_2];
	wire	[`INT8-1:0]	i1	= conv_v[`index_1];
	wire	[`INT8-1:0]	i0	= conv_v[`index_0];
	
	integer file, i;
	
	NPU NPU_i0(.clk(clk), .reset(reset), .Decode_pc(Decode_pc), .Execute_op(Execute_op), .conv_res(conv_res), .conv_write(conv_write), .conv_v(conv_v));//.Memory_vmem(Memory_vmem), .before_s_result(before_s_result), .after_s_result(after_s_result), .cc(cc), .cc_res(cc_res), .b_(b_), .btk(btk), .WBack_v(WBack_v), .wb_addr(wb_addr));
	
	always #5 clk <= ~clk;
	
//	always @ (posedge clk)
//		if(conv_write)
//			$fwrite(file, "%h\n", conv_v);
			
	
	initial begin
		$dumpvars;
		clk = 0;
		reset = 1;
		
		file = $fopen("result.txt", "w");
		
		#20
		reset = 0;
		for (i=0; i < 42060; i=i+1) begin
			#10
			@(posedge clk);
			if(conv_write)
				$fwrite(file, "%h\n", conv_v);
		end
		
		$fclose(file);
		$finish;
		end

endmodule