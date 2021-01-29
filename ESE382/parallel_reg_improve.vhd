-------------------------------------------------------------------------------
--
-- Title       : parallel_reg
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
-- parralel in parralel out register to improve the system from
-- data changing glitch caused by shift register
------------------------------------------------------------------------------- 

library ieee;
use ieee.std_logic_1164.all;

entity parallel_reg is 
	port (
	parallel_in : in std_logic_vector (7 downto 0);
	parallel_out : out std_logic_vector(7 downto 0);
	clk : in std_logic;
	rst_bar : in std_logic
	);
end;

architecture behavior of parallel_reg is 
begin 
	process(clk)
	begin 	
		if rising_edge(clk) then
			if rst_bar = '0' then 
				parallel_out <= "00000000";
			else
				parallel_out <= parallel_in;
			end if;
		end if;
	end process;
end;

			