library ieee;
use ieee.std_logic_1164.ALL;
use ieee.numeric_std.ALL;

entity Reg_File_TB is
end entity;

architecture sim of Reg_File_TB is
    
    signal clk         : std_logic := '0';
    signal RegWrite    : std_logic := '0';
    signal write_reg   : std_logic_vector(4 downto 0) := (others => '0');
    signal write_data  : std_logic_vector(31 downto 0) := (others => '0');
    signal read_reg1   : std_logic_vector(4 downto 0) := (others => '0');
    signal read_reg2   : std_logic_vector(4 downto 0) := (others => '0');
    signal read_data1  : std_logic_vector(31 downto 0);
    signal read_data2  : std_logic_vector(31 downto 0);
		   
begin	 
    uut:entity Reg_File
        port map (
            clk         => clk,
            RegWrite    => RegWrite,
            write_reg   => write_reg,
            write_data  => write_data,
            read_reg1   => read_reg1,
            read_reg2   => read_reg2,
            read_data1  => read_data1,
            read_data2  => read_data2
        );
  	--clock Driver
    process
    begin
        while true loop
            clk <= '0';
            wait for 5 ns;
            clk <= '1';
            wait for 5 ns;
        end loop;
    end process;

   
    process
    begin
        wait for 10 ns;
		
        write_reg   <= "00001";
        write_data  <= x"AAAAAAAA";
        RegWrite    <= '1';
        wait for 10 ns;
        RegWrite    <= '0';

        
        write_reg   <= "00010";
        write_data  <= x"BBBBBBBB";
        RegWrite    <= '1';
        wait for 10 ns;
        RegWrite    <= '0';

        
        read_reg1 <= "00001";
        read_reg2 <= "00010";
        wait for 10 ns;

        
        write_reg   <= "00000";
        write_data  <= x"FFFFFFFF";
        RegWrite    <= '1';
        wait for 10 ns;
        RegWrite    <= '0';

        
        read_reg1 <= "00000";
        wait for 10 ns;

        wait;
    end process;

end architecture ;
