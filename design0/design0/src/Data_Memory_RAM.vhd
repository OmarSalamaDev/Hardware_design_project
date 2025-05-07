library ieee;  
use ieee.std_logic_1164.ALL; 
use ieee.numeric_std.ALL;	

entity Data_Mem is
	port(
	clk : in STD_LOGIC;	
	reset : in STD_LOGIC;
	address : in STD_LOGIC_VECTOR(31 downto 0);
	read : in STD_LOGIC;
	write : in STD_LOGIC;	  
	data_write : in STD_LOGIC_VECTOR(31 downto 0);
	data_read : out STD_LOGIC_VECTOR(31 downto 0)
	);
end entity;

architecture Behavioral of Data_Mem is 
	type ram_type is array (0 to 63) of STD_LOGIC_VECTOR(7 downto 0);
	signal ram : ram_type := (
		-- add $t0, $t1, $t2  => 0x012A4020
		0 => x"01",  -- 00000001
		1 => x"2A",  -- 00101010
		2 => x"40",  -- 01000000
		3 => x"20",  -- 00100000
		
		-- sub $t3, $t4, $t5  => 0x018D5822
		4 => x"01",
		5 => x"8D",
		6 => x"58",
		7 => x"22",
		
		-- lw $t0, 4($t1) => 0x8D280004
		8 => x"8D",
		9 => x"28",
		10 => x"00",
		11 => x"04",
		
		-- sw $t2, 8($t3) => 0xAD6A0008
		12 => x"AD",
		13 => x"6A",
		14 => x"00",
		15 => x"08",
		
		-- beq $t0, $t1, 3 => 0x11090003
		16 => x"11",
		17 => x"09",
		18 => x"00",
		19 => x"03",
		
  others => (others => '0')); 
  
  signal data_out_reg : std_logic_vector(31 downto 0):= (others => '0');

begin 
	
	process (clk) is
    
	begin
        
		if rising_edge(clk) then
            
			if reset = '1' then
               
				data_out_reg <= (others => '0');
            
			else
               
				if write = '1' then 
                    
					ram(to_integer(unsigned(address))) <= data_write(31 downto 24);
                    
					ram(to_integer(unsigned(address) + 1)) <= data_write(23 downto 16);
                    
					ram(to_integer(unsigned(address) + 2)) <= data_write(15 downto 8);
                    
					ram(to_integer(unsigned(address) + 3)) <= data_write(7 downto 0);
                
				end if;

               
			if read = '1' then
                    
				data_out_reg <= ram(to_integer(unsigned(address)))     &
                                    
								ram(to_integer(unsigned(address) + 1)) &
                                   
								ram(to_integer(unsigned(address) + 2)) &
                                    
								ram(to_integer(unsigned(address) + 3));
                
			end if;
            
			end if;
        
		end if;
    
	end process;

    
	data_read <= data_out_reg;


end architecture;