library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE WORK.week12.ALL;

entity main is
	PORT (
		START : IN STD_LOGIC;
		CLK: IN STD_LOGIC;
		DR_WIRE,
		AC_WIRE:inout STD_LOGIC_VECTOR(7 DOWNTO 0);
		IR_WIRE:inout STD_LOGIC_VECTOR(7 DOWNTO 0);
		RAM_WIRE: inout STD_LOGIC_VECTOR(7 DOWNTO 0);
	   AR_WIRE:inout STD_LOGIC_VECTOR(7 DOWNTO 0);
		PC_WIRE: inout STD_LOGIC_VECTOR(7 DOWNTO 0);
		Tsignal : inout STD_LOGIC_VECTOR(2 DOWNTO 0));
end main;

architecture Behavioral of main is
	-- creating control signals
	SIGNAL BUSin: STD_LOGIC_VECTOR(7 DOWNTO 0); --sending register selection control signal
	SIGNAL Rload: STD_LOGIC_VECTOR(4 DOWNTO 0); --receiving register selection control signal 
	SIGNAL ACINC: STD_LOGIC; -- Accumillator increment control signal
	SIGNAL PCINC: STD_LOGIC; -- Program counter control signal 
	SIGNAL CONTROL2ALU: STD_LOGIC_VECTOR (3 DOWNTO 0); -- ALU operation selection control signal
	SIGNAL ALUout : STD_LOGIC_VECTOR (7 DOWNTO 0); -- ALU output signal
	SIGNAL SCsignal : STD_LOGIC; -- sequence counter clear when instruction excution is finished control signal
	SIGNAL BUSencoder : STD_LOGIC_VECTOR(7 DOWNTO 0); --INPUTS TO ENCODER OF BUS SYSTEM
	SIGNAL ENC2BUS : STD_LOGIC_VECTOR(2 DOWNTO 0); --OUTPUTS OF ENCODER OF BUS SYSTEM
	SIGNAL Csignal : STD_LOGIC; -- sequence counter clear control signal
begin
		
	-- Creating registers
	AR : REG GENERIC MAP (8) PORT MAP(BUSin, CLK, Rload(0), '0', '0', '0', AR_WIRE); --Address register
	PC : REG GENERIC MAP (8) PORT MAP(BUSin, CLK, Rload(1), PCINC, '0', START, PC_WIRE); --program Csignal
	DR : REG GENERIC MAP (8) PORT MAP(BUSin, CLK, Rload(2), '0', '0', '0', DR_WIRE); -- data register
	AC : REG GENERIC MAP (8) PORT MAP(ALUout, CLK, Rload(3), ACINC, '0', '0', AC_WIRE); --accumilator
	IR : REG GENERIC MAP (8) PORT MAP(BUSin, CLK, Rload(4), '0', '0', '0', IR_WIRE); --input register
	M  : RAM PORT MAP(AR_WIRE(5 downto 0), BUSin, RAM_WIRE, BUSencoder(6), '0'); --RAM memory

	-- Creating ALU
	ALU0 : ALU PORT MAP (CONTROL2ALU, DR_WIRE, AC_WIRE, ALUout);
	
	-- Creating Control unit (Note : the sequence counter is built inside the control unit itself + register load selection)
	CU : CONTROL_UNIT PORT MAP (IR_WIRE(7 DOWNTO 6), Tsignal, Rload, PCINC, ACINC, SCsignal, CONTROL2ALU, BUSencoder, IR_WIRE(1 DOWNTO 0));

	-- Creating T counter
	Csignal <= SCsignal OR START;
	TCsignal : Counter PORT MAP(Csignal, CLK, '1', Tsignal);
  
	-- Creating common bus system 
	BUS_ENCODER : ENCODER8X3 PORT MAP (BUSencoder, ENC2BUS);
	COMMON_BUS : MUX8X1 PORT MAP ("ZZZZZZZZ", AR_WIRE,PC_WIRE,DR_WIRE,AC_WIRE,IR_WIRE, RAM_WIRE, "ZZZZZZZZ", ENC2BUS, BUSin);


end Behavioral; 
