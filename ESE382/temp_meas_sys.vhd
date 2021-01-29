-------------------------------------------------------------------------------
--
-- Title       : temp_meas_sys
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
-- top-level structure for the temperature measure system
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity temp_meas_sys is 
	port(
	convst : in std_logic;
	adc_out : in std_logic;
	clk: in std_logic;
	rst_bar : in std_logic;
	sclk : out std_logic;	
	sclk_dis : out std_logic;
	seven_seg0, seven_seg1: out std_logic_vector(6 downto 0)
	);													  
end temp_meas_sys;

architecture improved of temp_meas_sys is 
signal adc_result: std_logic_vector(7 downto 0);  
signal parallel_out: std_logic_vector(7 downto 0);
begin  
	u0: entity binary_7segment
		port map(
		binary=> parallel_out,
		seven_seg0 => seven_seg0,
		seven_seg1 => seven_seg1
		);
		
	u1: entity fsm_adc_cntrl
		port map(
		convst=> convst,
		adc_out=>adc_out,
		clk=>clk,
		rst_bar=>rst_bar,
		adc_result=>adc_result,	
		sclk_dis => sclk_dis,
		sclk=>sclk
		);	   
	u3: entity parallel_reg
		port map(
		clk=>clk,
		rst_bar=>rst_bar,
		parallel_in =>adc_result,
		parallel_out=>parallel_out
		);
		
end architecture;