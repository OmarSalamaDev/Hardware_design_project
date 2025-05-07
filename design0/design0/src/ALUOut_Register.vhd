--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;


entity ALUOut is
   
	Port (
	clk : in STD_LOGIC;
    reset : in STD_LOGIC;    
	ALUOut_in: in STD_LOGIC_VECTOR(31 downto 0); --ALU result coming from ALU        
	aluout : out STD_LOGIC_VECTOR(31 downto 0)  -- ALUOut output  
	);

end entity;  

architecture Behavioral of ALUOut is
signal reg_aluout : std_logic_vector(31 downto 0) := (others => '0');
begin
	process (clk) is
	begin
		if rising_edge(clk) then
			if reset = '1' then
				reg_aluout <= (others => '0');
			else
				reg_aluout <= ALUOut_in; 
			end if;
		end if;
	end process; 
	aluout <= reg_aluout;
end architecture;