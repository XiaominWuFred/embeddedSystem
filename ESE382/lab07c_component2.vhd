-------------------------------------------------------------------------------
--
-- Title       : bcd_seven
-- Design      : lab07b
-- Author      : xiaomin wu
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\lab07b\lab07b\src\bcd_seven.vhd
-- Generated   : Wed Mar 15 13:13:04 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {bcd_seven} architecture {table}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use ieee.numeric_std.all; 

entity bcd_seven is
	 port(
		 bcd : in STD_LOGIC_VECTOR(3 downto 0);
		 seg_drive : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end bcd_seven;

--}} End of automatically maintained section

architecture table of bcd_seven is
type table_type is array (natural range <>) of std_logic_vector (6 downto 0);
constant mytable : table_type := 
("0000001","1001111","0010010","0000110","1001100","0100100","0100000","0001111","0000000","0000100");
begin
	 seg_drive <= mytable(to_integer(unsigned(bcd)));
	

end table;
