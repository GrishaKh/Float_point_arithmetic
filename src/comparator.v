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

input [SIZE-1:0] in_A;
input [SIZE-1:0] in_B;

output [1:0] out_code;

parameter [1:0] EQUAL = 2'b00;
parameter [1:0] GREAT = 2'b01;
parameter [1:0] SMALL = 2'b10;

assign out_code = (in_A == in_B) ? EQUAL:
                  (in_A <  in_B) ? GREAT:
                                   SMALL;

endmodule // comparator
