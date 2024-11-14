--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   02:30:30 11/08/2024
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Digital_Timer/TB_Seconds.vhd
-- Project Name:  Digital_Timer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Seconds
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY TB_Seconds IS
END TB_Seconds;
 
ARCHITECTURE behavior OF TB_Seconds IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Second
    PORT(
         Clk : IN  std_logic;
         Reset : IN  std_logic;
         Start : IN  std_logic;
         Pause : IN  std_logic;
         Stop : IN  std_logic;
         Seconds : OUT  std_logic_vector(5 downto 0);
         Done : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Reset : std_logic := '1';
   signal Start : std_logic := '0';
   signal Pause : std_logic := '0';
   signal Stop : std_logic := '0';

 	--Outputs
   signal Seconds : std_logic_vector(5 downto 0);
   signal Done : std_logic;

   -- Clock period definitions
   constant Clk_period : time := 1000 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Second PORT MAP (
          Clk => Clk,
          Reset => Reset,
          Start => Start,
          Pause => Pause,
          Stop => Stop,
          Seconds => Seconds,
          Done => Done
        );

   -- Clock process definitions
   Clk_process :process
   begin
		Clk <= '0';
		wait for Clk_period/2;
		Clk <= '1';
		wait for Clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for Clk_period*10;
		
		Reset <= '0';
		
		wait for Clk_period;
		
		Reset <= '1';
		
		
		Start <= '1';
		
		wait for Clk_period;
		
		Start <= '0';
		
		wait for 67*Clk_period;
		
		Stop <= '1';
		
		wait for Clk_period;
		
		Stop <= '0';

		wait for 10*Clk_period;
		
		Start <= '1';
		
		wait for Clk_period;
		
		Start <= '0';

		wait for 10*Clk_period;
		
		Pause <= '1';
		
		wait for Clk_period;
		
		Pause <= '0';
		
		wait for 10*Clk_period;
		
		Reset <= '0';
		
		wait for Clk_period;
		
		Reset <= '1';
		
      -- insert stimulus here 

      wait;
   end process;

END;
