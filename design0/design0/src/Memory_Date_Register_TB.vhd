library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MDR_TB is
end entity;

architecture sim of MDR_tb is
    signal clk      : std_logic := '0';
    signal data_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal read     : std_logic := '0';
    signal data_out : std_logic_vector(31 downto 0);

begin 
    clk <= not clk after 5 ns;
    
    DUT:entity MDR
        port map (
            clk      => clk,
            data_in  => data_in,
            read     => read,
            data_out => data_out
        );
		  
    process
    begin
        wait for 7 ns;
        data_in <= x"AAAAAAAA";  
        read <= '1';             

        wait for 10 ns;
        data_in <= x"12345678";  
        read <= '0';             

        wait for 10 ns;
        data_in <= x"87654321";
        read <= '1';             

        wait for 10 ns;
        wait;
    end process;

end architecture;
