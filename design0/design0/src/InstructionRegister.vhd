
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity InstructionRegister is 
	port(  --input
	CLK: in std_logic;
	reset: in std_logic;
	IRWrite: in std_logic;
	MemData: in std_logic_vector(31 downto 0);	
	       --output
	Instruction: out std_logic_vector(31 downto 0));
end entity;	

architecture behavior of InstructionRegister is
signal internal_instuction: std_logic_vector(31 downto 0):= (others => '0');
begin
	process(CLK)
	begin 
	if rising_edge(CLK) then 
		if reset = '1' then
        internal_instuction <= (others => '0');  -- Clear the register on reset
		elsif IRWrite = '1' then         -- Load instruction if enabled
			internal_instuction <= MemData;
		end if;
	end if;
end process;
Instruction <= internal_instuction;
end architecture ;
			



