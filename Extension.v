`include "def.v"
`include "op_code.v"

module signExt #(parameter int=`INT8, length=16)(
	
	input	[int * length-1:0]	in_a,
	
	output	wire	[int * length * 2-1:0]	out_a
	
);
	genvar j;
	
	generate
		for(j=0; j<length; j=j+1) begin: signExt
         assign out_a[(j+1)*8*2-1:j*8*2] = in_a[(j+1)*8-1] == 1 ? {8'b11111111, in_a[j*8+:8]} : {8'd0, in_a[j*8+:8]};
		end
	endgenerate
	
endmodule

module zeroExt #(parameter int=`INT8, length=16)(
	
	input	[int * length-1:0]	in_a,
	
	output	wire	[int * length * 2-1:0]	out_a
	
);
	
	genvar i;
	
	generate
		for(i=0; i<length; i=i+1) begin: zeroExt
         assign out_a[(i+1)*8*2-1:i*8*2] = { {8{1'b0}}, in_a[i*8 +: 8] };
		end
	endgenerate
	
endmodule