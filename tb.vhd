library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;


entity tb is
end;

architecture rtl of tb is

signal clk : std_logic := '0';
signal a: t_data := nulll;
signal b: t_data := nulll;
component top
port (
  clk: in std_logic;
  a: in t_data;
  b: out t_data
);
end component;
signal counter: natural := 0;

begin

clk <= not clk after 0.5 ns;

process ( clk ) is
begin
if rising_edge( clk ) then

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