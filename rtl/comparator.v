`include "configuration.v"

module comparator
#(
    parameter SIZE = `EXP_SIZE
)
(
    in_A,
    in_B,
    out_code
);

// Inputs
input [SIZE-1:0] in_A; // comparable first data
input [SIZE-1:0] in_B; // comparable second data

//Outputs
output [1:0] out_code; // result of compare (equal(00), greate(01) or small(10))

// Local parameters
localparam [1:0] EQUAL = 2'b00;
localparam [1:0] GREAT = 2'b01;
localparam [1:0] SMALL = 2'b10;

assign out_code = (in_A == in_B) ? EQUAL: // compare and assign
                  (in_A <  in_B) ? GREAT:
                                   SMALL;

endmodule // comparator
