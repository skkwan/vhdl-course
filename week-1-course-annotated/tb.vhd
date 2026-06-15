library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

-- Question:
--      - Is everything in tb run sequentially?
--
-- Point of tb is our test bench. The test bench has a clock that goes from 0
-- to 1 and 1 to 0 back and forth, every 0.5 nanoseconds.
--
-- When the clock has a rising edge, we execute a block of code line-by-line which
-- first assigns the input signal a, (false, false, vector of eight 0's).
-- We also increment the counter (initially set to 0).
-- If the counter is 0 (first execution) then the input signal's "reset" bit is
-- set to 1 (true).
-- If the counter's value is less than 161, then the input signal's "valid" bit
-- is set to 1 (true).
-- Otherwise the counter value is set to 0 (i.e. every 162 instances, reset the
-- counter to 0).


entity tb is
end;

architecture rtl of tb is

-- declare our stuff 
-- std_logic is a boolean 
signal clk : std_logic := '0';
signal a: t_data := nulll;
signal b: t_data := nulll;
component top  -- corresponds to our top.vhd
port (
  clk: in std_logic; -- all inputs/outputs to our "top" function
  a: in t_data;
  b: out t_data
);
end component;
signal counter: natural := 0; -- non-negative integer, initialize to 0

begin

-- changes state of clock every 0.5 ns
clk <= not clk after 0.5 ns;

process ( clk ) is
begin
if rising_edge( clk ) then
  -- when clk goes from 0 to 1

  a <= ( '0', '0', rand );
  counter <= counter + 1;
  if counter = 0 then
    a.reset <= '1';
  elsif counter + 1 < 162 then
    a.valid <= '1';
  else
    counter <= 0;
  end if; 

end if;
end process;

c: top port map ( clk, a, b );

end;
