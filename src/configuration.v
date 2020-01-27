// `define HALF_PRECISION
`define SINGLE_PRECISION
// `define DOUBLE_PRECISION

`ifdef HALF_PRECISION
    `define EXP_SIZE     5
    `define MANTIS_SIZE 10
`elsif DOUBLE_PRECISION
    `define EXP_SIZE    11
    `define MANTIS_SIZE 52
`else
    `define EXP_SIZE    8
    `define MANTIS_SIZE 23
`endif

`define NUMBER_SIZE (1 + EXP_SIZE + MANTIS_SIZE)

// localparam EXP_SIZE = PRECISION == HALF   ? 5 :
//                       PRECISION == SINGLE ? 8 :
//                                             11;
// 
// localparam MANTIS_SIZE = PRECISION == HALF   ? 10:
//                          PRECISION == SINGLE ? 23:
//                                                52;
