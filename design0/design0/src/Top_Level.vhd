-- Top level

library ieee;
use ieee.std_logic_1164.all;

entity Top_Level is
	
    port( clk , reset : in std_logic );	 
	
end Top_Level;	

architecture Behavioral of Top_Level is 

-- components	  

component Memory 
	port(
	-- inputs
        CLK       : in std_logic;
        address   : in std_logic_vector(31 downto 0);
        MemWrite  : in std_logic;
        MemRead   : in std_logic;
        WriteData : in std_logic_vector(31 downto 0);

        -- output
        MemData   : out std_logic_vector(31 downto 0) );
end component; 

component InstructionRegister	
	port(
	clk:in STD_LOGIC;
	reset: in std_logic;
	IRWrite:in STD_LOGIC;
	MemData :in std_logic_vector(31 downto 0);
	instruction :out std_logic_vector(31 downto 0)
	);
end component; 

component MDR 

	Port (			  
	clk : in STD_LOGIC;	
	reset  : in STD_LOGIC;
	data_in : in STD_LOGIC_VECTOR(31 downto 0);	
	data_out  : out STD_LOGIC_VECTOR(31 downto 0)
	);

end component;	

component PC
    
	Port (  
		clk : in STD_LOGIC;	  
		reset : in STD_LOGIC;
		pc_control : in STD_LOGIC;   
		pc_in : in STD_LOGIC_VECTOR(31 downto 0);
		pc_out : out STD_LOGIC_VECTOR(31 downto 0)
    
	);

end component; 	  

component Reg_File 

	Port (	
	    clk : in STD_LOGIC;	
	    reset: in std_logic;
		RegWrite : in STD_LOGIC;-- from Control       
		write_reg : in STD_LOGIC_VECTOR(4 downto 0);
		write_data : in STD_LOGIC_VECTOR(31 downto 0);
		read_reg1 : in STD_LOGIC_VECTOR(4 downto 0);  
		read_reg2 : in STD_LOGIC_VECTOR(4 downto 0);  
		read_data1 : out STD_LOGIC_VECTOR(31 downto 0);
		read_data2 : out STD_LOGIC_VECTOR(31 downto 0) 
	); 
end component;

component TempRegisters is
  port( -- input
        CLK         : in std_logic;
        reset       : in std_logic;
        in_reg_A    : in std_logic_vector (31 downto 0);
        in_reg_B    : in std_logic_vector (31 downto 0);
        in_ALU_out  : in std_logic_vector (31 downto 0);

        -- output
        out_reg_A   : out std_logic_vector(31 downto 0);
        out_reg_B   : out std_logic_vector(31 downto 0);
        out_ALU_out : out std_logic_vector(31 downto 0) );
end component;

component ALU 
	port(
		A: in std_logic_vector(31 downto 0);
	   	B: in std_logic_vector(31 downto 0);	  
		control: in std_logic_vector(3 downto 0);
		result: out std_logic_vector(31 downto 0);
		zero: out std_logic
	);
end component;

component ALUControl 
    port (
        ALUOp: in  std_logic_vector(1 downto 0);
        funct: in  std_logic_vector(5 downto 0);
        control: out std_logic_vector(3 downto 0)
    );
end component;

component MUX2x1_5bit 
	port(
		A,B: in std_logic_vector(4 downto 0);
		sel: in std_logic;
		num_out: out std_logic_vector(4 downto 0)
	);
end component;

component MUX2x1_32bit 
	port(
		A,B: in std_logic_vector(31 downto 0);
		sel: in std_logic;
		num_out: out std_logic_vector(31 downto 0)
	);
end component;

component MUX3x1_32bit 
	port(
		A,B,C: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0);
		num_out: out std_logic_vector(31 downto 0)
	);
end component;

component MUX4x1_32bit 
	port(
		A,B,C,D: in std_logic_vector(31 downto 0);
		sel: in std_logic_vector(1 downto 0);
		num_out: out std_logic_vector(31 downto 0)
	);
end component;	

component SL2 
	port(
		num_in: in std_logic_vector(31 downto 0);
	   	num_out: out std_logic_vector(31 downto 0)
	);
end component; 

component SL2_Jump  
	port(
		num_in: in std_logic_vector(25 downto 0);
	   	num_out: out std_logic_vector(27 downto 0)
	);
end component;

component sign_ext 
	port(
		num_in: in std_logic_vector(15 downto 0);
	   	num_out: out std_logic_vector(31 downto 0)
	);
end component;	 

component ControlUnit 
	 port(--input
	 clk:   in std_logic;
	 Reset: in std_logic;
	 Op:    in std_logic_vector(5 downto 0);
	 
	 --output(control signals)
	 PCWrtieCond,PCWrite,IorD,MemRead,MemWrite,MemtoReg,IRWrite,ALUSrcA,RegWrite,RegDst: out std_logic;
	 PCSource,ALUOp,ALUSrcB : out std_logic_vector(1 downto 0));
