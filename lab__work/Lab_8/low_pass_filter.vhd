-------------------------------------------------------------------------------
-- Ryan Salmon
-- Code I definitly did work on, top level for lab 8!
-- Testing custom made low pass filter in simulation
-------------------------------------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.ALL;
use ieee.numeric_std.all;


Entity low_pass_filter is
  port (
        clk : in std_logic;                           -- CLOCK_50
        reset_n : in std_logic;                       -- active low reset
        data_in : in std_logic_vector(15 downto 0);   --Audio sample, in 16 bit fixed point format (15 bits of assumed decimal)
        filter_en : in std_logic;                     --This is enables the internal registers and coincides with a new audio sample
        data_out : out std_logic_vector(15 downto 0)  --This is the filtered audio signal out, in 16 bit fixed point format
        );
end low_pass_filter;

architecture model of low_pass_filter is

type sample is array (0 to 16) of std_logic_vector(15 downto 0); --Array to hold samples
constant values: sample := (x"0051", x"00BA", x"01E1", x"0408", x"071A", x"0AAC", x"0E11", x"107F", x"1161", x"107F", x"0E11", x"0AAC", x"071A", x"0408", x"01E1", x"00BA", x"0051");
type data_reg is array (0 to 16) of std_logic_vector(15 downto 0);  
type data_out32 is array (0 to 16) of std_logic_vector(31 downto 0);
signal data_shift: data_reg:= (others => (others => '0')); --Array to hold the data coming in
signal data_mul  : data_out32 := (others => (others => '0')); --Hold the 32-bit multiplication output
signal sample_val : sample := (others => (others => '0'));

signal sum        : signed(31 downto 0);

component multi IS
	PORT
	(
		dataa		: IN STD_LOGIC_VECTOR  (15 DOWNTO 0);
		datab		: IN STD_LOGIC_VECTOR  (15 DOWNTO 0);
		result	: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component dffeee is
  port(
       d       : in  std_logic_vector(15 downto 0);
	   q       : out std_logic_vector(15 downto 0);
	   clk     : in std_logic;
	   enable  : in std_logic;
	   reset_n : in std_logic
	   );
end component;

begin

  process(filter_en)
  begin
    if(filter_en = '1') then
      data_shift(0) <= data_in;
    end if;
  end process;

  watthesigma: for i in 1 to 16 generate
	bruh: dffeee port map(
	     d => data_shift(i - 1),
		 q => data_shift(i),
		 clk => clk,
		 reset_n => reset_n,
		 enable => filter_en
		 );
    end generate;
	 
 
	  Multiplier: for i in 0 to 16 generate
	    munchies: multi port map(
		   dataa => data_shift(i),
			datab => values(i),
			result => data_mul(i));
	  end generate Multiplier;


        sum <= signed(data_mul(0)) + signed(data_mul(1)) + signed(data_mul(2)) + signed(data_mul(3))
		       + signed(data_mul(4)) + signed(data_mul(5)) + signed(data_mul(6))+ signed(data_mul(7)) 
				 + signed(data_mul(8)) + signed(data_mul(9)) + signed(data_mul(10)) + signed(data_mul(11))
				 + signed(data_mul(12)) + signed(data_mul(13)) + signed(data_mul(14)) + signed(data_mul(15))
				 + signed(data_mul(16));
   

    data_out <= std_logic_vector(sum(30 downto 15));
	 
	 
end model;	
	
	   
	
	
	