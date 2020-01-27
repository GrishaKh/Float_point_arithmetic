`include "configuration.v"

module extender
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    mantis,
    type_number,
    mantis_out
);

parameter [2:0] NORMAL = 3'b011;

// Inputs
input [MANTIS_SIZE-1:0] mantis;
input [2:0]             type_number;

// Outputs
output [(MANTIS_SIZE+3)-1:0] mantis_out;

// Assignments
assign mantis_out = type_number == NORMAL ? 
                    {1'b1, mantis, 2'b00} : 
                    {mantis, 3'b000};

endmodule // extender
