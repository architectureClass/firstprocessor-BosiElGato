
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Process_Complete is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           DataOut : out  STD_LOGIC_VECTOR (31 downto 0);
           programCounter : out  STD_LOGIC_VECTOR (31 downto 0));
end Process_Complete;

architecture Behavioral of Process_Complete is

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


	signal outPCToInstructionMemory : std_logic_vector(31 downto 0);
	signal OutAdderToPC : std_logic_vector(31 downto 0);
begin


end Behavioral;

