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
