library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Data_Mem_TB is
end entity;

architecture sim of Data_Mem_TB is 
    signal clk        : std_logic := '0';
    signal address    : std_logic_vector(31 downto 0) := (others => '0');
    signal read       : std_logic := '0';
    signal write      : std_logic := '0';
    signal data_write : std_logic_vector(31 downto 0) := (others => '0');
    signal data_read  : std_logic_vector(31 downto 0);

    		   
begin

    DUT:entity Data_Mem
        port map (
            clk        => clk,
            address    => address,
            read       => read,
            write      => write,
            data_write => data_write,
            data_read  => data_read
        );

   --clk Driver
    process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    
    process
    begin
        wait for 10 ns;	  
        
        address <= x"00000000";
        data_write <= x"DEADBEEF";
        write <= '1';
        wait for 10 ns;
        write <= '0';  
		
        address <= x"00000004";
        data_write <= x"CAFEBABE";
        write <= '1';
        wait for 10 ns;
        write <= '0'; 
        
        address <= x"00000000";
        read <= '1';
        wait for 10 ns;
        read <= '0';

        
        address <= x"00000004";
        read <= '1';
        wait for 10 ns;
        read <= '0';

        wait;
    end process;

end architecture;
