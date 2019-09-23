module round (exp, mantis, operator, mantis_out, exp_out);

input [7:0] exp;
input [27:0] mantis;
input operator; // 0:+ ; 1:-
output [7:0] exp_out;
output [22:0] mantis_out;

wire [22:0] mantis_tmp;
wire carry;
wire [3:0] r_bits = mantis[3:0];
wire [27:0] mantis_shifted;

assign exp_out = exp;
//assign mantis_out = mantis_shifted[26:4];
assign mantis_out = mantis_tmp;

//assign {carry, mantis_tmp} = mantis[3:0] > 4'b1000 || (mantis[3:0] == 4'b1000 && !operator)? 
//				mantis[26:4] + mantis[3] : mantis[26:4];

//assign {carry, mantis_tmp} = r_bits > 4'b1000 || (r_bits == 4'b1000 && ^mantis[26:4] && !mantis[4])?
//				mantis[26:4] + mantis[3] : mantis[26:4];
assign mantis_tmp = r_bits >= 4'b1000 ? mantis[26:4] + 1 : mantis[26:4];
/*shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);*/

endmodule // round
