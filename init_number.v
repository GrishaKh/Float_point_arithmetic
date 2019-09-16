module init_number (
    exp_A, exp_B,
    mantis_A, mantis_B,
    type_A, type_B,
    exp, mantis_great, mantis_small
);

input [7:0] exp_A, exp_B;
input [27:0] mantis_A, mantis_B;
input [2:0] type_A, type_B;
output [7:0] exp;
output [27:0] mantis_great, mantis_small;

wire [27:0] mantis_ext_a, mantis_ext_b;
wire [27:0] mantis_shift, mantis_nonshift;
wire [27:0] mantis_shifted;
wire [7:0] diff_exp, exp_shift;
wire code_exp, code_mantis;

extender __extender_A (
    .mantis (mantis_A),
    .type (type_A),
    .mantis_out (mantis_ext_A)
);

extender __extender_B (
    .mantis (mantis_B),
    .type (type_B),
    .mantis_out (mantis_ext_B)
);

comparator __comparator_exp (
    .in_a (exp_A),
    .in_b (exp_B),
    .out_code (code_exp)
);

shift_selector __shift_selector (
    .comp_code (code_exp),
    .exp_a (exp_A),
    .exp_b (exp_B),
    .mantis_a (mantis_ext_A),
    .mantis_b (mantis_ext_B),
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
    .in_A (mantis_nonshift),
    .in_B (mantis_shifted),
    .out_code(code_mantis)
);

swap __swap (
    .comp_code (code_mantis),
    .in_A (mantis_nonshift),
    .in_B (mantis_shifted),
    .out_great (mantis_great),
    .out_small (mantis_small)
);

endmodule // init_number
