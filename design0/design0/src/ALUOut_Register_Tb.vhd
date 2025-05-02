library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity ALUOut_TB is
end entity;

architecture sim of ALUOut_tb is
    signal clk        : std_logic := '0';
    signal ALUOut_in  : std_logic_vector(31 downto 0);
    signal aluout     : std_logic_vector(31 downto 0);

begin	 
    
    DUT: entity ALUOut
        port map (
            clk        => clk,
            ALUOut_in  => ALUOut_in,
            aluout     => aluout
        );		   
    clk <= not clk after 5 ns; 
    
    process
    begin
        ALUOut_in <= x"00000001";
        wait for 10 ns;

        ALUOut_in <= x"0000000A";
        wait for 10 ns;

        ALUOut_in <= x"00000064";
        wait for 10 ns;

        wait;
    end process;

end architecture;