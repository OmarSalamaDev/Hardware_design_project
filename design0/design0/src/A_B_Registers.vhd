--sohaila
--A, B registers
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity AB_Reg is
    
	Port ( 
	clk : in STD_LOGIC;
	data_in : in STD_LOGIC_VECTOR(31 downto 0);
	data_out: out STD_LOGIC_VECTOR(31 downto 0)	
	);

end entity; 

architecture Behavioral of AB_Reg is 
begin
    
	process(clk)is 
	begin	   
		if rising_edge(clk) then
			data_out <= data_in;
		end if;		  
	end process;

end architecture;