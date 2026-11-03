LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

ENTITY ALU2 IS   
    PORT (
        clock  : IN  std_logic;
        reset  : IN  std_logic;              -- active-low reset
        A, B   : IN  unsigned(7 downto 0);   -- 8-bit inputs
        opcode : IN  unsigned(15 downto 0);  -- 16-bit opcode from decoder
        neg    : OUT std_logic;              -- negative flag 
        R1, R2 : OUT unsigned(3 downto 0)    -- 4-bit outputs for 7-seg
    );
END ALU2;

ARCHITECTURE calculation OF ALU2 IS

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
                -- 1. Produce the difference between A and B
                --    (set neg = '1' if result is "negative" i.e. B > A)
                ----------------------------------------------------------------
                WHEN "0000000000000001" =>
                    IF Reg1 >= Reg2 THEN
                        neg    <= '0';
                        Result <= Reg1 - Reg2;     -- A - B
                    ELSE
                        neg    <= '1';
                        Result <= Reg2 - Reg1;     -- |A - B|
                    END IF;

                ----------------------------------------------------------------
                -- 2. Produce the 2's complement of B
                ----------------------------------------------------------------
                WHEN "0000000000000010" =>
                    neg    <= '0';
                    Result <= (NOT Reg2) + 1;

                ----------------------------------------------------------------
                -- 3. Swap the lower 4 bits of A with lower 4 bits of B
                --    Output = A with its low bits replaced by B's low bits
                --    [A7..A4][B3..B0]
                ----------------------------------------------------------------
                WHEN "0000000000000100" =>
                    neg    <= '0';
                    Result <= Reg1(7 downto 4) & Reg2(3 downto 0);

                ----------------------------------------------------------------
                -- 4. Produce null on the output (all zeros)
                ----------------------------------------------------------------
                WHEN "0000000000001000" =>
                    neg    <= '0';
                    Result <= (others => '0');

                ----------------------------------------------------------------
                -- 5. Decrement B by 5
                ----------------------------------------------------------------
                WHEN "0000000000010000" =>
                    neg    <= '0';
                    Result <= Reg2 - 5;    

                ----------------------------------------------------------------
                -- 6. Invert the bit-significance order of A
                --    Bit-reverse: [A7..A0] -> [A0..A7]
                ----------------------------------------------------------------
                WHEN "0000000000100000" =>
                    neg    <= '0';
                    Result <= Reg1(0) & Reg1(1) & Reg1(2) & Reg1(3) &
                              Reg1(4) & Reg1(5) & Reg1(6) & Reg1(7);

                ----------------------------------------------------------------
                -- 7. Shift B left by three bits, input bit = 1 (SHL)
                --    Result = B << 3 with "111" filled on the right
                --    [B4..B0][1 1 1]
                ----------------------------------------------------------------
                WHEN "0000000001000000" =>
                    neg    <= '0';
                    Result <= Reg2(4 downto 0) & "111";

                ----------------------------------------------------------------
                -- 8. Increment A by 3
                ----------------------------------------------------------------
                WHEN "0000000010000000" =>
                    neg    <= '0';
                    Result <= Reg1 + 3;

                ----------------------------------------------------------------
                -- 9. Invert all bits of B
                ----------------------------------------------------------------
                WHEN "0000000100000000" =>
                    neg    <= '0';
                    Result <= NOT Reg2;

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
    R1 <= Result(3 DOWNTO 0);    -- lower 4 bits
    R2 <= Result(7 DOWNTO 4);    -- upper 4 bits

END calculation;
