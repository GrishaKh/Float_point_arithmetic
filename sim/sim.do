vlib work

vlog -work work ../rtl/*v
vlog -work work *v

vsim -lib work work.fpa_tb
run -all
