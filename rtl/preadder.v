`include "configuration.v"

primitive mantis_swap_detect (swap, shift_code, s_A, s_B, m_code_1, m_code_0);

output swap;
input  shift_code, s_A, s_B, m_code_1, m_code_0;

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

endprimitive // mantis_swap_detect

module preadder
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    sign_A,
    sign_B,
    exp_A,
    exp_B,
    mantis_A,
    mantis_B,
    sign_of_great,
    sign_of_small,
    exp, 
    mantis_great,
    mantis_small,
    loss
);

// Inputs
input                       sign_A;   // sign of the first operand
input                       sign_B;   // sign of the second operand
input [ EXP_SIZE      -1:0] exp_A;    // exponent of the first operand
input [ EXP_SIZE      -1:0] exp_B;    // exponent of the second operand
input [(MANTIS_SIZE+3)-1:0] mantis_A; // mantissa of the first operand
input [(MANTIS_SIZE+3)-1:0] mantis_B; // mantissa of the second operand

// Outputs
output                       sign_of_great; // sign of the great number
output                       sign_of_small; // sign of the small number
output [ EXP_SIZE      -1:0] exp;           // exponent
output [(MANTIS_SIZE+3)-1:0] mantis_great;  // grater mantissa
output [(MANTIS_SIZE+3)-1:0] mantis_small;  // smaller mantissa
output                       loss;          // loss preadder

// Wires
wire [(MANTIS_SIZE+3)-1:0] mantis_shift;      // mantissa, which must be shifted
wire [(MANTIS_SIZE+3)-1:0] mantis_nonshift;   // mantissa, which should not be shifted
wire [(MANTIS_SIZE+3)-1:0] mantis_shifted;    // shifted mantissa
wire [ EXP_SIZE      -1:0] exp_shift;         // exponent that belongs to the shiftable mantis
wire [1:0]                 code_exp;          // comparator output that compares the exponents
wire [1:0]                 code_mantis;       // comparator output that compares shiftable and nonshiftable manitisses
wire                       mantis_swap_code;  // mantissa swap detector output
wire                       shift_select_code; // output of the shift selector

// Assignments
assign shift_select_code = code_exp[1]&(~code_exp[0]);

// Instances
comparator __comparator_exp
(
    .in_A     (exp_A),
    .in_B     (exp_B),
    .out_code (code_exp)
);

shift_selector __shift_selector
(
    .comp_code    (shift_select_code),
    .exp_A        (exp_A),
    .exp_B        (exp_B),
    .mantis_A     (mantis_A),
    .mantis_B     (mantis_B),
    .mantis_shift (mantis_shift),
    .mantis_out   (mantis_nonshift),
    .exp_shift    (exp_shift),
    .exp_out      (exp)
);

shifter
#(
    .MODE(1),
    .DIRECTION(1)
)
__shifter
(
    .exp                (exp_shift),
    .mantis             (mantis_shift),
    .exp_target_or_diff (exp),
    .mantis_out         (mantis_shifted),
    .loss               (loss),
    .exp_out            ()
);

comparator
#(
    .SIZE(MANTIS_SIZE+3)
)
__comparator_mantis
(
    .in_A     (mantis_shifted),
    .in_B     (mantis_nonshift),
    .out_code (code_mantis)
);

mantis_swap_detect __mantis_swap_code
(
    mantis_swap_code,
    shift_select_code,
    sign_A,
    sign_B,
    code_mantis[1],
    code_mantis[0]
);

swap __swap_mantis
(
    .swap_code (mantis_swap_code),
    .in_A      (mantis_shifted),
    .in_B      (mantis_nonshift),
    .out_great (mantis_great),
    .out_small (mantis_small)
);

swap
#(
    .SIZE(1)
)
__swap_sign
(
    .swap_code (shift_select_code^mantis_swap_code),
    .in_A      (sign_A),
    .in_B      (sign_B),
    .out_great (sign_of_great),
    .out_small (sign_of_small)
);

endmodule // init_number
