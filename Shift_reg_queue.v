`include "def.v"
`define FULL	1'b0
`define NFULL	1'b1
`define DEPTH 5'b10000

module Shift_reg_queue(
	input clk, 
	input reset, 
	
	input	wire	[2:0]	strd_cyc,
	input	wire	in_valid, 
	input	wire	out_block,
	input	wire	[`INT16-1:0]	in_data,
	
	output	wire	[`LENGTH * `INT8-1:0]	out_vector,
	output	wire	out_en,
	
	//for tb
	output	wire	[`LENGTH * `INT8 - 1:0]	q
	//for img
	//output	wire	[`LENGTH * `INT16-1:0]	Execute_pxl_vector
	);
	
	/*
	9:1
	25:2
	49:4
	81:6
	*/
	/*wire	[`INT16-1:0] mod =	(strd_cyc == 1)	?	9	:
										(strd_cyc == 2)	?	25	:
										(strd_cyc == 4)	?	49	:
										(strd_cyc == 6)	?	81	:	1;
	*/
	wire	[`INT8-1:0]	in_wire = 	(in_data[15] == 1) ? 0		:
											(in_data > 255) ? 255	:	(in_data) & 8'b11111111;
	
	reg	curr_state, next_state;
	reg	shift_en;
	reg	[1:0]	addr_sel;
	reg	unsigned	[3:0]		addr, next_addr;
	reg	[`LENGTH * `INT8-1:0]	queue;	//in -> q0 -> ... -> q15 -> out
	reg	[`LENGTH * `INT16-1:0]	q16;
	
	wire	full, zero;
	
	reg	unsigned	[4:0]	level;
	
	assign	out_curr_state	= curr_state;
	assign	out_next_state = next_state;
	assign	out_level	= level;
	
	//state update
	always @ (posedge clk or posedge reset)
		if (reset) curr_state <= `NFULL;
		else curr_state <= next_state;
	
	always @ (*) begin//posedge clk		//curr_state or in_valid) begin
		if(reset) begin
//			level			= 4'd0;
			shift_en		= 1'b0;
			next_state	= `NFULL;
			end
		casex(curr_state)
			`FULL:begin
				if(in_valid) begin
//					level		= 'd0;
					shift_en	= 1'b1;
					end
				else begin
//					level		= 'd0;
					shift_en	= 1'b0;
					end
				next_state	= `NFULL;
				end
			
			`NFULL:begin
				if(in_valid) begin
//					level		= level + 1;
					shift_en	= 1'b1;
					end
				else begin
//					level		= level;
					shift_en	= 1'b0;
					end
				if(level == `DEPTH)
					next_state	= `FULL;
				else
					next_state	= `NFULL;
				end
			endcase
		end

	//data shifting
	always @ (posedge clk) begin
		if (reset)
			level = 'd0;
		else if (shift_en) begin
			queue[`index_0] <= in_wire;
			level = level + 1;
			end
		if (curr_state == `FULL)
			level = 'd0;
		end
	
	always @ (posedge clk)
		if (shift_en) queue[`index_1] <= queue[`index_0];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_2] <= queue[`index_1];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_3] <= queue[`index_2];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_4] <= queue[`index_3];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_5] <= queue[`index_4];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_6] <= queue[`index_5];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_7] <= queue[`index_6];
	
	always @ (posedge clk)
		if (shift_en) queue[`index_8] <= queue[`index_7];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_9] <= queue[`index_8];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_10] <= queue[`index_9];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_11] <= queue[`index_10];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_12] <= queue[`index_11];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_13] <= queue[`index_12];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_14] <= queue[`index_13];
		
	always @ (posedge clk)
		if (shift_en) queue[`index_15] <= queue[`index_14];
	
	wire	[`INT8-1:0]	out_data0;
	wire	[`INT8-1:0]	out_data1;
	wire	[`INT8-1:0]	out_data2;
	wire	[`INT8-1:0]	out_data3;
	wire	[`INT8-1:0]	out_data4;
	wire	[`INT8-1:0]	out_data5;
	wire	[`INT8-1:0]	out_data6;
	wire	[`INT8-1:0]	out_data7;
	wire	[`INT8-1:0]	out_data8;
	wire	[`INT8-1:0]	out_data9;
	wire	[`INT8-1:0]	out_data10;
	wire	[`INT8-1:0]	out_data11;
	wire	[`INT8-1:0]	out_data12;
	wire	[`INT8-1:0]	out_data13;
	wire	[`INT8-1:0]	out_data14;
	wire	[`INT8-1:0]	out_data15;


//	assign	out_data0 = /*(curr_state != `FULL) ?*/ queue[`index_0] ;//: 'dx;
//	assign	out_data1 = /*(curr_state != `FULL) ?*/ queue[`index_1] ;//: 'dx;
//	assign	out_data2 = /*(curr_state != `FULL) ?*/ queue[`index_2] ;//: 'dx;
//	assign	out_data3 = /*(curr_state != `FULL) ?*/ queue[`index_3] ;//: 'dx;
//	assign	out_data4 = /*(curr_state != `FULL) ?*/ queue[`index_4] ;//: 'dx;
//	assign	out_data5 = /*(curr_state != `FULL) ?*/ queue[`index_5] ;//: 'dx;
//	assign	out_data6 = /*(curr_state != `FULL) ?*/ queue[`index_6] ;//: 'dx;
//	assign	out_data7 = /*(curr_state != `FULL) ?*/ queue[`index_7] ;//: 'dx;
//	assign	out_data8 = /*(curr_state != `FULL) ?*/ queue[`index_8] ;//: 'dx;
//	assign	out_data9 = /*(curr_state != `FULL) ?*/ queue[`index_9] ;//:	'dx;
//	assign	out_data10 = /*(curr_state != `FULL) ?*/ queue[`index_10] ;//: 'dx;
//	assign	out_data11 = /*(curr_state != `FULL) ?*/ queue[`index_11] ;//: 'dx;
//	assign	out_data12 = /*(curr_state != `FULL) ?*/ queue[`index_12] ;//: 'dx;
//	assign	out_data13 = /*(curr_state != `FULL) ?*/ queue[`index_13] ;//: 'dx;
//	assign	out_data14 = /*(curr_state != `FULL) ?*/ queue[`index_14] ;//: 'dx;
//	assign	out_data15 = /*(curr_state != `FULL) ?*/ queue[`index_15] ;//: 'dx;
	
	assign	out_data0 = (curr_state == `FULL) ? queue[`index_0] : 'd0;
	assign	out_data1 = (curr_state == `FULL) ? queue[`index_1] :	'd0;
	assign	out_data2 = (curr_state == `FULL) ? queue[`index_2] : 'd0;
	assign	out_data3 = (curr_state == `FULL) ? queue[`index_3] : 'd0;
	assign	out_data4 = (curr_state == `FULL) ? queue[`index_4] : 'd0;
	assign	out_data5 = (curr_state == `FULL) ? queue[`index_5] : 'd0;
	assign	out_data6 = (curr_state == `FULL) ? queue[`index_6] : 'd0;
	assign	out_data7 = (curr_state == `FULL) ? queue[`index_7] : 'd0;
	assign	out_data8 = (curr_state == `FULL) ? queue[`index_8] : 'd0;
	assign	out_data9 = (curr_state == `FULL) ? queue[`index_9] :	'd0;
	assign	out_data10 = (curr_state == `FULL) ? queue[`index_10] : 'd0;
	assign	out_data11 = (curr_state == `FULL) ? queue[`index_11] : 'd0;
	assign	out_data12 = (curr_state == `FULL) ? queue[`index_12] : 'd0;
	assign	out_data13 = (curr_state == `FULL) ? queue[`index_13] : 'd0;
	assign	out_data14 = (curr_state == `FULL) ? queue[`index_14] : 'd0;
	assign	out_data15 = (curr_state == `FULL) ? queue[`index_15] : 'd0;
	
	assign	out_vector	= {out_data15, out_data14, out_data13, out_data12, out_data11, out_data10, out_data9, out_data8, out_data7, out_data6, out_data5, out_data4, out_data3, out_data2, out_data1, out_data0};
	assign	out_en	= (curr_state == `FULL);
	
	assign q = queue;

endmodule