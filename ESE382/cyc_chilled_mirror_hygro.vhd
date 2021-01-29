-------------------------------------------------------------------------------
--
-- Title       : cyc_chilled_mirror_hygro
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
-- top level structure for the whole cycling chilled mirror system
-- structure approch was used
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity cyc_chilled_mirror_hygro is 
	port (
	start : in std_logic;
	dps : in std_logic;
	adc_out : in std_logic;
	clk : in std_logic;
	rst_bar : in std_logic;
	en_tec : out std_logic;
	c_h : out std_logic;
	convst : out std_logic;
	sclk : out std_logic;
	seven_seg0, seven_seg1 : out std_logic_vector(6 downto 0)
	);
end;	

architecture stracture of cyc_chilled_mirror_hygro is 
signal convsts : std_logic;
signal sclk_dis : std_logic;
signal start_neg : std_logic;

begin 
	u0: entity temp_meas_sys 
		port map(
		convst => convsts,
		adc_out => adc_out,
		clk => clk,
		rst_bar => rst_bar,
		sclk =>sclk,
		seven_seg0 => seven_seg0,
		seven_seg1 => seven_seg1,
		sclk_dis => sclk_dis
		);	 
		
	u1: entity edge_det 
		port map(
		pos => '0',
		rst_bar => rst_bar,
		sig => start,
		clk => clk,
		sig_edge =>	start_neg
		);		
		
	u2: entity control_fsm 
		port map(
		start_neg => start_neg,
		dps => dps,
		sclk_dis => sclk_dis,
		rst_bar => rst_bar,
		clk => clk,
		en_tec => en_tec,
		c_h => c_h,
		convst => convsts
		);	 
		
		convst <= convsts;
	end;
	
