vlib work
vcom -93 -work work ../multi.vhd
vcom -93 -work work ../dffeee.vhd
vcom -93 -work work ../high_pass_filter.vhd
vcom -93 -work work filter_tb.vhd
vsim -voptargs=+acc filter_tb
do wave.do

