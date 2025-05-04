library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity SL2_TB is
end entity;

architecture TB of SL2_TB is

    component SL2 is
        port(
            num_in: in std_logic_vector(31 downto 0);
            num_out: out std_logic_vector(31 downto 0)
        );
    end component;

    signal A_tb, B_tb: std_logic_vector(31 downto 0);

begin

    c1: SL2 port map (
        num_in => A_tb,
    	num_out => B_tb
    );

	A_tb <= x"F0000000";	  	

end architecture;
