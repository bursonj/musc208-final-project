library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- this converts a four bit number to
-- the pins necesarry to power the
-- display
entity sevenSegmentDisplay is
    Port ( i1 : in  STD_LOGIC;
           i2 : in  STD_LOGIC;
           i4 : in  STD_LOGIC;
           i8 : in  STD_LOGIC;
           a : out  STD_LOGIC;
           b : out  STD_LOGIC;
           c : out  STD_LOGIC;
           d : out  STD_LOGIC;
           e : out  STD_LOGIC;
           f : out  STD_LOGIC;
           g : out  STD_LOGIC;
			  an0 : out STD_LOGIC;
			  an1 : out  STD_LOGIC;
           an2 : out  STD_LOGIC;
           an3 : out  STD_LOGIC);
end sevenSegmentDisplay;

architecture Behavioral of sevenSegmentDisplay is

	signal outputs : STD_LOGIC_VECTOR(0 to 6);
	signal inputs : STD_LOGIC_VECTOR(0 to 3);
	signal angry_cal : STD_LOGIC := '1';
	signal angry_chris : STD_LOGIC := '1';
	signal angry_andy : STD_LOGIC := '1';
	signal typical_tenzin : STD_LOGIC := '0';

begin

	inputs(0) <= i1;
	inputs(1) <= i2;
	inputs(2) <= i4;
	inputs(3) <= i8;
	
	a <= outputs(0);
	b <= outputs(1);
	c <= outputs(2);
	d <= outputs(3);
	e <= outputs(4);
	f <= outputs(5);
	g <= outputs(6);
	
	an0 <= typical_tenzin;
	an1 <= angry_cal;
	an2 <= angry_chris;
	an3 <= angry_andy;
	
	with inputs select outputs <=
		"0000001" when "0000",
		"1001111" when "0001",
		"0010010" when "0010",
		"0000110" when "0011",
		"1001100" when "0100",
		"0100100" when "0101",
		"0100000" when "0110",
		"0001111" when "0111",
		"0000000" when "1000",
		"0001100" when "1001",
		"0001000" when "1010",
		"1100000" when "1011",
		"0110001" when "1100",
		"1000010" when "1101",
		"0110000" when "1110",
		"0111000" when "1111";
		
end Behavioral;

