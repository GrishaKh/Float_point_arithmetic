vlib work

vlog -work work ./src/*v

vsim -lib work work.fpa_tb
run -all