end component; 	  


-- constants   

  constant PC_increment : std_logic_vector(31 downto 0) := x"00000004";
  


-- signals:  

  
signal PC_out, MuxToAddress, MemDataOut, MemoryDataRegOut, InstructionRegOut : std_logic_vector(31 downto 0);
signal MuxToWriteData, ReadData1ToA, ReadData2ToB, RegAToMux, RegBToMux : std_logic_vector(31 downto 0) ;
signal SignExtendOut, ShiftLeft1ToMux4, MuxToAlu, Mux4ToAlu, AluResultOut, AluOutToMux : std_logic_vector(31 downto 0) ;
signal JumpAddress, MuxToPC : std_logic_vector(31 downto 0);

  
signal ZeroCarry_TL, ALUSrcA_TL, RegWrite_TL, RegDst_TL : std_logic;
signal PCWriteCond_TL, PCWrite_TL, IorD_TL, MemRead_TL, MemWrite_TL : std_logic;
signal MemToReg_TL, IRWrite_TL, ANDtoOR, ORtoPC : std_logic ;


signal MuxToWriteRegister : std_logic_vector(4 downto 0);


signal ALUControltoALU : std_logic_vector(3 downto 0);


signal PCsource_TL, ALUSrcB_TL, ALUOp_TL : std_logic_vector(1 downto 0);

  begin
	  ANDtoOR <= ZeroCarry_TL and PCWriteCond_TL;
      ORtoPC <= ANDtoOR or PCWrite_TL;
      JumpAddress(31 downto 28) <= PC_out(31 downto 28);
	
	  
	  
	  A_Logic_Unit : ALU                  port map(MuxToAlu, Mux4ToALU, ALUControltoALU, AluResultOut, ZeroCarry_TL);
      ALU_CONTROL  : ALUControl           port map(ALUOp_TL, InstructionRegOut(5 downto 0), ALUControltoALU);
      CTRL_UNIT    : ControlUnit          port map(clk, reset, InstructionRegOut(31 downto 26), PCWriteCond_TL, PCWrite_TL, IorD_TL, MemRead_TL, MemWrite_TL, MemToReg_TL, IRWrite_TL, ALUSrcA_TL, RegWrite_TL, RegDst_TL, PCsource_TL, ALUOp_TL, ALUSrcB_TL);
      INSTR_REG    : InstructionRegister  port map(clk, reset, IRWrite_TL, MemDataOut, InstructionRegOut);
      MEM          : Memory               port map(clk, MuxToAddress, MemWrite_TL, MemRead_TL, RegBToMux, MemDataOut);
      MEM_DATA_REG : MDR                  port map(clk, reset, MemDataOut, MemoryDataRegOut);
      MUX_1        : MUX2x1_32bit         port map(PC_out, AluOutToMux, IorD_TL, MuxToAddress);
      MUX_2        : MUX2x1_5bit          port map(InstructionRegOut(20 downto 16), InstructionRegOut(15 downto 11), RegDst_TL, MuxToWriteRegister);
      MUX_3        : MUX2x1_32bit         port map(AluOutToMux, MemoryDataRegOut, MemToReg_TL, MuxToWriteData);
      MUX_4        : MUX2x1_32bit         port map(PC_out, RegAToMux, ALUSrcA_TL, MuxToAlu);
      MUX_5        : MUX4x1_32bit         port map(RegBToMux, PC_increment, SignExtendOut, ShiftLeft1ToMux4, ALUSrcB_TL, Mux4ToAlu);
      MUX_6        : MUX3x1_32bit         port map(AluResultOut, AluOutToMux, JumpAddress, PCsource_TL, MuxToPC); 
	  P_C          : PC                   port map(clk, reset, ORtoPC, MuxToPC,  PC_out);
      REG          : Reg_File             port map(clk, reset, RegWrite_TL, MuxToWriteRegister, MuxToWriteData, InstructionRegOut(25 downto 21), InstructionRegOut(20 downto 16), ReadData1ToA, ReadData2ToB);
      SE           : sign_ext             port map(InstructionRegOut(15 downto 0), SignExtendOut);
      SLL1         : SL2                  port map(SignExtendOut, ShiftLeft1ToMux4);
      SLL2         : SL2_Jump             port map(InstructionRegOut(25 downto 0), JumpAddress(27 downto 0));
      TEMP_REG     : TempRegisters        port map(clk, reset, ReadData1ToA, ReadData2ToB, AluResultOut, RegAToMux, RegBToMux, AluOutToMux);
  end Behavioral;
  