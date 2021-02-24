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
  signal a_sim, b_sim : std_logic_vector (3 DOWNTO 0);  --make 2 4 bit simulated signals for a and b sim
  signal func_bit_sim : std_logic_vector(2 downto 0);   --make a simulated function bit to choose operation
  signal y_sim : std_logic_vector(3 DOWNTO 0);        --make a simulated signal to be the output of operations

  signal alu_test : std_logic_vector(3 downto 0);  --keeps track of what the alu's output is supposed to be 


  -- TODO define other signals your group may need
  signal tester : std_logic_vector(10 downto 0) := "00000000000";    --make a 11 bit signal 
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
    uut : entity work.alu generic map( N => 4 )
    -- todo port map for your alu 
    port map(  a => a_sim, b => b_sim, f => func_bit_sim, y => y_sim );
  stim_proc: process
      -- TODO any signals or variables you need
      variable i: integer range 0 to 2047;  --test all the possible combinatiosn of tester, amount of times for lop is run
   begin		
      -- TODO make a for loop to test operations
        for i in 0 to 2047 loop
          tester <= std_logic_vector(to_unsigned(i, 11)); --used to test all possibe combinations
          func_bit_sim <= tester(2 downto 0);
          -- Connect bits 7,8,9,10 of tester to a_sim
          a_sim <= tester(10 downto 7);   --break
          -- Connect bits 3,4,5,6 of tester to b_sim
          b_sim <= tester(6 downto 3);
          wait for 10 ns;
          
          --determine what kind of operation we are supposd to be diooin
          case func_bit_sim(2 downto 0) is  
            when "000" => alu_test <= a_sim and b_sim;
            when "001" => alu_test <= a_sim or b_sim;
            when "010" => alu_test <= a_sim nor b_sim;
            when "011" => alu_test <= a_sim nand b_sim;
            when "100" => alu_test <= a_sim xor b_sim;
            when "101" => alu_test <= a_sim xnor b_sim;
            when "110" => alu_test <= not a_sim;
            when "111" => alu_test <= not b_sim;
            when others => alu_test <= (others => 'X');
          end case;
          
        --Check if y_sim is equal to the values that we want
        --If they are not equal, we report the values of a, b, f, and y that are invalid
        if (alu_test /= y_sim) then
          report "a: " & to_string(a_sim) & " b: " & to_string(b_sim);
          report "f: " & to_string(func_bit_sim);
          report "y: " & to_string(y_sim);
        end if;

      end loop;
   end process;
END behavioral;