`include "configuration.v"

module top
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    clk,
    rst,
    number_A,
    number_B,
    number_out
);

// Inputs
input                                clk;      // clock
input                                rst;      // reset
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_A; // first number
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_B; // second number

// Outputs
output reg [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_out; // result

// Wires and regs
reg  [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_A_reg;
reg  [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number_B_reg;
wire [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number;

// Instances
fpa __fpa
(
    .number_A   (number_A_reg),
    .number_B   (number_B_reg),
    .number_out (number)
);

// Sequential block
always @(posedge clk or negedge rst)
begin
    if (~rst) begin
        number_A_reg <= {(1+EXP_SIZE+MANTIS_SIZE){1'b0}};
        number_B_reg <= {(1+EXP_SIZE+MANTIS_SIZE){1'b0}};
        number_out   <= {(1+EXP_SIZE+MANTIS_SIZE){1'b0}};
    end
    else begin
        number_A_reg <= number_A;
        number_B_reg <= number_B;
        number_out   <= number;
    end
end

endmodule // top
