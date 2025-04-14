onerror {resume}
radix define States {
    "7'b1000000" "0" -color "yellow",
    "7'b1111001" "1" -color "yellow",
    "7'b0100100" "2" -color "yellow",
    "7'b0110000" "3" -color "yellow",
    "7'b0011001" "4" -color "yellow",
    "7'b0010010" "5" -color "yellow",
    "7'b0000010" "6" -color "yellow",
    "7'b1111000" "7" -color "yellow",
    "7'b0000000" "8" -color "yellow",
    "7'b0011000" "9" -color "yellow",
    "7'b1111111" "Blank" -color "yellow",
    -default default
}
quietly WaveActivateNextPane {} 0
add wave -noupdate /filter_tb/UUT/clk
add wave -noupdate /filter_tb/UUT/reset_n
add wave -noupdate /filter_tb/UUT/data_in
add wave -noupdate /filter_tb/UUT/filter_en
add wave -noupdate /filter_tb/UUT/data_out
add wave -noupdate /filter_tb/UUT/data_shift
add wave -noupdate /filter_tb/UUT/data_mul
add wave -noupdate /filter_tb/UUT/sample_val
add wave -noupdate /filter_tb/UUT/sum
add wave -noupdate /filter_tb/UUT/Multiplier(0)/munchies/dataa
add wave -noupdate /filter_tb/UUT/Multiplier(0)/munchies/datab
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {21777 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {21550 ns} {22550 ns}
