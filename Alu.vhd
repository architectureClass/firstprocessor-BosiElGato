
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Alu is
    Port ( Op1 : in  STD_LOGIC_VECTOR (31 downto 0);
           Op2 : in  STD_LOGIC_VECTOR (31 downto 0);
           AluOp : in  STD_LOGIC_VECTOR (5 downto 0);
           AluResult : out  STD_LOGIC_VECTOR (31 downto 0));
end Alu;

architecture Behavioral of Alu is

begin
process (Op1,Op2,AluOp)
begin
	case (AluOp) is 
		when "000000" =>
			AluResult <= Op1 + Op2;
		when "000010" =>
			AluResult <= Op1 or Op2;
		when "000100" =>
			AluResult <= Op1 - Op2;
		when "000001" =>
			AluResult <= Op1 and Op2;
			
		when others =>
			 AluResult <= (others => '0');
	end case;
end process;	
	
			
end Behavioral;

