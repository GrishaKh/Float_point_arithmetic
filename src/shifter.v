`include "configuration.v"

module shifter
#(
    parameter EXP_SIZE       = `EXP_SIZE,
    parameter MANTIS_SIZE    = `MANTIS_SIZE,
    parameter DIRECTION      = 0, // 0-left, 1-right
    parameter MODE           = 0  // 0-diff, 1-exp_target
)
(
    exp,
    mantis,
    exp_target_or_diff,
    exp_out,
    mantis_out,
    loss
);

// Inputs
input [ EXP_SIZE      -1:0] exp;
input [ EXP_SIZE      -1:0] exp_target_or_diff;
input [(MANTIS_SIZE+3)-1:0] mantis;

// Outputs
output [ EXP_SIZE      -1:0] exp_out;
output [(MANTIS_SIZE+3)-1:0] mantis_out;
output                       loss;
//output overflow;

// Wires
wire [    EXP_SIZE       -1:0] shift_number;
wire [(2*(MANTIS_SIZE+3))-1:0] tmp;
tri0                           overflow;

// Generate block
generate
    if (MODE) begin
        assign exp_out      = exp_target_or_diff;
        assign shift_number = exp_target_or_diff - exp;
    end
    else begin
        if (DIRECTION) assign {overflow, exp_out} = exp + exp_target_or_diff;
        else           assign exp_out             = exp - exp_target_or_diff;
        assign shift_number = exp_target_or_diff;
    end
    if (DIRECTION) assign tmp = !overflow && !(&exp_out) && shift_number < (2*(MANTIS_SIZE+3)) ?
                          ({mantis, {(MANTIS_SIZE+3){1'b0}}} >> shift_number): {(2*(MANTIS_SIZE+3)){1'b0}};
    else           assign tmp = ({mantis, {(MANTIS_SIZE+3){1'b0}}} << shift_number);

    assign loss       = |tmp[(MANTIS_SIZE+3)-1:0];
    assign mantis_out =  tmp[(2*(MANTIS_SIZE+3))-1:(MANTIS_SIZE+3)];
endgenerate

endmodule // shifter
