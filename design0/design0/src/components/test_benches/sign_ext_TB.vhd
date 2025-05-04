library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity sign_ext_TB is
end entity;

architecture TB of sign_ext_TB is

    component sign_ext is
        port(
            num_in: in std_logic_vector(15 downto 0);
            num_out: out std_logic_vector(31 downto 0)
        );
    end component;

    signal A_tb: std_logic_vector(15 downto 0);
	signal B_tb: std_logic_vector(31 downto 0);

begin

    c1: sign_ext port map (
        num_in => A_tb,
    	num_out => B_tb
    );
	
	process is
	begin
		A_tb <= x"F000"; -- negative number
		wait for 20 ns;
		A_tb <= x"1000"; -- positive number
		wait;
	end process;
		
end architecture;
