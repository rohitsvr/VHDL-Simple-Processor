LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU1 IS
    PORT (
        clock    : IN  std_logic;
        reset  : IN  std_logic;              -- active-low reset
        A, B   : IN  unsigned(7 downto 0);   -- 8-bit inputs
        opcode : IN  unsigned(15 downto 0);  -- 16-bit opcode from decoder
        neg    : OUT std_logic;              -- negative flag
        R1, R2 : OUT unsigned(3 downto 0)    -- 4-bit outputs for 7-seg
    );
END ALU1;

ARCHITECTURE calculation OF ALU1 IS

    SIGNAL Reg1, Reg2, Result : unsigned(7 downto 0) := (others => '0');

BEGIN

    -----------------------------------------------------------------------
    -- Store inputs in temporary registers
    -----------------------------------------------------------------------
    Reg1 <= A;   
    Reg2 <= B;

    PROCESS(clock, reset)
    BEGIN
        -------------------------------------------------------------------
        -- Active-low Reset
        -------------------------------------------------------------------
        IF reset = '0' THEN
            Result <= (others => '0');
            neg    <= '0';

        ELSIF rising_edge(clock) THEN

            CASE opcode IS

                ----------------------------------------------------------------
                -- 1. ADD : sum(A, B)
                ----------------------------------------------------------------
                WHEN "0000000000000001" =>
                    neg    <= '0';
                    Result <= Reg1 + Reg2;

                ----------------------------------------------------------------
                -- 2. SUB : diff(A, B) with neg flag
                ----------------------------------------------------------------
                WHEN "0000000000000010" =>
                    IF Reg1 >= Reg2 THEN
                        neg    <= '0';
                        Result <= Reg1 - Reg2;
                    ELSE
                        neg    <= '1';
                        Result <= Reg2 - Reg1;
                    END IF;

                ----------------------------------------------------------------
                -- 3. INVERSE : NOT(A)
                ----------------------------------------------------------------
                WHEN "0000000000000100" =>
                    neg    <= '0';
                    Result <= NOT Reg1;

                ----------------------------------------------------------------
                -- 4. NAND : NOT(A AND B)
                ----------------------------------------------------------------
                WHEN "0000000000001000" =>
                    neg    <= '0';
                    Result <= NOT (Reg1 AND Reg2);

                ----------------------------------------------------------------
                -- 5. NOR : NOT(A OR B)
                ----------------------------------------------------------------
                WHEN "0000000000010000" =>
                    neg    <= '0';
                    Result <= NOT (Reg1 OR Reg2);

                ----------------------------------------------------------------
                -- 6. AND : A AND B
                ----------------------------------------------------------------
                WHEN "0000000000100000" =>
                    neg    <= '0';
                    Result <= Reg1 AND Reg2;

                ----------------------------------------------------------------
                -- 7. XOR : A XOR B
                ----------------------------------------------------------------
                WHEN "0000000001000000" =>
                    neg    <= '0';
                    Result <= Reg1 XOR Reg2;

                ----------------------------------------------------------------
                -- 8. OR : A OR B
                ----------------------------------------------------------------
                WHEN "0000000010000000" =>
                    neg    <= '0';
                    Result <= Reg1 OR Reg2;

                ----------------------------------------------------------------
                -- 9. XNOR : NOT(A XOR B)
                ----------------------------------------------------------------
                WHEN "0000000100000000" =>
                    neg    <= '0';
                    Result <= NOT (Reg1 XOR Reg2);

                ----------------------------------------------------------------
                -- DEFAULT CASE: No Operation
                ----------------------------------------------------------------
                WHEN OTHERS =>
                    Result <= Result;

            END CASE;

        END IF;
    END PROCESS;

    -----------------------------------------------------------------------
    -- Split the 8-bit result into two 4-bit outputs for 7 segment display
    -----------------------------------------------------------------------
    R1 <= Result(3 DOWNTO 0);      -- lower 4 bits
    R2 <= Result(7 DOWNTO 4);      -- upper 4 bits

END calculation;
