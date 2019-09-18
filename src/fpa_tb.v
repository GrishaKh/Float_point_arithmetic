`timescale 1ns/1ps

module fpa_tb;

reg [31:0] number_A, number_B;
wire sign;
wire [7:0] exp;
wire [27:0] mantis;

fpa __fpa (
    .number_A (number_A),
    .number_B (number_B),
    .sign (sign),
    .exp (exp),
    .mantis (mantis)
);

initial begin
    repeat (1000) begin
        number_A = $random;
        number_B = $random;

        number_A[31] = 1'b0;
        number_B[31] = 1'b0;
        #5;

        $display ("number_A = %b", number_A);
        $display ("number_B = %b", number_B);
        $display ("{sign, exp, mantis} = %b", {sign, exp, mantis});
        $write ("\n ******************************* \n");

        if (~mantis[4] & mantis[3] & (&(~mantis[2:0]))) begin
            $display ("hasav");
            $finish;
        end
        #5;
    end
end

endmodule
