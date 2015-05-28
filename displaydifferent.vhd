----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:23:41 02/26/2015 
-- Design Name: 
-- Module Name:    displayDifferent - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity displayDifferent is
  port (inputs1 : in    std_logic_vector (0 to 3);
        outputs : out   std_logic_vector (0 to 6);
        inputs2 : in    std_logic_vector (0 to 3);
        inputs3 : in    std_logic_vector (0 to 3);
        inputs4 : in    std_logic_vector (0 to 3);
        anodes  : inout std_logic_vector (0 to 3);
        CLCK    : in    std_logic);
end displayDifferent;

architecture Behavioral of displayDifferent is

  component sevenSegmentDisplay
    port (i1  : in  std_logic;
          i2  : in  std_logic;
          i4  : in  std_logic;
          i8  : in  std_logic;
          a   : out std_logic;
          b   : out std_logic;
          c   : out std_logic;
          d   : out std_logic;
          e   : out std_logic;
          f   : out std_logic;
          g   : out std_logic;
          an0 : out std_logic;
          an1 : out std_logic;
          an2 : out std_logic;
          an3 : out std_logic);
  end component;

  component scale_clock
    port (clk_50Mhz : in  std_logic;
          rst       : in  std_logic;
          clk_2Hz   : out std_logic);
  end component;

  signal outDigit1 : std_logic_vector(0 to 6);
  signal outDigit2 : std_logic_vector(0 to 6);
  signal outDigit3 : std_logic_vector(0 to 6);
  signal outDigit4 : std_logic_vector(0 to 6);
  signal CLK       : std_logic := '0';
  signal reseter   : std_logic := '0';

  signal inputs_1 : std_logic_vector(0 to 3);
  signal inputs_2 : std_logic_vector(0 to 3);
  signal inputs_3 : std_logic_vector(0 to 3);
  signal inputs_4 : std_logic_vector(0 to 3);

  signal count4 : std_logic_vector(0 to 1);

begin

  inputs_1 <= inputs1;
  inputs_2 <= inputs2;
  inputs_3 <= inputs3;
  inputs_4 <= inputs4;

  clockScaler : scale_clock
    port map(clk_50Mhz => CLCK,
             rst       => reseter,
             clk_2Hz   => CLK);

  displayDriverDigit1 : sevenSegmentDisplay port map (i1 => inputs_1(0),
                                                      i2 => inputs_1(1),
                                                      i4 => inputs_1(2),
                                                      i8 => inputs_1(3),
                                                      a  => outDigit1(0),
                                                      b  => outDigit1(1),
                                                      c  => outDigit1(2),
                                                      d  => outDigit1(3),
                                                      e  => outDigit1(4),
                                                      f  => outDigit1(5),
                                                      g  => outDigit1(6));

  displayDriverDigit2 : sevenSegmentDisplay port map(i1 => inputs_2(0),
                                                     i2 => inputs_2(1),
                                                     i4 => inputs_2(2),
                                                     i8 => inputs_2(3),
                                                     a  => outDigit2(0),
                                                     b  => outDigit2(1),
                                                     c  => outDigit2(2),
                                                     d  => outDigit2(3),
                                                     e  => outDigit2(4),
                                                     f  => outDigit2(5),
                                                     g  => outDigit2(6));

  displayDriverDigit3 : sevenSegmentDisplay port map(i1 => inputs_3(0),
                                                     i2 => inputs_3(1),
                                                     i4 => inputs_3(2),
                                                     i8 => inputs_3(3),
                                                     a  => outDigit3(0),
                                                     b  => outDigit3(1),
                                                     c  => outDigit3(2),
                                                     d  => outDigit3(3),
                                                     e  => outDigit3(4),
                                                     f  => outDigit3(5),
                                                     g  => outDigit3(6));

  displayDriverDigit4 : sevenSegmentDisplay port map(i1 => inputs_4(0),
                                                     i2 => inputs_4(1),
                                                     i4 => inputs_4(2),
                                                     i8 => inputs_4(3),
                                                     a  => outDigit4(0),
                                                     b  => outDigit4(1),
                                                     c  => outDigit4(2),
                                                     d  => outDigit4(3),
                                                     e  => outDigit4(4),
                                                     f  => outDigit4(5),
                                                     g  => outDigit4(6));


  process(CLK)
  begin
    if (CLK'event and CLK = '1') then
      count4 <= count4 + 1;
    end if;
  end process;

  with count4 select anodes <=
    "1110" when "00",
    "1101" when "01",
    "1011" when "11",
    "0111" when "10";

  with anodes select outputs <=
    outDigit1 when "1110",
    outDigit2 when "1101",
    outDigit3 when "1011",
    outDigit4 when "0111";



end Behavioral;

