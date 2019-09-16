module comparator (in_A, in_B, out_code);
parameter SIZE = 8;

input [SIZE-1:0] in_A;
input [SIZE-1:0] in_B;
output out_code;

assign out_code = in_A >= in_B;

endmodule // comparator
