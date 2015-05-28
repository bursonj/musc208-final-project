library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity scale_clock_chi is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_chi   : out std_logic);
end scale_clock_chi;

architecture Behavioral of scale_clock_chi is

  signal prescaler : unsigned(23 downto 0);
  signal clk_4186Hz_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_4186Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif clk_50Mhz'event then   -- rising clock edge
      if prescaler = X"1DF" then     -- 190 840 in hex
        prescaler   <= (others => '0');
        clk_4186Hz_i   <= not clk_4186Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_chi <= clk_4186Hz_i;

end Behavioral;