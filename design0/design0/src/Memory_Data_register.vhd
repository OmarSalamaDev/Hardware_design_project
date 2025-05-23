
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity MDR is

	Port (			  
	clk : in STD_LOGIC;	   
	reset  : in STD_LOGIC;	
	data_in : in STD_LOGIC_VECTOR(31 downto 0);	
	data_out  : out STD_LOGIC_VECTOR(31 downto 0)
	);

end entity; 


architecture Behavioral of MDR is

signal internal_data_out  :  STD_LOGIC_VECTOR(31 downto 0):= (others => '0');

begin					  
	
	process(clk) is	
	
	begin			  
		
		if rising_edge(clk) then  
			
			if reset = '1' then
  
				internal_data_out <= (others => '0');

			else
    
				internal_data_out <= data_in;

			
			end if;				   
		
		end if;					  
	
	end process;
	
	data_out <= internal_data_out;

end architecture;
