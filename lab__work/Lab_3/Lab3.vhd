-------------------------------------------------------------------------
-- Ryan Salmon
-- 02/7/2025
-- Lab 3 pre-lab  
-- Top level file for interrupt handling with Keys 
-------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components.all;

Entity Lab3 is
  port(
    CLOCK_50  : in  std_logic;
    KEY       : in  std_logic_vector(3 downto 0);
	 SW        : in  std_logic_vector(7 downto 0);
	 LEDR      : out std_logic_vector(7 downto 0);
    HEX0      : out std_logic_vector(6 downto 0)
   );
end Lab3;

architecture model of Lab3 is 
------------------- Signal Declaration -------------------
signal KEY_Sync : std_logic_vector(3 downto 0);
signal SW_Sync  : std_logic_vector(7 downto 0);
signal reset_n  : std_logic;

------------------- Process Start ------------------------
begin
  sync_keys : synchronizer 
	generic map( 
	  size => 4
	)
	port map(
      clk      => CLOCK_50,
	  reset_n  => '1',
	  async_in => KEY,
	  sync_out => KEY_sync
	);
	
  reset_n <= KEY_sync(0);
  
  sync_switches : synchronizer 
	generic map( 
	  size => 8
	)
	port map(
	  clk      => CLOCK_50,
	  reset_n  => reset_n,
	  async_in => SW,
	  sync_out => SW_sync
	);


u0 : component nios_system
       port map (
		 clk_clk            => CLOCK_50,            --         clk.clk
		 reset_reset_n      => reset_n,      --       reset.reset_n
		 switches_export    => SW_sync,    --    switches.export
		 leds_export        => LEDR,        --        leds.export
		 hex0_export        => HEX0,        --        hex0.export
		 pushbuttons_export => KEY_Sync  -- pushbuttons.export
	   );
		
------------------- Process End -------------------------
end model;