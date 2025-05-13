--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;	

entity PC is
    
	Port (  
		clk : in STD_LOGIC;	  
		reset : in STD_LOGIC;
		pc_control : in STD_LOGIC;   
		pc_in : in STD_LOGIC_VECTOR(31 downto 0);
		pc_out : out STD_LOGIC_VECTOR(31 downto 0)
    
	);

end entity;  

architecture Behavioral of PC is
signal current_pc : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');  
begin
    
	process(clk)is 
	begin
		if rising_edge(clk) then
            if reset = '1' then
                current_pc <= (others => '0');
            elsif pc_control = '1' then
                current_pc <= pc_in;  
            end if;
        end if;
    end process;
	
    pc_out <= current_pc;
end architecture;