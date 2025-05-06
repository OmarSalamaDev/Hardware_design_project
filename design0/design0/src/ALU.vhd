library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;	
use ieee.numeric_std.all;


  --> ALU Operation Codes <--
-------------------------------
-- add         			| 000 |
-- subtract    			| 001 |
-- and         			| 010 |
-- or          			| 011 |
-- nor         			| 100 |
-- shift_left  			| 101 |
-- shift_right 			| 110 |
-- set_is_less_than 	| 111 |
-------------------------------


entity ALU is
	port(
		A: in std_logic_vector(31 downto 0);
	   	B: in std_logic_vector(31 downto 0);	  
		control: in std_logic_vector(2 downto 0);
		result: out std_logic_vector(31 downto 0);
		zero: out std_logic
	);
end entity;

architecture ALU_ARCH of ALU is
	signal temp_buf: std_logic_vector(31 downto 0);
begin
	process(A, B, control) is
	begin
		case control is
			when "000" =>		   
				temp_buf <= A + B; -- add
			when "001" =>
				temp_buf <= A - B; --sub
			when "010" =>
				temp_buf <= A and B; -- and
			when "011" =>
				temp_buf <= A or B; -- or
			when "100" =>
				temp_buf <= not (A or B); -- nor
			when "101" =>
				temp_buf <= A(30 downto 0) & '0'; --sll
			when "110" =>
				temp_buf <= '0' & A(31 downto 1); -- srl
			when "111" =>
				if signed(A) < signed(B) then
					temp_buf <= (31 downto 1 => '0') & '1'; --slt -> A less than B -> '1'
				else
					temp_buf <= (others => '0'); --slt -> A not less than B -> '0'
				end if;
			when others =>
				temp_buf <= (others => '0');
		end case;		
	end process;

	result <= temp_buf;
	zero <= '1' when temp_buf = x"00000000" else '0';

end architecture;
