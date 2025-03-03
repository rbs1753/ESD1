-------------------------------------------------------------------------------
-- ESD 1 Lab 4 Testbench File
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity servo_tb is
end servo_tb;


architecture model of servo_tb is 

component servo_controller is
   Generic(
	     iterator : integer(13 downto 0) := 1000 
	);
	Port(
	     we         : in std_logic := '0';
		 addr       : in std_logic := '0';
		 w_data     : in std_logic_vector(31 downto 0);
	     clk        : in  std_logic;
	     reset_n    : in  std_logic;
		 outwave    : out std_logic;
		 IRQ        : out std_logic;
		 ); 
End component servo_controller;
 

constant period       : time := 20ns;                                              
signal clk            : std_logic := '0';
signal reset_n        : std_logic := '0';

signal we             : std_logic;
signal addr           : std_logic;
signal w_data         : std_logic_vector(31 downto 0);
signal min            : unsigned(31 downto 0) := 50000;
signal max            : unsigned(31 downto 0) := 100000;
signal outwave        : std_logic;
signal IRQ            : std_logic;

begin

	clock: process
	  begin
		clk <= not clk;
		wait for period/2;
	end process; 
	
	async_reset: process
	  begin
        wait for 2 * period;
        reset <= '1';
      wait;
    end process; 
	
	uut: servo_controller 
	    generic map(iterator => 10000)
		port map(
		  clk      => clk,
		  reset_n  => reset_n,
		  we       => we,
		  addr     => addr,
		  w_data   => w_data,
		  outwave  => outwave,
		  IRQ      => IRQ
		  );
		  
    sequential_tb: process
	  begin
	    wait 100 ms
		we => '1';
		wait 20 ns;
		we => '0';
		wait 100 ms;
		we => '1';
		wait 20 ns;
		
      end process;
		
	    



end model;
		  