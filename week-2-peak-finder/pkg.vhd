library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


package pkg is

constant numChan  : natural := 8;
constant widthChan: natural := integer( ceil( log2( real( numChan ) ) ) );
constant widthAdc : natural := 16;
constant threshold: natural := 2 ** ( widthAdc - 1 ) + 2 ** ( widthAdc - 2 ) + 2 ** ( widthAdc - 3 );

type t_data is
record
  reset: std_logic;
  valid: std_logic;
  adc  : std_logic_vector( widthAdc - 1 downto 0 );
end record;
type t_datas is array ( natural range <> ) of t_data;
function nulll return t_data;

type t_peak is
record
  reset: std_logic;
  valid: std_logic;
  chan : std_logic_vector( widthChan - 1 downto 0 );
  adc  : std_logic_vector( widthAdc  - 1 downto 0 );
end record;
type t_peaks is array ( natural range <> ) of t_peak;
function nulll return t_peak;

function "<" ( lhs, rhs: std_logic_vector ) return boolean;
function ">" ( lhs, rhs: std_logic_vector ) return boolean;

function "+" ( std: std_logic_vector; i: integer ) return std_logic_vector;

function uint( std: std_logic_vector ) return integer;

shared variable seed1: natural := 13;
shared variable seed2: natural := 45;
impure function rand return std_logic_vector;


end;


package body pkg is

function nulll return t_data is begin return ( '0', '0', ( others => '0' ) ); end function;
function nulll return t_peak is begin return ( '0', '0', others => ( others => '0' ) ); end function;

function "<" ( lhs, rhs: std_logic_vector ) return boolean is
begin
  return unsigned( lhs ) < unsigned( rhs );
end function;
function ">" ( lhs, rhs: std_logic_vector ) return boolean is
begin
  return unsigned( lhs ) > unsigned( rhs );
end function;

function uint( std: std_logic_vector ) return integer is
begin
  return to_integer( unsigned( std ) );
 end function;

function "+" ( std: std_logic_vector; i: integer ) return std_logic_vector is
begin
  return std_logic_vector( unsigned( std ) + i );
end function;

impure function rand return std_logic_vector is
  variable std: std_logic_vector( 8 - 1 downto 0 );
  variable r: real;
begin
  uniform( seed1, seed2, r );
  return std_logic_vector( to_unsigned( integer( floor( r * 2.0 ** widthADC ) ), widthADC ) );
end function;


end;