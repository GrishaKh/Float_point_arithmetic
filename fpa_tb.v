`timescale 1ns/1ps

module fpa_tb;

reg [31:0] number_A, number_B;
wire sign;
wire [7:0] exp;
wire [22:0] mantis;

fpa __fpa (
    .number_A (number_A),
    .number_B (number_B),
    .sign (sign),
    .exp (exp),
    .mantis (mantis)
);

initial begin
    repeat (100000) begin
        number_A = $random;
        number_B = $random;

        number_A[31] = 1'b0;
        number_B[31] = 1'b0;
        #5;

        $display ("number_A = %b", number_A);
        $display ("number_B = %b", number_B);
        $display ("out_test = %b", {sign, exp, mantis});
        $display ("out_real = %b", $shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)));
        
        if ($shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)) == {sign, exp, mantis})
        begin
            $display ("Pass");
        end else begin
            $display ("Fail");
	    $stop;
        end

        $write ("\n ******************************* \n");
        #5;
    end

    $finish;
end

endmodule
