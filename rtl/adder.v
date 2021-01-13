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

// Inputs
input                       sign_A;   // sign of the first operand
input                       sign_B;   // sign of the second operand
input [ EXP_SIZE      -1:0] exp;      // exponent
input [(MANTIS_SIZE+3)-1:0] mantis_A; // mantissa of the first operand
input [(MANTIS_SIZE+3)-1:0] mantis_B; // mantissa of the second operand

// Outputs
output                       sign;       // sign of the result
output [ EXP_SIZE      -1:0] exp_out;    // unstandardized exponent of the result
output [(MANTIS_SIZE+3)-1:0] mantis_out; // unstandardized mantissa of the result
output                       loss;
output                       operator;   // add or sub

// Wires
wire                       carry;          // carry bit of the addition
wire [(MANTIS_SIZE+3)-1:0] mantis_sum;     // result of mantis_A + mantis_B or mantis_A - mantis_B
wire [(MANTIS_SIZE+3)-1:0] mantis_shifted; // if carry is 1: mantis shifted one step
wire [ EXP_SIZE      -1:0] exp_tmp;        // if carry is 1: exponent decrement

// Assignments
assign operator            = sign_A^sign_B;                  // detect operator
assign {carry, mantis_sum} = operator ? mantis_A - mantis_B: // if operator is minus(1): sub
                                        mantis_A + mantis_B; // else(0): add
assign sign    = sign_A;
assign exp_out = operator & ~|mantis_sum ? {EXP_SIZE{1'b0}} : exp_tmp;
assign mantis_out = carry ? {carry, mantis_shifted[(MANTIS_SIZE+3)-2:0]}:
                                           mantis_shifted;

// Instances
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


endmodule // adder
