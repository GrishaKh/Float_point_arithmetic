`timescale 1ns / 1ps

module normalize_fp_tb();
    parameter WIDTH = 32;

    reg clk, en;
    reg [WIDTH-1:0] number;
    wire [WIDTH-1:0] out;
    wire ready;

    normalize_fp _inst (.clk(clk), .en(en), .number(number), .ready(ready), .out(out));

    always #5 clk = ~clk;

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars();
    end

    initial begin
        clk = 1'b0;
        en = 1'b0;
        number = {WIDTH{1'b0}};
    end

    initial begin
        #7 en = 1'b1;
        #20 number = 32'b01011010100110110101111111101001;
        #20 en = 1'b0;

        #40 $finish;
    end
endmodule
