library ieee;
use ieee.std_logic_1164.all;

entity TestBench is  
end entity TestBench;

architecture sim of TestBench is
  signal clk   : std_logic := '0';
  signal reset : std_logic := '0';
  constant clk_period : time := 12 ns;
  

  component Top_Level is  
    port (
      clk   : in std_logic;
      reset : in std_logic
    );
  end component;
  
begin

  UUT: Top_Level  
    port map (
      clk   => clk,
      reset => reset
    );


  -- Clock process remains the same
  clock_process : process
  begin
	  reset <= '1';
		wait for clk_period;
		reset <= '0';	 
		
    for i in 0 to 50 loop
      clk <= '1';
      wait for clk_period;
      clk <= '0';
      wait for clk_period;
    end loop;
	wait;
  end process;


end sim;	

