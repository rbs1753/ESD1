
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

entity dffeee is
  port(
       d       : in  std_logic_vector(15 downto 0);
	   q       : out std_logic_vector(15 downto 0);
	   clk     : in std_logic;
	   enable  : in std_logic;
	   reset_n : in std_logic
	   );
end dffeee;

architecture model of dffeee is

begin
  process(d, clk, reset_n, enable)
  begin
	if(reset_n ='0') then
	  q <= (others => '0');
	elsif(rising_edge(clk)) then
	  if(enable = '1') then
	    q <= d;
	   end if;
	end if;
	end process;
	
end model;