library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;	
use ieee.numeric_std.all;


  --> ALU Operation Codes <--
--------------------------------
-- add         			| 0000 |
-- subtract    			| 0001 |
-- and         			| 0010 |
-- or          			| 0011 |
-- nor         			| 0100 |
-- shift_left  			| 0101 |
-- shift_right 			| 0110 |
-- set_is_less_than 	| 0111 |
--------------------------------


entity ALU is
	port(
		A: in std_logic_vector(31 downto 0);
	   	B: in std_logic_vector(31 downto 0);	  
		control: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0);
		zero: out std_logic
	);
end entity;

architecture ALU_ARCH of ALU is
	signal temp_buf: std_logic_vector(31 downto 0):= (others => '0');
begin
	process(A, B, control) is
	begin
		case control is
			when "0000" =>		   
				temp_buf <= A + B; -- add
			when "0001" =>
				temp_buf <= A - B; --sub
			when "0010" =>
				temp_buf <= A and B; -- and
			when "0011" =>
				temp_buf <= A or B; -- or
			when "0100" =>
			temp_buf <= not (A or B); -- nor
		     -- shift left logical
            when "0101" =>
		    temp_buf <=std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B(10 downto 6)))));
			 when "0110" =>
            -- shift right logical
            temp_buf <=std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B(10 downto 6)))));
            when "0111" =>
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
