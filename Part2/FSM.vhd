library ieee;
use ieee.std_logic_1164.all;
entity FSM is
    port
    (   clk          : in  std_logic;
        data_in      : in  std_logic;
        reset        : in  std_logic;
        student_id   : out std_logic_vector(3 downto 0);
        current_state: out std_logic_vector(3 DOWNTO 0)
    );
end entity;
architecture fsm of FSM is
    -- Build an enumerated type with 9 states for
    -- the state machine ( 9 states for parsing 9 digits of
    -- student id)
    type state_type is (s0, s1, s2, s3, s4, s5, s6, s7, s8);
    -- Register to hold the current state
    signal yfsm : state_type;
begin
    process (clk, reset)
    begin
        if reset = '0' then -- active-LOW reset
            yfsm <= s0;
        elsif rising_edge(clk) then
            -- Determine the next state
            -- synchronously, based on
            -- the current state and the input
            case yfsm is
                when s0 =>      -- S0 -> S1
                    yfsm <= s1;
                when s1 =>      -- S1 -> S2
                    yfsm <= s2;
                when s2 =>      -- S2 -> S3
                    yfsm <= s3;
                when s3 =>      -- S3 -> S4
                    yfsm <= s4;
                when s4 =>      -- S4 -> S5
                    yfsm <= s5;
                when s5 =>      -- S5 -> S6
                    yfsm <= s6;
                when s6 =>      -- S6 -> S7
                    yfsm <= s7;
                when s7 =>      -- S7 -> S8
                    yfsm <= s8;
                when s8 =>      -- S8 -> S0
                    yfsm <= s0;
            end case;
        end if;
    end process;
    -- Moore
    process (yfsm, data_in) -- data_in if reqd only
    begin
        case yfsm is
            when s0 =>                     -- 5
                student_id    <= "0101";
                current_state <= "0000";   -- S0
            when s1 =>                     -- 0
                student_id    <= "0000";
                current_state <= "0001";   -- S1
            when s2 =>                     -- 1
                student_id    <= "0001";
                current_state <= "0010";   -- S2
            when s3 =>                     -- 1
                student_id    <= "0001";
                current_state <= "0011";   -- S3
            when s4 =>                     -- 7
                student_id    <= "0111";
                current_state <= "0100";   -- S4
            when s5 =>                     -- 7
                student_id    <= "0111";
                current_state <= "0101";   -- S5
            when s6 =>                     -- 3
                student_id    <= "0011";
                current_state <= "0110";   -- S6
            when s7 =>                     -- 9
                student_id    <= "1001";
                current_state <= "0111";   -- S7
            when s8 =>                     -- 3
                student_id    <= "0011";
                current_state <= "1000";   -- S8
        end case; 
    end process;
end fsm;
