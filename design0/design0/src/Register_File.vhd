--sohaila
library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Reg_File is

	Port (	
		clk : in STD_LOGIC;	
		RegWrite : in STD_LOGIC;-- from Control       
		write_reg : in STD_LOGIC_VECTOR(4 downto 0);
		write_data : in STD_LOGIC_VECTOR(31 downto 0);
		read_reg1 : in STD_LOGIC_VECTOR(4 downto 0);  
		read_reg2 : in STD_LOGIC_VECTOR(4 downto 0);  
		read_data1 : out STD_LOGIC_VECTOR(31 downto 0);
		read_data2 : out STD_LOGIC_VECTOR(31 downto 0) 
	); 
end Reg_File;

architecture Behavioral of Reg_File is							 
	type reg_arr is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
	signal regs : reg_arr := (others => (others => '0'));

begin
    
	process(clk) is 
	begin		
		if rising_edge(clk) then 
    		if RegWrite = '1' then
				if write_reg /= "00000" then 
					regs(to_integer(unsigned(write_reg))) <= write_data;
				end if;
			end if;	 
		end if;
    
	end process;		  
	read_data1 <= regs(to_integer(unsigned(read_reg1))); 
	read_data2 <= regs(to_integer(unsigned(read_reg2)));

end architecture;