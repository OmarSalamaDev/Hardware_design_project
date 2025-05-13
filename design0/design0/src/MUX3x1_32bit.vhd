library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;	 
use ieee.numeric_std.all;


entity MUX3x1_32bit is
	port(
		A,B,C: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0);
		num_out: out std_logic_vector(31 downto 0)
	);
end entity;


architecture MUX3x1_32bit_ARCH of MUX3x1_32bit is 
signal mux_out : std_logic_vector(31 downto 0);
begin
	with sel select
    mux_out <= A when "00",
               B when "01",
               C when "10",
               x"00000000" when others;
  num_out <= mux_out;
end architecture;	
