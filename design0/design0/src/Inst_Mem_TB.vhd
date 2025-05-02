library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Inst_Mem_TB is
end entity;

architecture sim of Inst_Mem_TB is	
    signal clk        : std_logic := '0';
    signal address    : std_logic_vector(31 downto 0) := (others => '0');
    signal instruction: std_logic_vector(31 downto 0);
   
begin

    
    DUT:entity Inst_Mem
        port map (
            clk         => clk,
            address     => address,
            instruction => instruction
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
        wait for 10 ns;

        address <= x"00000004";  														
        wait for 10 ns;

        address <= x"00000008";  
        wait for 10 ns;

        address <= x"0000000C";  

        wait for 20 ns;

        
        wait;
    end process;

end architecture;
