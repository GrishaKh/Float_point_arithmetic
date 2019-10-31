module init_number (
    number,
    sign,
    exp,
    mantis,
    ext_mantis,
    type
);

input [31:0] number;
output sign;
output [7:0] exp;
output [22:0] mantis;
output [27:0] ext_mantis;
output [2:0] type;

div_number __div_number
(
    .number (number),
    .sign (sign),
    .exp (exp),
    .mantis (mantis)
);

type_detect __type_number
(
    .type (type),
    .exp (exp),
    .mantis (mantis)
);

extender __extender (
    .mantis (mantis),
    .type_number (type),
    .mantis_out (ext_mantis)
);


endmodule // init_number
