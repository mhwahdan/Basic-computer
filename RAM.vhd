    
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RAM is
    Port ( address : in  STD_LOGIC_VECTOR (5 downto 0);
			  datain : in STD_LOGIC_VECTOR (7 downto 0); 
           dataout : out  STD_LOGIC_VECTOR (7 downto 0);
           R : in  STD_LOGIC;
			  W : in STD_LOGIC);
end RAM;


architecture Behavioral of RAM is
type memory is array(0 to 7) of std_logic_vector (7 downto 0); --64X8 memory
signal Rsignal : memory := (		
0  => "00000110" , 
1  => "11000001" ,                   
2  => "01000111" ,                     
3  => "11000001" ,
4  => "11001010" ,          
5  => "10000010" , 
6  => "00000000" , 		 
7  => "00000010");
begin
dataout <= Rsignal(conv_integer(unsigned(address))) when R = '1' else (others => 'Z');
Rsignal(conv_integer(unsigned(address))) <= datain when W = '1';
end Behavioral;






