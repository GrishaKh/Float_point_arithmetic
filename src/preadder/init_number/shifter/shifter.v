module shifter (exp, mantis, shift_number, exp_out, mantis_out);
parameter MODE = 0; // 0-RIGHT, 1-LEFT

input [7:0] exp, shift_number;
input [27:0] mantis;
output [7:0] exp_out;
output [27:0] mantis_out;

generate
if (!MODE) begin
    assign exp_out = exp + shift_number;
    assign mantis_out = (mantis >> shift_number);
end
else begin
    assign exp_out = exp - shift_number;
    assign mantis_out = (mantis << shift_number);
end
endgenerate

endmodule
