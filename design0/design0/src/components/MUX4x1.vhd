library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;	 
use ieee.numeric_std.all;


entity MUX4x1 is
	port(
		A,B,C,D: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0);
		num_out: out std_logic_vector(31 downto 0)
	);
end entity;


architecture MUX4x1_ARCH of MUX4x1 is
begin
	num_out <= A when sel = "00" else
			   B when sel = "01" else
			   C when sel = "10" else
			   D;
end architecture;	
