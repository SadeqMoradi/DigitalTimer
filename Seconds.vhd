library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity Second is
    Port ( Clk : in  STD_LOGIC;
           Reset : in  STD_LOGIC;
           Start : in  STD_LOGIC;
           Pause : in  STD_LOGIC;
           Stop : in  STD_LOGIC;
           Seconds : out  STD_LOGIC_VECTOR (5 downto 0);
           Done : out  STD_LOGIC);
end Second;

architecture Behavioral of Second is
	SIGNAL STATE : STD_LOGIC :='0';
	SIGNAL D : STD_LOGIC :='0';
	SIGNAL REG : STD_LOGIC_VECTOR (5 downto 0):="000000";
	SIGNAL UP : STD_LOGIC_VECTOR (5 downto 0):="000000";
	
	COMPONENT SUM_module
	PORT(
		A_s : IN std_logic_vector(5 downto 0);
		B_s : IN std_logic_vector(5 downto 0);
		C_s_in : IN std_logic;          
		S_out : OUT std_logic_vector(5 downto 0);
		C_s_out : OUT std_logic
		);
	END COMPONENT;
	

begin
	Inst_SUM_module: SUM_module PORT MAP(
		A_s => REG,
		B_s => "000001",
		C_s_in => '0',
		S_out => UP,
		C_s_out => open
	);


	PROCESS(Clk)
		BEGIN
			IF Clk'EVENT and Clk = '1' THEN
				IF D = '1' THEN 
					D <= '0';
				END IF;
				
				IF Reset = '0' THEN
					REG <= "000000";
					STATE <= '1';
				ELSIF Start = '1' THEN STATE <= '1';
				ELSIF Pause = '1' THEN STATE <= '0';
				ELSIF Stop = '1' THEN
					REG <= "000000";
					STATE <= '0';
				ELSIF REG = "111100" THEN 
					REG <= "000000";
					D <= '1';
				ELSIF State = '1' THEN 	REG <= UP;
				END IF; 
				
				Done <= D;
				Seconds <= REG;
					
				
			END IF;
		END PROCESS;

end Behavioral;

