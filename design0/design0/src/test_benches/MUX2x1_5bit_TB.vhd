library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity MUX2x1_5bit_TB is
end entity;

architecture TB of MUX2x1_5bit_TB is

    component MUX2x1_5bit is
        port(
			A,B: in std_logic_vector(4 downto 0);
			sel: in std_logic;
			num_out: out std_logic_vector(4 downto 0)
        );
    end component;

		signal A_tb,B_tb: std_logic_vector(4 downto 0);
		signal sel_tb: std_logic;
		signal out_tb: std_logic_vector(4 downto 0);

begin

    c1: MUX2x1_5bit port map (
        A => A_tb,
    	B => B_tb,
		sel => sel_tb,
		num_out => out_tb
    );
	
	process is
	begin
		A_tb <= "10000";
		B_tb <= "00001";
		sel_tb <= '0';
		wait for 20 ns;
		sel_tb <= '1';
		wait;
	end process;
		
end architecture;
