module normalize_fp(clk, en, number, ready, out);
	parameter WIDTH = 32;

	input clk, en;
	input [WIDTH-1:0] number;
	output [WIDTH-1:0] out;
	output reg ready;

	wire sign;
	reg [WIDTH-2:23] exp;
	reg [22:0] mantis;

	assign sign = number[WIDTH-1];
	assign out = {sign, exp, mantis};

	always @(posedge clk) begin
		if (en) begin
			exp <= number[WIDTH-2:23];
			mantis <= number[22:0];
			ready <= 1'b0;
		end
		else begin
			if ((mantis != {WIDTH{1'b0}}) && (mantis[22] == 1'b0) && ((exp - 1) >= {WIDTH-1{1'b0}})) begin
				mantis <= mantis << 1;
				exp <= exp - 1'b1;
			end else ready <= 1'b1;
		end
	end
endmodule
