module round (exp, mantis, mantis_out, exp_out);

input [7:0] exp;
input [27:0] mantis;
output [7:0] exp_out;
output [22:0] mantis_out;

wire [27:0] mantis_tmp;
wire carry;
wire r_bits = mantis[3:0];
wire [27:0] mantis_shifted;

assign mantis_out = mantis_shifted[26:4];
assign {carry, mantis_tmp} = mantis + mantis[3];

shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);

endmodule // round
