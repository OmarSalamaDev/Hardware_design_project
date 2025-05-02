--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity MDR is

	Port (			  
	clk : in STD_LOGIC;
	data_in : in STD_LOGIC_VECTOR(31 downto 0);
	read  : in STD_LOGIC;	
	data_out  : out STD_LOGIC_VECTOR(31 downto 0)
	);

end entity; 


architecture Behavioral of MDR is

begin					  
	process(clk) is	
	begin			  
		if rising_edge(clk) then  
			if read = '1' then	  
				data_out <= data_in;
			end if;				   
		end if;					  
	end process;			  
end architecture;