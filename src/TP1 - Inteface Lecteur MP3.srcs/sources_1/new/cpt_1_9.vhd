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

signal cpt1_9 : unsigned(3 downto 0) := ("0001"); 

begin
   cpt_tirage_register: process(clock,raz)
   begin
     if(raz='1') then   
        cpt1_9 <= to_unsigned(1,4); 
     elsif(clock'event and clock ='1') then
     
            if (v_up='1')and (v_dw = '0')then
                if(cpt1_9 >= "1001") then
                    cpt1_9 <= cpt1_9;
                else
                    cpt1_9 <= cpt1_9 + 1;
                end if;
         
             
             elsif (v_up='0') and (v_dw ='1')then
                if(cpt1_9 <= "0001") then
                    cpt1_9 <= cpt1_9;
                else
                    cpt1_9 <= cpt1_9  - 1;
                end if;
             
        end if;
     end if;
   end process cpt_tirage_register;
   
out_cpt1_9 <= std_logic_vector(cpt1_9);
 
end architecture Behavioral;