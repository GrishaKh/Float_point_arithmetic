`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/04/2019 03:51:36 PM
// Design Name: 
// Module Name: fp_adder_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fp_adder_tb();

reg [31:0] number_1, number_2;
wire [31:0] out;

reg sign [1:0];
reg [7:0] exp [1:0];
reg [22:0] mantis [1:0];

fp_adder _inst (.number_1(number_1), .number_2(number_2), .out(out));

/*initial begin
    $dumpfile("sim.vcd");
    $dumpvars();
end*/

/*initial begin
	number_1 = 32'b01000000001111110000000000011111;
	number_2 = 32'b01000001011111110000110000000001;
	#5;
	$display("out_test = %h, %b", out, out);
	$display("out_real = %h, %b", $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)), $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)));

#20 $finish;
end*/

initial begin
    repeat (10000) begin
		sign[0] = $urandom;
		sign[1] = $urandom;
		exp[0] = $urandom%254 + 1;
		exp[1] = $urandom%254 + 1;
		mantis[0] = $urandom;
		mantis[1] = $urandom;

		mantis[0][0] = 1'b1;
		mantis[1][0] = 1'b0;
		number_1 = {0&sign[0], exp[0], mantis[0]};
		number_2 = {0&sign[0], exp[1], mantis[1]};
		#5;
		$display("N_1 = %h, %b", number_1, number_1);
		$display("N_2 = %h, %b", number_2, number_2);
		$display("mantis[0] = %b", _inst.mantis[0]);
		$display("mantis[1] = %b", _inst.mantis[1]);
		$display("mantis[2] = %b", _inst.mantis[2]);
		$display("carry = %b", _inst.carry);
		$display("out_test = %h, %b", out, out);
		$display("out_real = %h, %b", $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)), $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)));
		$display("exp[1]-exp[0] = %d", _inst.exp[1] - _inst.exp[0]);
		$display("exp[0]-exp[1] = %d", _inst.exp[0] - _inst.exp[1]);
		$display("Real %f + %f = %f", $bitstoshortreal(number_1), $bitstoshortreal(number_2), $bitstoshortreal(number_1) + $bitstoshortreal(number_2));
		$display("Test %f + %f = %f", $bitstoshortreal(number_1), $bitstoshortreal(number_2), $bitstoshortreal(out));
		if ($shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)) != out)
		begin
			$display("Fail");
			$display("*************************************");
			$stop;
		end
		else begin
			$display("Pass");
			$display("*************************************");
		end
    end

    #20 $finish;
end

endmodule
