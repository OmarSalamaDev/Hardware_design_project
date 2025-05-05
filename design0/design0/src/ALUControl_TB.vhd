library ieee;
use ieee.std_logic_1164.all;

entity ALUControl_tb is
-- No ports in testbench
end entity;

architecture Behavioral of ALUControl_tb is

    -- Component declaration
    component ALUControl
        port (
            ALUOp: in  std_logic_vector(1 downto 0);
            funct: in  std_logic_vector(5 downto 0);
            ALUControl: out std_logic_vector(2 downto 0)
        );
    end component;

    -- Testbench signals
    signal ALUOp_tb: std_logic_vector(1 downto 0);
    signal funct_tb: std_logic_vector(5 downto 0);
    signal ALUControl_tb: std_logic_vector(2 downto 0);

begin

    -- Instantiate the unit under test
    uut: ALUControl
        port map (
            ALUOp => ALUOp_tb,
            funct => funct_tb,
            ALUControl => ALUControl_tb
        );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test ALUOp = "00" (Load/Store)
        ALUOp_tb <= "00";
        funct_tb <= "000000"; -- ignored
        wait for 10 ns;

        -- Test ALUOp = "01" (BEQ)
        ALUOp_tb <= "01";
        funct_tb <= "000000"; -- ignored
        wait for 10 ns;

        -- R-type instructions (ALUOp = "10") with various funct codes
        ALUOp_tb <= "10";
        
        funct_tb <= "100000"; -- add
        wait for 10 ns;
        
        funct_tb <= "100010"; -- sub
        wait for 10 ns;

        funct_tb <= "100100"; -- and
        wait for 10 ns;

        funct_tb <= "100101"; -- or
        wait for 10 ns;

        funct_tb <= "101010"; -- not
        wait for 10 ns;

        funct_tb <= "101110"; -- SL
        wait for 10 ns;

        funct_tb <= "101011"; -- SR
        wait for 10 ns;

        funct_tb <= "111111"; -- invalid
        wait for 10 ns;

        -- Test invalid ALUOp
        ALUOp_tb <= "11";
        funct_tb <= "000000"; -- ignored
        wait for 10 ns;

        -- End simulation
        wait;
    end process;

end architecture;
