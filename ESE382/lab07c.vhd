-------------------------------------------------------------------------------
--
-- Title       : binary_7segment
-- Design      : binary_7segment
-- Author      : Xiaomin Wu
-- Company     : SBU
--
-------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\lab07c\src\binary_7segment.vhd
-- Generated   : Wed Mar 15 16:34:20 2017
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.22
--
-------------------------------------------------------------------------------
--
-- Description : 
-- 7 bits binary(range 0 to 99) convert to decimal number and display on two 
-- seven_segment_display. structure approch is used.
-- three components; U1 :bin7_bcd U2 : bcd_seven  U3 : bcd_seven
-------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity binary_7segment is
	 port(
		 binary : in STD_LOGIC_VECTOR(7 downto 0);
		 seven_seg0 : out STD_LOGIC_VECTOR(6 downto 0);
		 seven_seg1 : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end binary_7segment;

--}} End of automatically maintained section

architecture structure of binary_7segment is

signal tempbcd0 :STD_LOGIC_VECTOR(3 downto 0);
signal tempbcd1 :STD_LOGIC_VECTOR(3 downto 0);

component bin7_bcd
	port(
		 bin : in STD_LOGIC_VECTOR(7 downto 0);
		 bcd0 : out STD_LOGIC_VECTOR(3 downto 0);
		 bcd1 : out STD_LOGIC_VECTOR(3 downto 0)
	     );
end component;

component bcd_seven
	port(
		 bcd : in STD_LOGIC_VECTOR(3 downto 0);
		 seg_drive : out STD_LOGIC_VECTOR(6 downto 0)
	     );
end component;

begin

	U1: bin7_bcd port map(bin => binary, bcd0 => tempbcd0, bcd1 => tempbcd1);	
	U2: bcd_seven port map(bcd => tempbcd0, seg_drive => seven_seg0);
	U3: bcd_seven port map(bcd => tempbcd1, seg_drive => seven_seg1);	

end structure;
