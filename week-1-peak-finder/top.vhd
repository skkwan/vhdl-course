library ieee;
use ieee.std_logic_1164.all;
use work.pkg.all;

-- peak finder: outputs the input data after 3 clock cycles, with its valid bit set to 1 if the value IS a local peak
-- (strictly greater than its neighbors), or with its valid bit set to 0 if it is not a local peak

entity top is
port (
  clk : in std_logic;
  a: in t_data;
  b: out t_data
);
end;

architecture rtl of top is

-- declare four registers of type t_data, initialize with nulll
signal reg1: t_data := nulll;
signal reg2: t_data := nulll;
signal reg3: t_data := nulll;
signal reg4: t_data := nulll;

begin

-- register 3 is going to be our output: connect it to the output b
b <= reg4;

-- need a clock to make our process sensitive to time
process ( clk ) is
begin
if rising_edge( clk ) then
  -- rising_edge: if it goes from 0 to 1
  -- e.g. first clock cycle: input i0 is mapped to reg1. 
  -- second clock cycle: reg2 is mapped to reg1, so reg2 now stores i0. reg1 holds the second input i1.
  -- third clock cycle: reg3 is mapped to reg2, so reg3 now holds i0. reg2 holds i1. The third input i2 is now available in reg1 which is 
  --                    sufficient for us to do the peak-finding: if reg2's value is greater than reg1 and reg3, reg2 was a peak (valid)

  reg3 <= reg2;
  reg2 <= reg1;
  reg1 <= a;

  reg4 <= reg2;  -- always assign reg2 (the value under consideration) to reg4, the output

  -- check if reg2 is a peak value
  if ((reg2.data > reg1.data) and (reg2.data > reg3.data)) then
    reg4.valid <= '1';  -- set reg4's peak/valid bit to True
  end if;

end if;
end process;

end;
