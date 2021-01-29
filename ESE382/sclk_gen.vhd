-------------------------------------------------------------------------------
--
-- Title       : sclk_gen
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
-- scaled clock generator using sequencial design
-- generate clock with 8 times period (1/8 frequency) of system clock
-- generates one system clock width pulse after 8 scaled clock period.
-------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all; 
use ieee.numeric_std.all;

entity sclk_gen is 
	port (
	sclk_en : in std_logic;
	clk : in std_logic;
	rst_bar : in std_logic;
	sclk_dis : out std_logic;
	sclk : out std_logic
	);					 
end;

architecture behavior of sclk_gen is 
begin 
	process (clk) 
	variable memory : std_logic :='0'; 
	variable edgecount : integer range 0 to 8 := 0;
	variable countdivide : unsigned(2 downto 0);
	begin 
		if rst_bar = '0' then 
			memory := '0';
			countdivide := "000";
			sclk <= '0';
			sclk_dis <= '0';
		elsif rising_edge(clk) then 
			if sclk_en = '1' then  
				countdivide := countdivide + 1;
				sclk <= countdivide(2);
				if memory = '1' and countdivide(2) = '0' then 
					edgecount := edgecount + 1;
					if edgecount = 8 then 
					sclk_dis <= '1';
					edgecount := 0;	 
					end if;	
					
				else 
					sclk_dis <= '0';	 
				end if;
				memory :=  countdivide(2); 
			end if;
		end if;
	end process;
end;
				