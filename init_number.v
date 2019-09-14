module init_number (
    exp_a, exp_b,
    mantis_a, mantis_b,
    type_a, type_b,
    exp, mantis_great, mantis_small
);

input [7:0] exp_a, exp_b;
input [27:0] mantis_a, mantis_b;
input [2:0] type_a, type_b;
output [7:0] exp;
output [27:0] mantis_great, mantis_small;

wire [27:0] mantis_ext_a, mantis_ext_b;
wire [27:0] mantis_shift, mantis_nonshift;
wire [27:0] mantis_shifted;
wire [7:0] diff_exp, exp_shift;
wire code_exp, code_mantis;

extender __extender_a (
    .mantis (mantis_a),
    .type (type_a),
    .mantis_out (mantis_ext_a)
);

extender __extender_b (
    .mantis (mantis_b),
    .type (type_b),
    .mantis_out (mantis_ext_b)
);

comparator __comparator_exp (
    .in_a (exp_a),
    .in_b (exp_b),
    .out_code (code_exp)
);

shift_selector __shift_selector (
    .comp_code (code_exp),
    .exp_a (exp_a),
    .exp_b (exp_b),
    .mantis_a (mantis_ext_a),
    .mantis_b (mantis_ext_b),
    .mantis_shift (mantis_shift),
    .mantis_out (mantis_nonshift),
    .exp_shift (exp_shift),
    .diff_exp (diff_exp)
);

shifter __shifter (
    .exp (exp_shift),
    .mantis (mantis_shift),
    .shift_number (diff_exp),
    .exp_out (exp),
    .mantis_out (mantis_shifted)
);

comparator #(.SIZE(28)) __comparator_mantis (
    .in_a (mantis_nonshift),
    .in_b (mantis_shifted),
    .out_code(code_mantis)
);

swap __swap (
    .comp_code (code_mantis),
    .in_a (mantis_nonshift),
    .in_b (mantis_shifted),
    .out_great (mantis_great),
    .out_small (mantis_small)
);

endmodule // init_number