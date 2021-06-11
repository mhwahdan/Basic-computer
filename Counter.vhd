library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity Counter is
    Port ( rst : in std_logic;
			  clk : in std_logic;
			  en : in std_logic;
           o: out std_logic_vector(0 to 2));
end Counter;

architecture Behavior of Counter is
  signal Csignal : std_logic_vector(0 to 2);
    begin
      process(rst,clk,en)
        begin
         if (rst = '1') then
				Csignal <= "000";
         elsif (clk'event and clk = '1' and en='1' ) then
				Csignal <= Csignal + 1;
         end if;
      end process;
  o <= Csignal;
end Behavior;                          
		