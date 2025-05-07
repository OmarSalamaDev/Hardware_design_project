--sohaila
--A, B registers
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity AB_Reg is
    
	Port ( 
	clk : in STD_LOGIC;
	reset : in STD_LOGIC;
	data_in : in STD_LOGIC_VECTOR(31 downto 0);
	data_out: out STD_LOGIC_VECTOR(31 downto 0)	
	);

end entity; 

architecture Behavioral of AB_Reg is
signal reg_data : std_logic_vector(31 downto 0) := (others => '0');
begin
    
	process(clk)is 
	begin	   
		if rising_edge(clk) then
			if reset = '1' then
			
	reg_data <= (others => '0');
            
			else
                
				reg_data <= data_in;
            
			end if;
        
		end if;
    
	end process;
	data_out <= reg_data;
end architecture;