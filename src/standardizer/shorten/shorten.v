module shorten (mantis, out);

input [27:0] mantis;
output [22:0] out;

assign out = mantis[26:4];
endmodule
