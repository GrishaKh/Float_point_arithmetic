module adder (
    sign_A, sign_B,
    exp, sign,
    mantis_A, mantis_B,
    exp_out, mantis_out,
    operator_out
);

input sign_A, sign_B;
input [7:0] exp;
input [27:0] mantis_A, mantis_B;
output sign;
output [7:0] exp_out;
output [27:0] mantis_out;
output operator_out;

wire carry;
wire [27:0] mantis_sum, mantis_shifted;

assign operator_out = sign_A^sign_B;
assign {carry, mantis_sum} = operator_out ? mantis_A - mantis_B : mantis_A + mantis_B;
assign sign = sign_A;

shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis(mantis_sum),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);

assign mantis_out = carry ? {carry, mantis_shifted[26:0]} : mantis_shifted;


endmodule
