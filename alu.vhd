-------------------------------------------------
-- Module Name: alu - group designed
-------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;   

--Defines our alu entity with a generic value of 32 bits used for inputs a and b
--3 bit function vector corresponds to 8 different operations for our alu
--Output y shares the same number of bits as the inputs a and b
entity alu is
    generic ( N : integer := 32 );
    port ( a, b : in STD_LOGIC_VECTOR(N-1 downto 0);
      f : in STD_LOGIC_VECTOR(2 downto 0);
      Y : out STD_LOGIC_VECTOR(N-1 downto 0));
end alu;

--Behavioral architecture defining implementation of our ALU
architecture Behavioral of alu is
begin 
  --Process runs with our two inputs, the function vector, and the output
    process (a, b, f)
    begin
      case f(2 downto 0) is 
        when "000" => Y <= a and b;
        when "001" => Y <= a or b;
        when "010" => Y <= a nor b;
        when "011" => Y <= a nand b;
        when "100" => Y <= a xor b;
        when "101" => Y <= a xnor b;
        when "110" => Y <= not a;
        when "111" => Y <= not b;
        when others => Y <= (others => 'X');
      end case;
    end process;
end Behavioral;