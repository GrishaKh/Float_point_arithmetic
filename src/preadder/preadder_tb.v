`timescale 1ns/1ps

module preadder_tb;

reg [31:0] number_A, number_B;
wire [31:0] special_result;
wire special_case;
wire sign;
wire [7:0] exp;
wire [27:0] mantis_great, mantis_small;

preadder __tb
(
    .number_A(number_A),
    .number_B(number_B),
    .special_result(special_result),
    .special_case(special_case),
    .sign(sign),
    .exp(exp),
    .mantis_great(mantis_great),
    .mantis_small(mantis_small)
);

initial begin
    repeat (10) begin
        number_A = $random;
        number_B = $random;
        #5;
        $display ("number_A = %b", number_A);
        $display ("number_B = %b", number_B);
        $display ("special_case = %b", special_case);
        $display ("sign = %b", sign);
        $display ("exp = %b", exp);
        $display ("mantis_great = %b", mantis_great);
        $display ("mantis_small = %b", mantis_small);
        $display ("special_result = %b", special_result);
        #5;
        $display;
        $display ("*************************************");
        $display;

    end
    #5 $finish;
end

endmodule
