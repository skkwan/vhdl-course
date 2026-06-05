library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity top is
port (
  clk : in std_logic;
  a: in t_data;
  b: out t_data
);
end;

architecture rtl of top is

-- declare a signal called "reg" of type t_data, initialize with nulll?
signal reg: t_data := nulll;

begin

-- assign "reg" to "b" 
b <= reg;

-- ( clk ) means that this process's "sensitivity list" is clk 
process ( clk ) is
begin
if rising_edge( clk ) then
  -- rising_edge: if it goes from 0 to 1
  -- then assign A to reg
  -- the line "b <= reg" outside of the process is run constantly? so then this
  -- automatically becomes b <= A?
  reg <= A;

end if;
end process;

end;
