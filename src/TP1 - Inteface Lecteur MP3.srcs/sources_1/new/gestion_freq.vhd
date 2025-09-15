library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity gestion_freq is
    Port ( raz : in STD_LOGIC;
           horloge : in STD_LOGIC;

           CE_perception: out STD_LOGIC;
           CE_affichage: out STD_LOGIC);
end gestion_freq;

architecture Behavioral of gestion_freq is

signal compt_affichage : unsigned(16 downto 0) := (others => '0');
signal compt_perception : unsigned(24 downto 0) := (others => '0');

begin


   compteur_1: process(horloge, raz)
   begin
     if(raz='1') then
        compt_affichage <= (others => '0');
     elsif(horloge'event and horloge ='1') then
                compt_affichage <= compt_affichage + 1;
            end if;
   end process compteur_1;

   CE_aff: process(compt_affichage)
   begin
     if(compt_affichage=to_unsigned(33333,17)) then
        CE_perception <= '1';
     else
        CE_perception <= '0';
            end if;
   end process CE_aff;

   compteur_2: process(horloge, raz)
   begin
     if(raz='1') then
        compt_perception <= (others => '0');
     elsif(horloge'event and horloge ='1') then
                compt_perception <= compt_perception + 1;
            end if;
   end process compteur_2;

   CE_incr: process(compt_perception)
   begin
     if(compt_perception=to_unsigned(100000000,25)) then
        CE_affichage <= '1';
     else
        CE_affichage <= '0';
            end if;
   end process CE_incr;

end architecture Behavioral;
