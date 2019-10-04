`timescale 1ns/1ps

module fpa_tb;

reg clk;
reg [4:0] status_end;
reg status;
reg [31:0]  number_A_0,
            number_B_0,
            number_A_1,
            number_B_1,
            number_A_2,
            number_B_2,
            number_A_3,
            number_B_3,
            number_A_4,
            number_B_4;

wire [31:0] number_out [4:0];

initial clk = 1;
initial for (int i = 0; i < 5; i++) status_end [i] = 1'b0;

function void check_equiv (reg [31:0] num_A, reg [31:0] num_B, num_check);
    if ($shortrealtobits($bitstoshortreal(num_A) + $bitstoshortreal(num_B)) != num_check)
    begin
        $display ("Fail");
        $display ("number_A = %b, %f", num_A, $bitstoshortreal(num_A));
        $display ("number_B = %b, %f", num_B, $bitstoshortreal(num_B));
        $display ("out_test = %b, %f", num_check, $bitstoshortreal(num_check));
        $display ("out_real = %b", $shortrealtobits($bitstoshortreal(num_A) + $bitstoshortreal(num_B)));
        $write ("\n ******************************* \n");
        status = 1'b1;
        $stop;
    end
        //$display ("number_A = %b, %d", num_A, $bitstoshortreal(num_A));
        //$display ("number_B = %b, %d", num_B, $bitstoshortreal(num_B));
        //$display ("out_test = %b, %d", num_check, $bitstoshortreal(num_check));
        //$display ("out_real = %b", $shortrealtobits($bitstoshortreal(num_A) + $bitstoshortreal(num_B)));
        //$write ("\n ******************************* \n");
endfunction

top zero (
    .clk (clk),
    .number_A (number_A_0),
    .number_B (number_B_0),
    .number_out (number_out[0])
);

top inf (
    .clk (clk),
    .number_A (number_A_1),
    .number_B (number_B_1),
    .number_out (number_out[1])
);

top nan (
    .clk (clk),
    .number_A (number_A_2),
    .number_B (number_B_2),
    .number_out (number_out[2])
);

top sub (
    .clk (clk),
    .number_A (number_A_3),
    .number_B (number_B_3),
    .number_out (number_out[3])
);

top norm (
    .clk (clk),
    .number_A (number_A_4),
    .number_B (number_B_4),
    .number_out (number_out[4])
);

always #2 clk = ~clk;

initial begin : init_zero
    reg sign [1:0];
    reg [7:0] exp [1:0];
    reg [22:0] mantis [1:0];
    
    sign [1:0] = {0, 0};
    exp [1:0] = {0, 0};
    mantis [1:0] = {0, 0};

    assign number_A_0 = {sign[0], exp[0], mantis[0]};
    assign number_B_0 = {sign[1], exp[1], mantis[1]};

    repeat (100) begin
    @(posedge clk);
    repeat (10000) begin
        @(posedge clk);
        #0.5 check_equiv (number_A_0, number_B_0, number_out[0]);
        mantis[1] = $urandom;
        sign[0] = $urandom;
        sign[1] = $urandom;
        @(posedge clk);
    end

    exp[1] = $urandom;
    mantis[1] = 0;
    end

    $display ("End ZERO <-> ZERO, ZERO <-> SUB, ZERO <-> NORM");
    
    mantis[1] = 0;
    exp[1] = 8'hFF;

    @(posedge clk);
    repeat (10000) begin
        @(posedge clk);
        #0.5 check_equiv (number_A_0, number_B_0, number_out[0]);
        mantis[1] = $urandom;
        sign[0] = $urandom;
        sign[1] = $urandom;
        @(posedge clk);
    end

    $display ("End ZERO <-> INF, ZERO <-> NAN");

    status_end[0] = 1;
end

initial begin : init_inf
    reg sign [1:0];
    reg [7:0] exp [1:0];
    reg [22:0] mantis [1:0];
    
    sign [1:0] = {1'b0, 1'b0};
    exp[0] = 8'hFF;
    exp[1] = 0;
    mantis[0] = 0;
    mantis[1] = 0;

    assign number_A_0 = {sign[0], exp[0], mantis[0]};
    assign number_B_0 = {sign[1], exp[1], mantis[1]};

    repeat (100) begin
    @(posedge clk);
    repeat (10000) begin
        @(posedge clk);
        #0.5 check_equiv (number_A_0, number_B_0, number_out[1]);
        mantis[1] = $urandom;
        sign[0] = $urandom;
        sign[1] = $urandom;
        @(posedge clk);
    end

    exp[1] = $urandom;
    mantis[1] = 0;
    end

    $display ("End INF <-> ZERO, INF <-> SUB, INF <-> NORM");
    
    mantis[1] = 0;
    exp[1] = 8'hFF;

    @(posedge clk);
    repeat (10000) begin
        @(posedge clk);
        #0.5 check_equiv (number_A_0, number_B_0, number_out[0]);
        mantis[1] = $urandom;
        sign[0] = $urandom;
        sign[1] = $urandom;
        @(posedge clk);
    end

    $display ("End INF <-> INF, INF <-> NAN");

    status_end[1] = 1;
end

initial begin
    wait (status_end[0] & status_end[1]);
    if (status) $display ("Test Fail...");
    else        $display ("Test Pass!");

    $finish;
end

endmodule
