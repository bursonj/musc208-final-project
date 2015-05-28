library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity octave_chooser is
  port (in_clock  : in  std_logic;
        selector  : in  unsigned(2 downto 0);
        out_clock : out std_logic);
end octave_chooser;

architecture Behavioral of octave_chooser is

  component halver is
    port (
      in_line  : in  std_logic;
      out_line : out std_logic);
  end component halver;

  signal mux_in : std_logic_vector(0 to 6);

begin

  halver_1 : entity work.halver
    port map (
      in_line  => in_clock,
      out_line => mux_in(1));

  halver_2 : entity work.halver
    port map (
      in_line  => mux_in(1),
      out_line => mux_in(2));

  halver_3 : entity work.halver
    port map (
      in_line  => mux_in(2),
      out_line => mux_in(3));

  halver_4 : entity work.halver
    port map (
      in_line  => mux_in(3),
      out_line => mux_in(4));

  halver_5 : entity work.halver
    port map (
      in_line  => mux_in(4),
      out_line => mux_in(5));

  halver_6 : entity work.halver
    port map (
      in_line  => mux_in(5),
      out_line => mux_in(6));

  mux_in(0) <= in_clock;

  with selector select out_clock <=
    mux_in(0) when "110",
    mux_in(1) when "101",
    mux_in(2) when "100",
    mux_in(3) when "011",
    mux_in(4) when "010",
    mux_in(5) when "001",
    mux_in(6) when "000";

end Behavioral;
