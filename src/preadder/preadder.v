module preadder (
    number_A, number_B,
    sign, exp,
    mantis_great, mantis_small,
    special_result, special_case
);

input [31:0] number_A, number_B;
output sign;
output [7:0] exp;
output [27:0] mantis_great, mantis_small;
output [31:0] special_result;
output special_case;

wire sign_A, sign_B;
wire [7:0] exp_A, exp_B;
wire [22:0] mantis_A, mantis_B;

wire [2:0] type_A, type_B;

div_number __number_A
(
    .number(number_A),
    .sign(sign_A),
    .exp(exp_A),
    .mantis(mantis_A)
);

div_number __number_B
(
    .number(number_B),
    .sign(sign_B),
    .exp(exp_B),
    .mantis(mantis_B)
);

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

special_cases __special_cases
(
    .sign_A(sign_A),
    .sign_B(sign_B),
    .exp_A(exp_A),
    .exp_B(exp_B),
    .mantis_A(mantis_A),
    .mantis_B(mantis_B),
    .type_A(type_A),
    .type_B(type_B),
    .result(special_result),
    .special_case(special_case)
);

init_number __init_number
(
    .sign_A (sign_A),
    .sign_B (sign_B),
    .exp_A(exp_A),
    .exp_B(exp_B),
    .mantis_A(mantis_A),
    .mantis_B(mantis_B),
    .type_A (type_A),
    .type_B(type_B),
    .sign (sign),
    .exp(exp),
    .mantis_great(mantis_great),
    .mantis_small(mantis_small)
);

endmodule // preadder
