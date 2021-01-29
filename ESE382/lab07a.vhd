-------------------------------------------------------------------------------
--
-- Title       : bin7_bcd
-- Design      : lab07a
-- Author      : xiaomin wu
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\lab07a\lab07a\src\lab07a.vhd
-- Generated   : Tue Mar 14 22:39:49 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- convert 7 bits binary number (range 0 - 99) to two digit bcd number
-- using single loop with if statement
-- using double dabble algorithem
-- shift 7 times add 3 if bcd digit is greater than 4
-------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;  

entity bin7_bcd is
	 port(
		 bin : in STD_LOGIC_VECTOR(7 downto 0);
		 bcd0 : out STD_LOGIC_VECTOR(3 downto 0);
		 bcd1 : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end bin7_bcd;

--}} End of automatically maintained section

architecture behavioral of bin7_bcd is

begin
	 shift: process (bin)
	 		  variable binv :unsigned (7 downto 0);
			   variable bcdv : unsigned (7 downto 0);	  
			   
			   begin
				   bcdv := (others => '0');
				   binv(7 downto 0) := unsigned (bin);
				   
				   for i in 0 to 7 loop   
					   bcdv(7 downto 1) := bcdv(6 downto 0);
					   bcdv(0) := binv(7-i);
					   
					   if(i < 7 and bcdv(3 downto 0) > "0100") then
						   bcdv(3 downto 0) := bcdv(3 downto 0) + "0011";
					   end if;
					   
					   if(i < 7 and bcdv(7 downto 4) > "0100") then
						   bcdv(7 downto 4) := bcdv(7 downto 4) + "0011";
					   end if;
				   end loop;
				   
				   bcd0 <= std_logic_vector(bcdv(3 downto 0));
				   bcd1 <= std_logic_vector(bcdv(7 downto 4));
			   end process;
			   
					   
					   


end behavioral;
