-------------------------------------------------------------------------
-- Ryan Salmon
-- 02/28/2025
-- Lab 4 
-- Top level file for hardware testing
-------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components.all;

Entity Lab4 is
  Port(CLOCK_50     : in std_logic;
       KEY          : in std_logic_vector(3 downto 0);
	   GPIO_0       : out std_logic_vector(35 downto 0)
	   );
End Entity Lab4;

architecture model of Lab4 is

------------------- Signal Declaration -------------------
signal KEY_Sync : std_logic_vector(3 downto 0);
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

	functional: servo_controller port map(
	   we      => '1',
		addr    => '0',
		w_data  => x"0000C34F",
		clk     => CLOCK_50,
		reset_n => reset_n,
		outwave => GPIO_0(3),
		IRQ     => open);
end model;