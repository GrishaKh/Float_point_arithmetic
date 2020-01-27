`include "configuration.v"

module special_cases
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    sign_A,
    sign_B,
    exp_A,
    exp_B,
    mantis_A,
    mantis_B,
    type_A,
    type_B,
    result,
    special_case
);

// Parameters
parameter [2:0] ZERO      = 3'b000,
                INF       = 3'b001,
                SUBNORMAL = 3'b010,
                NORMAL    = 3'b011,
                NAN       = 3'b100;

// Inputs
input                   sign_A;
input                   sign_B;
input [EXP_SIZE   -1:0] exp_A;
input [EXP_SIZE   -1:0] exp_B;
input [MANTIS_SIZE-1:0] mantis_A;
input [MANTIS_SIZE-1:0] mantis_B;
input [2:0]             type_A;
input [2:0]             type_B;

// Outputs
output reg [(1+EXP_SIZE+MANTIS_SIZE)-1:0] result;
output reg                                special_case;

// Combinational block
always @(*) begin
    if (type_A == NAN && type_B == NAN) begin
        special_case = 1'b1;
        result = (mantis_A[MANTIS_SIZE-1:0] >= mantis_B[MANTIS_SIZE-1:0]) ? 
                 (mantis_A[MANTIS_SIZE-1:0] == mantis_B[MANTIS_SIZE-1:0]) ?
                                                      {sign_A&sign_B, exp_A, 1'b1, mantis_A[MANTIS_SIZE:0]}:
                                                      {sign_A, exp_A, 1'b1, mantis_A[MANTIS_SIZE-1:0]}:
				    		                          {sign_B, exp_B, 1'b1, mantis_B[MANTIS_SIZE-1:0]};
    end
    else if (type_A == ZERO && type_B == ZERO) begin
        special_case = 1'b1;
        result       = {sign_A&sign_B, {((1+EXP_SIZE+MANTIS_SIZE)-1){1'b0}}};
    end
    else if (type_A == ZERO || type_B == NAN) begin
        special_case = 1'b1;
        result       = type_B == NAN ? {sign_B, exp_B, 1'b1, mantis_B[MANTIS_SIZE-1:0]}:
				                       {sign_B, exp_B, mantis_B};
    end
    else if (type_B == ZERO || type_A == NAN) begin
        special_case = 1'b1;
        result       = type_A == NAN ? {sign_A, exp_A, 1'b1, mantis_A[MANTIS_SIZE-1:0]}: 
		                               {sign_A, exp_A, mantis_A};
    end
    else if (type_A == INF) begin
        special_case = 1'b1;
        if (type_B == NORMAL || type_B == SUBNORMAL) begin
            result = {sign_A, exp_A, mantis_A};
        end
        else begin // type_B == INF
            if (sign_A == sign_B) result = {sign_A, {EXP_SIZE{1'b1}}, {MANTIS_SIZE{1'b0}}};
            else                  result = {1'b1, {EXP_SIZE{1'b1}}, 1'b1, {(MANTIS_SIZE-1){1'b0}}};
        end
    end
    else if (type_B == INF) begin
        special_case = 1'b1;
        result       = {sign_B, exp_B, mantis_B};
    end
    else begin
        special_case = 1'b0;
        result       = {(1+EXP_SIZE+MANTIS_SIZE){1'b0}};
    end
end

endmodule // special cases
