-------------------------------------------------------------------------------
--
-- Title       : sh_adc_cntrl
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
-- top-level structural design of fsm_adc_cntrl
-- containing 7 components.
-- read data from adc convertor with timing control.
-- using finite state machine as controllor
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity fsm_adc_cntrl is 
	port(
	convst: in std_logic;
	adc_out:in std_logic;
	clk:in std_logic;
	rst_bar:in std_logic;
	sclk : out std_logic; 
	sclk_dis : out std_logic;
	adc_result :out std_logic_vector(7 downto 0)
	);
end fsm_adc_cntrl;	

architecture structural of fsm_adc_cntrl is 
signal sig_edgeu1 : std_logic;
signal eod : std_logic;	 
signal qu2 : std_logic;
signal sclk_diss: std_logic;	 
signal qu4 : std_logic;	
signal sclk1 : std_logic; 
signal sig_edgeu6 : std_logic;
begin 
	u1: entity edge_det
		port map(
		rst_bar => rst_bar,
		clk => clk,
		sig => convst,
		pos => '0',
		sig_edge => sig_edgeu1
		);	
		
	u2: entity adc_fsm
		port map(
		sig_edge=>sig_edgeu1,
		eod=>eod,
		sclk_dis=>sclk_diss,
		rst_bar=>rst_bar,
		clk=>clk,
		enable_count=>qu2,
		sclk_en=>qu4
		);
		
	u3: entity delay_counter 
		port map(
		clear_count => '0',
		enable_count => qu2,
		clk => clk,
		rst_bar => rst_bar,
		eod => eod
		);		  
		
	u5: entity sclk_gen
		port map(
		sclk_en => qu4,
		clk => clk,
		rst_bar => rst_bar,
		sclk_dis => sclk_diss,
		sclk => sclk1
		); 
		
	u6: entity edge_det
		port map(
		rst_bar => rst_bar,
		clk => clk,
		sig => sclk1,
		pos => '1',
		sig_edge => sig_edgeu6
		); 
		
	u7: entity left_shift_reg
		port map(
		serial_in => adc_out,
		shift_en => sig_edgeu6,
		clk => clk,
		rst_bar => rst_bar,
		q => adc_result
		);	
	
	sclk_dis <= sclk_diss;	
	sclk <= sclk1;
end architecture;