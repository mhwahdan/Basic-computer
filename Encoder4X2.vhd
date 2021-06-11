library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Encoder4X2 is
 port(
 i : in STD_LOGIC_VECTOR(3 downto 0);
 o : out STD_LOGIC_VECTOR(1 downto 0));
end Encoder4X2;

architecture behavior of Encoder4X2 is
begin
o<= "00" when i="0001" else
				  "01" when i="0010" else
				  "10" when i="0100" else
				  "11" when i="1000" else
				  "ZZ";
end behavior;
