primitive mantis_swap_detect (swap, shift_code, s_A, s_B, m_code_1, m_code_0);

output swap;
input shift_code, s_A, s_B, m_code_1, m_code_0;

table
//  shift_code  s_A     s_B     m_code_1    m_code_0    :   swap
    ?           ?       ?       0           1           :   1;
    ?           ?       ?       1           0           :   0;
    ?           ?       ?       1           1           :   x;
    ?           0       0       0           0           :   0;
    ?           1       1       0           0           :   0;
    0           0       1       0           0           :   0;
    0           1       0       0           0           :   1;
    1           0       1       0           0           :   1;
    1           1       0       0           0           :   0;
endtable

endprimitive

module init_number (
    sign_A, sign_B,
    exp_A, exp_B,
    mantis_A, mantis_B,
    sign_of_great, sign_of_small, exp, 
    mantis_great, mantis_small, loss
);

input sign_A, sign_B;
input [7:0] exp_A, exp_B;
input [27:0] mantis_A, mantis_B;
output sign_of_great, sign_of_small;
output [7:0] exp;
output [27:0] mantis_great, mantis_small;
output [1:0] loss;

wire [27:0] mantis_shift, mantis_nonshift;
wire [27:0] mantis_shifted;
wire [7:0] exp_shift;
wire [1:0] code_exp, code_mantis;
wire mantis_swap_code;
wire shift_select_code = ~code_exp[1]&code_exp[0];

assign loss[0] = code_mantis[1];

comparator __comparator_exp (
    .in_A (exp_A),
    .in_B (exp_B),
    .out_code (code_exp)
);

shift_selector __shift_selector (
    .comp_code (shift_select_code),
    .exp_A (exp_A),
    .exp_B (exp_B),
    .mantis_A (mantis_A),
    .mantis_B (mantis_B),
    .mantis_shift (mantis_shift),
    .mantis_out (mantis_nonshift),
    .exp_shift (exp_shift),
    .exp_out (exp)
);

shifter #(.MODE(1), .DIRECTION(1)) __shifter (
    .exp (exp_shift),
    .mantis (mantis_shift),
    .exp_target_or_diff (exp),
    .mantis_out (mantis_shifted),
    .loss (loss[1]),
    .exp_out ()
);

comparator #(.SIZE(28)) __comparator_mantis (
    .in_A (mantis_shifted),
    .in_B (mantis_nonshift),
    .out_code(code_mantis)
);

mantis_swap_detect __mantis_swap_code
(   mantis_swap_code,
    shift_select_code,
    sign_A,
    sign_B,
    code_mantis[1],
    code_mantis[0]
);

swap __swap_mantis (
    .swap_code (mantis_swap_code),
    .in_A (mantis_shifted),
    .in_B (mantis_nonshift),
    .out_great (mantis_great),
    .out_small (mantis_small)
);

swap #(.SIZE(1)) __swap_sign (
    .swap_code (shift_select_code^mantis_swap_code),
    .in_A (sign_A),
    .in_B (sign_B),
    .out_great (sign_of_great),
    .out_small (sign_of_small)
);

endmodule // init_number
