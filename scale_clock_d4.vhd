library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity scale_clock_d is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_d   : out std_logic);
end scale_clock_d;

architecture Behavioral of scale_clock_d is

  signal prescaler : unsigned(23 downto 0);
  signal clk_2349Hz_i : std_logic;
begin

  -- this creates a square wave with the frequency
  -- of D7
  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_2349Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then
      if prescaler = X"5326" then    
        prescaler   <= (others => '0');
        clk_2349Hz_i   <= not clk_2349Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_d <= clk_2349Hz_i;

end Behavioral;
