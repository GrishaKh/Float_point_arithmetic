`include "configuration.v"

module div_number
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    number,
    sign,
    exp,
    mantis
);

// Inputs
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number;

// Outputs
output                   sign;
output [EXP_SIZE   -1:0] exp;
output [MANTIS_SIZE-1:0] mantis;

// Assignments
assign {sign, exp, mantis} = number;

endmodule // div_number
