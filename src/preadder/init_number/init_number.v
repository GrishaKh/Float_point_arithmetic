module init_number (
    sign_A, sign_B,
    exp_A, exp_B,
    mantis_A, mantis_B,
    type_A, type_B,
    sign, exp, 
    mantis_great, mantis_small
);

input sign_A, sign_B;
input [7:0] exp_A, exp_B;
input [22:0] mantis_A, mantis_B;
input [2:0] type_A, type_B;
output sign;
output [7:0] exp;
output [27:0] mantis_great, mantis_small;

wire [27:0] mantis_ext_A, mantis_ext_B;
wire [27:0] mantis_shift, mantis_nonshift;
wire [27:0] mantis_shifted;
wire [7:0] diff_exp, exp_shift;
wire code_exp, code_mantis;

extender __extender_A (
    .mantis (mantis_A),
    .type_number (type_A),
    .mantis_out (mantis_ext_A)
);

extender __extender_B (
    .mantis (mantis_B),
    .type_number (type_B),
    .mantis_out (mantis_ext_B)
);

comparator __comparator_exp (
    .in_A (exp_A),
    .in_B (exp_B),
    .out_code (code_exp)
);

shift_selector __shift_selector (
    .comp_code (code_exp),
    .exp_A (exp_A),
    .exp_B (exp_B),
    .mantis_A (mantis_ext_A),
    .mantis_B (mantis_ext_B),
    .mantis_shift (mantis_shift),
    .mantis_out (mantis_nonshift),
    .exp_shift (exp_shift),
    .exp_out (exp)
);

shifter #(.MODE(1)) __shifter (
    .exp (exp_shift),
    .mantis (mantis_shift),
    .exp_target_or_diff (exp),
    .mantis_out (mantis_shifted)
);

comparator #(.SIZE(28)) __comparator_mantis (
    .in_A (mantis_nonshift),
    .in_B (mantis_shifted),
    .out_code(code_mantis)
);

sign_detect __sign_detect (
    .sign_A (sign_A),
    .sign_B (sign_B),
    .mantis_A (mantis_nonshift),
    .mantis_B (mantis_shifted),
    .comp_code_mantis (code_mantis),
    .comp_code_exp (code_exp),
    .sign (sign)
);

swap __swap (
    .comp_code (code_mantis),
    .in_A (mantis_nonshift),
    .in_B (mantis_shifted),
    .out_great (mantis_great),
    .out_small (mantis_small)
);

endmodule // init_number
