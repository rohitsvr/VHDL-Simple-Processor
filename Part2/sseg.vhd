LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg IS
    PORT (
        neg  : IN  STD_LOGIC;
		  bcd   : IN  STD_LOGIC_VECTOR(3 DOWNTO 0);
        ResultLED  : OUT STD_LOGIC_VECTOR(0 TO 6); -- a b c d e f g, active-low
        NegativeLED : OUT STD_LOGIC_VECTOR(0 TO 6)
    );
END sseg;

ARCHITECTURE Behavior OF sseg IS
BEGIN
    PROCESS (bcd, neg)
    BEGIN
        CASE bcd IS
            WHEN "0000" => ResultLED <= "0000001"; -- 0
            WHEN "0001" => ResultLED <= "1001111"; -- 1
            WHEN "0010" => ResultLED <= "0010010"; -- 2
            WHEN "0011" => ResultLED <= "0000110"; -- 3
            WHEN "0100" => ResultLED <= "1001100"; -- 4
            WHEN "0101" => ResultLED <= "0100100"; -- 5
            WHEN "0110" => ResultLED <= "0100000"; -- 6
            WHEN "0111" => ResultLED <= "0001111"; -- 7
            WHEN "1000" => ResultLED <= "0000000"; -- 8
            WHEN "1001" => ResultLED <= "0000100"; -- 9
            WHEN "1010" => ResultLED <= "0001000"; -- A
            WHEN "1011" => ResultLED <= "1100000"; -- B
            WHEN "1100" => ResultLED <= "0110001"; -- C
            WHEN "1101" => ResultLED <= "1000010"; -- D
            WHEN "1110" => ResultLED <= "0110000"; -- E
            WHEN "1111" => ResultLED <= "0111000"; -- F
            WHEN OTHERS => ResultLED <= "1111111"; -- all off
        END CASE;

        IF neg = '1' THEN
            NegativeLED <= "1111110";  -- minus sign (g on)
        ELSE
            NegativeLED <= "1111111";  -- blank
        END IF;
    END PROCESS;
END Behavior;
