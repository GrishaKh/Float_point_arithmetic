`timescale 1ns / 1ps

module normalize_fp_tb();
    reg [31:0] number;
    wire [31:0] out;

    normalize_fp _inst (.number(number), .out(out));

    initial begin
        $dumpfile("sim.vcd");
        $dumpvars();
    end

    initial number = {32{1'b0}};

    initial begin
        #20 number = 32'b01011010100110110101111111101001;

        #40 $finish;
    end
endmodule
