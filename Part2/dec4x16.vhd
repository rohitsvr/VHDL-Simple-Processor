library ieee;
use ieee.std_logic_1164.all;

entity dec4x16 is
    port (
        w   : in  std_logic_vector(3 downto 0);   -- 4-bit input
        En  : in  std_logic;                      -- enable
        y   : out std_logic_vector(15 downto 0)   -- 16 outputs
    );
end entity;

architecture behavior of dec4x16 is
begin
    process(w, En)
    begin
        if En = '1' then
            case w is
                when "0000" => y <= "0000000000000001";
                when "0001" => y <= "0000000000000010";
                when "0010" => y <= "0000000000000100";
                when "0011" => y <= "0000000000001000";
                when "0100" => y <= "0000000000010000";
                when "0101" => y <= "0000000000100000";
                when "0110" => y <= "0000000001000000";
                when "0111" => y <= "0000000010000000";
                when "1000" => y <= "0000000100000000";
                when "1001" => y <= "0000001000000000";
                when "1010" => y <= "0000010000000000";
                when "1011" => y <= "0000100000000000";
                when "1100" => y <= "0001000000000000";
                when "1101" => y <= "0010000000000000";
                when "1110" => y <= "0100000000000000";
                when "1111" => y <= "1000000000000000";
                when others => y <= (others => '0');
            end case;
        else
            y <= (others => '0'); -- disabled
        end if;
    end process;

end architecture;