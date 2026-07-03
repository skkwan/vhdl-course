library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;


entity tb is
end;

architecture rtl of tb is

signal clk : std_logic := '0';
signal din: t_datas( 0 to numChan - 1 ) := ( others => nulll );
signal dout: t_peak := nulll;
component top
port (
  clk: in std_logic;
  din: in t_datas( 0 to numChan - 1 );
  dout: out t_peak
);
end component;
signal counter: natural := 0;

begin

clk <= not clk after 0.5 ns;

process ( clk ) is
begin
if rising_edge( clk ) then

  din <= ( others => nulll );
  counter <= counter + 1;
  for k in 0 to numChan - 1 loop
    if counter = 0 then
      din( k ).reset <= '1';
    elsif counter + 1 < 162 then
      din( k ).valid <= '1';
      din( k ).adc <= rand;
    else
      counter <= 0;
    end if; 
  end loop;

end if;
end process;

c: top port map ( clk, din, dout );

end;