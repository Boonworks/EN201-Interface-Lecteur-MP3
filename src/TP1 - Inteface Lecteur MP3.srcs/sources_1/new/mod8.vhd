library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity mod8 is
    Port (  clock:     in std_logic;
            raz:     in std_logic;
            CE_perception :     in std_logic;
            AN :    out std_logic_vector(7 downto 0);
            commande :    out std_logic_vector(2 downto 0));
end mod8;

architecture Behavioral of mod8 is
    signal s_count_val : unsigned(2 downto 0) := (others => '0');
begin
    upd_count : process(clock, raz, s_count_val)
    begin
        if(clock'event and clock = '1') then
            if(raz = '1') then
                s_count_val <= (others => '0');
            elsif(CE_perception = '1') then
                if(s_count_val = "111") then
                    s_count_val <= (others => '0');
                else
                    s_count_val <= s_count_val + 1;
                end if;
            end if;
        end if;
    end process;

    upd_AN : process(s_count_val)
    begin
        case s_count_val is
            when "000" => AN <=   "11111110"; --1
            when "001" => AN <=   "11111101"; --2
            when "010" => AN <=   "11111011"; --3
            when "011" => AN <=   "11110111"; --4
            when "100" => AN <=   "11101111"; --5
            when "101" => AN <=   "11011111"; --6
            when "110" => AN <=   "10111111"; --7
            when others => AN <=  "01111111"; --8
         end case;
     end process;


commande <= std_logic_vector(s_count_val);

end Behavioral;
