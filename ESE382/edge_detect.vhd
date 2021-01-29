-------------------------------------------------------------------------------
--
-- Title       : edge_det
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
-- edge detector using sequencial design
-- can detect positive edge when pos = '1', negative edge when pos = '0'
-- generates one system clock width pulse after detection.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity edge_det is 
	port(
	pos : in std_logic;
	rst_bar : in std_logic;
	sig: in std_logic;
	clk: in std_logic;
	sig_edge: out std_logic
	);						
end;

architecture behavior of edge_det is 
begin 
	process(clk,rst_bar)
	variable memory: std_logic := '0';
	begin
		if rst_bar = '0' then
			sig_edge <= '0';   
			memory := '0';
		elsif rising_edge(clk) then 
			if pos = '1'then
				
				if memory = '0' and sig = '1' then 
				sig_edge <= '1';
				elsif memory = '1' and  sig = '1' then 
				sig_edge <= '0';
				end if;
			
				memory := sig;
			
			elsif pos ='0' then 
				
				if memory = '1' and sig = '0' then 
				sig_edge <= '1';
				elsif memory = '0' and  sig = '0' then 
				sig_edge <= '0';
				end if;
			
				memory := sig; 
			end if;
		end if;
	end process;
end;