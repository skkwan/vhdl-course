library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

package pkg is

constant width: natural := 8;

-- declare t_data
type t_data is
record
  -- for the peak finder, valid is 1 if the value is a peak, otherwise 0
  valid: std_logic;
  -- data: std_logic_vector is a vector of length 8 ("downto": little-endian, 7
  -- downto 0 means there are 8 bits)
  data: std_logic_vector( width - 1 downto 0 );
end record;

function nulll return t_data; -- initialize

-- shared variables can be accessed by more than one process (undefined
-- behaviour). they can be used to share information between processes
-- https://www.hdlworks.com/hdl_corner/vhdl_ref/VHDLContents/SharedVariable.htm
shared variable seed1: natural := 13;
shared variable seed2: natural := 45;
impure function rand return std_logic_vector;


end;  
-- this ends the declaration of pkg 

-- begin declaration of body of pkg 
package body pkg is

function nulll return t_data is begin return ( '0', ( others => '0' ) ); end function;

-- impure functions may return different values for the same set of parameters,
-- and may have "side effects", like updating objects outside of their scope
-- https://www.hdlworks.com/hdl_corner/vhdl_ref/VHDLContents/Function.htm
-- Here we declare an impure function "rand" (impure because "uniform" returns
-- a random number), which we will use to initialize the "data" member of a
-- t_data type:
impure function rand return std_logic_vector is
  variable std: std_logic_vector( 8 - 1 downto 0 );
  variable r: real;
begin
  -- from the math_real package
  uniform( seed1, seed2, r );
  return std_logic_vector( to_unsigned( integer( floor( r * 2.0 ** width ) ), width ) );
end function;


end;
