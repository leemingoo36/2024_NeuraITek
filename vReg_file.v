`include "def.v"

module vReg_file(
	
	input wire clk,
	input wire reset,
	input wire [4:0] rA_addr,
	input wire [4:0] rB_addr,
	input wire [4:0] rD_addr,
	input	wire [`LENGTH * `INT8-1:0] write_data,
	input wire reg_write,
	
	input wire [`LENGTH * `INT8-1:0] conv_result,
	input	wire [4:0] conv_addr,
	input	wire conv_write,
	
	output wire [`LENGTH * `INT8-1:0] rA_data,
	output wire [`LENGTH * `INT8-1:0] rB_data
);
	
	
   reg	[`LENGTH * `INT8-1:0]	reg_0;
   reg	[`LENGTH * `INT8-1:0]	reg_1;
   reg	[`LENGTH * `INT8-1:0]	reg_2;
   reg	[`LENGTH * `INT8-1:0]	reg_3;
   reg	[`LENGTH * `INT8-1:0]	reg_4;
   reg	[`LENGTH * `INT8-1:0]	reg_5;
   reg	[`LENGTH * `INT8-1:0]	reg_6;
   reg	[`LENGTH * `INT8-1:0]	reg_7;
   reg	[`LENGTH * `INT8-1:0]	reg_8;
   reg	[`LENGTH * `INT8-1:0]	reg_9;
   reg	[`LENGTH * `INT8-1:0]	reg_10;
   reg	[`LENGTH * `INT8-1:0]	reg_11;
   reg	[`LENGTH * `INT8-1:0]	reg_12;
   reg	[`LENGTH * `INT8-1:0]	reg_13;
   reg	[`LENGTH * `INT8-1:0]	reg_14;
   reg	[`LENGTH * `INT8-1:0]	reg_15;
   reg	[`LENGTH * `INT8-1:0]	reg_16;
   reg	[`LENGTH * `INT8-1:0]	reg_17;
   reg	[`LENGTH * `INT8-1:0]	reg_18;
   reg	[`LENGTH * `INT8-1:0]	reg_19;
   reg	[`LENGTH * `INT8-1:0]	reg_20;
   reg	[`LENGTH * `INT8-1:0]	reg_21;
   reg	[`LENGTH * `INT8-1:0]	reg_22;
   reg	[`LENGTH * `INT8-1:0]	reg_23;
   reg	[`LENGTH * `INT8-1:0]	reg_24;
   reg	[`LENGTH * `INT8-1:0]	reg_25;
   reg	[`LENGTH * `INT8-1:0]	reg_26;
   reg	[`LENGTH * `INT8-1:0]	reg_27;
   reg	[`LENGTH * `INT8-1:0]	reg_28;
   reg	[`LENGTH * `INT8-1:0]	reg_29;
   reg	[`LENGTH * `INT8-1:0]	reg_30;
   reg	[`LENGTH * `INT8-1:0]	reg_31;
	
	//read
	assign	rA_data	=	(rA_addr == 5'b00000) ? reg_0 :
								(rA_addr == 5'b00001) ? reg_1 :
								(rA_addr == 5'b00010) ? reg_2 :
								(rA_addr == 5'b00011) ? reg_3 :
								(rA_addr == 5'b00100) ? reg_4 :
								(rA_addr == 5'b00101) ? reg_5 :
								(rA_addr == 5'b00110) ? reg_6 :
								(rA_addr == 5'b00111) ? reg_7 :
								(rA_addr == 5'b01000) ? reg_8 :
								(rA_addr == 5'b01001) ? reg_9 :
								(rA_addr == 5'b01010) ? reg_10 :
								(rA_addr == 5'b01011) ? reg_11 :
								(rA_addr == 5'b01100) ? reg_12 :
								(rA_addr == 5'b01101) ? reg_13 :
								(rA_addr == 5'b01110) ? reg_14 :
								(rA_addr == 5'b01111) ? reg_15 :
								(rA_addr == 5'b10000) ? reg_16 :
								(rA_addr == 5'b10001) ? reg_17 :
								(rA_addr == 5'b10010) ? reg_18 :
								(rA_addr == 5'b10011) ? reg_19 :
								(rA_addr == 5'b10100) ? reg_20 :
								(rA_addr == 5'b10101) ? reg_21 :
								(rA_addr == 5'b10110) ? reg_22 :
								(rA_addr == 5'b10111) ? reg_23 :
								(rA_addr == 5'b11000) ? reg_24 :
								(rA_addr == 5'b11001) ? reg_25 :
								(rA_addr == 5'b11010) ? reg_26 :
								(rA_addr == 5'b11011) ? reg_27 :
								(rA_addr == 5'b11100) ? reg_28 :
								(rA_addr == 5'b11101) ? reg_29 :
								(rA_addr == 5'b11110) ? reg_30 :
								(rA_addr == 5'b11111) ? reg_31 : 'dx;
	
	assign	rB_data	=	(rB_addr == 5'b00000) ? reg_0 :
								(rB_addr == 5'b00001) ? reg_1 :
								(rB_addr == 5'b00010) ? reg_2 :
								(rB_addr == 5'b00011) ? reg_3 :
								(rB_addr == 5'b00100) ? reg_4 :
								(rB_addr == 5'b00101) ? reg_5 :
								(rB_addr == 5'b00110) ? reg_6 :
								(rB_addr == 5'b00111) ? reg_7 :
								(rB_addr == 5'b01000) ? reg_8 :
								(rB_addr == 5'b01001) ? reg_9 :
								(rB_addr == 5'b01010) ? reg_10 :
								(rB_addr == 5'b01011) ? reg_11 :
								(rB_addr == 5'b01100) ? reg_12 :
								(rB_addr == 5'b01101) ? reg_13 :
								(rB_addr == 5'b01110) ? reg_14 :
								(rB_addr == 5'b01111) ? reg_15 :
								(rB_addr == 5'b10000) ? reg_16 :
								(rB_addr == 5'b10001) ? reg_17 :
								(rB_addr == 5'b10010) ? reg_18 :
								(rB_addr == 5'b10011) ? reg_19 :
								(rB_addr == 5'b10100) ? reg_20 :
								(rB_addr == 5'b10101) ? reg_21 :
								(rB_addr == 5'b10110) ? reg_22 :
								(rB_addr == 5'b10111) ? reg_23 :
								(rB_addr == 5'b11000) ? reg_24 :
								(rB_addr == 5'b11001) ? reg_25 :
								(rB_addr == 5'b11010) ? reg_26 :
								(rB_addr == 5'b11011) ? reg_27 :
								(rB_addr == 5'b11100) ? reg_28 :
								(rB_addr == 5'b11101) ? reg_29 :
								(rB_addr == 5'b11110) ? reg_30 :
								(rB_addr == 5'b11111) ? reg_31 : 'dx;
	
	//write
	always @(posedge clk or posedge reset)
		if(reset)
			reg_0	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00000))
				reg_0	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00000))
				reg_0	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_1	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00001))
				reg_1	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00001))
				reg_1	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_2	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00010))
				reg_2	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00010))
				reg_2	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_3	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00011))
				reg_3	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00011))
				reg_3	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_4	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00100))
				reg_4	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00100))
				reg_4	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_5	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00101))
				reg_5	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00101))
				reg_5	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_6	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00110))
				reg_6	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00110))
				reg_6	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_7	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b00111))
				reg_7	<=	write_data;
			else if(conv_write && (conv_addr == 5'b00111))
				reg_7	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_8	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01000))
				reg_8	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01000))
				reg_8	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_9	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01001))
				reg_9	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01001))
				reg_9	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_10	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01010))
				reg_10	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01010))
				reg_10	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_11	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01011))
				reg_11	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01011))
				reg_11	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_12	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01100))
				reg_12	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01100))
				reg_12	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_13	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01101))
				reg_13	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01101))
				reg_13	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_14	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01110))
				reg_14	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01110))
				reg_14	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_15	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b01111))
				reg_15	<=	write_data;
			else if(conv_write && (conv_addr == 5'b01111))
				reg_15	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_16	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10000))
				reg_16	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10000))
				reg_16	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_17	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10001))
				reg_17	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10001))
				reg_17	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_18	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10010))
				reg_18	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10010))
				reg_18	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_19	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10011))
				reg_19	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10011))
				reg_19	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_20	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10100))
				reg_20	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10100))
				reg_20	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_21	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10101))
				reg_21	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10101))
				reg_21	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_22	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10110))
				reg_22	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10110))
				reg_22	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_23	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b10111))
				reg_23	<=	write_data;
			else if(conv_write && (conv_addr == 5'b10111))
				reg_23	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_24	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11000))
				reg_24	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11000))
				reg_24	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_25	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11001))
				reg_25	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11001))
				reg_25	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_26	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11010))
				reg_26	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11010))
				reg_26	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_27	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11011))
				reg_27	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11011))
				reg_27	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_28	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11100))
				reg_28	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11100))
				reg_28	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_29	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11101))
				reg_29	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11101))
				reg_29	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_30	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11110))
				reg_30	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11110))
				reg_30	<=	conv_result;
			end
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_31	<=	'd0;
		else begin
			if(reg_write && (rD_addr == 5'b11111))
				reg_31	<=	write_data;
			else if(conv_write && (conv_addr == 5'b11111))
				reg_31	<=	conv_result;
			end
	
endmodule
