library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Inst_Mem	is
	port(
	clk:in STD_LOGIC;
	reset: in std_logic;
	IRWrite:in STD_LOGIC;
	address :in std_logic_vector(31 downto 0);
	instruction :out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of Inst_Mem is 
	signal internal_instruction: std_logic_vector(31 downto 0);

begin
	--synchronous process
	process (clk) is
	begin
		if rising_edge(clk) then
			if reset = '1' then
				instruction <= (others => '0');
			elsif IRWrite = '1' then
				internal_instruction <= address;
				
			end if;	
		end if;	
	end process; 		   
	instruction <= internal_instruction;
end architecture;
