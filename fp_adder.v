`timescale 1ns/1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Instigate Design CJSC
// Engineer: Grisha Khachatryan
// 
// Create Date: 09/04/2019 03:51:36 PM
// Design Name: Float_point_adder
// Module Name: fp_adder
// Project Name: Floating point arithmetic
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

module fp_adder (number_1, number_2, out);

input [31:0] number_1, number_2;
output reg [31:0] out;

reg sign[2:0];
reg [7:0] exp[2:0];
reg [22:0] mantis[2:0];
reg carry;

reg m[2:0];

reg norm_sign;
reg [7:0] norm_exp;
reg [22:0] norm_mantis;

wire [31:0] out_norm;

normalize_fp nm ({norm_sign, norm_exp, norm_mantis}, out_norm);

always @(*)
begin
    {sign[0], exp[0], mantis[0]} = number_1;
    {sign[1], exp[1], mantis[1]} = number_2;

    //m[0] = mantis[0][0];
    //m[1] = mantis[1][0];

    //$display("mantis[0] = %b; m[0] = %b", mantis[0], m[0]);
    //$display("mantis[1] = %b; m[1] = %b", mantis[1], m[1]);
	
	if (exp[0] != {8{1'b0}}) begin
	    {mantis[0], m[0]} = {1'b1, mantis[0]};
    	    exp[0] = exp[0] + 1;
	end else $finish;

	if (exp[1] != {8{1'b0}}) begin
	    {mantis[1], m[1]} = {1'b1, mantis[1]};
    	    exp[1] = exp[1] + 1;
	end else $finish;

    if (exp[0] > exp[1]) begin
        {mantis[1], m[1]} = {mantis[1], m[1]} >> (exp[0] - exp[1]);
        exp[2] = exp[0];
    end
    else if (exp[0] < exp[1]) begin
        {mantis[0], m[0]} = {mantis[0], m[0]} >> (exp[1] - exp[0]);
        exp[2] = exp[1];
    end
    else begin
        exp[2] = exp[1];
    end

    if (~(sign[0]^sign[1])) begin
        {carry, mantis[2], m[2]} = {mantis[0], m[0]} + {mantis[1], m[1]};
        sign[2] = sign[0];
	//mantis[2] = mantis[2] + (m[0] ^ m[1]);
        
	if (!carry) begin
            mantis[2] = {mantis[2][21:0], m[2]};
            exp[2] = exp[2] - 1;
        end

	//mantis[2] = mantis[2] + (m[0] + m[1]);
    end
    else if (sign[0]|sign[1]) begin
        if ({mantis[0], m[0]} >= {mantis[1], m[1]})
        begin
            {mantis[2], m[2]} = {mantis[0], m[0]} - {mantis[1], m[1]};
            sign[2] = sign[0];
        end
        else begin
            {mantis[2], m[2]} = {mantis[1], m[1]} - {mantis[0], m[0]};
            sign[2] = sign[1];
        end
	$display("sign = %b", sign[2]);
	if (mantis[2][22] != 1'b1) begin
		{mantis[2], m[2]} = {mantis[2][21:0], m[2], 1'b0};
		exp[2] = exp[2] - 1;
	end
	norm_exp = exp[2];
	norm_mantis = mantis[2];
	norm_sign = sign[2];
        #2;
	exp[2] = out_norm[30:23]-1;
	sign[2] = out_norm[31];
	mantis[2] = {out_norm[21:0], m[2]};
    end 
    out = {sign[2], exp[2], mantis[2]};
end

endmodule
