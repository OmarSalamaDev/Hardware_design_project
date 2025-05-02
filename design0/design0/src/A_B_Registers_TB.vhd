library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity AB_Reg_TB is
end entity;

architecture sim of AB_Reg_TB is 
    signal clk      : std_logic := '0';
    signal data_in  : std_logic_vector(31 downto 0) := (others => '0');
    signal data_out : std_logic_vector(31 downto 0);

begin	
    clk <= not clk after 5 ns; 
    DUT:entity AB_Reg
        port map (
            clk      => clk,
            data_in  => data_in,
            data_out => data_out
        );
			   
    process
    begin
        wait for 7 ns; 
        data_in <= x"0000000A";
        wait for 10 ns;
        data_in <= x"0000000F";
        wait for 10 ns;
        data_in <= x"12345678";
        wait for 10 ns;
        wait;
    end process;

end architecture;
