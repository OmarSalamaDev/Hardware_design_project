--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Inst_Mem	is
	port(
	clk :in STD_LOGIC;
	address :in std_logic_vector(31 downto 0);
	instruction :out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of Inst_Mem is	 
	--array of 64 bits each bit containing a word or an address of 32bit(4 bytes)
	type memory_arr is array (0 to 63) of std_logic_vector(31 downto 0); --64bit * 32bit = 2048bit = 256 byte	
	signal memory : memory_arr :=( 
	--Þíã ÇÝÊÑÇÖíå 
		0 => x"00500093",  -- addi format x1, x0, 5
		1 => x"00A00113",  -- addi format x2, x0, 10
		2 => x"002081B3",  -- add  x3, x1, x2
		others => x"00000000"
	);	

begin
	--synchronous process
	process (clk) is
	begin
		if rising_edge(clk) then
			instruction <= memory(to_integer(unsigned(address(7 downto 2))));-- 2**6 = 64
		end if;	
	end process; 
end architecture;
