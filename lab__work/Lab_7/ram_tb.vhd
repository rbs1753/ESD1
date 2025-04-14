-------------------------------------------------------------------------------
-- ESD 1 Lab 7 Testbench File
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity ram_tb is
end ram_tb;


architecture model of ram_tb is 
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
signal writebyteenable_n :  std_logic_vector(3 downto 0):= "1111";
signal address :  std_logic_vector(11 DOWNTO 0):= (others => '0');
signal writedata :  std_logic_vector(31 DOWNTO 0):=(others => '0');
signal readdata :  std_logic_vector(31 DOWNTO 0):= (others => '0');

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

  UUT: raminfr Port Map(
    clk               => clk,
	reset_n           => reset_n,
	writebyteenable_n => writebyteenable_n,
	address           => address,
	writedata         => writedata,
	readdata          => readdata
	);

  ram_test: process
  begin
  
   wait for 4 * period;
  
	writebyteenable_n <= "0000"; --Set write enable to full range
	writedata         <= x"12345678"; --Full 32-bit test
	wait for period;
    for i in 0 to 4095 loop
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"12345678"
	    report"Data Failure";
	end loop;
	
	
------------------------------------- End of 32-bit test -------------------------------------

	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1100"; --Set write enable to half range
	writedata <= x"00001234";
	wait for period;
	for i in 0 to 4095 loop --Test top half of ram
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"12341234"
	    report"Data Failure";
	  
	end loop;
	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "0011"; --Set write enable to half range
	writedata <= x"56780000";
	wait for period;
	for i in 0 to 4095 loop --Test bottom half of ram
	  wait for period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"56781234"
	    report"Data Failure";
	end loop;
	
------------------------------------- End of 16-bit test -------------------------------------
	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1110"; --Set write enable to 1-byte range
	writedata <= x"00000011";
	wait for period;
	for i in 0 to 4095 loop
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"56781211"
	    report"Data Failure";
	  
	end loop;
	
------------------------------------- End of RAM1 test -------------------------------------

	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1101"; --Set write enable to 1-byte range
	writedata <= x"00003300";
	wait for period;
	for i in 0 to 4095 loop
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"56783311"
	    report"Data Failure";
	end loop;
	
------------------------------------- End of RAM2 test -------------------------------------

	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "1011"; --Set write enable to 1-byte range
	writedata <= x"00440000";
	wait for period;
	
	for i in 0 to 4095 loop
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"56443311"
	    report"Data Failure";
	end loop;
	
------------------------------------- End of RAM3 test -------------------------------------
	
	address           <= (others => '0'); --Reset Address to 0
	writebyteenable_n <= "0111"; --Set write enable to 1-byte range
	writedata <= x"55000000";
	wait for period;
	for i in 0 to 4095 loop
	  wait for 2 * period;
	  address <= std_logic_vector(to_unsigned(i, 12));
	  assert readdata = x"55443300"
	    report"Data Failure";
	end loop;
------------------------------------- End of RAM4 test -------------------------------------
	wait;
	end process;
	
end model;