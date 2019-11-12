module extender (mantis, type_number, mantis_out);

input [22:0] mantis;
input [2:0] type_number;
output [25:0] mantis_out;

parameter [2:0] NORMAL = 3'b011;

assign mantis_out = type_number == NORMAL ? 
                    {1'b1, mantis, 2'b00}: 
                    {mantis, 3'b000};

endmodule
