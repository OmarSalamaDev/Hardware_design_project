library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity PC_TB is
end entity;

architecture sim of PC_TB is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal pc_write : STD_LOGIC := '0';
    signal pc_source : STD_LOGIC_VECTOR(1 downto 0) := "00";
    signal pc_in : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal pc_out : STD_LOGIC_VECTOR(31 downto 0);

    

begin
    DUT:entity PC
	port map (
        clk => clk,
        reset => reset,
        pc_write => pc_write,
        pc_source => pc_source,
        pc_in => pc_in,
        pc_out => pc_out
    );

    
    clk_process: process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

    stim_proc: process
    begin
        --reset
        reset <= '1';
        wait for 10 ns;
        reset <= '0';	
        
        pc_write <= '1';
        pc_source <= "00";
        wait for 10 ns;  -- rising edge -> PC = 4
        wait for 10 ns;  -- rising edge -> PC = 8
												 
        pc_source <= "01";
        pc_in <= x"00000020";
        wait for 10 ns;  -- rising edge -> PC = 0x20
						   
        pc_source <= "10";
        pc_in <= x"00000064";
        wait for 10 ns;  -- rising edge -> PC = 0x64	 
        
        pc_write <= '0';
        pc_source <= "00";
        wait for 10 ns;  -- rising edge, no change

        wait;
    end process;

end architecture;
