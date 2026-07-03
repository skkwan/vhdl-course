library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity pf is
port (
  clk : in std_logic;
  pf_din: in t_datas( 0 to numChan - 1 );
  pf_dout: out t_datas( 0 to numChan - 1 )
);
end;

architecture rtl of pf is

component pf_node
port (
  clk : in std_logic;
  node_din: in t_data;
  node_dout: out t_data
);
end component;

begin

g: for k in 0 to numChan - 1 generate

signal node_din: t_data := nulll;
signal node_dout: t_data := nulll;

begin

node_din <= pf_din( k );
pf_dout( k ) <= node_dout;

c: pf_node port map ( clk, node_din, node_dout );

end generate;

end;


library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity pf_node is
port (
  clk : in std_logic;
  node_din: in t_data;
  node_dout: out t_data
);
end;


architecture rtl of pf_node is

signal smaller, bigger: std_logic := '0';
signal din, dout: t_data := nulll;

begin

node_dout <= dout;
bigger <= '1' when din.adc > node_din.adc else '0';

process ( clk ) is
begin
if rising_edge( clk ) then

  din <= node_din;
  smaller <= '0';
  if node_din.valid = '1' and din.valid = '1' and din.adc < node_din.adc then
    smaller <= '1';
  end if;

  dout <= nulll;
  dout.reset <= din.reset;
  if bigger = '1' and smaller = '1' and uint( din.adc ) > threshold then
    dout.valid <= '1';
    dout.adc <= din.adc;
  end if;

end if;
end process;

end;
