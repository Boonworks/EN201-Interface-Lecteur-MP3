library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity mux8 is
  Port (
        commande :  in STD_LOGIC_VECTOR(2 downto 0);
        val_0 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_1 :     in STD_LOGIC_VECTOR(6 downto 0);   
        val_2 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_3 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_4 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_5 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_6 :     in STD_LOGIC_VECTOR(6 downto 0);
        val_7 :     in STD_LOGIC_VECTOR(6 downto 0);

        dp :        out std std_logic;
        sept_seg :  out STD_LOGIC_VECTOR(6 downto 0));

end mux8;

architecture Behavioral of mux8 is
begin
process(commande)
    begin
        case commande IS
            when "000" => 
                sept_seg <= val_0;
            when "001" => 
                sept_seg <= val_1;
            when "010" => 
                sept_seg <= val_2;
            when "011" => 
                sept_seg <= val_3;
            when "100" => 
                sept_seg <= val_4;
            when "110" =>
                sept_seg <= val_6;
            when "101" => 
                sept_seg <= val_5;    
            when "111" =>
                sept_seg <= val_7;     
            when others =>
                sept_seg <= "000000";    
       end case;
   end process;
end Behavioral;