module fpa (number_A, number_B, number_out);

input [31:0] number_A, number_B;
output [31:0] number_out;

wire sign_of_great, sign_of_small, sign_out;
wire [7:0] exp_preadder, exp_tmp, exp_out;
wire [27:0] mantis_great, mantis_small, mantis_tmp;
wire [22:0] mantis_out;
wire special_case;
wire [31:0] special_result;
wire [1:0] loss_preadder;
wire loss_adder;
wire operator;

assign number_out = special_case ? special_result : {sign_out, exp_out, mantis_out};

preadder __preadder (
    .number_A (number_A),
    .number_B (number_B),
    .sign_of_great (sign_of_great),
    .sign_of_small (sign_of_small),
    .exp (exp_preadder),
    .mantis_great (mantis_great),
    .mantis_small (mantis_small),
    .special_case (special_case),
    .special_result (special_result),
    .loss (loss_preadder)
);

adder __adder (
    .sign_A (sign_of_great),
    .sign_B (sign_of_small),
    .exp (exp_preadder),
    .sign (sign_out),
    .mantis_A (mantis_great),
    .mantis_B (mantis_small),
    .exp_out (exp_tmp),
    .mantis_out (mantis_tmp),
    .loss (loss_adder),
    .operator(operator)
);

standardizer __standardizer (
    .exp_in (exp_tmp),
    .mantis_in (mantis_tmp),
    .sign_in (sign_out),
    .operator_in (operator),
    .exp_out (exp_out),
    .mantis_out (mantis_out),
    .loss ({loss_preadder[1] | loss_adder, loss_preadder[0]})
);

endmodule
