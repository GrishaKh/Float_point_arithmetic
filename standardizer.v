module standardizer (
    exp_in, mantis_in,
    operator_in,
    exp_out, mantis_out
);

input [7:0] exp_in;
input [27:0] mantis_in;
input operator_in;
output [7:0] exp_out;
output [22:0] mantis_out;

wire [7:0] exp_norm;
wire [27:0] mantis_norm;

normalize __normalize (
    .exp_in (exp_in),
    .mantis_in (mantis_in),
    .exp_out (exp_norm),
    .mantis_out (mantis_norm)
);

round __round (
    .exp (exp_norm),
    .mantis (mantis_norm),
    .operator (operator_in),
    .exp_out (exp_out),
    .mantis_out (mantis_out)
);

endmodule // standardizer
