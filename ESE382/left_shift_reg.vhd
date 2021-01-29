-------------------------------------------------------------------------------
--
-- Title       : left_shift_reg
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
-- left shift register using sequencial design
-- shift memory to left 1 bit each time when enabled 
-- using variable to store memory.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity left_shift_reg is 
	port(
	serial_in : in std_logic;
	shift_en : in std_logic;
	clk : in std_logic;
	rst_bar : in std_logic;
	q : out std_logic_vector(7 downto 0)
	);									 
end left_shift_reg;

architecture behavior of left_shift_reg is 
begin 
	process(rst_bar, clk)
	variable memory : std_logic_vector(7 downto 0) :="00000000";
	begin 
		if rst_bar = '0' then 
			memory := "00000000";
		elsif rising_edge(clk) then 
			if shift_en = '1'then 
				memory(7 downto 1):= memory(6 downto 0);
				memory(0) := serial_in;
			end if;
		end if;	
		q <= memory;
	end process;	
end architecture;