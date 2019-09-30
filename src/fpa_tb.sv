`timescale 1ns/1ps

module fpa_tb;

reg clk, status;
reg [61:0] counter;
wire [31:0] number_out [3:0];

initial clk = 1;
initial status = 0;
initial counter = 62'b0;

function void check_equiv (reg [31:0] num_A, reg [31:0] num_B, num_check);
    if ($shortrealtobits($bitstoshortreal(num_A) + $bitstoshortreal(num_B)) != num_check)
    begin
        $display ("Fail");
        $display ("number_A = %b, %d", num_A, $bitstoshortreal(num_A));
        $display ("number_B = %b, %d", num_B, $bitstoshortreal(num_B));
        $display ("out_test = %b, %d", num_check, $bitstoshortreal(num_check));
        $display ("out_real = %b", $shortrealtobits($bitstoshortreal(num_A) + $bitstoshortreal(num_B)));
        $write ("\n ******************************* \n");
        status = 1'b1;
        $stop;
    end
endfunction

top inst_00 (
    .clk (clk),
    .number_A ({1'b0, counter[30:0]}),
    .number_B ({1'b0, counter[61:31]}),
    .number_out (number_out[0])
);

top inst_01 (
    .clk (clk),
    .number_A ({1'b0, counter[30:0]}),
    .number_B ({1'b1, counter[61:31]}),
    .number_out (number_out[1])
);

top inst_11 (
    .clk (clk),
    .number_A ({1'b1, counter[30:0]}),
    .number_B ({1'b1, counter[61:31]}),
    .number_out (number_out[2])
);

top inst_10 (
    .clk (clk),
    .number_A ({1'b1, counter[30:0]}),
    .number_B ({1'b0, counter[61:31]}),
    .number_out (number_out[3])
);

always #2 clk = ~clk;

initial begin
    forever begin
        @(posedge clk);

        #0.2 check_equiv ({1'b0, counter[30:0]}, {1'b0, counter[61:31]}, number_out[0]);
        #0.2 check_equiv ({1'b0, counter[30:0]}, {1'b1, counter[61:31]}, number_out[1]);
        #0.2 check_equiv ({1'b1, counter[30:0]}, {1'b1, counter[61:31]}, number_out[2]);
        #0.2 check_equiv ({1'b1, counter[30:0]}, {1'b0, counter[61:31]}, number_out[3]);

        counter = counter + 1;
        @(posedge clk);
    end
end

initial begin
    wait (counter[20]);
    $display ("counter[20] == 1");
    wait (counter[21]);
    $display ("counter[21] == 1");
    wait (counter[22]);
    $display ("counter[22] == 1");
    wait (counter[23]);
    $display ("counter[23] == 1");
    wait (counter[25]);
    $display ("counter[25] == 1");
    wait (counter[28]);
    $display ("counter[28] == 1");
    wait (counter[29]);
    $display ("counter[29] == 1");
    wait (counter[30]);
    $display ("counter[30] == 1");
    wait (counter[31]);
    $display ("counter[31] == 1");
    wait (&counter);
    if (status) $display ("Test Fail...");
    else        $display ("Test Pass!");

    $finish;
end

endmodule
