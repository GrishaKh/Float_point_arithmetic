module fp_adder (number_1, number_2, out);

input [31:0] number_1, number_2;
output reg [31:0] out;

reg sign[2:0];
reg [7:0] exp[2:0];
reg [22:0] mantis[2:0];
reg carry;

reg m[2:0];

wire [31:0] out_norm;

normalize_fp nm ({sign[2], exp[2], mantis[2]}, out_norm);

always @(*)
begin
    {sign[0], exp[0], mantis[0]} = number_1;
    {sign[1], exp[1], mantis[1]} = number_2;

    m[0] = mantis[0];
    m[1] = mantis[1];

    mantis[0] = mantis[0] >> 1;
    mantis[0] = {1'b1, mantis[0][21:0]};
    mantis[1] = mantis[1] >> 1;
    mantis[1] = {1'b1, mantis[1][21:0]};
    exp[0] = exp[0] + 1;
    exp[1] = exp[1] + 1;

    if (exp[0] > exp[1]) begin
        mantis[1] = mantis[1] >> (exp[0] - exp[1]);
        exp[2] = exp[0];
    end
    else if (exp[0] < exp[1]) begin
        mantis[0] = mantis[0] >> (exp[1] - exp[0]);
        exp[2] = exp[1];
    end
    else begin
        exp[2] = exp[1];
    end

    if (~(sign[0]^sign[1])) begin
        {carry, mantis[2]} = mantis[0] + mantis[1];
        sign[2] = sign[0];

        if (!carry) begin
            mantis[2] = mantis[2] << 1;
            exp[2] = exp[2] - 1;
        end
        mantis[2] = mantis[2] + m[0] + m[1];
        out = {sign[2], exp[2], mantis[2]};
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
        
        out = {out_norm[31], out_norm[30:23]-1'b1, out_norm[21:0], 1'b0};
    end 
end

endmodule
