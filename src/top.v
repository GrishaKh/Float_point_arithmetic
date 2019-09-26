module top (clk, number_A, number_B, number_out);

input clk;
input [31:0] number_A, number_B;
output reg [31:0] number_out;

reg [31:0] number_A_reg, number_B_reg;
wire [31:0] number;

fpa __fpa (
    .number_A (number_A_reg),
    .number_B (number_B_reg),
    .number_out (number)
);

always @(posedge clk) begin
    number_A_reg <= number_A;
    number_B_reg <= number_B;
    number_out <= number;
end

endmodule
