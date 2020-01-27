module top
(
    clk,
    rst,
    number_A,
    number_B,
    number_out
);

input        clk;
input        rst;
input [31:0] number_A;
input [31:0] number_B;

output reg [31:0] number_out;

reg  [31:0] number_A_reg;
reg  [31:0] number_B_reg;
wire [31:0] number;

fpa __fpa
(
    .number_A (number_A_reg),
    .number_B (number_B_reg),
    .number_out (number)
);

always @(posedge clk or negedge rst)
begin
    if (~rst) begin
        number_A_reg <= 32'h0;
        number_B_reg <= 32'h0;
        number_out   <= 32'h0;
    end
    else begin
        number_A_reg <= number_A;
        number_B_reg <= number_B;
        number_out   <= number;
    end
end

endmodule // top
