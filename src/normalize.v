module normalize (
    exp_in, mantis_in,
    exp_out, mantis_out
);

input [7:0] exp_in;
input [25:0] mantis_in;
output reg [7:0] exp_out;
output reg [25:0] mantis_out;

reg [3:0] parts [5:0];
reg [5:0] shift;

function [5:0] shift_mantis;
    input [3:0] bits;
    input [5:0] dev;
    reg [5:0] res;
    begin
        casex (bits)
            4'b1xxx : res = dev;
            4'b01xx : res = dev + 1;
            4'b001x : res = dev + 2;
            default : res = dev + 3;
        endcase

        shift_mantis = res;
    end
endfunction

always @(*) begin
    {parts[5], parts[4], parts[3], parts[2], parts[1], parts[0]} = mantis_in[23:0];

    if (mantis_in[25]) shift = 0;
    else if (mantis_in[24]) shift = 1;
    else if      (|parts[5]) shift = shift_mantis(parts[5], 6'd2) ;
    else if (|parts[4]) shift = shift_mantis(parts[4], 6'd6) ;
    else if (|parts[3]) shift = shift_mantis(parts[3], 6'd10) ;
    else if (|parts[2]) shift = shift_mantis(parts[2], 6'd14);
    else if (|parts[1]) shift = shift_mantis(parts[1], 6'd18);
    else if (|parts[0]) shift = shift_mantis(parts[0], 6'd22);
    else                shift = 0                            ;

    if (exp_in >= shift) begin
        mantis_out = (mantis_in << shift);
        exp_out = (exp_in - shift);
    end
    else begin
        mantis_out = (mantis_in << exp_in);
        exp_out = 8'h00;
    end
end
endmodule
