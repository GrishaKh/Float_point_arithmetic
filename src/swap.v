`include "configuration.v"

module swap
#(
    parameter SIZE = `MANTIS_SIZE+3
)
(
    swap_code,
    in_A,
    in_B,
    out_great,
    out_small
);

// Inputs
input            swap_code;
input [SIZE-1:0] in_A;
input [SIZE-1:0] in_B;

// Outputs
output [SIZE-1:0] out_great;
output [SIZE-1:0] out_small;

// Assigments
assign out_great = swap_code ? in_B : in_A;
assign out_small = swap_code ? in_A : in_B;

endmodule // swap
