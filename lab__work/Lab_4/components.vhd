-------------------------------------------------------------------------------
-- Ryan Salmon
-- components package
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package components is
---------------------------------- Componet List ---------------------------------------


component synchronizer is 
    generic (size       : integer := 2
            );
    port (
      clk               : in std_logic;
      reset_n             : in std_logic;
      async_in          : in std_logic_vector (size - 1 downto 0);
      sync_out          : out std_logic_vector (size - 1 downto 0)
    );
  end component synchronizer;

  component servo_controller is
   Generic(
	     iterator : unsigned(11 downto 0) := x"1F4"
	);
	Port(
	     we         : in std_logic;
		 addr       : in std_logic;
		 w_data     : in std_logic_vector(31 downto 0);
	     clk        : in  std_logic;
	     reset_n    : in  std_logic;
		 outwave    : out std_logic;
		 IRQ        : out std_logic
		 ); 
End component servo_controller;


   
---------------------------------- Componet List end ---------------------------------------
end components;