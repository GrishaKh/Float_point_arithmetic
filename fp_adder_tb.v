`timescale 1ns/1ps

module fp_adder_tb();

reg [31:0] number_1, number_2;
wire [31:0] out;

fp_adder _inst (.number_1(number_1), .number_2(number_2), .out(out));

initial begin
    $dumpfile("sim.vcd");
    $dumpvars();
end

initial begin
    number_1 = 0;
    number_2 = 0;
    #10 number_1 = 32'b01000000001000000000000000000000;
    number_2 = 32'b01000000011000000000000000000000;
    #10 number_1 = 32'b01000000000100110011001100110011;
    number_2 = 32'b01000000011000000000000000000000;
    #10 number_1 = 32'b01000000101000000000000000000000;
    number_2 = 32'b01000000001000000000000000000000;

    #20 $finish;
end

endmodule
