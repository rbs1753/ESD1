-------------------------------------------------------------------------
-- Ryan Salmon
-- 01/27/2025
-- Lab 2 pre-lab  
-- Creates Pushbuttons, Switches and a Hex output 
-- Other LEDs configured from hardcoded values
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components.all;

ENTITY Lab2 is
  port (
    CLOCK2_50 : in  std_logic;
    KEY       : in  std_logic_vector(3 downto 0);
	SW        : in  std_logic_vector(9 downto 0);
    HEX0      : out std_logic_vector(6 downto 0)
   );
   
end entity Lab2;

architecture model of Lab2 is

  signal KEY0_sync    : std_logic_vector(3 downto 0);

  signal switch_sync  : std_logic_vector(9 downto 0);


  signal reset_n : std_logic;


begin

 
	
	sync_keys : synchronizer 
	  generic map( 
		size => 4
		)
	  port map(
		clk      => CLOCK2_50,
		reset_n    => '1',
		async_in => KEY,
		sync_out => KEY0_sync
	);
	 reset_n <= KEY0_sync(0);
	sync_switches : synchronizer 
	  generic map( 
		size => 10
		)
	  port map(
		clk      => CLOCK2_50,
		reset_n    => reset_n,
		async_in => SW,
		sync_out => switch_sync
	);
	
	u0 : component nios_system
	port map (
		clk_clk            => CLOCK2_50,             --         clk.clk
		reset_reset_n      => reset_n,               --       reset.reset_n
		switches_export    => switch_sync(7 downto 0),           --    switches.export
		pushbuttons_export => KEY0_sync,             -- pushbuttons.export
		hex0_export        => HEX0                   --        hex0.export
	);

end model;