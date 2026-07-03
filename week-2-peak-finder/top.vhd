library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity top is
port (
  clk : in std_logic;
  din: in t_datas( 0 to numChan - 1 );
  dout: out t_peak
);
end;

architecture rtl of top is

signal pf_din: t_datas( 0 to numChan - 1 ) := ( others => nulll );
signal pf_dout: t_datas( 0 to numChan - 1 ) := ( others => nulll );
component pf
port (
  clk : in std_logic;
  pf_din: in t_datas( 0 to numChan - 1 );
  pf_dout: out t_datas( 0 to numChan - 1 )
);
end component;

signal merge_din: t_datas( 0 to numChan - 1 ) := ( others => nulll );
signal merge_dout: t_peak := nulll;
component merge
port (
  clk : in std_logic;
  merge_din: in t_datas( 0 to numChan - 1 );
  merge_dout: out t_peak
);
end component;

begin

merge_din <= pf_dout;

process ( clk ) is
begin
if rising_edge( clk ) then

  pf_din <= din;
  dout <= merge_dout;

end if;
end process;

cPF: pf port map ( clk, pf_din, pf_dout );

cMerge: merge port map ( clk, merge_din, merge_dout );

end;
