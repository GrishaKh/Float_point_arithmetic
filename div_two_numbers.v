module div_two_numbers
(
    A, B,
    sign_a, sign_b,
    exp_a, exp_b,
    mantis_a, mantis_b
);

input [31:0] A, B;
output sign_a, sign_b;
output [7:0] exp_a, exp_b;
output [23:0] mantis_a, mantis_b;

div_number __number_A
(
    .number(A),
    .sign(sign_a),
    .exp(exp_a),
    .mantis(mantis_a)
);

div_number __number_B
(
    .number(B),
    .sign(sign_b),
    .exp(exp_b),
    .mantis(mantis_b)
);

endmodule
