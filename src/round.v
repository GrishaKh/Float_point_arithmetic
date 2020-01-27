`include "configuration.v"

module round
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    exp,
    mantis,
    operator,
    loss,
    mantis_out,
    exp_out
);

// Inputs
input [ EXP_SIZE      -1:0] exp;
input [(MANTIS_SIZE+3)-1:0] mantis;
input                       loss;
input                       operator;

//Outputs
output [EXP_SIZE   -1:0] exp_out;
output [MANTIS_SIZE-1:0] mantis_out;

// Wires
wire [MANTIS_SIZE:0] mantis_tmp;
wire                 carry;
wire [1:0]           r_bits;
wire                 s;
// wire [25:0] mantis_shifted;

// Assignments
assign r_bits     = mantis[1:0];
assign s          = loss&(~operator) | ~loss&mantis[2];
assign exp_out    = exp + carry;
assign mantis_out = |exp ? mantis_tmp[MANTIS_SIZE-1:0] : mantis_tmp[MANTIS_SIZE:1];

assign {carry, mantis_tmp} = (r_bits > 2'b10 || (r_bits == 2'b10 && s)) ?
                             mantis[(MANTIS_SIZE+3)-1:2] + 1'b1 : mantis[(MANTIS_SIZE+3)-1:2];


/*shifter #(.DIRECTION(1)) __shifter (
    .exp (exp),
    .exp_target_or_diff ({{7{1'b0}}, carry}),
    .mantis (mantis_tmp),
    .exp_out (exp_out),
    .mantis_out (mantis_shifted)
);*/

endmodule // round
