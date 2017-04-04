
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Process_Complete is
    Port ( CLK : in  STD_LOGIC;
           RST : in  STD_LOGIC;
			  aluResult : out  STD_LOGIC_VECTOR (31 DOWNTO 0));
           --DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           --programCounter : out  STD_LOGIC_VECTOR (31 downto 0));
end Process_Complete;

architecture Behavioral of Process_Complete is

component Adder is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Result : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


Component Register_File is
    Port ( Rs1 : in  STD_LOGIC_VECTOR (4 downto 0);
           Rs2 : in  STD_LOGIC_VECTOR (4 downto 0);
           Rd : in  STD_LOGIC_VECTOR (4 downto 0);
           Rst : in  STD_LOGIC;
           Dwr : in  STD_LOGIC_VECTOR (31 downto 0);
           CRs1 : out  STD_LOGIC_VECTOR (31 downto 0);
           CRs2 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

Component Program_Counter is
    Port ( Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


component Instruction_Memory is
    Port ( Address : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Control_Unity is
    Port ( Op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           Op : in  STD_LOGIC_VECTOR (1 downto 0);
           AluOp : out  STD_LOGIC_VECTOR (5 downto 0));
end component;

component Alu is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Next_Program_Counter is
Port ( Data_In : in  STD_LOGIC_VECTOR (31 downto 0);
           rst : in  STD_LOGIC;
           Clk : in  STD_LOGIC;
           Data_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Mux is
    Port ( Crs2 : in  STD_LOGIC_VECTOR (31 downto 0);
           Imm : in  STD_LOGIC_VECTOR (31 downto 0);
           i : in  STD_LOGIC;
           Mux_Out : out  STD_LOGIC_VECTOR (31 downto 0));
end component;

component Extention_signal is
    Port ( In1 : in  STD_LOGIC_VECTOR (12 downto 0);
           Out1 : out  STD_LOGIC_VECTOR (31 downto 0));
end component;


	signal outadder_NPC : std_logic_vector(31 downto 0);
	signal OutNPC_Add : std_logic_vector(31 downto 0);
	signal OutPC_IM : std_logic_vector(31 downto 0);
	signal Out_IM : std_logic_vector(31 downto 0);
	signal OutALu_RF : std_logic_vector(31 downto 0);
	signal outUC_ALU : std_logic_vector(5 downto 0);
	signal outRF_Alu :std_logic_vector(31 downto 0);
	signal outRF_Alu2 :std_logic_vector(31 downto 0);
	signal Mux_out_aux :std_logic_vector(31 downto 0);     
	signal Imm_out_aux :std_logic_vector(31 downto 0); 
	
begin



Sumador  : Adder PORT MAP(
		op1 =>"00000000000000000000000000000001",
		op2 => OutNPC_Add,
		result =>outadder_NPC
);

NextProgramCounter :Next_Program_Counter PORT MAP(
		Data_In => outadder_NPC,
		rst => RST,
		Clk=> CLK,
		Data_Out =>OutNPC_Add
);

ProgramCounter1 : Program_Counter PORT MAP(
		Data_In => OutNPC_Add,
		rst => RST,
		Clk=> CLK,
		Data_Out => OutPC_IM
);

InstructionMemory : Instruction_Memory PORT MAP(

		Address => OutPC_IM ,
           rst =>RST,
           Data_Out => Out_IM 
);

UnidadControl: Control_Unity PORT MAP(
			  Op3 => Out_IM(24 downto 19),
           Op =>Out_IM(31 downto 30),
           AluOp =>outUC_ALU
	);
		
RegisterFile1 : Register_File PORT MAP (

			  Rs1 =>Out_IM(18 downto 14 ),
           Rs2 =>Out_IM(4 downto 0 ),
           Rd =>Out_IM(29 downto 25),
           Rst =>RST,
           Dwr =>OutALu_RF,
           CRs1 => outRF_Alu,
           CRs2 => outRF_Alu2
);

ExtensionSigno: Extention_signal PORT MAP(
				In1 =>  Out_IM (12 downto 0),
           Out1 => Imm_out_aux
);

Multiplexor: Mux PORT MAP(
           Crs2 => outRF_Alu2,
           Imm => Imm_out_aux,
           i => Out_IM(13),
           Mux_Out =>Mux_out_aux
);



AritmeticLogicUnity : Alu PORT MAP (
			  Op1 => outRF_Alu,
           Op2 => Mux_out_aux,
           AluOp => outUC_ALU,
           AluResult => OutALu_RF
);
aluResult <= OutAlu_RF;


end Behavioral;

