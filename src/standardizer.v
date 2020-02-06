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
input [ EXP_SIZE      -1:0] exp_in;      // input exponent
input [(MANTIS_SIZE+3)-1:0] mantis_in;   // input mantissa
input                       loss;        // lost detector
input                       operator_in; // input operator (+ or -)

// Outputs
output [EXP_SIZE   -1:0] exp_out;    // exponent output
output [MANTIS_SIZE-1:0] mantis_out; // mantissa output

//Wires
wire [ EXP_SIZE      -1:0] exp_norm;    // normalized exponent
wire [(MANTIS_SIZE+3)-1:0] mantis_norm; // normalized mantissa

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
