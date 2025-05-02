--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;	

entity PC is
    
	Port (  
		clk : in STD_LOGIC;	  
		reset : in STD_LOGIC; -- for current_ppc signal
		pc_write : in STD_LOGIC;
		pc_source : in STD_LOGIC_VECTOR(1 downto 0);    
		pc_in : in STD_LOGIC_VECTOR(31 downto 0);
		pc_out : out STD_LOGIC_VECTOR(31 downto 0)
    
	);

end entity;  

architecture Behavioral of PC is
signal current_pc : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  
begin
    
	process(clk, reset)is 
	begin
		if reset = '1' then
			current_pc <= (others => '0');
			
		elsif rising_edge(clk) then  
			if pc_write = '1' then	
				case pc_source is		
					when "00" => current_pc <= std_logic_vector(unsigned(current_pc) + 4); 
					when "01" | "10" => current_pc <= pc_in; -- =pc + 4 +(4 * offset) => åíÊÍÓÈ Ý Çá ALU
					when others => null; 
			end case;
            
			end if;
		end if;
	end process;              
	pc_out <= current_pc;

end architecture;