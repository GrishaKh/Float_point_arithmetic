module shift_selector (
    comp_code,
    exp_a, exp_b,
    mantis_a, mantis_b,
    exp_shif, diff_exp,
    mantis_shift, mantis_out
);

input comp_code;
input [7:0] exp_a, exp_b;
input [27:0] mantis_a, mantis_b;
output reg [7:0] exp_shif, diff_exp;
output reg [27:0] mantis_shift, mantis_out;

always @(*) begin
    if (comp_code) begin
        diff_exp = exp_a - exp_b;
        mantis_shift = mantis_b;
        mantis_out = mantis_a;
    end // comp_code == 1
    else begin
        diff_exp = exp_b - exp_a;
        mantis_shift = mantis_a;
        mantis_out = mantis_b;
    end //comb_code == 0
end

endmodule // shift_selector