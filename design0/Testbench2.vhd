library ieee;
use ieee.std_logic_1164.all;

entity Testbench is
end entity;

architecture behavior of Testbench is
    -- Declare clock and reset signals
    signal clk   : std_logic := '0';
    signal reset : std_logic := '0';

    -- Declare component (your MIPS top-level entity)
    component TopLevel
        port (
            clk   : in std_logic;
            reset : in std_logic
        );
    end component;

begin

    
    UUT: TopLevel
        port map (
            clk   => clk,
            reset => reset
        );

    -- Clock generation process: 10 ns period (5 ns high / 5 ns low)
    clk_process: process
    begin
        while true loop
            clk <= '1';
            wait for 5 ns;
            clk <= '0';
            wait for 5 ns;
        end loop;
    end process;

    -- Reset and simulation control
    stim_process: process
    begin
        -- Wait for the first rising edge
        wait for 2 ns;
        wait until rising_edge(clk);

        -- Assert synchronous reset
        reset <= '1';
        wait until rising_edge(clk);  -- Hold for one clock cycle
        reset <= '0';

        -- Let simulation run for enough time to observe behavior
        wait for 1000 ns;

        -- End simulation in Active-HDL
        assert false report "Simulation completed." severity failure;
    end process;

end behavior;

