library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity cpt_1_9_tb is
end;

architecture bench of cpt_1_9_tb is

  component cpt_1_9
      Port ( clock :      in STD_LOGIC;
             raz :        in std_logic;
             v_up :       in std_logic;
             v_dw :       in std_logic;
             out_cpt1_9 : out STD_LOGIC_VECTOR(3 downto 0));
  end component;

  signal clock: STD_LOGIC;
  signal raz: std_logic;
  signal v_up: std_logic:= '0';
  signal v_dw: std_logic:= '0';
  signal out_cpt1_9: STD_LOGIC_VECTOR(3 downto 0);

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: cpt_1_9 port map ( clock      => clock,
                          raz        => raz,
                          v_up       => v_up,
                          v_dw       => v_dw,
                          out_cpt1_9 => out_cpt1_9 );


clocking: process
    begin
        while not stop_the_clock loop
            CLOCK <= '0', '1' after clock_period / 2;
            wait for clock_period;
        end loop;
        wait;
end process;



stimulus: process
begin
	raz <='0', '1' after clock_period * 2 , '0' after CLOCK_period * 4;

    -- 2
    v_up <= '1'; wait for CLOCK_period * 6;
    v_up <= '0'; wait for CLOCK_period * 5;
    --3
    v_up <= '1'; wait for CLOCK_period;
    v_up <= '0'; wait for CLOCK_period * 5;
  

    v_up <= '1' ; v_dw <= '1'; wait for CLOCK_period *5;

end process;

end;
  