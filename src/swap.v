module swap (comp_code, in_A, in_B, out_great, out_small);
parameter SIZE = 28;

input comp_code;
input [SIZE-1:0] in_A, in_B;
output [SIZE-1:0] out_great, out_small;

assign out_great = comp_code ? in_A : in_B;
assign out_small = comp_code ? in_B : in_A;

endmodule // swap