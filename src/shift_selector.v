`include "configuration.v"

module shift_selector
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    comp_code,
    exp_A,
    exp_B,
    mantis_A,
    mantis_B,
    exp_shift,
    exp_out,
    mantis_shift,
    mantis_out
);

// Inputs
input                       comp_code; // input code of comparator
input [ EXP_SIZE      -1:0] exp_A;     // exponent of first number
input [ EXP_SIZE      -1:0] exp_B;     // exponent of second number
input [(MANTIS_SIZE+3)-1:0] mantis_A;  // mantissa of first number
input [(MANTIS_SIZE+3)-1:0] mantis_B;  // mantissa of second number

// Outputs
output reg [ EXP_SIZE      -1:0] exp_shift;    // shiftable exponent
output reg [ EXP_SIZE      -1:0] exp_out;      // nonshiftable exponent
output reg [(MANTIS_SIZE+3)-1:0] mantis_shift; // shiftable mantis
output reg [(MANTIS_SIZE+3)-1:0] mantis_out;   // nonshiftable mantis

// Combinational block
always @(*) begin
    if (comp_code) begin
        mantis_shift = mantis_B;
        mantis_out   = mantis_A;
        exp_shift    = exp_B;
        exp_out      = exp_A;
    end // comp_code == 1
    else begin
        mantis_shift = mantis_A;
        mantis_out   = mantis_B;
        exp_shift    = exp_A;
        exp_out      = exp_B;
    end //comb_code == 0
end

endmodule // shift_selector
