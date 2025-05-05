library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;	 
use ieee.numeric_std.all;

entity ALUControl is
    port (
        ALUOp: in  std_logic_vector(1 downto 0);
        funct: in  std_logic_vector(5 downto 0);
        ALUControl: out std_logic_vector(2 downto 0)
    );
end entity;	

architecture Behavioral of ALUControl is
begin
    process(ALUOp, funct) is
    begin
        case ALUOp is
            when "00" => ALUControl <= "000"; -- add for LW/SW
            when "01" => ALUControl <= "001"; -- sub for BEQ
            when "10" => -- R-type, use funct field
                case funct is
                    when "100000" => ALUControl <= "000"; -- add
                    when "100010" => ALUControl <= "001"; -- sub
                    when "100100" => ALUControl <= "010"; -- and
                    when "100101" => ALUControl <= "011"; -- or
                    when "101010" => ALUControl <= "100"; -- not
					when "101110" => ALUControl <= "101"; -- SL
					when "101011" => ALUControl <= "110"; -- SR
					when others => ALUControl <= "111"; -- invalid
				end case;
            when others =>
                ALUControl <= "111"; -- invalid
        end case;
    end process;
end architecture;
