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
input [EXP_SIZE-1:0]    exp_in;    // exponent of the number to be normalization
input [MANTIS_SIZE-1:0] mantis_in; // mantissa of the number to be normalization

// Outputs
output reg [EXP_SIZE-1:0]    exp_out;    // normalized exponent
output reg [MANTIS_SIZE-1:0] mantis_out; // normalized mantissa

// Regs
reg [5:0] shift; // shift quantity

// Function for compute shift quantity
function [5:0] shift_mantis;
    input [MANTIS_SIZE-1:0] bits; // input data

    reg [5:0] res; // result
    integer   i;

    begin
        res = 0;
        for (i = 0; i < MANTIS_SIZE; i = i + 1)
        begin
            if (!res) begin // if the value is still 0: continue, else the "res" is equal final result
                if (bits[MANTIS_SIZE-1-i]) begin
                    res = i;
                end
            end
        end
        shift_mantis = res; // return result
    end
endfunction // shift_mantis

// Combinational block
always @(*) begin
    if (mantis_in[MANTIS_SIZE-1]) shift = 0;
    else                          shift = shift_mantis(mantis_in);

    if (exp_in >= shift) begin // if the exponent greater than or equal to shift quantity
        mantis_out = (mantis_in << shift);
        exp_out = (exp_in - shift);
    end
    else begin                 // if the exponent smaller than shift quantity
        mantis_out = (mantis_in << exp_in);
        exp_out = 0;
    end
end

endmodule // normalize
