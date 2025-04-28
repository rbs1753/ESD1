--------------------------------------------------------------------------------
-- Ryan Salmon
-- 4/16/25
-- Lab 9 top level file, for audio purposes of course ;)
--------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



entity Lab_9 is

  Port (clk, reset_n : in std_logic;
        write : in std_logic;
        address : in std_logic;
        writedata : in std_logic_vector(15 downto 0);
        readdata :out std_logic_vector(15 downto 0)
        );
		  
end Lab_9;

architecture model of Lab_9 is


component filter is
  port (
        clk        : in std_logic;                       -- CLOCK_50
        reset_n    : in std_logic;                       -- active low reset
		address    : in std_logic;
        data_in    : in std_logic_vector(15 downto 0);   --Audio sample, in 16 bit fixed point format (15 bits of assumed decimal)
        filter_en  : in std_logic;                       --This is enables the internal registers and coincides with a new audio sample
        data_out   : out std_logic_vector(15 downto 0)    --This is the filtered audio signal out, in 16 bit fixed point format
        );
end component;




Begin

	Filter_mux: filter port map(
	  clk        => clk,
	  reset_n    => reset_n,
	  address    => address,
	  data_in    => writedata,
	  filter_en  => write, 
	  data_out   => readdata
	  );
	  
end model;