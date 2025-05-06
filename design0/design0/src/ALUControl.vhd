library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


	   --> funct codes <--
----------------------------------
-- add         			| 100000 |
-- subtract    			| 100010 |
-- and         			| 100100 |
-- or          			| 100101 |
-- nor         			| 100111 |
-- shift_left  			| 000000 |
-- shift_right 			| 000010 |
-- set_is_less_than     | 101010 |
----------------------------------


entity ALUControl is
    port (
        ALUOp: in  std_logic_vector(1 downto 0);
        funct: in  std_logic_vector(5 downto 0);
        control: out std_logic_vector(2 downto 0)
    );
end entity;

architecture ALUControl_ARCH of ALUControl is
begin
    process(ALUOp, funct)
    begin
        case ALUOp is
            when "00" =>
                control <= "000"; -- add (for LW/SW)
            when "01" =>
                control <= "001"; -- sub (for BEQ)
            when "10" => -- R-type
                case funct is
                    when "100000" => control <= "000"; -- add
                    when "100010" => control <= "001"; -- sub
                    when "100100" => control <= "010"; -- and
                    when "100101" => control <= "011"; -- or
                    when "100111" => control <= "100"; -- nor
                    when "000000" => control <= "101"; -- sll
                    when "000010" => control <= "110"; -- srl
					when "101010" => control <= "111"; -- slt
                    when others   => control <= "111"; -- default/fallback
                end case;
            when others =>
                control <= "111"; -- default
        end case;
    end process;
end architecture;
