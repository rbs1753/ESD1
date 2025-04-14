vlib work
vcom -93 -work work ../ip/raminfr.vhd
vcom -93 -work work ../../Lab_7/synchronizer.vhd
vcom -93 -work work ../../Lab_7/components.vhd
vcom -93 -work work ../../Lab_7/Lab7.vhd
vcom -93 -work work ../../Lab_7/ram_tb.vhd
vsim -voptargs=+acc ram_tb
do wave.do
run 60000 ns
