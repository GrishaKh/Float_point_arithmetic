module shift_selector
(
    comp_code,
    exp_A,
    exp_B,
    mantis_A,
    mantis_B,
    exp_shift,
    exp_out,
    mantis_shift,
    mantis_out
);

input        comp_code;
input [7:0]  exp_A;
input [7:0]  exp_B;
input [25:0] mantis_A;
input [25:0] mantis_B;

output reg [7:0]  exp_shift;
output reg [7:0]  exp_out;
output reg [25:0] mantis_shift;
output reg [25:0] mantis_out;

always @(*) begin
    if (comp_code) begin
        mantis_shift = mantis_B;
        mantis_out   = mantis_A;
        exp_shift    = exp_B;
        exp_out      = exp_A;
    end // comp_code == 1
    else begin
        mantis_shift = mantis_A;
        mantis_out   = mantis_B;
        exp_shift    = exp_A;
        exp_out      = exp_B;
    end //comb_code == 0
end

endmodule // shift_selector
