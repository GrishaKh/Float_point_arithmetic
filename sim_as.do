vlib work

vlog -work work ./src/*.v
vlog -work work ./src/fpa_assert.sv

vsim -lib work work.fpa_tb
run -all
