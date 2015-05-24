library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity scale_clock is
  port (
    clk_50Mhz : in  std_logic;
    rst       : in  std_logic;
    clk_c4    : out std_logic;
    clk_d4    : out std_logic;
    clk_e4    : out std_logic;
    clk_f4    : out std_logic;
    clk_g4    : out std_logic;
    clk_a4    : out std_logic;
    clk_b4    : out std_logic;
    clk_c5    : out std_logic);
end scale_clock;

architecture Behavioral of scale_clock is

  signal prescaler_c4 : unsigned(23 downto 0);
  signal prescaler_d4 : unsigned(23 downto 0);
  signal prescaler_e4 : unsigned(23 downto 0);
  signal prescaler_f4 : unsigned(23 downto 0);
  signal prescaler_g4 : unsigned(23 downto 0);
  signal prescaler_a4 : unsigned(23 downto 0);
  signal prescaler_b4 : unsigned(23 downto 0);
  signal prescaler_c5 : unsigned(23 downto 0);
  signal clk_c4_262Hz : std_logic;
  signal clk_d4_294Hz : std_logic;
  signal clk_e4_330Hz : std_logic;
  signal clk_f4_349Hz : std_logic;
  signal clk_g4_392Hz : std_logic;
  signal clk_a4_440Hz : std_logic;
  signal clk_b4_494Hz : std_logic;
  signal clk_c5_523Hz : std_logic;

begin

  gen_clk : process (clk_50Mhz, rst)
  begin  -- process gen_clk
    if rst = '1' then
      clk_c4_262Hz <= '0';
      clk_d4_294Hz <= '0';
      clk_e4_330Hz <= '0';
      clk_f4_349Hz <= '0';
      clk_g4_392Hz <= '0';
      clk_a4_440Hz <= '0';
      clk_b4_494Hz <= '0';
      clk_c5_523Hz <= '0';
      prescaler_c4 <= (others => '0');
      prescaler_d4 <= (others => '0');
      prescaler_e4 <= (others => '0');
      prescaler_f4 <= (others => '0');
      prescaler_g4 <= (others => '0');
      prescaler_a4 <= (others => '0');
      prescaler_b4 <= (others => '0');
      prescaler_c5 <= (others => '0');
    elsif rising_edge(clk_50Mhz) then   -- rising clock edge
      if prescaler_c4 = X"2E978" then   -- 95420 in hex
        prescaler_c4 <= (others => '0');
        clk_c4_262Hz <= not clk_c4_262Hz;
        prescaler_c4 <= prescaler_c4 - "1";
      end if;
      if prescaler_d4 = X"29854" then
        prescaler_d4 <= (others => '0');
        clk_d4_294Hz <= not clk_d4_294Hz;
        prescaler_d4 <= prescaler_d4 - "1";
      end if;
      if prescaler_e4 = X"24FDA" then
        prescaler_e4 <= (others => '0');
        clk_e4_330Hz <= not clk_e4_330Hz;
        prescaler_e4 <= prescaler_e4 - "1";
      end if;
      if prescaler_f4 = X"22FA2" then
        prescaler_f4 <= (others => '0');
        clk_f4_349Hz <= not clk_f4_349Hz;
        prescaler_f4 <= prescaler_f4 - "1";
      end if;
      if prescaler_g4 = X"1F23E" then
        prescaler_g4 <= (others => '0');
        clk_g4_392Hz <= not clk_g4_392Hz;
        prescaler_g4 <= prescaler_g4 - "1";
      end if;
      if prescaler_a4 = X"1BBE4" then
        prescaler_a4 <= (others => '0');
        clk_a4_440Hz <= not clk_a4_440Hz;
        prescaler_a4 <= prescaler_a4 - "1";
        if prescaler_b4 = X"18B5F" then
          prescaler_b4 <= (others => '0');
          clk_b4_494Hz <= not clk_b4_494Hz;
          prescaler_b4 <= prescaler_b4 - "1";
        end if;
        if prescaler_c5 = X"17572" then
          prescaler_c5 <= (others => '0');
          clk_c5_523Hz <= not clk_c5_523Hz;
          prescaler_c5 <= prescaler_c5 - "1";
        end if;
      end if;

      prescaler_c4 <= prescaler_c4 + "1";
      prescaler_d4 <= prescaler_d4 + "1";
      prescaler_e4 <= prescaler_e4 + "1";
      prescaler_f4 <= prescaler_f4 + "1";
      prescaler_g4 <= prescaler_g4 + "1";
      prescaler_a4 <= prescaler_a4 + "1";
      prescaler_b4 <= prescaler_b4 + "1";
      prescaler_c5 <= prescaler_c5 + "1";
    end if;
  end process gen_clk;

  clk_c4 <= clk_c4_262Hz;
  clk_d4 <= clk_d4_294Hz;
  clk_e4 <= clk_e4_330Hz;
  clk_f4 <= clk_f4_349Hz;
  clk_g4 <= clk_g4_392Hz;
  clk_a4 <= clk_a4_440Hz;
  clk_b4 <= clk_b4_494Hz;
  clk_c5 <= clk_c5_523Hz;

end Behavioral;
