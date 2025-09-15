library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity detec_impulsion is
    Port (  clock :    in std_logic;
            input :    in std_logic;
            output :   out std_logic);
end detec_impulsion;

architecture Behavioral of detec_impulsion is
    signal s_temp : std_logic := '0';
begin
    calc_output : process(clock, input)
    begin
        if(clock'event and clock = '1') then
            s_temp <= input;
            if input = '1' and s_temp = '0' then
                output <= '1';
            else
                output <= '0';
            end if;
        end if;
     end process;

end Behavioral;
