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

  component nios_system is
  	port (
  		clk_clk            : in  std_logic                    := 'X';             -- clk
  		reset_reset_n      : in  std_logic                    := 'X';             -- reset_n
  		switches_export    : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
  		pushbuttons_export : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
  		hex0_export        : out std_logic_vector(6 downto 0)                     -- export
   	);
   end component nios_system;
   
---------------------------------- Componet List end ---------------------------------------
end components;