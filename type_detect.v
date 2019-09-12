module type_detect (exp, mantis, type);

input [7:0] exp;
input [22:0] mantis;
output reg [2:0] type;

parameter [2:0] ZERO      = 3'b000,
                INF       = 3'b001,
                SUBNORMAL = 3'b010,
                NORMAL    = 3'b011,
                NAN       = 3'b100;

always @(*) begin
    if (|exp) begin
        if (&exp) begin
            if (|mantis) type = NAN;
            else         type = INF;
        end
        else             type = NORMAL;
    end
    else begin
        if (|mantis)     type = SUNNORMAL;
        else             type = ZERO;
    end
end

endmodule
