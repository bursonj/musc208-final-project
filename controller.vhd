library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all;

entity controller is
  port (notes           : in    std_logic_vector(0 to 7);
        clck            : in    std_logic;
        dac             : out   std_logic_vector(10 downto 0);
        oct_up          : in    std_logic;
        oct_down        : in    std_logic;
        display_anodes  : inout std_logic_vector(0 to 3);
        display_outputs : out   std_logic_vector(0 to 6));
end controller;

architecture Behavioral of controller is

  -- all of the components and wires needed for the controller
  -- are declared here
  -- further descriptions of each at instantiation
  component scale_clock_clow is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_clow  : out std_logic);
  end component scale_clock_clow;

  component scale_clock_d is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_d     : out std_logic);
  end component scale_clock_d;

  component scale_clock_e is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_e     : out std_logic);
  end component scale_clock_e;

  component scale_clock_f is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_f     : out std_logic);
  end component scale_clock_f;

  component scale_clock_g is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_g     : out std_logic);
  end component scale_clock_g;

  component scale_clock_a is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_a     : out std_logic);
  end component scale_clock_a;

  component scale_clock_b is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_b     : out std_logic);
  end component scale_clock_b;

  component scale_clock_chi is
    port (
      clk_50Mhz : in  std_logic;
      rst       : in  std_logic;
      clk_chi   : out std_logic);
  end component scale_clock_chi;

  component octave_chooser is
    port (
      in_clock  : in  std_logic;
      selector  : in  std_logic_vector(2 downto 0);
      out_clock : out std_logic);
  end component octave_chooser;

  component debouncer is
    port (
      clk       : in  std_logic;
      buttonin  : in  std_logic;
      buttonout : out std_logic);
  end component debouncer;

  component displayDifferent is
    port (
      inputs1 : in    std_logic_vector (0 to 3);
      outputs : out   std_logic_vector (0 to 6);
      inputs2 : in    std_logic_vector (0 to 3);
      inputs3 : in    std_logic_vector (0 to 3);
      inputs4 : in    std_logic_vector (0 to 3);
      anodes  : inout std_logic_vector (0 to 3);
      CLCK    : in    std_logic);
  end component displayDifferent;

  signal clow_osc : std_logic := '0';
  signal d_osc    : std_logic := '0';
  signal e_osc    : std_logic := '0';
  signal f_osc    : std_logic := '0';
  signal g_osc    : std_logic := '0';
  signal a_osc    : std_logic := '0';
  signal b_osc    : std_logic := '0';
  signal chi_osc  : std_logic := '0';

  signal clow_out : std_logic := '0';
  signal d_out    : std_logic := '0';
  signal e_out    : std_logic := '0';
  signal f_out    : std_logic := '0';
  signal g_out    : std_logic := '0';
  signal a_out    : std_logic := '0';
  signal b_out    : std_logic := '0';
  signal chi_out  : std_logic := '0';

  signal clow_scale : std_logic := '0';
  signal d_scale    : std_logic := '0';
  signal e_scale    : std_logic := '0';
  signal f_scale    : std_logic := '0';
  signal g_scale    : std_logic := '0';
  signal a_scale    : std_logic := '0';
  signal b_scale    : std_logic := '0';
  signal chi_scale  : std_logic := '0';

  signal clow_out2 : std_logic_vector(10 downto 0);
  signal d_out2    : std_logic_vector(10 downto 0);
  signal e_out2    : std_logic_vector(10 downto 0);
  signal f_out2    : std_logic_vector(10 downto 0);
  signal g_out2    : std_logic_vector(10 downto 0);
  signal a_out2    : std_logic_vector(10 downto 0);
  signal b_out2    : std_logic_vector(10 downto 0);
  signal chi_out2  : std_logic_vector(10 downto 0);

  signal reseter : std_logic := '0';

  signal oct_sel : unsigned(2 downto 0) := "000";

  signal up_debounced   : std_logic := '0';
  signal down_debounced : std_logic := '0';

  signal change_sel : std_logic := '0';

  signal zero : std_logic_vector(0 to 3) := "0000";

  signal octave_num : std_logic_vector(3 downto 0) := "0000";

