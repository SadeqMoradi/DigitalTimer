--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:33:57 11/08/2024
-- Design Name:   
-- Module Name:   C:/Documents and Settings/Digital_Timer/TB2.vhd
-- Project Name:  Digital_Timer
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: TopModule
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
 
ENTITY TB2 IS
END TB2;
 
ARCHITECTURE behavior OF TB2 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TopModule
    PORT(
         Clk : IN  std_logic;
         Pause_M : IN  std_logic;
         Pause_S : IN  std_logic;
         Start_M : IN  std_logic;
         Start_S : IN  std_logic;
         Stop_M : IN  std_logic;
         Stop_S : IN  std_logic;
         Reset_M : IN  std_logic;
         Reset_S : IN  std_logic;
         D_M : OUT  std_logic;
         M : OUT  std_logic_vector(5 downto 0);
         S : OUT  std_logic_vector(5 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clk : std_logic := '0';
   signal Pause_M : std_logic := '0';
   signal Pause_S : std_logic := '0';
   signal Start_M : std_logic := '0';
   signal Start_S : std_logic := '0';
   signal Stop_M : std_logic := '0';
   signal Stop_S : std_logic := '0';
   signal Reset_M : std_logic := '1';
   signal Reset_S : std_logic := '1';

 	--Outputs
   signal D_M : std_logic;
   signal M : std_logic_vector(5 downto 0);
   signal S : std_logic_vector(5 downto 0);

   -- Clock period definitions
   constant Clk_period : time := 1000 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TopModule PORT MAP (
          Clk => Clk,
          Pause_M => Pause_M,
          Pause_S => Pause_S,
          Start_M => Start_M,
          Start_S => Start_S,
          Stop_M => Stop_M,
          Stop_S => Stop_S,
          Reset_M => Reset_M,
          Reset_S => Reset_S,
          D_M => D_M,
          M => M,
          S => S
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

      -- insert stimulus here 
		Reset_M <= '0';
		Reset_S <= '0';
		
		wait for Clk_period;
		
		Reset_M <= '1';
		Reset_S <= '1';
      wait;
   end process;

END;
