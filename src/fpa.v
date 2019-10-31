module fpa (number_A, number_B, operator, number_out);

input [31:0] number_A, number_B;
input operator;
output [31:0] number_out;

wire sign_of_great, sign_of_small;
wire [7:0] exp_A, exp_B, exp_mantis;
wire [7:0] exp_preadder, exp_out;
wire [27:0] ext_mantis_A, ext_mantis_B;
wire [27:0] mantis_great, mantis_small;
wire [22:0] mantis_A, mantis_B, mantis_out;
wire [2:0] type_A, type_B;
wire special_case;
wire [31:0] special_result;
wire [1:0] loss_preadder;
wire loss_adder;
wire operator_adder;

wire sign_mult, sign_adder;
wire [7:0] exp_mult, exp_adder;
wire [27:0] mantis_mult, mantis_adder;

wire sign_out = operator ? sign_mult : sign_adder;
wire [7:0] exp_tmp = operator ? exp_mult : exp_adder;
wire [27:0] mantis_tmp = operator ? mantis_mult : mantis_adder;

assign number_out = special_case & ~operator ? special_result : {sign_out, exp_out, mantis_out};

init_number __number_A
(
    .number (number_A),
    .sign (sign_A),
    .exp (exp_A),
    .mantis (mantis_A),
    .ext_mantis (ext_mantis_A),
    .type (type_A)
);

init_number __number_B
(
    .number (number_B),
    .sign (sign_B),
    .exp (exp_B),
    .mantis (mantis_B),
    .ext_mantis (ext_mantis_B),
    .type (type_B)
);

preadder __preadder (
    .sign_A (sign_A),
    .sign_B (sign_B),
    .exp_A (exp_A),
    .exp_B (exp_B),
    .mantis_A (ext_mantis_A),
    .mantis_B (ext_mantis_B),
    .sign_of_great (sign_of_great),
    .sign_of_small (sign_of_small),
    .exp (exp_preadder),
    .mantis_great (mantis_great),
    .mantis_small (mantis_small),
    .loss (loss_preadder)
);

special_cases __special_cases
(
    .sign_A (sign_A),
    .sign_B (sign_B),
    .exp_A (exp_A),
    .exp_B (exp_B),
    .mantis_A (mantis_A),
    .mantis_B (mantis_B),
    .type_A (type_A),
    .type_B (type_B),
    .result (special_result),
    .special_case (special_case)
);

adder __adder (
    .sign_A (sign_of_great),
    .sign_B (sign_of_small),
    .exp (exp_preadder),
    .mantis_A (mantis_great),
    .mantis_B (mantis_small),
    .sign (sign_adder),
    .exp_out (exp_adder),
    .mantis_out (mantis_adder),
    .loss (loss_adder),
    .operator(operator_adder)
);

mult __mult (
    .sign_A (sign_A),
    .sign_B (sign_B),
    .exp_A (exp_A),
    .exp_B (exp_B),
    .mantis_A (ext_mantis_A),
    .mantis_B (ext_mantis_B),
    .sign (sign_mult),
    .exp (exp_mult),
    .mantis (mantis_mult)
);

standardizer __standardizer (
    .exp_in (exp_tmp),
    .mantis_in (mantis_tmp),
    .sign_in (sign_out),
    .operator_in (operator_adder),
    .exp_out (exp_out),
    .mantis_out (mantis_out),
    .loss ({loss_preadder[1] | loss_adder, loss_preadder[0]})
);

endmodule
