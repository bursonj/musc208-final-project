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
      clk_c4   : out std_logic;
      clk_d4   : out std_logic;
      clk_e4   : out std_logic;
      clk_f4   : out std_logic;
      clk_g4   : out std_logic;
      clk_a4   : out std_logic;
      clk_b4   : out std_logic;    
      clk_c5   : out std_logic;
  end component scale_clock;

  signal c4_osc : std_logic := '0';
  signal d4_osc : std_logic := '0';
  signal e4_osc : std_logic := '0';
  signal f4_osc : std_logic := '0';
  signal g4_osc : std_logic := '0';
  signal a4_osc : std_logic := '0';
  signal b4_osc : std_logic := '0';
  signal c5_osc : std_logic := '0';
  signal c4_out : std_logic := '0';
  signal d4_out : std_logic := '0';
  signal e4_out : std_logic := '0';
  signal f4_out : std_logic := '0';
  signal g4_out : std_logic := '0';
  signal a4_out : std_logic := '0';
  signal b4_out : std_logic := '0';
  signal c5_out : std_logic := '0';

  signal c4_out2 : std_logic_vector(0 to 7);
  signal d4_out2 : std_logic_vector(0 to 7);
  signal e4_out2 : std_logic_vector(0 to 7);
  signal f4_out2 : std_logic_vector(0 to 7);
  signal g4_out2 : std_logic_vector(0 to 7);
  signal a4_out2 : std_logic_vector(0 to 7);
  signal b4_out2 : std_logic_vector(0 to 7);
  signal c5_out2 : std_logic_vector(0 to 7);

  signal reseter : std_logic := '0';
  
begin

  scale_clock_1 : entity work.scale_clock
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_c4    => c4_out); --is this right? Don't we want this to
                            --be 'clk_c4 => c4_osc'?

  c4_out <= c4_osc and notes(0);
  d4_out <= d4_osc and notes(1);
  e4_out <= e4_osc and notes(2);
  f4_out <= f4_osc and notes(3);
  g4_out <= g4_osc and notes(4);
  a4_out <= a4_osc and notes(5);
  b4_out <= b4_osc and notes(6);
  c5_out <= c5_osc and notes(7);

  c4_out2 <= '00000000' when not(c4_out) else '11111111';
  d4_out2 <= '00000000' when not(d4_out) else '11111111';
  e4_out2 <= '00000000' when not(e4_out) else '11111111';
  f4_out2 <= '00000000' when not(f4_out) else '11111111';
  g4_out2 <= '00000000' when not(g4_out) else '11111111';
  a4_out2 <= '00000000' when not(a4_out) else '11111111';
  b4_out2 <= '00000000' when not(b4_out) else '11111111';
  c5_out2 <= '00000000' when not(c5_out) else '11111111';

  dac <= std_logic_vector(unsigned(c4_out) + unsigned(d4_out) + unsigned(e4_out) + unsigned(f4_out) + unsigned(g4_out) + unsigned(a4_out) + unsigned(b4_out) + unsigned(c5_out));

  
end Behavioral;
