library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PWM_mod is
Port (    clock:      in std_logic;
          raz:        in std_logic;
          ce:         in std_logic;
          idata   :   in std_logic_vector(10 downto 0);
          odata :     out std_logic;
          ampSD :     out std_logic);
end PWM_mod;

architecture Behavioral of PWM_mod is
  signal count :      unsigned(10 downto 0) := (others => '0');
  signal e_count :    std_logic := '0';
  signal new_idata :  unsigned(10 downto 0);

  begin

  enable_count : process(clock, ce)
  begin
  new_idata <= unsigned(idata) + to_unsigned(1024, 11);
    if(clock'event and clock ='1') then
      if(raz = '1' or count = new_idata) then
        e_count <= '0';
      elsif(ce = '1') then
        e_count <= '1';
      end if;
    end if;
  end process;

  upd_count : process(clock, e_count, new_idata, count)
  begin
    new_idata <= unsigned(idata) + to_unsigned(1024, 11);
    if(clock'event and clock ='1') then
      if(e_count = '1') then
          if(count = new_idata) then
            odata <= '0';
          else
            count <= count + 1;
            odata <= '1';
          end if;
        else
          count <= (others => '0');
          odata <= '0';
      end if;
    end if;
  end process;

  ampSD <= '1';

end architecture Behavioral;
