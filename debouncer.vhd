----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:57:22 02/26/2015 
-- Design Name: 
-- Module Name:    debouncer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity debouncer is
    Port ( clk : in  STD_LOGIC;
           buttonin : in  STD_LOGIC;
           buttonout : out  STD_LOGIC);
end debouncer;

architecture Behavioral of debouncer is

	signal button: STD_LOGIC := '0';

begin

	process(clk, button)
		variable oldb:STD_LOGIC := '1';
		variable cnt:STD_LOGIC_VECTOR(19 downto 0);
	begin
		if(clk'event and clk='1') then
			if (buttonin XOR oldb) = '1' then
				cnt := (others => '0');
				oldb := buttonin;
			else
				cnt := cnt+1;
				if ((cnt = x"F423F") and ((oldb xor buttonin) = '0')) then
					button <= oldb;
				end if;
			end if;
		end if;
		buttonout <= button;
	end process;
	
end Behavioral;
