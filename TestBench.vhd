LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

ENTITY TEST IS
END TEST;
 
ARCHITECTURE behavior OF TEST IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT main
    PORT(
         START : IN  std_logic;
         CLK : IN  std_logic;
         DR_WIRE : INOUT  std_logic_vector(7 downto 0);
         AC_WIRE : INOUT  std_logic_vector(7 downto 0);
         IR_WIRE : INOUT  std_logic_vector(7 downto 0);
         RAM_WIRE : INOUT  std_logic_vector(7 downto 0);
         AR_WIRE : INOUT  std_logic_vector(7 downto 0);
         PC_WIRE : INOUT  std_logic_vector(7 downto 0);
         Tsignal : INOUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal START : std_logic := '0';
   signal CLK : std_logic := '0';

	--BiDirs
   signal DR_WIRE : std_logic_vector(7 downto 0);
   signal AC_WIRE : std_logic_vector(7 downto 0);
   signal IR_WIRE : std_logic_vector(7 downto 0);
   signal RAM_WIRE : std_logic_vector(7 downto 0);
   signal AR_WIRE : std_logic_vector(7 downto 0);
   signal PC_WIRE : std_logic_vector(7 downto 0);
   signal Tsignal : std_logic_vector(2 downto 0);

   -- Clock period definitions
   constant CLK_period : time := 1 us;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: main PORT MAP (
          START => START,
          CLK => CLK,
          DR_WIRE => DR_WIRE,
          AC_WIRE => AC_WIRE,
          IR_WIRE => IR_WIRE,
          RAM_WIRE => RAM_WIRE,
          AR_WIRE => AR_WIRE,
          PC_WIRE => PC_WIRE,
          Tsignal => Tsignal
        );

   -- Clock process definitions
   CLK_process :process
   begin
		CLK <= '0';
		wait for CLK_period/2;
		CLK <= '1';
		wait for CLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      
		
		START<='1';
		wait for CLK_period;
		START<='0';
		

      wait;
   end process;

END;
