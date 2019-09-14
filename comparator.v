module comparator (in_a, in_b, out_code);
parameter SIZE = 8;

input [SIZE-1:0] in_a;
input [SIZE-1:0] in_b;
output out_code;

assign out_code = in_a >= in_b;

endmodule // comparator