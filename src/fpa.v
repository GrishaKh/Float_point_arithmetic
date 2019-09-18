module fpa (number_A, number_B, sign, exp, mantis);

input [31:0] number_A, number_B;
output sign;
output [7:0] exp;
output [27:0] mantis;

wire [7:0] exp_preadder;
wire [27:0] mantis_great, mantis_small;

preadder __preadder (
    .number_A (number_A),
    .number_B (number_B),
    .sign (sign),
    .exp (exp_preadder),
    .mantis_great (mantis_great),
    .mantis_small (mantis_small)
);

adder __adder (
    .exp (exp_preadder),
    .mantis_A (mantis_great),
    .mantis_B (mantis_small),
    .exp_out (exp),
    .mantis_out (mantis)
);

endmodule
