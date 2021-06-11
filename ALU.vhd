library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.week12.All;
use IEEE.STD_LOGIC_UNSIGNED.ALL ;



entity ALU is
port(
	Operation : in STD_LOGIC_VECTOR(3 downto 0);
	I1 : in STD_LOGIC_VECTOR(7 downto 0); -- OPERAND 1 = AC
	I2 : in STD_LOGIC_VECTOR(7 downto 0); -- I2 OPERAND 2 = DR
	OUTPUT : out STD_LOGIC_VECTOR(7 downto 0) -- RESULT WHICH GOES TO ACCUMILATOR
);


end ALU;

architecture Behavioral of ALU is
signal ENC_operation :STD_LOGIC_VECTOR(1 downto 0); --ENCODED OPERATION

begin
    
	 Encoder: Encoder4X2 port map(Operation,ENC_operation); -- ENCODING THE OPERATION
	 
	 OUTPUT <=  "ZZZZZZZZ" WHEN ENC_operation = "00" ELSE
				    I2 and I1 WHEN ENC_operation = "01" ELSE
					 I2 + I1 WHEN ENC_operation = "10" ELSE
					 NOT I2 WHEN ENC_operation = "11" ELSE
					 "XXXXXXXX"; -- SELECTING THE OUTPUT VALUE ACCORDING TO THE OPERATION
					 
end Behavioral;
