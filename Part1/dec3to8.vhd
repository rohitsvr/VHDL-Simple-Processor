library ieee;
use ieee.std_logic_1164.all;

entity dec3to8 is
    port(
        w  : in  std_logic_vector(2 downto 0);  -- inputs S2 S1 S0
        En : in  std_logic;                     -- enable
        y  : out std_logic_vector(7 downto 0)   -- outputs OP0..OP7
    );
end entity;

architecture behavior of dec3to8 is
    signal Enw : std_logic_vector(3 downto 0);
begin
    Enw <= En & w;  -- concatenate En as MSB

    with Enw select
        y <= "00000001" when "1000",  -- En=1,w="000"
             "00000010" when "1001",
             "00000100" when "1010",
             "00001000" when "1011",
             "00010000" when "1100",
             "00100000" when "1101",
             "01000000" when "1110",
             "10000000" when "1111",
             "00000000" when others;
end architecture;
