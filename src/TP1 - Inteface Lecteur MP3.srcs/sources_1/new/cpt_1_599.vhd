library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity cpt_1_599 is
    Port (  clock:          in std_logic;
            raz:            in std_logic;
            CE_affichage:   in std_logic;
            incr:           in std_logic;
            decr:           in std_logic;
            init :          in std_logic;
            output  :       out std_logic_vector(9 downto 0));
end entity cpt_1_599;

architecture Behavioral of cpt_1_599 is
    signal s_count_val : unsigned(9 downto 0) := (others => '0');
begin
    compteur_1_599 : process(clock, raz, CE_affichage, s_count_val)
    begin
        if(clock'event and clock = '1') then
            if(raz = '0' or init = '1') then
                s_count_val <= "0000000001";
            elsif(CE_affichage = '1') then
                if(incr = '1' and decr = '1') then
                    if(s_count_val = "1001010111") then
                        s_count_val <= s_count_val;
                    else
                        s_count_val <= s_count_val + 1;
                    end if;
                elsif(decr = '0' and incr = '1') then
                    if(s_count_val = "0000000001") then
                        s_count_val <= s_count_val;
                    else
                        s_count_val <= s_count_val - 1;
                    end if;
                end if;
            end if;
        end if;
    end process;

output <= std_logic_vector(s_count_val);

end Behavioral;
