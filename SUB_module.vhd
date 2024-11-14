
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity SUM_module is
    Port ( A_s : in  STD_LOGIC_VECTOR (5 downto 0);
           B_s : in  STD_LOGIC_VECTOR (5 downto 0);
           C_s_in : in  STD_LOGIC;
           S_out : out  STD_LOGIC_VECTOR (5 downto 0);
           C_s_out : out  STD_LOGIC);
end SUM_module;

architecture Behavioral of SUM_module is
	SIGNAL i : integer range 1 to 5;
	SIGNAL j : integer range 1 to 5;
	SIGNAL C_temp : STD_LOGIC_VECTOR (5 downto 0);
begin

	
	S_out(0) <= (A_s(0) xor B_s(0)) xor C_s_in ;
	C_temp(0) <= (A_s(0) and B_s(0)) or (C_s_in and (A_s(0) xor B_s(0)));

	label1 : for i in 1 to 5 generate 
		S_out(i) <= (A_s(i) xor B_s(i)) xor C_temp(i-1) ;
	end generate;

	label2 : for j in 1 to 5 generate
		C_temp(j) <= (A_s(j) and B_s(j)) or (C_temp(j-1) and (A_s(j) xor B_s(j)));
	end generate;
	
	C_s_out <= C_temp(5);
	
	

end Behavioral;

