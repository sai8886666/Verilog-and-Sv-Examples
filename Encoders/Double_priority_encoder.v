module double_priority;
// =========== signal declaration ==================//
	reg [7:0]in;
	reg [2:0]out;

	reg [2:0]temp_out;
	reg [7:0]temp_dout,temp_exout;

// ============ logic for encoder operation ============//

	always @(in) begin
		casex(in)
			8'b0000_0001 : temp_out = 3'd0;
			8'b0000_001x: temp_out = 3'd1;
			8'b0000_01xx: temp_out = 3'd2;
			8'b0000_1xxx : temp_out = 3'd3;
			8'b0001_xxxx : temp_out = 3'd4;
			8'b001x_xxxx : temp_out = 3'd5;
			8'b01xx_xxxx : temp_out = 3'd6;
			8'b1xxx_xxxx : temp_out = 3'd7;
		endcase
	end

// =============== logic for decoder =================//

	always @(temp_out) begin
		case(temp_out) 
			8'd0 : temp_dout = 8'd1;
			8'd1 : temp_dout = 8'd2;
			8'd2 : temp_dout = 8'd4;
			8'd3 : temp_dout = 8'd8;
			8'd4 : temp_dout = 8'd16;
			8'd5 : temp_dout = 8'd32;
			8'd6 : temp_dout = 8'd64;
			8'd7 : temp_dout = 8'd128;
		endcase
	end 
// ==================  ex-or operations ==============//

	assign temp_exout[0] = temp_dout[0]^in[0];
	assign temp_exout[1] = temp_dout[1]^in[1];
	assign temp_exout[2] = temp_dout[2]^in[2];
	assign temp_exout[3] = temp_dout[3]^in[3];
	assign temp_exout[4] = temp_dout[4]^in[4];
	assign temp_exout[5] = temp_dout[5]^in[5];
	assign temp_exout[6] = temp_dout[6]^in[6];
	assign temp_exout[7] = temp_dout[7]^in[7];




// ============== logic for second encoder ================//

	always @(temp_exout) begin
		casex(temp_exout)
			8'b0000_0001 : out = 3'd0;
			8'b0000_001x : out = 3'd1;
			8'b0000_01xx : out = 3'd2;
			8'b0000_1xxx : out = 3'd3;
			8'b0001_xxxx : out = 3'd4;
			8'b001x_xxxx : out = 3'd5;
			8'b01xx_xxxx : out = 3'd6;
			8'b1xxx_xxxx : out = 3'd7;
		endcase
	end


// =================== stimulus passing ======================

	initial begin
		in = 8'd130;
	#12 in = 8'd36;
	end

	initial begin
		$monitor("in = %b_%b   out = %d   temp_out = %b  temp_dout = %b  temp_e_out = %b ",in[7:4],in[3:0],out,temp_out,temp_dout,temp_exout);
	end

endmodule
