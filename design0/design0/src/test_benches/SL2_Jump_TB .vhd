library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity SL2_Jump_TB is
end entity;

architecture TB of SL2_Jump_TB is

    component SL2_Jump is
        port(
            num_in: in std_logic_vector(25 downto 0);
            num_out: out std_logic_vector(27 downto 0)
        );
    end component;

    signal A_tb: std_logic_vector(25 downto 0);
	signal B_tb: std_logic_vector(27 downto 0);

begin

    c1: SL2_Jump port map (
        num_in => A_tb,
    	num_out => B_tb
    );

	A_tb <= "11000000000000000000000011";	  	

end architecture;
