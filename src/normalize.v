`include "configuration.v"

module normalize
#(
    parameter SIZE_MANTIS = 26,
    parameter SIZE_EXP = 8
)
(
    exp_in,
    mantis_in,
    exp_out,
    mantis_out
);


input [SIZE_EXP-1:0]    exp_in;
input [SIZE_MANTIS-1:0] mantis_in;

output reg [SIZE_EXP-1:0]    exp_out;
output reg [SIZE_MANTIS-1:0] mantis_out;

reg [SIZE_MANTIS-1:0] mantis_tmp;
reg [5:0]             shift;

function [5:0] shift_mantis;
    input [SIZE_MANTIS-1:0] bits;

    reg [5:0] res;
    integer   i;

    begin
        res = 0;
        for (i = 0; i < SIZE_MANTIS; i = i + 1)
        begin
            if (!res) begin
                if (bits[SIZE_MANTIS-1-i]) begin
                    res = i;
                end
            end
        end
        shift_mantis = res;
    end
endfunction

always @(*) begin
    if (mantis_in[SIZE_MANTIS-1]) shift = 0;
    else                          shift = shift_mantis(mantis_in);

    if (exp_in >= shift) begin
        mantis_tmp = (mantis_in << shift);
        exp_out = (exp_in - shift);
    end
    else begin
        mantis_tmp = (mantis_in << exp_in);
        exp_out = 0;
    end

    mantis_out = mantis_tmp;
end

endmodule // normalize
