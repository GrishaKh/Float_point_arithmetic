module round (exp, mantis, operator, loss, mantis_out, exp_out);

input [7:0] exp;
input [25:0] mantis;
input loss;
input operator;
output [7:0] exp_out;
output [22:0] mantis_out;

wire [23:0] mantis_tmp;
wire carry;
wire [1:0] r_bits = mantis[1:0];
wire [25:0] mantis_shifted;
// wire r = r_bit & (mantis[1] | loss);
wire s = loss&(~operator) | ~loss&mantis[2];

assign exp_out = exp + carry;
// assign mantis_out = mantis_shifted[26:4];
assign mantis_out = |exp ? mantis_tmp[22:0] : mantis_tmp[23:1];

// assign {carry, mantis_tmp} = r ? operator ? mantis[24:1] - 1'b1 : mantis[24:1] + 1'b1 : mantis[24:1];

assign {carry, mantis_tmp} = (r_bits > 2'b10 || (r_bits == 2'b10 && s)) ?
                            mantis[25:2] + 1'b1 : mantis[25:2];


/*shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);*/

endmodule // round
