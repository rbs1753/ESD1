-------------------------------------------------------------------------
-- Ryan Salmon
-- 02/19/2025
-- Lab 4 pre-Lab
-- Top level file containing the FSM, Register Logic
-------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

Entity servo_controller is
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
End Entity servo_controller;
 

Architecture model of servo_controller is

signal min_angle  : unsigned(31 downto 0) := x"0000C350";
signal max_angle  : unsigned(31 downto 0) := x"000186A0";
signal angle_cnt  : unsigned(31 downto 0) := x"0000C350";
signal period_cnt : unsigned(31 downto 0);

constant period : unsigned(31 downto 0) := x"000F4240";

Type state_type is (sweep_R, int_R, sweep_L, int_L);
signal current_state, next_state : state_type;



begin
 sync : process(clk, reset_n) --State transition to clock logic 
      begin
        if(reset_n = '0') then -- Active low button
          current_state <= sweep_R;
        elsif (rising_edge(clk)) then
          current_state <= next_state;
        end if;
      end process;

  
  comb: process(current_state, we, min_angle, max_angle, angle_cnt)
      begin
	    case(current_state) is
		  when sweep_R =>
		    if (angle_cnt >= max_angle) then
			  next_state <= int_R;
			else next_state <= sweep_R;
			  end if;
			 
			
		  when int_R =>
		    if(we = '1') then 
			  next_state <= sweep_L;
			  else next_state <= int_R;
			  end if;
			
		  
		  when sweep_L =>
		    if(angle_cnt <= min_angle) then
			  next_state <= int_L;
			 else next_state <= sweep_L;
			 end if;
		
		  when int_L =>
		   if(we = '1') then 
		     next_state <= sweep_R;
			else next_state <= int_L;
			end if;
			
		  when others => next_state <= sweep_R;
			
		  end case;
		end process;
		
		
  reg: process(max_angle, min_angle, we, w_data, addr, clk, reset_n)
    begin
	   if(reset_n = '0') then -- Active low button
          min_angle <= x"0000C350";
			 max_angle <= x"000186A0";
			 
        elsif (rising_edge(clk)) then
	       if(we = '1') then
		      if(addr = '0') then
		        min_angle <= unsigned(w_data);
		      else max_angle <= unsigned(w_data);
		      end if;
		  end if;
		end if;
    end process;

  counter: process(current_state, period_cnt, clk, reset_n)
    begin
		if(reset_n = '0') then -- Active low button
          period_cnt <= (others => '0');
        elsif (rising_edge(clk)) then
	     if(period_cnt = period) then
		  period_cnt <= (others => '0');
		else period_cnt <= period_cnt + x"1";
		end if;
		end if;
	 end process;
	 
	 
	angle_c : process(current_state, min_angle, max_angle, angle_cnt, clk, reset_n)
	  begin
	  if(reset_n = '0') then -- Active low button
          angle_cnt <= x"0000C350";
        elsif (rising_edge(clk)) then
	    case current_state is
		   when sweep_R =>
			  if(period_cnt = period) then
		       angle_cnt <= angle_cnt + iterator;
			  else angle_cnt <= angle_cnt;
			  end if;
			  
			  when sweep_L =>
			    if(period_cnt = period) then
		         angle_cnt <= angle_cnt - iterator;
			  else angle_cnt <= angle_cnt;
			  end if;
			  
			  when others => angle_cnt <= angle_cnt;
			  
	    end case;
		end if;
	 end process; 
	 
	 
	 
  PWM: process(period_cnt, angle_cnt, clk, reset_n)
    begin
	 if(reset_n = '0') then -- Active low button
          outwave <= '0';
    elsif (rising_edge(clk)) then
	   if(period_cnt <= angle_cnt) then
		    outwave <= '1';
		else outwave <= '0';
	   end if;
		end if;
	 end process;
	 
	 
  IRQ_P: process(current_state)
    begin
	   case current_state is
		  when int_R => IRQ  <= '1';
		  when int_L => IRQ  <= '1';
		  when others => IRQ <= '0';
		 end case;
	   end process;
			
			   


		  
end model;