`include "configuration.v"

module type_detect
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    exp,
    mantis,
    type
);

// Inputs
input [EXP_SIZE   -1:0] exp;    // input exponent
input [MANTIS_SIZE-1:0] mantis; // input mantissa

// Outputs
output reg [2:0] type; // output type

parameter [2:0] ZERO      = 3'b000,
                INF       = 3'b001,
                SUBNORMAL = 3'b010,
                NORMAL    = 3'b011,
                NAN       = 3'b100;

// Combinational block
always @(*) begin
    if (|exp) begin
        if (&exp) begin
            if (|mantis) type = NAN;
            else         type = INF;
        end
        else             type = NORMAL;
    end
    else begin
        if (|mantis)     type = SUBNORMAL;
        else             type = ZERO;
    end
end

endmodule // type_detect
