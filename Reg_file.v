`include "def.v"

module Reg_file (
	
	input wire clk,
	input wire reset,
	input wire [4:0] rA_addr,
	input wire [4:0] rB_addr,
	input wire [4:0] rD_addr,
	input wire [`INT32-1:0] write_data,
	input wire reg_write,
	
	output wire [`INT32-1:0] rA_data,
	output wire [`INT32-1:0] rB_data
);

	
	
	reg	[`INT32-1:0]	reg_0;
	reg	[`INT32-1:0]	reg_1;
	reg	[`INT32-1:0]	reg_2;
	reg	[`INT32-1:0]	reg_3;
	reg	[`INT32-1:0]	reg_4;
	reg	[`INT32-1:0]	reg_5;
	reg	[`INT32-1:0]	reg_6;
	reg	[`INT32-1:0]	reg_7;
	reg	[`INT32-1:0]	reg_8;
	reg	[`INT32-1:0]	reg_9;
	reg	[`INT32-1:0]	reg_10;
	reg	[`INT32-1:0]	reg_11;
	reg	[`INT32-1:0]	reg_12;
	reg	[`INT32-1:0]	reg_13;
	reg	[`INT32-1:0]	reg_14;
	reg	[`INT32-1:0]	reg_15;
	reg	[`INT32-1:0]	reg_16;
	reg	[`INT32-1:0]	reg_17;
	reg	[`INT32-1:0]	reg_18;
	reg	[`INT32-1:0]	reg_19;
	reg	[`INT32-1:0]	reg_20;
	reg	[`INT32-1:0]	reg_21;
	reg	[`INT32-1:0]	reg_22;
	reg	[`INT32-1:0]	reg_23;
	reg	[`INT32-1:0]	reg_24;
	reg	[`INT32-1:0]	reg_25;
	reg	[`INT32-1:0]	reg_26;
	reg	[`INT32-1:0]	reg_27;
	reg	[`INT32-1:0]	reg_28;
	reg	[`INT32-1:0]	reg_29;
	reg	[`INT32-1:0]	reg_30;
	reg	[`INT32-1:0]	reg_31;
	
	
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
								(rA_addr == 5'b11111) ? reg_31 : 32'dx;
	
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
								(rB_addr == 5'b11111) ? reg_31 : 32'dx;
	
	//write
	always @(posedge clk or posedge reset)
		if(reset)
			reg_0	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00000))
				reg_0	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_1	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00001))
				reg_1	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_2	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00010))
				reg_2	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_3	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00011))
				reg_3	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_4	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00100))
				reg_4	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_5	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00101))
				reg_5	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_6	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00110))
				reg_6	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_7	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b00111))
				reg_7	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_8	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01000))
				reg_8	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_9	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01001))
				reg_9	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_10	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01010))
				reg_10	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_11	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01011))
				reg_11	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_12	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01100))
				reg_12	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_13	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01101))
				reg_13	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_14	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01110))
				reg_14	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_15	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b01111))
				reg_15	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_16	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10000))
				reg_16	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_17	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10001))
				reg_17	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_18	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10010))
				reg_18	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_19	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10011))
				reg_19	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_20	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10100))
				reg_20	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_21	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10101))
				reg_21	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_22	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10110))
				reg_22	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_23	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b10111))
				reg_23	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_24	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11000))
				reg_24	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_25	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11001))
				reg_25	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_26	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11010))
				reg_26	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_27	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11011))
				reg_27	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_28	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11100))
				reg_28	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_29	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11101))
				reg_29	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_30	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11110))
				reg_30	<=	write_data;
	
	always @(posedge clk or posedge reset)
		if(reset)
			reg_31	<=	'd0;
		else
			if(reg_write && (rD_addr == 5'b11111))
				reg_31	<=	write_data;
	
	
	
endmodule
