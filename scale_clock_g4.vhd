library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.all;

entity scale_clock_g is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_g   : out std_logic);
end scale_clock_g;

architecture Behavioral of scale_clock_g is

  signal prescaler : unsigned(23 downto 0);
  signal clk_3136Hz_i : std_logic;
begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_3136Hz_i   <= '0';
      prescaler   <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler = X"3E48" then     -- 190 840 in hex
        prescaler   <= (others => '0');
        clk_3136Hz_i   <= not clk_3136Hz_i;
      else
        prescaler <= prescaler + "1";
      end if;
    end if;
  end process gen_clk;

clk_g <= clk_3136Hz_i;

end Behavioral;