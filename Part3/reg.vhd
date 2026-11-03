library ieee;
use ieee.std_logic_1164.all;

entity reg is
    port(
        A     : in  std_logic_vector(7 downto 0);  -- data in
        reset : in  std_logic;                     -- active-low reset
        clock : in  std_logic;                     -- clock
        Q     : out std_logic_vector(7 downto 0)   -- data out
    );
end entity;

architecture behavior of reg is
begin
    process(reset, clock)
    begin
        if reset = '0' then
            Q <= (others => '0');          -- clear on reset
        elsif rising_edge(clock) then
            Q <= A;                        -- store A on rising edge
        end if;
    end process;
end architecture;
