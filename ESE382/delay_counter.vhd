-------------------------------------------------------------------------------
--
-- Title       : delay_counter
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
-- delay_counter using sequencial design
-- generate 36 us delay with a 
-- one system clock width pulse after delay.
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;

entity delay_counter is 
	port (
	clear_count : in std_logic;
	enable_count : in std_logic;
	clk : in std_logic;
	rst_bar : in std_logic;
	eod : out std_logic
	);					
end;

architecture behavior of delay_counter is 
begin 
	process(rst_bar, clk, enable_count)
	variable count: integer :=0;  
	variable mark: std_logic :='0';
	begin 				 
		if rst_bar = '0' then 
			eod <= '0';
		elsif rising_edge(clk) then 
				if enable_count = '1' then 
					count := count + 1;
				end if;
				
				if clear_count = '1' then 
					count := 0;	 
				end if; 
				
				if mark = '1' then 
					eod <= '0';
					mark := '0';
					end if;
				
				if count = 36 then 
					eod <= '1';	
					mark := '1';
					count := 0;
				end if;		 
		end if;
	end process;
end architecture;
	
				
				
				
		