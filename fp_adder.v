module fp_adder (number_1, number_2, out);

input [31:0] number_1, number_2;
output reg [31:0] out;

reg sign[2:0];
reg [7:0] exp[2:0];
reg [22:0] mantis[2:0];
reg carry;

always @(*)
begin
    {sign[0], exp[0], mantis[0]} = number_1;
    {sign[1], exp[1], mantis[1]} = number_2;

    if (exp[0] > exp[1]) begin
        mantis[1] = mantis[1] >> 1;
        mantis[1] = {1'b1, mantis[1][21:0]};
        mantis[1] = mantis[1] >> (exp[0] - exp[1] - 1);
        exp[2] = exp[0];
    end
    else begin
        mantis[0] = mantis[0] >> 1;
        mantis[0] = {1'b1, mantis[0][21:0]};
        mantis[0] = mantis[0] >> (exp[1] - exp[0] - 1);
        exp[2] = exp[1];
    end

    if (~(sign[0]^sign[1])) begin
        {carry, mantis[2]} = mantis[0] + mantis[1];
        sign[2] = sign[0];
    end
    else if (sign[0]|sign[1]) begin
        if (mantis[0] >= mantis[1])
            {carry, mantis[2]} = mantis[0] - mantis[1];
        else
            {carry, mantis[2]} = mantis[1] - mantis[0];
        sign[2] = 1'b1;
    end

    if (carry) begin
        mantis[2] = {carry, mantis[2][21:0]};
        exp[2] = exp[2] + 1;
    end

    $display(exp[2]);
    $display(mantis[2]);
    $display(sign[2]);

     
    out = {sign[2], exp[2], mantis[2]};
    
end

endmodule
