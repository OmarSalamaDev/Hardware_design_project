 library ieee;
 use ieee.std_logic_1164.all;
 use ieee.numeric_std.all;	
 
 entity ControlUnit is
	 port(--input
	 CLK:   in std_logic;
	 Reset: in std_logic;
	 Op:    in std_logic_vector(5 downto 0);
	 
	 --output(control signals)
	 PCWrtieCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst: out std_logic;
	 PCSource,ALUOp,ALUSrcB : out std_logic_vector(1 downto 0));
 end entity;
 
 architecture Behavioral of ControlUnit is 	
 	 --10states
  type state is( FETCH,
                ID,
                EXE,
				MemAddressComp,
				BranchComp,
				JumpComp,
				R_typeComp,
				MemAccessLoad,
				MemAccessStore,
				WB);
   signal current_state, next_state: state;
   signal ctrl_state: std_logic_vector(15 downto 0):=(others =>'0');
   
   begin
	   process(CLK,Reset,Op)
	   begin
		   if Reset = '1' then
			   current_state <= FETCH;
		   elsif rising_edge(CLK) then
			   current_state <= next_state;
		   end if;
		   
		   case current_state is
			   when FETCH => next_state <= ID; 
			   when ID =>
			    if    Op = "000000" then --R_type
				   next_state <= EXE; 
				elsif Op = "100011" then --lw
					next_state <= MemAddressComp;
				elsif Op = "101011" then --sw
					next_state <= MemAddressComp;
				elsif Op = "000100" then --beq
					next_state <= BranchComp;
				elsif Op = "000010" then --jump
					next_state <= JumpComp;
				end if;
				when MemAddressComp => if Op = "100011" then --lw
					                      next_state <= MemAccessLoad;
				                       else	--sw
					                      next_state <= MemAccessStore;
				   					   end if;
				when EXE => next_state <= R_typeComp;
				when BranchComp => next_state <= FETCH;
				when JumpComp => next_state <= FETCH;
				when R_typeComp => next_state <= FETCH;
				when MemAccessLoad => next_state <= WB;
				when MemAccessStore => next_state <= FETCH;
				when WB => next_state <= FETCH; 
			end case;
		end process ;
	    
	 with current_state select
		ctrl_state <= "0101001000001000" when FETCH,
                      "0000000000011000" when ID,
		              "0000000000010100" when MemAddressComp,
		              "0000000001000100" when EXE,
		              "0000000000000011" when R_typeComp,
		              "0011000000000000" when MemAccessLoad,
		              "0010100000000000" when MemAccessStore,
		              "1000000010100100" when BranchComp,
		              "0100000100000000" when JumpComp,
		              "0000010000000010" when WB,  
		              "0000000000000000" when others;
		   
		
	PCWrtieCond <= ctrl_state(15);
	PCWrite <= ctrl_state(14);
	IorD <= ctrl_state(13);
	MemRead <= ctrl_state(12);
	MemWrite <= ctrl_state(11);
	MemtoReg <= ctrl_state(10);
	IRWrite <= ctrl_state(9);
	PCSource <= ctrl_state(8 downto 7);
	ALUOp <= ctrl_state(6 downto 5);
	ALUSrcB <= ctrl_state(4 downto 3);
	ALUSrcA <= ctrl_state(2);
	RegWrite <= ctrl_state(1);
	RegDst <= ctrl_state(0);
	
	end architecture ;
	
		
				
			   
			   