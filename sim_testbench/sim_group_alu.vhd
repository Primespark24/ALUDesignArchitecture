--------------------------------------------------------------------------------
--  Module Name:  sim_group_alu 
--      Purpose:  Example of a programmed test bench 
-- Project Name:  Test all inputs for the 4 bit alu (has two 4 bit input)
--------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;        -- use this instead of STD_LOGIC_ARITH
 
ENTITY sim_group_alu IS
END sim_group_alu;
 
ARCHITECTURE behavioral OF sim_group_alu IS 
  -- These signals are use to wire the alu to the board level signals
  -- input signals
  -- TODO Define input signals
  -- output signals
  -- TODO Define output signals

  -- TODO define other signals your group may need

 

  ----------------------------------------------------------------------------------------
  -- Function to_string for testbench
  -- convert a STD Logic vector to a string so we can report it in the testbench console
  -- output.
  -- source: https://stackoverflow.com/questions/15406887/vhdl-convert-vector-to-string
  -----------------------------------------------------------------------------------------
  function to_string ( a: std_logic_vector) return string is
    variable b : string (1 to a'length) := (others => NUL);
    variable stri : integer := 1; 
    begin
        for i in a'range loop
            b(stri) := std_logic'image(a((i)))(2);
        stri := stri+1;
        end loop;
    return b;
  end function;

BEGIN
    uut : entity work.alu generic map( N => 32 )
    -- todo port map for your alu
 
  stim_proc: process
      -- TODO any signals or variables you need
   begin		
      -- TODO make a for loop to test operations
      --for i in 0 to ??? loop


      --end loop;
   end process;
END behavioral;