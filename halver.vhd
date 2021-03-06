library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity halver is
  port (in_line  : in  std_logic;
        out_line : inout std_logic);
end halver;

architecture Behavioral of halver is

  --halves the frequency of an input wave
  --by outputting a new wave that switches
  --switches between high and low, once per
  --period of the input wave
begin
  track : process(in_line)
  begin
    if rising_edge(in_line) then
      out_line <= not out_line;
    end if;
  end process;
  
end Behavioral;
