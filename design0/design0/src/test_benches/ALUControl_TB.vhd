library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALUControl_TB is
end entity;

architecture TB of ALUControl_TB is

    component ALUControl is
        port (
            ALUOp: in  std_logic_vector(1 downto 0);
            funct: in  std_logic_vector(5 downto 0);
            control: out std_logic_vector(2 downto 0)
        );
    end component;

    signal ALUOp_tb: std_logic_vector(1 downto 0);
    signal funct_tb: std_logic_vector(5 downto 0);
    signal control_tb: std_logic_vector(2 downto 0);

begin

    c1: ALUControl port map (
        ALUOp => ALUOp_tb,
        funct => funct_tb,
    	control => control_tb
    );

    process
    begin
        -- LW/SW: ALUOp = 00 ? add
        ALUOp_tb <= "00";
        funct_tb <= "000000"; -- ignored
        wait for 10 ns;

        -- BEQ: ALUOp = 01 ? sub
        ALUOp_tb <= "01";
        funct_tb <= "000000"; -- ignored
        wait for 10 ns;

        -- R-type tests: ALUOp = 10
        ALUOp_tb <= "10";

        -- add (funct = 100000)
        funct_tb <= "100000";
        wait for 10 ns;

        -- sub (funct = 100010)
        funct_tb <= "100010";
        wait for 10 ns;

        -- and (funct = 100100)
        funct_tb <= "100100";
        wait for 10 ns;

        -- or (funct = 100101)
        funct_tb <= "100101";
        wait for 10 ns;

        -- nor (funct = 100111)
        funct_tb <= "100111";
        wait for 10 ns;

        -- slt (funct = 101010)
        funct_tb <= "101010";
        wait for 10 ns;

        -- sll (funct = 000000)
        funct_tb <= "000000";
        wait for 10 ns;

        -- srl (funct = 000010)
        funct_tb <= "000010";
        wait for 10 ns;

        -- Invalid funct
        funct_tb <= "111111";
        wait for 10 ns;

        -- Invalid ALUOp
        ALUOp_tb <= "11";
        funct_tb <= "000000";
        wait for 10 ns;

        wait;
    end process;

end architecture;
