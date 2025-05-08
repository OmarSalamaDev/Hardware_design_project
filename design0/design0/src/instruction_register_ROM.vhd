library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity instruction_register	is
	port(
	clk:in STD_LOGIC;
	reset: in std_logic;
	IRWrite:in STD_LOGIC;
	inst_in :in std_logic_vector(31 downto 0);
	inst_out :out std_logic_vector(31 downto 0)
	);
end entity;

architecture Behavioral of instruction_register is 
	signal internal_instruction: std_logic_vector(31 downto 0):= (others => '0');

begin
	--synchronous process
	process (clk) is
	begin
		if rising_edge(clk) then
			if reset = '1' then
				internal_instruction <= (others => '0');
			elsif IRWrite = '1' then
				internal_instruction <= inst_in;
				
			end if;	
		end if;	
	end process; 		   
	inst_out <= internal_instruction;
end architecture;
