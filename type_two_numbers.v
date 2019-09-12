module type_two_numbers
(
    exp_A, exp_B,
    mantis_A, mantis_B,
    type_A, type_B
);

input [7:0] exp_A, exp_B;
input [22:0] mantis_A, mantis_B;
output [2:0] type_A, type_B;

type_detect __type_A
(
    .type(type_A),
    .exp(exp_A),
    .mantis(mantis_A)
);

type_detect __type_B
(
    .type(type_B),
    .exp(exp_B),
    .mantis(mantis_B)
);

endmodule
