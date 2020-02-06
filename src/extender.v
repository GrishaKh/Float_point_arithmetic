`include "configuration.v"

module extender
#(
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    mantis,
    type_number,
    mantis_out
);

// Inputs
input [MANTIS_SIZE-1:0] mantis;      // extendable mantissa
input [2:0]             type_number; // type of the extendable number

// Outputs
output [(MANTIS_SIZE+3)-1:0] mantis_out; // extended mantissa

// Local parameters
localparam [2:0] NORMAL = 3'b011;

// Assignments
assign mantis_out = type_number == NORMAL ? // extend mantissa depending on type of the number
                    {1'b1, mantis, 2'b00} : // if type is normal
                    {mantis, 3'b000};       // if type is subnormal

endmodule // extender
