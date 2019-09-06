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
    number_1 = 0;
    number_2 = 0;
#10 number_1 = 32'b01000000001000000000000000000000;
    number_2 = 32'b01000000011000000000000000000000;
#10 number_1 = 32'b01000000000100110011001100110011;
    number_2 = 32'b01000000011000000000000000000000;
#10 number_1 = 32'b01000000101000000000000000000000;
    number_2 = 32'b01000000001000000000000000000000;
#10 number_1 = 32'b01000000011000000000000000000000; // 0x40600000
    number_2 = 32'b11000000000000000000000000000000; // 0xC0000000
    //sum = b00111111110000000000000000000000, 0x3FC00000

#20 $finish;
end*/

initial begin
    repeat (100) begin
		sign[0] = $random;
		sign[1] = $random;
		exp[0] = $random%255 + 1;
		exp[1] = $random%255 + 1;
		mantis[0] = $random;
		mantis[1] = $random;
		number_1 = {sign[0], exp[0], mantis[0]};
		number_2 = {sign[1], exp[0], mantis[1]};
		#5;
	
		/*if ($shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)) != out)
		begin
			$display("Fail");
			$display("mantis_2 = %b", _inst.mantis[2]);
			$display("N_1 = %h, %b", number_1, number_1);
			$display("N_2 = %h, %b", number_2, number_2);
			$display("carry = %b", _inst.carry);
			$display("out = %h, %b", out, out);
			$display("out_test = %h, %b", $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)), $shortrealtobits($bitstoshortreal(number_1) + $bitstoshortreal(number_2)));
			$display("exp[1]-exp[0] = %d", _inst.exp[1] - _inst.exp[0]);
			$display("exp[0]-exp[1] = %d", _inst.exp[0] - _inst.exp[1]);
			$display("************");
			$stop;
		end
		else begin
			//$display("Pass");
		end*/
		$display("mantis_2 = %b", _inst.mantis[2]);
		$display("N_1 = %h, %b", number_1, number_1);
		$display("N_2 = %h, %b", number_2, number_2);
		$display("carry = %b", _inst.carry);
		$display("out = %h, %b", out, out);
		$display("exp[1]-exp[0] = %d", _inst.exp[1] - _inst.exp[0]);
		$display("exp[0]-exp[1] = %d", _inst.exp[0] - _inst.exp[1]);
		$display("************");
		
    end

    #20 $finish;
end

endmodule
