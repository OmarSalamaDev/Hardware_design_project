--sohaila
library ieee;  
use ieee.std_logic_1164.ALL; 
use ieee.numeric_std.ALL;	

entity Data_Mem is
	port(
	clk : in STD_LOGIC;
	address : in STD_LOGIC_VECTOR(31 downto 0);
	read : in STD_LOGIC;
	write : in STD_LOGIC;	  
	data_write : in STD_LOGIC_VECTOR(31 downto 0);
	data_read : out STD_LOGIC_VECTOR(31 downto 0)
	);
end entity;

architecture Behavioral of Data_Mem is 
	type ram_type is array (0 to 255) of STD_LOGIC_VECTOR(31 downto 0);
	signal ram : ram_type := (others => (others => '0'));

begin 
	
	process (clk) is 
	begin
		if rising_edge(clk) then
			if write = '1' then 
				ram(to_integer(unsigned(address(9 downto 2)))) <= data_write;
			end if;
		end if;
	end process;  
	-- combinational read
	data_read <= ram(to_integer(unsigned(address(9 downto 2)))) when read = '1' else (others => 'Z');
end architecture;