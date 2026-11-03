LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY sseg3 IS
    PORT (
        bcd_code : IN  std_logic_vector(3 DOWNTO 0);   -- from ALU3: 0000='n', 1111='y'
        segments : OUT std_logic_vector(0 TO 6)        -- a b c d e f g, active-low
    );
END sseg3;

ARCHITECTURE Behavior OF sseg3 IS

BEGIN
    PROCESS(bcd_code)
    BEGIN
        IF bcd_code = "0000" THEN
				segments <= "1001000";   -- show 'n'
        ELSIF bcd_code = "1111" THEN
            segments <= "1000100";   -- show 'y'
        ELSE
            segments <= "1111111";   -- blank
        END IF;
    END PROCESS;

END Behavior;
