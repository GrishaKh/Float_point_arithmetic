module sign_detect (
    sign_A, sign_B,
    mantis_A, mantis_B,
    comp_code_mantis, comp_code_exp,
    sign
);

input sign_A, sign_B;
input comp_code_mantis, comp_code_exp;
input [27:0] mantis_A, mantis_B;
output sign;

assign sign = (sign_A^sign_B) & (comp_code_mantis^comp_code_exp) ? sign_B : sign_A;

endmodule
