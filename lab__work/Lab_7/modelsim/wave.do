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
add wave -noupdate /ram_tb/clk
add wave -noupdate /ram_tb/reset_n
add wave -noupdate -radix binary /ram_tb/writebyteenable_n
add wave -noupdate /ram_tb/address
add wave -noupdate /ram_tb/writedata
add wave -noupdate /ram_tb/readdata
add wave -noupdate /ram_tb/UUT/RAM1
add wave -noupdate /ram_tb/UUT/RAM2
add wave -noupdate /ram_tb/UUT/RAM3
add wave -noupdate /ram_tb/UUT/RAM4
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {108775 ns} 0}
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
WaveRestoreZoom {0 ns} {794745 ns}
