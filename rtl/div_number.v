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
output                   sign;   // sign of the input number
output [EXP_SIZE   -1:0] exp;    // exponent of the input number
output [MANTIS_SIZE-1:0] mantis; // mantissa of the input number

// Assignments
assign {sign, exp, mantis} = number;

endmodule // div_number
