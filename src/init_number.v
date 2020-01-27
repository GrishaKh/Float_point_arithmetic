`include "configuration.v"

module init_number
#(
    parameter EXP_SIZE    = `EXP_SIZE,
    parameter MANTIS_SIZE = `MANTIS_SIZE
)
(
    number,
    sign,
    exp,
    mantis,
    ext_mantis,
    type
);

// Inputs
input [(1+EXP_SIZE+MANTIS_SIZE)-1:0] number;

// Outputs
output                       sign;
output [EXP_SIZE       -1:0] exp;
output [ MANTIS_SIZE   -1:0] mantis;
output [(MANTIS_SIZE+3)-1:0] ext_mantis;
output [2:0]                 type;

//Instances
div_number __div_number
(
    .number (number),
    .sign   (sign),
    .exp    (exp),
    .mantis (mantis)
);

type_detect __type_number
(
    .type   (type),
    .exp    (exp),
    .mantis (mantis)
);

extender __extender
(
    .mantis      (mantis),
    .type_number (type),
    .mantis_out  (ext_mantis)
);


endmodule // init_number