begin

  -- these are the eight oscillators, each outputs the highest pitch
  -- of the respective note
  scale_clock_clow_1 : entity work.scale_clock_clow
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_clow  => clow_osc);

  scale_clock_d_1 : entity work.scale_clock_d
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_d     => d_osc);

  scale_clock_e_1 : entity work.scale_clock_e
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_e     => e_osc);

  scale_clock_f_1 : entity work.scale_clock_f
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_f     => f_osc);

  scale_clock_g_1 : entity work.scale_clock_g
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_g     => g_osc);

  scale_clock_a_1 : entity work.scale_clock_a
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_a     => a_osc);

  scale_clock_b_1 : entity work.scale_clock_b
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_b     => b_osc);

  scale_clock_chi_1 : entity work.scale_clock_chi
    port map (
      clk_50Mhz => clck,
      rst       => reseter,
      clk_chi   => chi_osc);

  -- there is one octave chooser for each of the eight notes
  -- the chooser produces waveforms in each octave
  -- of the relevant note and uses the selector to
  -- decide which pitch to output
  octave_chooser_1 : entity work.octave_chooser
    port map (
      in_clock  => clow_osc,
      selector  => oct_sel,
      out_clock => clow_scale);

  octave_chooser_2 : entity work.octave_chooser
    port map (
      in_clock  => d_osc,
      selector  => oct_sel,
      out_clock => d_scale);

  octave_chooser_3 : entity work.octave_chooser
    port map (
      in_clock  => e_osc,
      selector  => oct_sel,
      out_clock => e_scale);

  octave_chooser_4 : entity work.octave_chooser
    port map (
      in_clock  => f_osc,
      selector  => oct_sel,
      out_clock => f_scale);

  octave_chooser_5 : entity work.octave_chooser
    port map (
      in_clock  => g_osc,
      selector  => oct_sel,
      out_clock => g_scale);

  octave_chooser_6 : entity work.octave_chooser
    port map (
      in_clock  => a_osc,
      selector  => oct_sel,
      out_clock => a_scale);

  octave_chooser_7 : entity work.octave_chooser
    port map (
      in_clock  => b_osc,
      selector  => oct_sel,
      out_clock => b_scale);

  octave_chooser_8 : entity work.octave_chooser
    port map (
      in_clock  => chi_osc,
      selector  => oct_sel,
      out_clock => chi_scale);

  --the debouncers ignore bounce in the octave switch buttons
  --because the buttons are not very good
  debouncer_1 : entity work.debouncer
    port map (
      clk       => clck,
      buttonin  => oct_up,
      buttonout => up_debounced);

  debouncer_2 : entity work.debouncer
    port map (
      clk       => clck,
      buttonin  => oct_down,
      buttonout => down_debounced);

  --this drives the seven segment display so we can
  --show the current octave on the screen
  displayDifferent_1 : entity work.displayDifferent
    port map (
      inputs1 => octave_num,
      outputs => display_outputs,
      inputs2 => zero,
      inputs3 => zero,
      inputs4 => zero,
      anodes  => display_anodes,
      CLCK    => clck);

  --each note is only output when the switch is on
  -- the notes vector is just the different switches
  clow_out <= clow_scale and notes(0);
  d_out    <= d_scale and notes(1);
  e_out    <= e_scale and notes(2);
  f_out    <= f_scale and notes(3);
  g_out    <= g_scale and notes(4);
  a_out    <= a_scale and notes(5);
  b_out    <= b_scale and notes(6);
  chi_out  <= chi_scale and notes(7);

  -- converts the one bit oscillator to 11 bits for the dac
  clow_out2 <= "00000000000" when clow_out = '0' else "00011111111";
  d_out2    <= "00000000000" when d_out = '0'    else "00011111111";
  e_out2    <= "00000000000" when e_out = '0'    else "00011111111";
  f_out2    <= "00000000000" when f_out = '0'    else "00011111111";
  g_out2    <= "00000000000" when g_out = '0'    else "00011111111";
  a_out2    <= "00000000000" when a_out = '0'    else "00011111111";
  b_out2    <= "00000000000" when b_out = '0'    else "00011111111";
  chi_out2  <= "00000000000" when chi_out = '0'  else "00011111111";

  -- adds all the waveforms together for final output
  dac <= std_logic_vector(unsigned(clow_out2) + unsigned(d_out2) + unsigned(e_out2) + unsigned(f_out2) + unsigned(g_out2) + unsigned(a_out2) + unsigned(b_out2) + unsigned(chi_out2));

  -- changes octave on button press
  change_sel <= up_debounced or down_debounced;

  changer : process(change_sel, up_debounced, oct_sel)
  begin
    if rising_edge(change_sel) then
      if up_debounced = '1' then
        oct_sel <= oct_sel + "1";
      else
        oct_sel <= oct_sel - "1";
      end if;
    end if;
  end process;

  octave_num <= std_logic_vector('0' & (oct_sel + "1"));

end Behavioral;
