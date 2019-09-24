module extender (mantis, type_number, mantis_out);

input [22:0] mantis;
input [2:0] type_number;
output [27:0] mantis_out;

parameter [2:0] NORMAL = 3'b011;

assign mantis_out = type_number == NORMAL ? 
                    {1'b1, mantis, 4'b0000}: 
                    {mantis, 5'b0000};

endmodule
