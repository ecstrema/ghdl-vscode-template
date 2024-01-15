library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity msa_compteur is
  port (
    rst_i          : in  std_logic;
    clk_i          : in  std_logic;
    btn_i          : in  std_logic;
    interrupteur_i : in  std_logic;
    compteur_o     : out std_logic_vector(3 downto 0)
    );
end msa_compteur;

architecture arch_msa_compteur of msa_compteur is

  type etat is (init, attente, incr, decr, relache);
  signal etat_p, etat_f         : etat;
  signal compteur_p, compteur_f : std_logic_vector(3 downto 0);

begin

-- assignation des sorties
  compteur_o <= compteur_p;

-- process registre
  p_sync : process(rst_i, clk_i)
  begin
    if(rst_i = '1') then
      etat_p     <= init;
      compteur_p <= "0000";
    elsif rising_edge(clk_i) then
      etat_p     <= etat_f;
      compteur_p <= compteur_f;
    end if;
  end process;

-- process combinatoire
  p_comb : process(etat_p, btn_i, compteur_p, interrupteur_i)
  begin
    -- assignations par defaut
    compteur_f <= compteur_p;

    case etat_p is
      when init =>
        etat_f <= attente;
      when attente =>
        if btn_i = '1' then
          if interrupteur_i = '1' then
            etat_f <= incr;
          else
            etat_f <= decr;
          end if;
        else
          etat_f <= attente;
        end if;
      when decr =>
        compteur_f <= std_logic_vector(unsigned(compteur_p) - 1);
        etat_f     <= relache;
      when incr =>
        compteur_f <= std_logic_vector(unsigned(compteur_p) + 1);
        etat_f     <= relache;
      when others =>                    -- relache =>
        if btn_i = '0' then
          etat_f <= attente;
        else
          etat_f <= relache;
        end if;
    end case;
  end process;
end arch_msa_compteur;
