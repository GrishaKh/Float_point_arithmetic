`include "configuration.v"

module normalize
#(
    parameter MANTIS_SIZE = `MANTIS_SIZE+3,
    parameter EXP_SIZE    = `EXP_SIZE
)
(
    exp_in,
    mantis_in,
    exp_out,
    mantis_out
);

// Inputs
input [EXP_SIZE-1:0]    exp_in;
input [MANTIS_SIZE-1:0] mantis_in;

// Outputs
output reg [EXP_SIZE-1:0]    exp_out;
output reg [MANTIS_SIZE-1:0] mantis_out;

// Regs
reg [MANTIS_SIZE-1:0] mantis_tmp;
reg [5:0]             shift;

// Functions
function [5:0] shift_mantis;
    input [MANTIS_SIZE-1:0] bits;

    reg [5:0] res;
    integer   i;

    begin
        res = 0;
        for (i = 0; i < MANTIS_SIZE; i = i + 1)
        begin
            if (!res) begin
                if (bits[MANTIS_SIZE-1-i]) begin
                    res = i;
                end
            end
        end
        shift_mantis = res;
    end
endfunction // shift_mantis

// Combinational block
always @(*) begin
    if (mantis_in[MANTIS_SIZE-1]) shift = 0;
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
