library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity scale_clock is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_c4   : out std_logic);
end scale_clock;

architecture Behavioral of scale_clock is

  signal prescaler : unsigned(23 downto 0);
  signal clk_262Hz_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_262Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = X"2E978" then     -- 190 840 in hex
        prescaler   <= (others => '0');
        clk_262Hz_i   <= not clk_262Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_c4 <= clk_262Hz_i;

end Behavioral;