module special_cases
(
    sign_A, sign_B,
    exp_A, exp_B,
    mantis_A, mantis_B,
    type_A, type_B,
    result, special_case
);

parameter [2:0] ZERO      = 3'b000,
                INF       = 3'b001,
                SUBNORMAL = 3'b010,
                NORMAL    = 3'b011,
                NAN       = 3'b100;

input sign_A, sign_B;
input [7:0] exp_A, exp_B;
input [22:0] mantis_A, mantis_B;
input [2:0] type_A, type_B;
output reg [31:0] result;
output reg special_case;

always @(*) begin
    if (type_A == ZERO || type_B == NAN) begin
        special_case = 1'b1;
        result = {sign_B, exp_B, mantis_B};
    end
    else if (type_B == ZERO || type_A == NAN) begin
        special_case = 1'b1;
        result = {sign_A, exp_A, mantis_A};
    end
    else if (type_A == INF) begin
        special_case = 1'b1;
        if (type_B == NORMAL || type_B == SUBNORMAL) begin
            result = {sign_A, exp_A, mantis_A};
        end
        else if (type_B == INF) begin
            if (sign_A == sign_B) result = {sign_B, exp_B, mantis_B};
            else                  result = {1'b1, 8'hFF, 23'h000001};
        end
    end
    else if (type_B == INF) begin
        special_case = 1'b1;
        result = {sign_B, exp_B, mantis_B};
    end
    else begin
        special_case = 1'b0;
        result = 32'b0;
    end
end

endmodule
