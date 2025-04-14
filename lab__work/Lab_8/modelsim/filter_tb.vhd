

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;
use std.textio.all;



entity filter_tb is
end filter_tb;

architecture model of filter_tb is

component high_pass_filter is
  port (
        clk : in std_logic;                           -- CLOCK_50
        reset_n : in std_logic;                       -- active low reset
        data_in : in std_logic_vector(15 downto 0);   --Audio sample, in 16 bit fixed point format (15 bits of assumed decimal)
        filter_en : in std_logic;                     --This is enables the internal registers and coincides with a new audio sample
        data_out : out std_logic_vector(15 downto 0)  --This is the filtered audio signal out, in 16 bit fixed point format
        );
end component;

signal clk       : std_logic := '0';
signal reset_n   : std_logic := '0';
signal data_in   : std_logic_vector(15 downto 0) := (others => '0');
signal filter_en : std_logic := '0';
signal data_out  : std_logic_vector(15 downto 0):= (others => '0');
signal sim_done  : boolean := false;

constant period  : time := 20ns;

type samples is array (0 to 39) of signed(15 downto 0);
signal audioSampleArray : samples;

begin


-- clock process
  clock: process
    begin
      clk <= not clk;
      wait for period/2;
  end process; 
 
-- reset process
  async_reset: process
    begin
      wait for 2 * period;
      reset_n <= '1';
      wait;
  end process; 
  
  UUT: high_pass_filter port map(
    clk       => clk,
    reset_n   => reset_n,
    data_in   => data_in,
    filter_en => filter_en,
    data_out  => data_out
	);

  stimulus : process is
  file read_file : text open read_mode is "one_cycle_200_8k.csv";
  file results_file : text open write_mode is "output_waveform.csv";
  variable lineIn : line;
  variable lineOut : line;
  variable readValue : integer;
  variable writeValue : integer;
  begin
  wait for 100 ns;
  -- Read data from file into an array
  for i in 0 to 39 loop
  readline(read_file, lineIn);
  read(lineIn, readValue);
  audioSampleArray(i) <= to_signed(readValue, 16);
  wait for 50 ns;
  end loop;
  file_close(read_file);
  -- Apply the test data and put the result into an output file
  for i in 1 to 10 loop
  for j in 0 to 39 loop
  -- Your code here...
  data_in <= std_logic_vector(audioSampleArray(j));  -- Read the data from the array and apply it to Data_In
  wait for 20 ns;
  filter_en <= '1'; -- Remember to provide an enable pulse with each new sample
  wait for 20 ns;
  filter_en <= '0';
  writeValue := to_integer(signed(data_out)); -- Write filter output to file
  write(lineOut, writeValue);
  writeline(results_file, lineOut);
    -- Your code here...
  end loop;
  end loop;
  file_close(results_file);
  -- end simulation
  sim_done <= true;
  wait for 100 ns;
  -- last wait statement needs to be here to prevent the process
  -- sequence from restarting at the beginning
  wait;
  end process stimulus;
  
 end model;