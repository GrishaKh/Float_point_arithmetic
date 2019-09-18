module shifter (exp, mantis, exp_target_or_diff, exp_out, mantis_out);
parameter DIRECTION = 0; // 0-right, 1-left
parameter MODE      = 0; // 0-diff,  1-exp_target

input [7:0] exp, exp_target_or_diff;
input [27:0] mantis;
output [7:0] exp_out;
output [27:0] mantis_out;

wire [7:0] shift_number;

generate
    if (MODE) begin
        assign exp_out = exp_target_or_diff;
        assign shift_number = exp_target_or_diff - exp;
    end
    else begin
        assign exp_out = exp + -1*DIRECTION*exp_target_or_diff;
        assign shift_number = exp_target_or_diff;
    end
    if (DIRECTION) assign mantis_out = (mantis << shift_number);
    else           assign mantis_out = (mantis >> shift_number); 
endgenerate

endmodule
