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

signal reg: t_data := nulll;

begin

b <= reg;

process ( clk ) is
begin
if rising_edge( clk ) then

  reg <= A;

end if;
end process;

end;
