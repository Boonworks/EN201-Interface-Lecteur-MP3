library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity top_level_PWM is
  Port (    clock:      in std_logic;
            raz:        in std_logic;
            odata  :    out std_logic;
            ampSD :    out std_logic);
end top_level_PWM;

architecture Behavioral of top_level_PWM is
    signal ce :         std_logic;
    signal count_rom :  std_logic_vector(15 downto 0);
    signal data_out :   std_logic_vector(10 downto 0);

    component gestion_freq is
        Port (  clock:      in std_logic;
                raz:        in std_logic;
                ce :        out std_logic);
    end component gestion_freq;

    component cpt_rom is
        Port (  clock:      in std_logic;
                raz:        in std_logic;
                ce:         in std_logic;
                count_val : out std_logic_vector(15 downto 0));
    end component cpt_rom;

    component wav_rom is
        PORT (
            CLOCK          : IN  STD_LOGIC;
            ADDR_R         : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
            DATA_OUT       : OUT STD_LOGIC_VECTOR(10 DOWNTO 0)
        );
    end component wav_rom;

    component PWM_mod is
        Port (    clock:      in std_logic;
                  raz:        in std_logic;
                  ce:         in std_logic;
                  idata   :   in std_logic_vector(10 downto 0);
                  odata :     out std_logic;
                  ampSD :     out std_logic);
    end component PWM_mod;

       --signal toto : integer range 0 to 100000;

begin

    gestion_horloge_ce : gestion_freq port map(
        clock => clock,
        raz => raz,
        ce => ce
    );

    ROM_count : cpt_rom port map(
        clock => clock,
        raz => raz,
        ce => ce,
        count_val => count_rom
    );

    ROM : wav_rom port map(
        CLOCK => clock,
        ADDR_R => count_rom,
        DATA_OUT => data_out
    );

    PWM : PWM_mod port map(
        clock => clock,
        raz => raz,
        ce => ce,
        idata => data_out,
        odata => odata,
        ampSD => ampSD
    );

--    process(clk)
--    begin
--        if rising_edge(clk) then
--            if rst = '0' then
--                toto <= 0;
--            else
--                if toto < 100000 then
--                    toto <= toto + 1;
--                else
--                    toto <= 0;
--                end if;
--            end if;
--            if toto < 50000 then
--                odata <= '0';
--            else
--                odata <= '1';
--            end if;
--            ampSD <= '1';
--            led <= '1';
--        end if;
--    end process;

end Behavioral;
