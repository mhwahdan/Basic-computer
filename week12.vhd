library IEEE;
use IEEE.STD_LOGIC_1164.all;


package week12 is
 

component REG is
		GENERIC(n:NATURAL);
			port (I: IN  STD_LOGIC_VECTOR (n-1 DOWNTO 0);
					CLK: IN STD_LOGIC;
					LOAD: IN STD_LOGIC;
					INC: IN STD_LOGIC;
					dec: IN STD_LOGIC;
					CLR: IN STD_LOGIC;
					DATA: out  STD_LOGIC_VECTOR (n-1 DOWNTO 0));
end component;
	 


component MUX4X1 is
	port (i0: in std_logic_vector(7 downto 0);
         i1: in std_logic_vector(7 downto 0);
         i2: in std_logic_vector(7 downto 0);
         i3: in std_logic_vector(7 downto 0);
         S : in std_logic_vector (1 downto 0);
         o : out std_logic_vector(7 downto 0));
end component;
						  						  

						  
component MUX8X1 is 
	port (i0: in std_logic_vector(7 downto 0);
         i1: in std_logic_vector(7 downto 0);
         i2: in std_logic_vector(7 downto 0);
         i3: in std_logic_vector(7 downto 0);										
			i4: in std_logic_vector(7 downto 0);
			i5: in std_logic_vector(7 downto 0);
			i6: in std_logic_vector(7 downto 0);
			i7: in std_logic_vector(7 downto 0);										 
         S : in std_logic_vector (2 downto 0);
         o : out std_logic_vector(7 downto 0));
end component ;					  


component DEC2X4 is
	port(i : in std_logic_vector(1 downto 0);
        o : out std_logic_vector(3 downto 0);
        en: in std_logic);                    
end component;



component DEC3X8 is

	port(i : in std_logic_vector(2 downto 0);
		  o : out std_logic_vector(7 downto 0);
		  en: in std_logic);
end component;



component Encoder4X2 is
	 port(i : in STD_LOGIC_VECTOR(3 downto 0);
			o : out STD_LOGIC_VECTOR(1 downto 0));
end component;

		
		
component Encoder8x3 is
	port (i : in std_logic_vector (7 downto 0);
			o : out std_logic_vector (2 downto 0));
end component ;




component RAM is
    Port ( address : in  STD_LOGIC_VECTOR (5 downto 0);
			  datain : in STD_LOGIC_VECTOR (7 downto 0); 
           dataout : out  STD_LOGIC_VECTOR (7 downto 0);
           R : in  STD_LOGIC;
			  W : in STD_LOGIC);
end component;

		  
component Counter is
    Port (rst : in std_logic;
			 clk : in std_logic;
			 en : in std_logic;
          o: out std_logic_vector(0 to 2));
end component;


COMPONENT Control_Unit is
	port(Dsignal : in std_logic_vector(1 downto 0);
		  Tsignal : in std_logic_vector(2 downto 0);
		  Load : out std_logic_vector(4 downto 0);
		  PCINC: out std_logic;
		  ACINC: out std_logic;
		  SC_CLR: out std_logic;
		  ALUoperation: Out std_logic_vector(3 downto 0);
		  BUSselection: out std_logic_vector(7 downto 0);
		  IR: IN STD_LOGIC_VECTOR(1 DOWNTO 0)	
	);
end COMPONENT;


				
COMPONENT ALU is
port(Operation : in STD_LOGIC_VECTOR(3 downto 0);
	  I1 : in STD_LOGIC_VECTOR(7 downto 0);
	  I2 : in STD_LOGIC_VECTOR(7 downto 0);
	  OUTPUT : out STD_LOGIC_VECTOR(7 downto 0)
);
END COMPONENT;

end week12;

