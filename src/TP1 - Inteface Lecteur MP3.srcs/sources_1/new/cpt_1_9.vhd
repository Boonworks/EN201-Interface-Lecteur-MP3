library IEEE; --VOLUMEEE
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
entity cpt_1_9 is
    Port ( clock :      in STD_LOGIC;
           raz :        in std_logic;
           v_up :       in std_logic;
           v_dw :       in std_logic;
           out_cpt1_9 : out STD_LOGIC_VECTOR(3 downto 0));
end entity cpt_1_9;

architecture Behavioral of cpt_1_9 is

signal s_count_val : unsigned(3 downto 0) := ("0001");

begin

    cpt_tirage_register: process(clock,raz)
    begin
        if(clock'event and clock ='1') then
            if(raz = '0') then
                s_count_val <= "0001";
            elsif(v_up = '1' and v_dw = '1') then
                 s_count_val <= s_count_val;
            elsif(v_up = '1') then
                if(s_count_val = "1001") then
                    s_count_val <= s_count_val;
                else
                    s_count_val <= s_count_val + 1;
                end if;
            elsif(v_dw = '1') then
                if(s_count_val = "0001") then
                    s_count_val <= s_count_val;
                else
                    s_count_val <= s_count_val - 1;
                end if;
            end if;
        end if;
    end process cpt_tirage_register;

out_cpt1_9 <= std_logic_vector(s_count_val);

end architecture Behavioral;
