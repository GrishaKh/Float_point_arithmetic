`include "configuration.v"

module standardizer
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    exp_in,
    mantis_in,
    operator_in,
    loss,
    exp_out,
    mantis_out
);

// Inputs
input [ EXP_SIZE      -1:0] exp_in;
input [(MANTIS_SIZE+3)-1:0] mantis_in;
input                       loss;
input                       operator_in;

// Outputs
output [EXP_SIZE   -1:0] exp_out;
output [MANTIS_SIZE-1:0] mantis_out;

//Wires
wire [ EXP_SIZE      -1:0] exp_norm;
wire [(MANTIS_SIZE+3)-1:0] mantis_norm;

// Instances
normalize __normalize
(
    .exp_in     (exp_in),
    .mantis_in  (mantis_in),
    .exp_out    (exp_norm),
    .mantis_out (mantis_norm)
);

round __round
(
    .exp        (exp_norm),
    .mantis     (mantis_norm),
    .operator   (operator_in),
    .loss       (loss),
    .exp_out    (exp_out),
    .mantis_out (mantis_out)
);

endmodule // standardizer
