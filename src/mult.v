module mult
(
    sign_A, sign_B,
    exp_A, exp_B,
    mantis_A, mantis_B,
    sign, exp, mantis
);

input sign_A, sign_B;
input [7:0] exp_A, exp_B;
input [25:0] mantis_A, mantis_B;
output sign;
output [7:0] exp;
output [25:0] mantis;

wire [7:0] sum_exp = exp_A + exp_B;
wire [51:0] mult_mantis = mantis_A * mantis_B;

assign sign = sign_A ^ sign_B;
// assign exp = ~mult_mantis[49] ? mult_mantis[0] : sum_exp - 127 + mult_mantis[55];
assign mantis = mult_mantis[51:26];

endmodule
