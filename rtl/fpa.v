`include "configuration.v"

module fpa
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    number_A,
    number_B,
    number_out
);


// Inputs
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_A; // the first operand
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_B; // the second operand

// Outputs
output [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_out; // result of the computation

// Wires
wire                       sign_of_great;  // sign of the great number
wire                       sign_of_small;  // sign of the small number
wire [ EXP_SIZE      -1:0] exp_A;          // exponent of the first operand
wire [ EXP_SIZE      -1:0] exp_B;          // exponent of the second operand
wire [ EXP_SIZE      -1:0] exp_preadder;   // exponent output from preadder
wire [ EXP_SIZE      -1:0] exp_adder;      // exponent output from adder
wire [ EXP_SIZE      -1:0] exp_out;        // exponent of the result
wire [(MANTIS_SIZE+3)-1:0] ext_mantis_A;   // extended mantissa of the first operand
wire [(MANTIS_SIZE+3)-1:0] ext_mantis_B;   // extended mantissa of the second operand
wire [(MANTIS_SIZE+3)-1:0] mantis_great;   // great mantissa
wire [(MANTIS_SIZE+3)-1:0] mantis_small;   // small mantissa
wire [ MANTIS_SIZE   -1:0] mantis_A;       // mantissa of the first operand
wire [ MANTIS_SIZE   -1:0] mantis_B;       // mantissa of the second operand
wire [(MANTIS_SIZE+3)-1:0] mantis_adder;   // mantissa output from adder
wire [ MANTIS_SIZE   -1:0] mantis_out;     // mantissa of the result
wire [2:0]                 type_A;         // type of the first operand (zero, infinity, subnormal, normal, nan)
wire [2:0]                 type_B;         // type of the second operand (zero, infinity, subnormal, normal, nan)
wire                       special_case;   // Indicates a special case
wire                       loss_preadder;  // loss output from the preadder
wire                       loss_adder;     // loss output from the adder
wire                       loss;           // loss result
wire                       operator_adder; // output from adder, add or sub
wire                       sign_adder;     // sign output from the adder
wire [(1+EXP_SIZE+MANTIS_SIZE)-1:0] special_result; // computation result is equal to the special result, if there is a special case

// Assignes
assign loss       = loss_preadder | loss_adder;                       // loss detection
assign number_out = special_case ? special_result :
                                   {sign_adder, exp_out, mantis_out}; // result creation

// Instances
init_number __number_A
(
    .number     (number_A),
    .sign       (sign_A),
    .exp        (exp_A),
    .mantis     (mantis_A),
    .ext_mantis (ext_mantis_A),
    .type       (type_A)
);

init_number __number_B
(
    .number     (number_B),
    .sign       (sign_B),
    .exp        (exp_B),
    .mantis     (mantis_B),
    .ext_mantis (ext_mantis_B),
    .type       (type_B)
);

preadder __preadder
(
    .sign_A        (sign_A),
    .sign_B        (sign_B),
    .exp_A         (exp_A),
    .exp_B         (exp_B),
    .mantis_A      (ext_mantis_A),
    .mantis_B      (ext_mantis_B),
    .sign_of_great (sign_of_great),
    .sign_of_small (sign_of_small),
    .exp           (exp_preadder),
    .mantis_great  (mantis_great),
    .mantis_small  (mantis_small),
    .loss          (loss_preadder)
);

special_cases __special_cases
(
    .sign_A       (sign_A),
    .sign_B       (sign_B),
    .exp_A        (exp_A),
    .exp_B        (exp_B),
    .mantis_A     (mantis_A),
    .mantis_B     (mantis_B),
    .type_A       (type_A),
    .type_B       (type_B),
    .result       (special_result),
    .special_case (special_case)
);

adder __adder
(
    .sign_A     (sign_of_great),
    .sign_B     (sign_of_small),
    .exp        (exp_preadder),
    .mantis_A   (mantis_great),
    .mantis_B   (mantis_small),
    .sign       (sign_adder),
    .exp_out    (exp_adder),
    .mantis_out (mantis_adder),
    .loss       (loss_adder),
    .operator   (operator_adder)
);

standardizer __standardizer
(
    .exp_in      (exp_adder),
    .mantis_in   (mantis_adder),
    .operator_in (operator_adder),
    .loss        (loss),
    .exp_out     (exp_out),
    .mantis_out  (mantis_out)
);

endmodule // fpa
