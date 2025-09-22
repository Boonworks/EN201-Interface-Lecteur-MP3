library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top_level_mp3 is
    Port (  clock :         in std_logic;
            raz:            in std_logic;
            btn_center:     in std_logic;
            btn_left:       in std_logic;
            btn_right:      in std_logic;
            btn_up:         in std_logic;
            btn_down :      in std_logic;

            dp :            out std_logic;
            sept_seg :      out std_logic_vector(6 downto 0);
            AN :            out std_logic_vector(7 downto 0));
end top_level_mp3;

architecture Behavioral of top_level_mp3 is

  signal b_center :         std_logic;
  signal b_left :           std_logic;
  signal b_right :          std_logic;
  signal b_up :             std_logic;
  signal b_down :           std_logic;
  signal forward :          std_logic;
  signal play_pause :       std_logic;
  signal restart :          std_logic;
  signal volume_dw :        std_logic;
  signal volume_up :        std_logic;
  signal ce_affichage :     std_logic;
  signal ce_perception :    std_logic;
  signal nb_binaire_vol :   std_logic_vector(3 downto 0);
  signal nb_binaire :       std_logic_vector(9 downto 0);
  signal v0 :               std_logic_vector(6 downto 0);
  signal v1 :               std_logic_vector(6 downto 0);
  signal v2 :               std_logic_vector(6 downto 0);
  signal v3 :               std_logic_vector(6 downto 0);
  signal v4 :               std_logic_vector(6 downto 0);
  signal v5 :               std_logic_vector(6 downto 0);
  signal v6 :               std_logic_vector(6 downto 0);
  signal v7 :               std_logic_vector(6 downto 0);
  signal commande :         std_logic_vector(2 downto 0);

  component detec_impulsion is
      Port (  clock :     in std_logic;
              input :     in std_logic;
              output :    out std_logic);
  end component detec_impulsion;

  component gestion_freq is
      Port (  clock:            in std_logic;
              raz :             in std_logic;
              CE_affichage:     out std_logic;
              CE_perception :   out std_logic);
  end component gestion_freq;

  component FSM is
      Port (      clock:          in std_logic;
                  raz:            in std_logic;
                  b_up:           in std_logic;
                  b_down:         in std_logic;
                  b_center :      in std_logic;
                  b_left:         in std_logic;
                  b_right :       in std_logic;
                  play_pause:     out std_logic;
                  restart:        out std_logic;
                  forward:        out std_logic;
                  volume_up :     out std_logic;
                  volume_dw :     out std_logic);
  end component FSM;

  component cpt_1_9 is
      Port (  clock :      in STD_LOGIC;
              raz :        in std_logic;
              v_up :       in std_logic;
              v_dw :       in std_logic;
              out_cpt1_9 : out STD_LOGIC_VECTOR(3 downto 0));
  end component cpt_1_9;

  component cpt_1_599 is
      Port (  clock:          in std_logic;
              raz:            in std_logic;
              CE_affichage:   in std_logic;
              incr:           in std_logic;
              decr:           in std_logic;
              init :          in std_logic;
              output  :       out std_logic_vector(9 downto 0));
  end component cpt_1_599;

  component transcodeur is
        Port (
          nb_binaire     : in   STD_LOGIC_VECTOR(9 downto 0);
          nb_binaire_vol : in   STD_LOGIC_VECTOR(3 downto 0);
          PLAY_PAUSE     : in   std_logic;
          RESTART        : in   std_logic;
          FORWARD        : in   std_logic;
          sortie1        : out  std_logic_vector(6 downto 0);
          sortie2        : out  std_logic_vector(6 downto 0);
          sortie3        : out  std_logic_vector(6 downto 0);
          sortie4        : out  std_logic_vector(6 downto 0);
          S_uni_vol      : out  STD_LOGIC_VECTOR (6 downto 0);
          S_uni          : out  STD_LOGIC_VECTOR (6 downto 0);
          S_diz          : out  STD_LOGIC_VECTOR (6 downto 0);
          S_cent         : out  STD_LOGIC_VECTOR (6 downto 0)
              );
    end component transcodeur;

    component mod8 is
        Port (  clock:            in std_logic;
                raz:              in std_logic;
                CE_perception :   in std_logic;
                AN :              out std_logic_vector(7 downto 0);
                commande :        out std_logic_vector(2 downto 0));
    end component mod8;

    component mux8 is
        Port(   commande :  in STD_LOGIC_VECTOR(2 downto 0);
                val_0 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_1 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_2 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_3 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_4 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_5 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_6 :     in STD_LOGIC_VECTOR(6 downto 0);
                val_7 :     in STD_LOGIC_VECTOR(6 downto 0);
                dp :        out std_logic;
                sept_seg :  out STD_LOGIC_VECTOR(6 downto 0));
    end component mux8;

begin

    Reg_B_Center : detec_impulsion port map (
        clock => clock,
        input => btn_center,
        output => b_center
    );

    Reg_B_Left : detec_impulsion port map (
        clock => clock,
        input => btn_left,
        output => b_left
    );

    Reg_B_Right : detec_impulsion port map (
        clock => clock,
        input => btn_right,
        output => b_right
    );

    Reg_B_Up : detec_impulsion port map (
        clock => clock,
        input => btn_up,
        output => b_up
    );

    Reg_B_Down : detec_impulsion port map (
        clock => clock,
        input => btn_down,
        output => b_down
    );

    fsm_MP3 : FSM port map (
        clock => clock,
        raz => raz,
        b_up => b_up,
        b_down => b_down,
        b_center => b_center,
        b_left => b_left,
        b_right => b_right,
        play_pause => play_pause,
        restart => restart,
        forward => forward,
        volume_up => volume_up,
        volume_dw => volume_dw
    );

    gestion_horloge : gestion_freq port map (
        clock => clock,
        raz => raz,
        CE_affichage => ce_affichage,
        CE_perception => ce_perception
    );

    compteur_1_9 : cpt_1_9 port map (
        clock => clock,
        raz => raz,
        v_up => volume_up,
        v_dw => volume_dw,
        out_cpt1_9 => nb_binaire_vol
    );

    compteur_1_599 : cpt_1_599 port map (
        clock => clock,
        raz => raz,
        ce_affichage => ce_affichage,
        incr => play_pause,
        decr => forward,
        init => restart,
        output => nb_binaire
    );

    trans : transcodeur port map (
        forward => forward,
        play_pause => play_pause,
        restart => restart,

        nb_binaire => nb_binaire,
        nb_binaire_vol => nb_binaire_vol,

        S_cent =>     v0,
        S_diz =>      v1,
        S_uni =>      v2,
        S_uni_vol =>  v3,
        sortie1 =>    v4,
        sortie2 =>    v5,
        sortie3 =>    v6,
        sortie4 =>    v7
    );

    modulo8 : mod8 port map (
        clock => clock,
        raz => raz,
        ce_perception => ce_perception,
        AN => AN,
        commande => commande
    );

    multiplex8 : mux8 port map (
        val_0 => v0,
        val_1 => v1,
        val_2 => v2,
        val_3 => v3,
        val_4 => v4,
        val_5 => v5,
        val_6 => v6,
        val_7 => v7,
        commande => commande,
        DP => DP,
        sept_seg => sept_seg
    );

end Behavioral;
