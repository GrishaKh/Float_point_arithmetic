module shifter (exp, mantis, exp_target_or_diff, exp_out, mantis_out, loss);
parameter DIRECTION = 0; // 0-left, 1-right
parameter MODE      = 0; // 0-diff, 1-exp_target

input [7:0] exp, exp_target_or_diff;
input [27:0] mantis;
output [7:0] exp_out;
output [27:0] mantis_out;
output loss;
//output overflow;

tri0 overflow;
wire [7:0] shift_number;
wire [55:0] tmp;

generate
    if (MODE) begin
        assign exp_out = exp_target_or_diff;
        assign shift_number = exp_target_or_diff - exp;
    end
    else begin
        if (DIRECTION) assign {overflow, exp_out} = exp + exp_target_or_diff;
        else           assign exp_out = exp - exp_target_or_diff;
        assign shift_number = exp_target_or_diff;
    end
    if (DIRECTION) assign tmp = !overflow && !(&exp_out) ? ({mantis, 28'h0000000} >> shift_number) : {55{1'b0}};
    else           assign tmp = ({mantis, 28'h0000000} << shift_number);

    assign loss = |tmp[27:0];
    assign mantis_out = tmp[55:28];
endgenerate

endmodule