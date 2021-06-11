library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.week12.All;


entity Control_Unit is
	port( Dsignal : in std_logic_vector(1 downto 0);
			Tsignal : in std_logic_vector(2 downto 0);
			Load : out std_logic_vector(4 downto 0);
			PCINC: out std_logic;
			ACINC: out std_logic;
			SC_CLR: out std_logic;
			ALUoperation: Out std_logic_vector(3 downto 0);
			BUSselection: out std_logic_vector(7 downto 0);
			IR: IN STD_LOGIC_VECTOR(1 DOWNTO 0)	
	);
end Control_Unit;

architecture Behavioral of Control_Unit is
signal D_decoded : std_logic_vector(3 downto 0);
signal T_decoded : std_logic_vector(7 downto 0);

begin

	-- DECODERS FOR T and D Signals
	T_dec : Dec3x8 port map (Tsignal, T_decoded, '1');	
	D_dec : Dec2x4 port map (Dsignal, D_decoded, '1');
	
	--Select receving register
	LOAD <= "00001" WHEN (T_decoded(0) OR T_decoded(2)) = '1' ELSE
			  "00010" WHEN (T_decoded(3) AND D_decoded(2)) = '1' ELSE 
			  "00100" WHEN (D_decoded(0) AND T_decoded(3)) = '1' OR (D_decoded(1) AND T_decoded(3)) = '1' ELSE
			  "01000" WHEN (D_decoded(0) AND T_decoded(4)) = '1' OR (D_decoded(1) AND T_decoded(4)) = '1' OR (D_decoded(3) AND T_decoded(3) AND IR(1)) = '1' ELSE
			  "10000" WHEN T_decoded(1) = '1' ELSE
			  "ZZZZZ";
			  
	--select sender register
	BUSselection <= "00000010" WHEN (D_decoded(2) AND T_decoded(3)) = '1' ELSE  -- Address register
						 "00000100" WHEN T_decoded(0) = '1' ELSE -- Program counter
						 "00100000" WHEN T_decoded(2) = '1' ELSE -- Input register
						 "01000000" WHEN T_decoded(1) = '1' or (D_decoded(0) and T_decoded(3)) = '1' or (D_decoded(1) and T_decoded(3)) = '1' ELSE -- RAM
						 "00000000"; --High impedance meaning null data
	
	--Select ALU operation
	ALUoperation <= "0010" WHEN (D_decoded(0) AND T_decoded(4)) = '1' ELSE --AND operation
						 "0100" WHEN (D_decoded(1) AND T_decoded(4)) = '1' ELSE -- ADD operation
						 "1000" WHEN (D_decoded(3) AND T_decoded(3) AND IR(1)) = '1' ELSE -- Increment Accumilator
						 "0000"; -- Return Accumilator

	-- OTHER control signals
	SC_CLR <= (D_decoded(3) AND T_decoded(4)) OR  (D_decoded(2) AND T_decoded(4)) OR (D_decoded(1) AND T_decoded(5)) OR (D_decoded(0) AND T_decoded(5)) ; -- Sequence counter clear condition
	ACINC <= D_decoded(3) AND T_decoded(3) AND IR(0); -- Accumilator increment condition
	PCINC <= T_decoded(1);	-- Program counter increment condition
	
	
end Behavioral;

