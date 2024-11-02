`include "def.v"

`define	IDLE	2'b00
`define	EN_IN	2'b01
`define	DIS_IN	2'b10

//
`define	UNDER	2'b01
`define	SAME	2'b10

`define delay_to_result	4	//len = 8, 5

module PE_C (
	input	clk,
	input	reset,
	
	//from dec
	input	conv_en,
	input	wire	[2:0]	stride_cycle,
	input	force_wb,	//forcing write_back
	
	//from buff
	input	buff_full,
	
	//to PE
	output	out_accum,
	//to PE, buff
	output	out_en,
	
	//to pp
	output	reg	wb_en
	
	//tb
);
	
	//PE state
	reg	[1:0]	curr_state;
	reg	[1:0]	next_state;
	assign	curr_s = curr_state;
	
	//Stride state
	reg	[1:0]	curr_strd;
	reg	[1:0]	next_strd;
	
	
	//total process count(0 ~ )
	reg	unsigned	[5:0]	proc_cnt;
	
	//last input ~ idle	(0 ~ 7 : negedge conv_en )
	reg	[3:0]	idle_cnt;
	
	
	//the number of filter vectors (3x3 => 1, 5x5 => 2, 7x7 => 4, ...15x15 => 15, ...)
	reg	[2:0]	stride_cnt;
	
	wire			p_out_en	= (curr_strd == `SAME) ? 1'b1 : 1'b0;
	assign		out_en = p_out_en;
	
	reg			accum;
	assign		out_accum = accum;
	
	always @ (posedge clk or posedge reset)
		if(reset)
			proc_cnt <=	5'dx;
		else
//			if(curr_state == `IDLE)	proc_cnt <= 5'd1;
			if(curr_state == `IDLE)
				proc_cnt <= 5'd1;
			
			/////////////////////////////////////////////////////////
			else if((curr_state == `DIS_IN) && (next_state == `EN_IN))
				proc_cnt <= 5'd1;
			/////////////////////////////////////////////////////////
			
			else
				proc_cnt <= proc_cnt + 1;
	
	
	//
	//STATE_LOGIC
	//
	always @ (posedge clk or posedge reset)
		if(reset)	curr_state <= `IDLE;
		else	curr_state <= next_state;
	
	always @ (posedge clk or posedge reset)
		if(reset)
			begin
			next_state	= `IDLE;
			idle_cnt		= 4'dx;
			end
		else
			casex(curr_state)
				`IDLE:begin
					idle_cnt		= 4'd1;
					if(conv_en)
						next_state	= `EN_IN;
					else
						next_state	= `IDLE;
					end
				`EN_IN:begin
					idle_cnt = 4'd1;
					if(conv_en)
						next_state	= `EN_IN;
					else
						next_state	= `DIS_IN;
					end
					
				`DIS_IN:begin
					if(conv_en) begin
						next_state = `EN_IN;
						idle_cnt = 4'd1;
						end
					else if(idle_cnt < `delay_to_result-2) begin//-2 to be IDLE earlier
						idle_cnt		= idle_cnt + 1;
						next_state	= `DIS_IN;
						end
					else begin
						next_state	= `IDLE;
						end
					end
	
			endcase
	
	
	
	//
	//STRIDE LOGIC
	//Throught to generating accum signal, control accumulation value.
	//
	always @ (posedge clk or posedge reset)
		if(reset)	curr_strd	= `IDLE;
		else			curr_strd	= next_strd;
	
	always @ (proc_cnt) begin
		if(reset) begin
			next_strd	= `IDLE;
			stride_cnt	= 4'd1;
			accum			= 1'b0;
			end
		casex(curr_strd)
			`IDLE:begin									//
				accum = accum;
				stride_cnt = stride_cnt;
				if(proc_cnt >= `delay_to_result)	//when convolution is working and result value is being generated.
					if(stride_cnt < stride_cycle)		//when a patch is on process.
						next_strd = `UNDER;
					else
						next_strd = `SAME;				//when a patch is fully processed in this clk.
				else
					next_strd = curr_strd;			//when convolution is working but result value is not generated.
				end
			`UNDER:begin
				accum = 1'b1;
				stride_cnt = stride_cnt + 1;
				if(curr_state == `IDLE)
					next_strd = `IDLE;
				else if(stride_cnt >= stride_cycle)
					next_strd = `SAME;
					else
					next_strd = `UNDER;
				end
			`SAME:begin
				accum = 1'b0;
				stride_cnt = 'd1;
				if(curr_state == `IDLE)
					next_strd = `IDLE;
				else if (stride_cnt >= stride_cycle)
					next_strd = `SAME;
				else
					next_strd = `UNDER;
					
				end
		endcase
		end
endmodule
