
module nios_system (
	clk_clk,
	leds_export,
	switches_export,
	reset_reset_n);	

	input		clk_clk;
	output	[7:0]	leds_export;
	input	[7:0]	switches_export;
	input		reset_reset_n;
endmodule
