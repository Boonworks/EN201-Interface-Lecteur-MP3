library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpt_rom is
    Port (  clock:      in std_logic;
            raz:        in std_logic;
            ce:         in std_logic;
            count_val : out std_logic_vector(15 downto 0));
end entity cpt_rom;

architecture Behavioral of cpt_rom is
    signal s_count_val : unsigned(15 downto 0) := (others => '0');
begin
    count : process(clock, ce)
    begin
        if(clock'event and clock ='1') then
            if(raz = '1' or s_count_val = "1010110001000011") then
                s_count_val <= (others => '0');
            elsif(ce = '1') then
                s_count_val <= s_count_val + 1;
            end if;
        end if;
    end process count;

count_val <= std_logic_vector(s_count_val);

end Behavioral;
