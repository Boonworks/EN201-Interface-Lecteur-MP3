library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;

entity FSM_tb is
end;

architecture bench of FSM_tb is

  component FSM
  PORT (
          raz : IN STD_LOGIC;
          CLOCK : IN STD_LOGIC;
          B_UP : IN STD_LOGIC;
          B_DOWN : IN STD_LOGIC;
          B_CENTER : IN STD_LOGIC;
          B_LEFT : IN STD_LOGIC;
          B_RIGHT : IN STD_LOGIC;
          PLAY_PAUSE : OUT STD_LOGIC;
          RESTART : OUT STD_LOGIC;
          FORWARD : OUT STD_LOGIC;
          VOLUME_UP : OUT STD_LOGIC;
          VOLUME_DW : OUT STD_LOGIC);
  end component;

  signal raz: STD_LOGIC:= '0';
  signal CLOCK: STD_LOGIC:= '0';
  signal B_UP: STD_LOGIC:= '0' ;
  signal B_DOWN: STD_LOGIC:= '0';
  signal B_CENTER: STD_LOGIC:= '0';
  signal B_LEFT: STD_LOGIC:= '0';
  signal B_RIGHT: STD_LOGIC:= '0';
  signal PLAY_PAUSE: STD_LOGIC:= '0';
  signal RESTART: STD_LOGIC:= '0';
  signal FORWARD: STD_LOGIC:= '0';
  signal VOLUME_UP: STD_LOGIC:= '0';
  signal VOLUME_DW: STD_LOGIC:= '0';

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: FSM port map ( raz        => raz,
                      CLOCK      => CLOCK,
                      B_UP       => B_UP,
                      B_DOWN     => B_DOWN,
                      B_CENTER   => B_CENTER,
                      B_LEFT     => B_LEFT,
                      B_RIGHT    => B_RIGHT,
                      PLAY_PAUSE => PLAY_PAUSE,
                      RESTART    => RESTART,
                      FORWARD    => FORWARD,
                      VOLUME_UP  => VOLUME_UP,
                      VOLUME_DW  => VOLUME_DW );

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
    -- Put initialisation code here
    raz <= '1'; wait for CLOCK_period * 2;
    raz <= '0'; wait for CLOCK_period * 2;

    -- ON PASSE DANS L'ETAT PLAY FWD
    B_CENTER <= '1'; wait for CLOCK_period;
    B_CENTER <= '0'; wait for CLOCK_period * 9;
    
    -- ON PASSE DANS L'ETAT PAUSE
    B_CENTER <= '1'; wait for CLOCK_period;
    B_CENTER <= '0'; wait for CLOCK_period * 9;

    -- ON PASSE DANS PLAY BWD
    B_LEFT <= '1'; wait for CLOCK_period;
    B_LEFT <= '0'; wait for CLOCK_period * 9;
    
    -- ON PASSE DANS PAUSE
    B_CENTER <= '1'; wait for CLOCK_period;
    B_CENTER <= '0'; wait for CLOCK_period * 9;

    -- ON PASSE DANS STOP
    B_CENTER <= '1'; wait for CLOCK_period;
    B_CENTER <= '0'; wait for CLOCK_period * 9;

    -- on PASSE DANS PLAT FWD
    B_CENTER <= '1'; wait for CLOCK_period;
    B_CENTER <= '0'; wait for CLOCK_period * 9;
    
    stop_the_clock <= true;
    wait;
end process;



end;
  