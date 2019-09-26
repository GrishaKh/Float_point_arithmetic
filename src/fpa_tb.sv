`timescale 1ns/1ps

module fpa_tb;

reg clk;
reg [31:0] number_A, number_B;
reg sign_in[1:0];
reg [7:0] exp_in[1:0];
reg [22:0] mantis_in[1:0];

wire [31:0] number_out;

top __top (
    .clk (clk),
    .number_A (number_A),
    .number_B (number_B),
    .number_out (number_out)
);

always #2 clk = ~clk;

always begin
    /*for (sign_in[0] = 0; sign_in[0] < 1; sign_in[0] = sign_in[0] + 1)
    for (exp_in[0] = 0; exp_in[0] < 254; exp_in[0] = exp_in[0] + 1)
    for (mantis_in[0] = 0; mantis_in[0] < 8388607; mantis_in[0] = mantis_in[0] + 1)
    for (sign_in[1] = 0; sign_in[1] < 1; sign_in[0] = sign_in[1] + 1)
    for (exp_in[1] = 0; exp_in[1] < 254; exp_in[1] = exp_in[1] + 1)
    for (mantis_in[1] = 0; mantis_in[1] < 8388607; mantis_in[1] = mantis_in[1] + 1) begin
	number_A = {sign_in[0], exp_in[0], mantis_in[0]};
        number_B = {sign_in[1], exp_in[1], mantis_in[1]};
	#2;
        $display ("number_A = \t%b", number_A);
       	$display ("number_B = \t%b", number_B);
        $display ("out_test = \t%b", {sign, exp, mantis});
        $display ("out_expexted = \t%b", $shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)));
	if ($shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)) == {sign, exp, mantis})
        begin
            $display ("Pass");
	end else begin
  	    $display ("Fail");
	    $stop;
        end

        $write ("\n ******************************* \n");
        #1;
    end*/
    //repeat (100000) begin
    sign_in[0] = $urandom;
	sign_in[1] = $urandom;
	exp_in[0] = $urandom;
    exp_in[1] = $urandom;
	mantis_in[0] = $urandom;
	mantis_in[1] = $urandom;

    number_A = {sign_in[0], exp_in[0], mantis_in[0]};
    number_B = {sign_in[1], exp_in[1], mantis_in[1]};
    @(posedge clk);

    $display ("number_A = %b, %d", number_A, $bitstoshortreal(number_A));
    $display ("number_B = %b, %d", number_B, $bitstoshortreal(number_B));
    $display ("out_test = %b", {sign, exp, mantis});
    $display ("out_real = %b", $shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)));
	$display ("mantis[4] = %b", __fpa.__standardizer.__round.mantis[4]);
	$display ("diff = %d", __fpa.__preadder.__init_number.__shifter.shift_number);
    $display ("bits = %b", __fpa.__standardizer.__round.r_bits); 
 
    if ($shortrealtobits($bitstoshortreal(number_A) + $bitstoshortreal(number_B)) == number_out)
    begin
        //$display ("Pass");
        //continue;
    end else begin
        $display ("Fail");
	    $stop;
	    //continue;
    end

	$display ("Pass");
    //$write ("\n ******************************* \n");
    #1;
    //end

    //$finish;
end

endmodule
