module shift_selector (
    comp_code,
    exp_A, exp_B,
    mantis_A, mantis_B,
    exp_shift, diff_exp,
    mantis_shift, mantis_out
);

input comp_code;
input [7:0] exp_A, exp_B;
input [27:0] mantis_A, mantis_B;
output reg [7:0] exp_shift, diff_exp;
output reg [27:0] mantis_shift, mantis_out;

always @(*) begin
    if (comp_code) begin
        diff_exp = exp_A - exp_B;
        mantis_shift = mantis_B;
        mantis_out = mantis_A;
        exp_shift = exp_B;
    end // comp_code == 1
    else begin
        diff_exp = exp_B - exp_A;
        mantis_shift = mantis_A;
        mantis_out = mantis_B;
        exp_shift = exp_A;
    end //comb_code == 0
end

endmodule // shift_selector
