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

component nios_system is
		port (
			clk_clk                         : in  std_logic                    := 'X';             -- clk
			hex0_export                     : out std_logic_vector(6 downto 0);                    -- export
			hex1_export                     : out std_logic_vector(6 downto 0);                    -- export
			hex2_export                     : out std_logic_vector(6 downto 0);                    -- export
			hex3_export                     : out std_logic_vector(6 downto 0);                    -- export
			hex4_export                     : out std_logic_vector(6 downto 0);                    -- export
			hex5_export                     : out std_logic_vector(6 downto 0);                    -- export
			pushbuttons_export              : in  std_logic_vector(3 downto 0) := (others => 'X'); -- export
			reset_reset_n                   : in  std_logic                    := 'X';             -- reset_n
			switches_export                 : in  std_logic_vector(7 downto 0) := (others => 'X'); -- export
			willysmickynackerbacker_outwave : out std_logic                                        -- outwave
		);
	end component nios_system;
   
---------------------------------- Componet List end ---------------------------------------
end components;