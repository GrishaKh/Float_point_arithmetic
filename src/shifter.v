module shifter
#(
    parameter DIRECTION = 0, // 0-left, 1-right
    parameter MODE      = 0  // 0-diff, 1-exp_target
)
(
    exp,
    mantis,
    exp_target_or_diff,
    exp_out,
    mantis_out,
    loss
);

input [7:0]  exp;
input [7:0]  exp_target_or_diff;
input [25:0] mantis;

output [7:0]  exp_out;
output [25:0] mantis_out;
output        loss;
//output overflow;

wire [7:0]  shift_number;
wire [51:0] tmp;
tri0        overflow;

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
    if (DIRECTION) assign tmp = !overflow && !(&exp_out) && shift_number < 52 ? ({mantis, 26'h0000000} >> shift_number) : {52{1'b0}};
    else           assign tmp = ({mantis, 26'h0000000} << shift_number);

    assign loss       = |tmp[25:0];
    assign mantis_out = tmp[51:26];
endgenerate

endmodule // shifter
