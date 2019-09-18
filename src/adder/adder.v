module adder (
    sign_A, sign_B,
    exp, sign
    mantis_A, mantis_B,
    exp_out, mantis_out,
);

input sign_A, sign_B;
input [7:0] exp;
input [27:0] mantis_A, mantis_B;
output sign;
output [7:0] exp_out;
output [27:0] mantis_out;

wire carry;
wire [27:0] mantis_tmp;

assign {carry, mantis_tmp} = mantis_A + -1*(sign_A^sign_B)*mantis_B;
assign sign = sign_A;

shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis(mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_out)
);

endmodule
