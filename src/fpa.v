module fpa (number_A, number_B, sign, exp, mantis);

input [31:0] number_A, number_B;
output sign;
output [7:0] exp;
output [22:0] mantis;

wire sign_of_great, sign_of_small, sign_out;
wire [7:0] exp_preadder, exp_tmp, exp_out;
wire [27:0] mantis_great, mantis_small, mantis_tmp;
wire [22:0] mantis_out;
wire special_case;
wire [31:0] special_result;

assign {sign, exp, mantis} = special_case ? special_result : {sign_out, exp_out, mantis_out};

preadder __preadder (
    .number_A (number_A),
    .number_B (number_B),
    .sign_of_great (sign_of_great),
    .sign_of_small (sign_of_small),
    .exp (exp_preadder),
    .mantis_great (mantis_great),
    .mantis_small (mantis_small),
    .special_case (special_case),
    .special_result (special_result)
);

adder __adder (
    .sign_A (sign_of_great),
    .sign_B (sign_of_small),
    .exp (exp_preadder),
    .sign (sign_out),
    .mantis_A (mantis_great),
    .mantis_B (mantis_small),
    .exp_out (exp_tmp),
    .mantis_out (mantis_tmp)
);

standardizer __standardizer (
    .exp_in (exp_tmp),
    .mantis_in (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_out)
);

endmodule
