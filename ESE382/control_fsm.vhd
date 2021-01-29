-------------------------------------------------------------------------------
--
-- Title       : control_fsm
-- Design      : lab12
-- Author      : xiaomin wu
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\
-- Generated   : Wed Mar 15 13:13:04 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- finite state machine using three processes structure.
-- to control the cycling chilled mirror system and 
-- the temperature measurment. 
-- Temperature measurement was controlled by outputting signals to
-- the temperature meas_system
------------------------------------------------------------------------------- 
library ieee;
 use ieee.std_logic_1164.all;
 
entity control_fsm is 
	port(
	start_neg : in std_logic;
	dps : in std_logic;
	sclk_dis : in std_logic;
	rst_bar : in std_logic;
	clk : in std_logic;
	en_tec : out std_logic;
	c_h : out std_logic;
	convst : out std_logic
	);						
end control_fsm;


architecture three_process of control_fsm is 
type state is (idle,dpscheck,heat1,heat2,cool,tempmeas);
signal present_state, next_state : state;
begin 
	state_reg: process (clk)
	begin
		if	rising_edge(clk) then 
			if rst_bar = '0' then 
				present_state <= idle;
			else 
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	outputs: process(present_state)
	begin 
		case present_state is 
			when heat1 =>
			en_tec <= '1';
			c_h <= '0';	  --heat
			convst <= '0';
			when cool =>
			en_tec <= '1';
			c_h <= '1';	  --cool
			convst <= '1';
			when heat2 =>
			en_tec <= '1';
			c_h <= '0';
			convst <= '0';
			when others =>
			en_tec <= '0';
			c_h <= '0';
			convst <= '0'; 
		end case;
	end process;
	
	nxt_state: process (present_state, start_neg, dps, sclk_dis)
	begin 
		case present_state is 
			when idle =>
			if start_neg = '1' then 
				next_state <= dpscheck;
			else 
				next_state <= idle;
			end if;	   
			
			when dpscheck =>
			if dps = '1' then 
				next_state <= heat1;
			elsif dps = '0' then 
				next_state <= cool;
			else 
				next_state <= dpscheck;
			end if;
			
			when heat1 =>
			if dps = '0' then 
				next_state <= cool;
			else 
				next_state <= heat1;
			end if;
			
			when cool =>
			if dps = '1' then 
				next_state <=tempmeas;
			else
				next_state <= cool;
			end if;
				
			when tempmeas =>
			if sclk_dis = '1' then 
				next_state <= heat2;
			else 
				next_state <= tempmeas;
			end if;
			
			when heat2 =>
			if dps = '0' then 
				next_state <= idle;
			else 
				next_state <= heat2;
			end if;
			
			
			when others =>
			next_state <= Idle;
			
			end case;
		end process;
	end;
