module swap (comp_code, in_a, in_b, out_great, out_small);
parameter SIZE_IN = 28;

input comp_code;
input [SIZE_IN-1:0] in_a, in_b;
output [SIZE_IN-1:0] out_great, out_small;

assign out_great = comp_code ? in_a : in_b;
assign out_small = comp_code ? in_b : in_a;

endmodule // swap