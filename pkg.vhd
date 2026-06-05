library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


package pkg is

constant width: natural := 8;
type t_data is
record
  reset: std_logic;
  valid: std_logic;
  data: std_logic_vector( width - 1 downto 0 );
end record;
function nulll return t_data;

shared variable seed1: natural := 13;
shared variable seed2: natural := 45;
impure function rand return std_logic_vector;


end;


package body pkg is

function nulll return t_data is begin return ( '0', '0', ( others => '0' ) ); end function;

impure function rand return std_logic_vector is
  variable std: std_logic_vector( 8 - 1 downto 0 );
  variable r: real;
begin
  uniform( seed1, seed2, r );
  return std_logic_vector( to_unsigned( integer( floor( r * 2.0 ** width ) ), width ) );
end function;


end;