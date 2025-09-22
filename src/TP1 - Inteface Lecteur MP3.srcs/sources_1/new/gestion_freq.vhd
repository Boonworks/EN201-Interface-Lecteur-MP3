library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gestion_freq is
    Port (  clock:            in std_logic;
            raz :             in std_logic;
            CE_affichage:     out std_logic;
            CE_perception :   out std_logic);
end gestion_freq;

architecture Behavioral of gestion_freq is
    signal count_perc : unsigned(15 downto 0) := (others => '0');
    signal count_aff  : unsigned(23 downto 0) := (others => '0');
begin
    upd_aff : process(clock)
    begin
      if(clock'event and clock = '1') then
        if(raz = '1') then
          count_aff <= (others => '0');
          CE_affichage <= '0';
        elsif(count_aff = "100110001001011010000000") then
          count_aff <= (others => '0');
          CE_affichage <= '1';
        else
          count_aff <= count_aff + 1;
          CE_affichage <= '0';
        end if;
      end if;
    end process;

    upd_perc : process(clock)
    begin
        if(clock'event and clock = '1') then
            if(raz = '1') then
                count_perc <= (others => '0');
                CE_perception <='0';
            elsif(count_perc = "1000001000110101") then
                count_perc <= (others => '0');
                CE_perception <= '1';
            else
                count_perc <= count_perc + 1;
                CE_perception <= '0';
            end if;
        end if;
    end process;

end Behavioral;
