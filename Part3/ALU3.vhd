LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU3 IS
    PORT (
        clock      : IN  std_logic;
        reset      : IN  std_logic;                    -- active-low reset
        A, B       : IN  unsigned(7 downto 0);         -- 8-bit inputs
        opcode     : IN  unsigned(15 downto 0);        -- 16-bit opcode from decoder
        student_id : IN  std_logic_vector(3 downto 0); -- FSM output
        Result     : OUT std_logic_vector(3 downto 0); -- 1111 = 'y', 0000 = 'n'
        neg        : OUT std_logic                     -- not used
    );
END ALU3;

ARCHITECTURE calculation OF ALU3 IS

	 -- 1 = student_id has odd number of "1" bits
    SIGNAL odd_parity : std_logic;

BEGIN
    -----------------------------------------------------------------------------------------------------------------------
    -- 3. C) For each microcode instruction, display 'y' if the FSM output (student_id) had an odd parity and 'n' otherwise
    -----------------------------------------------------------------------------------------------------------------------
    odd_parity <= student_id(3) xor student_id(2) xor student_id(1) xor student_id(0);

    -------------------------------------------------------------------
    -- Output 'y' (1111) for odd parity or 'n' (0000)
    -------------------------------------------------------------------
    PROCESS(clock, reset)
    BEGIN
        IF reset = '0' THEN              -- default = 'n'
            Result <= "0000";
        ELSE 									  --rising_edge(clock) THEN
            IF odd_parity = '1' THEN
                Result <= "1111";        -- means "y"
            ELSE
                Result <= "0000";        -- means "n"
            END IF;
        END IF;
    END PROCESS;

END calculation;
