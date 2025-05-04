library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity MUX4x1_TB is
end entity;

architecture TB of MUX4x1_TB is

    component MUX4x1 is
        port(
			A,B,C,D: in std_logic_vector(31 downto 0);
			sel: in std_logic_vector(1 downto 0);
			num_out: out std_logic_vector(31 downto 0)
        );
    end component;

		signal A_tb,B_tb,C_tb,D_tb: std_logic_vector(31 downto 0);
		signal sel_tb: std_logic_vector(1 downto 0);
		signal out_tb: std_logic_vector(31 downto 0);

begin

    c1: MUX4x1 port map (
        A => A_tb,
    	B => B_tb,
		C => C_tb,
		D => D_tb,
		sel => sel_tb,
		num_out => out_tb
    );
	
	process is
	begin
		A_tb <= x"A0000000";
		B_tb <= x"B0000000";
		C_tb <= x"C0000000";
		D_tb <= x"D0000000";
		sel_tb <= "00";
		wait for 20 ns;
		sel_tb <= "01";
		wait for 20 ns;
		sel_tb <= "10";
		wait for 20 ns;
		sel_tb <= "11";
		wait;
	end process;
		
end architecture;
