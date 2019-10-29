module round (exp, mantis, sign, operator, loss, mantis_out, exp_out);

input sign;
input [7:0] exp;
input [27:0] mantis;
input [1:0] loss;
input operator;
output [7:0] exp_out;
output [22:0] mantis_out;

wire [23:0] mantis_tmp;
wire carry;
wire [3:0] r_bits = mantis[3:0];
wire [27:0] mantis_shifted;
wire s = loss[1]&(loss[0] | ~operator) | ~loss[1]&mantis[4];

assign exp_out = exp + carry;
// assign mantis_out = mantis_shifted[26:4];
assign mantis_out = |exp ? mantis_tmp[22:0] : mantis_tmp[23:1];

assign {carry, mantis_tmp} = (r_bits > 4'b1000 || (r_bits == 4'b1000 && s)) ?
			mantis[27:4] + 1'b1 : mantis[27:4];


/* shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);*/

endmodule // round
