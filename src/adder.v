module adder
(
    sign_A,
    sign_B,
    exp,
    mantis_A,
    mantis_B,
    sign,
    exp_out,
    mantis_out,
    loss,
    operator
);

input        sign_A;
input        sign_B;
input [7:0]  exp;
input [25:0] mantis_A;
input [25:0] mantis_B;

output        sign;
output [7:0]  exp_out;
output [25:0] mantis_out;
output        loss;
output        operator;

wire        carry;
wire [25:0] mantis_sum;
wire [25:0] mantis_shifted;
wire [7:0]  exp_tmp;

assign operator            = sign_A^sign_B;
assign {carry, mantis_sum} = operator ? mantis_A - mantis_B:
                                        mantis_A + mantis_B;
assign sign    = sign_A;
assign exp_out = operator & ~|mantis_sum ? 8'h00 : exp_tmp;

shifter
#(
    .DIRECTION(1)
)
__shifter
(
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis(mantis_sum),
    .exp_out (exp_tmp),
    .mantis_out (mantis_shifted),
    .loss (loss)
);

assign mantis_out = carry ? {carry, mantis_shifted[24:0]}:
                                           mantis_shifted;


endmodule // adder
