-------------------------------------------------------------------------
-- Ryan Salmon
-- 03/19/2025
-- Lab 5 pre-Lab
-- Top level file containing the connection to nios system
-------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use work.components.all;

Entity Lab5 is
  Port(
    CLOCK_50  : in  std_logic;
    KEY       : in  std_logic_vector(3 downto 0);
    SW        : in  std_logic_vector(7 downto 0);
    HEX5      : out std_logic_vector(6 downto 0);
    HEX4      : out std_logic_vector(6 downto 0);
    HEX3      : out std_logic_vector(6 downto 0);
    HEX2      : out std_logic_vector(6 downto 0);
    HEX1      : out std_logic_vector(6 downto 0);
    HEX0      : out std_logic_vector(6 downto 0);
    GPIO_0    : out std_logic_vector(35 downto 0)
    );
End Lab5;

Architecture model of Lab5 is

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
            clk_clk                         => CLOCK_50,                         --                     clk.clk
            hex0_export                     => HEX0,                     --                    hex0.export
            hex1_export                     => HEX1,                     --                    hex1.export
            hex2_export                     => HEX2,                     --                    hex2.export
            hex3_export                     => HEX3,                     --                    hex3.export
            hex4_export                     => HEX4,                     --                    hex4.export
            hex5_export                     => HEX5,                     --                    hex5.export
            pushbuttons_export              => KEY_Sync,              --             pushbuttons.export
            reset_reset_n                   => reset_n,                   --                   reset.reset_n
            switches_export                 => SW_Sync,                 --                switches.export
            willysmickynackerbacker_outwave => GPIO_0(3)  -- willysmickynackerbacker.outwave
        );


End model;