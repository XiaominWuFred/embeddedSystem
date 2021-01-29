-------------------------------------------------------------------------------
--
-- Title       : adc_fsm
-- Design      : lab10
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
-- inputs: 	sig_edge, eod, sclk_dis, rst_bar, clk 
-- outputs: enable_count, sclk_en.
------------------------------------------------------------------------------- 

library ieee;
 use ieee.std_logic_1164.all;
 
entity adc_fsm is 
	port(
	sig_edge : in std_logic;
	eod : in std_logic;
	sclk_dis : in std_logic;
	rst_bar : in std_logic;
	clk : in std_logic;
	enable_count : out std_logic;
	sclk_en : out std_logic
	);						
end adc_fsm;


architecture three_process of adc_fsm is  
type state is (Idle,Delay,Read);
signal present_state, next_state : state;
begin 
	state_reg: process (clk)
	begin
		if	rising_edge(clk) then 
			if rst_bar = '0' then 
				present_state <= Idle;
			else 
				present_state <= next_state;
			end if;
		end if;
	end process;
	
	outputs: process(present_state)
	begin 
		case present_state is 
			when Delay =>
			enable_count <= '1';
			sclk_en <= '0';
			when Read =>
			sclk_en <= '1';
			enable_count <= '0';
			when others =>
			sclk_en <= '0';
			enable_count <= '0';   
		end case;
	end process;
	
	nxt_state: process (present_state, eod, sig_edge, sclk_dis)
	begin 
		case present_state is 
			when Idle =>
			if sig_edge = '1'then 
				next_state <= Delay;
			elsif sig_edge = '0' then 
				next_state <=Idle;
			else 
				next_state <= Idle;
			end if;	   
			
			when Delay =>
			if eod = '1' then 
				next_state <= Read;
			else 
				next_state <= Delay;
			end if;
			
			when Read =>
			if sclk_dis = '1' then 
				next_state <= Idle;
			else 
				next_state <= Read;
			end if;
			
			when others =>
			next_state <= Idle;
			
			end case;
		end process;
	end;
	
				