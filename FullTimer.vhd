----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:33:05 11/08/2024 
-- Design Name: 
-- Module Name:    FullTimer - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity FullTimer is
    Port ( Clk : in  STD_LOGIC;
           Start_M : in  STD_LOGIC;
           Stop_M : in  STD_LOGIC;
           Start_S : in  STD_LOGIC;
           Stop_S : in  STD_LOGIC;
           Pause_M : in  STD_LOGIC;
           Pause_S : in  STD_LOGIC;
           Reset_M : in  STD_LOGIC;
           Reset_S : in  STD_LOGIC;
           Done_M : out  STD_LOGIC;
           Done_S : out  STD_LOGIC;
           Min : out  STD_LOGIC_VECTOR (5 downto 0);
           Sec : out  STD_LOGIC_VECTOR (5 downto 0));
end FullTimer;

architecture Behavioral of FullTimer is

	SIGNAL STATE_S : STD_LOGIC :='0';
	SIGNAL D_S : STD_LOGIC :='0';
	SIGNAL D_S_T : STD_LOGIC :='0';
	SIGNAL REG_S : STD_LOGIC_VECTOR (5 downto 0):="000000";
	SIGNAL UP_S : STD_LOGIC_VECTOR (5 downto 0):="000000";
	
	COMPONENT SUM_module
	PORT(
		A_s : IN std_logic_vector(5 downto 0);
		B_s : IN std_logic_vector(5 downto 0);
		C_s_in : IN std_logic;          
		S_out : OUT std_logic_vector(5 downto 0);
		C_s_out : OUT std_logic
		);
	END COMPONENT;
	
	SIGNAL STATE_M : STD_LOGIC :='0';
	SIGNAL D_M : STD_LOGIC :='0';
	SIGNAL REG_M : STD_LOGIC_VECTOR (5 downto 0):="000000";
	SIGNAL UP_M : STD_LOGIC_VECTOR (5 downto 0):="000000";


begin

	Inst_SUM_module_S: SUM_module PORT MAP(
		A_s => REG_S,
		B_s => "000001",
		C_s_in => '0',
		S_out => UP_S,
		C_s_out => open
	);
	
	Inst_SUM_module_M: SUM_module PORT MAP(
		A_s => REG_M,
		B_s => "000001",
		C_s_in => '0',
		S_out => UP_M,
		C_s_out => open
	);

	PROCESS(Clk)
		BEGIN
			IF Clk'EVENT and Clk = '1' THEN
				IF D_S = '1' THEN 
					D_S <= '0';
				END IF;
				
				IF D_S_T = '1' THEN 
					D_S_T <= '0';
				ELSIF REG_S = "111011" THEN D_S_T <= '1';
				END IF;			
				
				IF Reset_S = '0' THEN
					REG_S <= "000000";
					STATE_S <= '1';
				ELSIF Start_S = '1' THEN STATE_S <= '1';
				ELSIF Pause_S = '1' THEN STATE_S <= '0';
				ELSIF Stop_S = '1' THEN
					REG_S <= "000000";
					STATE_S <= '0';
				ELSIF REG_S = "111100" THEN 
					REG_S <= "000000";
					D_S <= '1';
				ELSIF State_S = '1' THEN 	REG_S <= UP_S;
				END IF; 
				
				Done_S <= D_S;
				Sec <= REG_S;
					
				
			END IF;
		END PROCESS;
		
	PROCESS(Clk)
		BEGIN
			IF Clk'EVENT and Clk = '1' THEN
				IF D_M = '1' THEN 
					D_M <= '0';
				END IF;
				
				IF Reset_M = '0' THEN
					REG_M <= "000000";
					STATE_M <= '1';
				ELSIF Start_M = '1' THEN STATE_M <= '1';
				ELSIF Pause_M = '1' THEN STATE_M <= '0';
				ELSIF Stop_M = '1' THEN
					REG_M <= "000000";
					STATE_M <= '0';
				ELSIF REG_M = "111100" THEN 
					REG_M <= "000000";
					D_M <= '1';
				ELSIF State_M = '1' and D_S_T = '1' THEN 	REG_M <= UP_M;
				END IF; 
				
				Done_M <= D_M;
				Min <= REG_M;
					
				
			END IF;
		END PROCESS;


end Behavioral;

