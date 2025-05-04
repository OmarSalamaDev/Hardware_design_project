library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.numeric_std.all;

entity ALU_TB is
end entity;

architecture TB of ALU_TB is

    component ALU is
        port(
            A: in std_logic_vector(31 downto 0);
            B: in std_logic_vector(31 downto 0);
            control: in std_logic_vector(2 downto 0);
            result: out std_logic_vector(31 downto 0);
            zero: out std_logic
        );
    end component;

    signal A_tb, B_tb, result_tb: std_logic_vector(31 downto 0);
    signal control_tb: std_logic_vector(2 downto 0);
    signal zero_tb: std_logic;

begin

    c1: ALU port map (
    	A => A_tb,
        B => B_tb,
        control => control_tb,
        result => result_tb,
        zero => zero_tb
    );

    process	is
    begin
        -- test add (000)
        A_tb <= x"00000005";
        B_tb <= x"00000003";
        control_tb <= "000";
        wait for 10 ns;

        -- test subtract (001)
        A_tb <= x"00000005";
        B_tb <= x"00000003";
        control_tb <= "001";
        wait for 10 ns;

        -- test and (010)
        A_tb <= x"FFFFFFFF";
        B_tb <= x"0F0F0F0F";
        control_tb <= "010";
        wait for 10 ns;

        -- test or (011)
        A_tb <= x"00000000";
        B_tb <= x"12345678";
        control_tb <= "011";
        wait for 10 ns;

        -- test not (100)
        A_tb <= x"AAAAAAAA";
        B_tb <= x"00000000";  -- B is unused
        control_tb <= "100";
        wait for 10 ns;

        -- test shift_left (101)
        A_tb <= x"0000000F";
        B_tb <= x"00000000";  -- B is unused
        control_tb <= "101";
        wait for 10 ns;

        -- test shift_right (110)
        A_tb <= x"F0000000";
        B_tb <= x"00000000";  -- B is unused
        control_tb <= "110";
        wait for 10 ns;

        -- test zero output
        A_tb <= x"00000000";
        B_tb <= x"00000000";
        control_tb <= "000";
        wait for 10 ns;

        wait; -- stop simulation
    end process;

end architecture;
