module standardizer (
    exp_in, mantis_in,
    operator_in, loss,
    exp_out, mantis_out
);

input [7:0] exp_in;
input [25:0] mantis_in;
input loss;
input operator_in;
output [7:0] exp_out;
output [22:0] mantis_out;

wire [7:0] exp_norm;
wire [25:0] mantis_norm;

normalize __normalize (
    .exp_in (exp_in),
    .mantis_in (mantis_in),
    .exp_out (exp_norm),
    .mantis_out (mantis_norm)
);

/*assign exp_out = exp_norm;
assign mantis_out = mantis_norm[23:1];*/

round __round (
    .exp (exp_norm),
    .mantis (mantis_norm),
    .operator (operator_in),
    .loss (loss),
    .exp_out (exp_out),
    .mantis_out (mantis_out)
);

endmodule // standardizer
