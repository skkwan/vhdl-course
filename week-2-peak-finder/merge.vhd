library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

entity merge is
port (
  clk : in std_logic;
  merge_din: in t_datas( 0 to numChan - 1 );
  merge_dout: out t_peak
);
end;

architecture rtl of merge is

constant widthAddr: natural := 7;
constant widthRam: natural := widthADC;
type t_ram is array ( 0 to 2 ** widthAddr - 1 ) of std_logic_vector( widthRam - 1 downto 0 );
signal ram : t_ram := ( others => ( others => '0' ) );
signal waddr, raddr: std_logic_vector( widthAddr - 1 downto 0 ) := ( others => '0' );
signal read: std_logic_vector( widthRam - 1 downto 0 ) := ( others => '0' );

begin
process ( clk ) is
begin
if rising_edge( clk ) then

  ram( uint( waddr ) ) <= merge_din( 0 ).adc;
  if merge_din( 0 ).valid = '1' then
    waddr <= waddr + 1;
  end if;


  read <= ram( uint ( raddr ) );

end if;
end process;

end;
