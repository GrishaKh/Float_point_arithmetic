`include "configuration.v"

module adder
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
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

input                       sign_A;
input                       sign_B;
input [ EXP_SIZE      -1:0] exp;
input [(MANTIS_SIZE+3)-1:0] mantis_A;
input [(MANTIS_SIZE+3)-1:0] mantis_B;

output                       sign;
output [ EXP_SIZE      -1:0] exp_out;
output [(MANTIS_SIZE+3)-1:0] mantis_out;
output                       loss;
output                       operator;

wire                       carry;
wire [(MANTIS_SIZE+3)-1:0] mantis_sum;
wire [(MANTIS_SIZE+3)-1:0] mantis_shifted;
wire [ EXP_SIZE      -1:0] exp_tmp;

assign operator            = sign_A^sign_B;
assign {carry, mantis_sum} = operator ? mantis_A - mantis_B:
                                        mantis_A + mantis_B;
assign sign    = sign_A;
assign exp_out = operator & ~|mantis_sum ? {EXP_SIZE{1'b0}} : exp_tmp;

shifter
#(
    .DIRECTION(1)
)
__shifter
(
    .exp                (exp),
    .exp_target_or_diff ({{(EXP_SIZE-1){1'b0}}, carry}),
    .mantis             (mantis_sum),
    .exp_out            (exp_tmp),
    .mantis_out         (mantis_shifted),
    .loss               (loss)
);

assign mantis_out = carry ? {carry, mantis_shifted[(MANTIS_SIZE+3)-2:0]}:
                                           mantis_shifted;


endmodule // adder
