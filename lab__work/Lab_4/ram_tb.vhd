-------------------------------------------------------------------------------
-- ESD 1 Lab 7 Testbench File
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity RAM_TB is
end RAM_TB;


architecture model of RAM_TB is 
component raminfr IS
  PORT(
    clk : IN std_logic;
    reset_n : IN std_logic;
    writebyteenable_n : IN std_logic_vector(3 downto 0);
    address : IN std_logic_vector(11 DOWNTO 0);
    writedata : IN std_logic_vector(31 DOWNTO 0);
    readdata : OUT std_logic_vector(31 DOWNTO 0)
);
END component raminfr;

constant period       : time := 20ns;                                              
signal clk            : std_logic := '0';
signal reset_n        : std_logic := '0';
signal writebyteenable_n :  std_logic_vector(3 downto 0);
signal address :  std_logic_vector(11 DOWNTO 0);
signal writedata :  std_logic_vector(31 DOWNTO 0);
signal readdata :  std_logic_vector(31 DOWNTO 0);

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
      reset <= '0';
      wait;
  end process; 

  UUT: raminfr Port Map(
    clk               => clk,
	reset_n           => reset_n,
	writebyteenable_n => writebyteenable_n,
	address           => address,
	writedata         => writedata,
	readdata          => readdata
	);
	
  ram_test: process
  writebyteenable_n <= "1111"; --Default values
  writedata         <= x"12345678"; --Full 32-bit test
  address           <= (others => '0'); --Reset Address to 0
  
  begin
	writebyteenable_n <= "0000"; --Set write enable to full range
    for i in 0 to 4095 loop
	  address <= std_logic_vector(to_unsigned(i, 12));
	end loop;
	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1100"; --Set write enable to half range
	writedata <= x"00001234";
	
	for i in 0 to 4095 loop
	  address <= std_logic_vector(to_unsigned(i, 12));
	end loop;
	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1110"; --Set write enable to 1-byte range
	writedata <= x"00000012";
	
	for i in 0 to 4095 loop
	  address <= std_logic_vector(to_unsigned(i, 12));
	end loop;
	
	end process;
	
end model;