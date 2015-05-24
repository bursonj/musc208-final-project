library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity controller is
  port (notes : in  std_logic_vector(0 to 7);
        clck  : in  std_logic;
        dac   : out std_logic_vector(10 downto 0));
end controller;



architecture Behavioral of controller is

  component scale_clock is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_2Hz   : out std_logic);
  end component scale_clock;

  signal c4_osc : std_logic := '0';
  signal d4_osc : std_logic := '0';
  signal e4_osc : std_logic := '0';
  signal f4_osc : std_logic := '0';
  signal g4_osc : std_logic := '0';
  signal a5_osc : std_logic := '0';
  signal b5_osc : std_logic := '0';
  signal c5_osc : std_logic := '0';
  signal c4_out : std_logic := '0';
  signal d4_out : std_logic := '0';
  signal e4_out : std_logic := '0';
  signal f4_out : std_logic := '0';
  signal g4_out : std_logic := '0';
  signal a5_out : std_logic := '0';
  signal b5_out : std_logic := '0';
  signal c5_out : std_logic := '0';

  signal c4_out2 : std_logic_vector(0 to 7);
  signal d4_out2 : std_logic_vector(0 to 7);
  signal e4_out2 : std_logic_vector(0 to 7);
  signal f4_out2 : std_logic_vector(0 to 7);
  signal g4_out2 : std_logic_vector(0 to 7);
  signal a5_out2 : std_logic_vector(0 to 7);
  signal b5_out2 : std_logic_vector(0 to 7);
  signal c5_out2 : std_logic_vector(0 to 7);

  signal reseter : std_logic := '0';
  
begin

  scale_clock_1 : entity work.scale_clock
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_2Hz    => c4_osc);

  c4_out <= c4_osc and notes(0);
  d4_out <= d4_osc and notes(1);
  e4_out <= e4_osc and notes(2);
  f4_out <= f4_osc and notes(3);
  g4_out <= g4_osc and notes(4);
  a5_out <= a5_osc and notes(5);
  b5_out <= b5_osc and notes(6);
  c5_out <= c5_osc and notes(7);

  c4_out2 <= "00000000" when c4_out = '0' else "11111111";
  d4_out2 <= "00000000" when d4_out = '0' else "11111111";
  e4_out2 <= "00000000" when e4_out = '0' else "11111111";
  f4_out2 <= "00000000" when f4_out = '0' else "11111111";
  g4_out2 <= "00000000" when g4_out = '0' else "11111111";
  a5_out2 <= "00000000" when a5_out = '0' else "11111111";
  b5_out2 <= "00000000" when b5_out = '0' else "11111111";
  c5_out2 <= "00000000" when c5_out = '0' else "11111111";

  dac <= std_logic_vector(resize(unsigned(c4_out2) + unsigned(d4_out2) + unsigned(e4_out2) + unsigned(f4_out2) + unsigned(g4_out2) + unsigned(a5_out2) + unsigned(b5_out2) + unsigned(c5_out2), 11));

  
end Behavioral;
