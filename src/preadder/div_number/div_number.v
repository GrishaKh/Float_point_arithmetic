module div_number (number, sign, exp, mantis);

input [31:0] number;
output sign;
output [7:0] exp;
output [22:0] mantis;

assign {sign, exp, mantis} = number;

endmodule
