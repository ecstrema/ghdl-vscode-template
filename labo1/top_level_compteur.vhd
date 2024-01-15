library IEEE;
use IEEE.std_logic_1164.all;

entity top_level_compteur is
  port (
    rst_i        : in  std_logic;
    clk_100mhz_i : in  std_logic;
    btnl_i       : in  std_logic;
    btnc_i       : in  std_logic;
    btnr_i       : in  std_logic;
    btnu_i       : in  std_logic;
    sw_i         : in  std_logic_vector(1 downto 0);
    dels_o       : out std_logic_vector(5 downto 0)
    );
end top_level_compteur;

architecture arch_top_level_compteur of top_level_compteur is

-- Déclaration des composants
  component clk_wiz
    port (
      clk_in1  : in  std_logic;
      clk_out1 : out std_logic;
      reset    : in  std_logic;
      locked   : out std_logic
      );
  end component;

  component divise_clk_2000
    port (
      rst_i : in  std_logic;
      clk_i : in  std_logic;
      en_o  : out std_logic
      );
  end component;

  component antirebond
    port (
      rst_i : in  std_logic;
      clk_i : in  std_logic;
      en_i  : in  std_logic;
      btn_i : in  std_logic;
      btn_o : out std_logic
      );
  end component;

  component msa_compteur
    port (
      clk_i          : in  std_logic;
      rst_i          : in  std_logic;
      btn_i          : in  std_logic;
      interrupteur_i : in  std_logic;
      compteur_o     : out std_logic_vector(3 downto 0)
      );
  end component;

  -----------------------------------------------------------------------------
  -- Laboratoire 1, section 2 : Retirer les '--' en début de ligne pour activer
  -- la déclaration du composant clingote_DEL
  -----------------------------------------------------------------------------
  -- component clignote_DEL
  --   port (
  --     rst_i : in  std_logic;
  --     clk_i : in  std_logic;
  --     sw_i  : in  std_logic;
  --     del_o : out std_logic
  --     );
  -- end component;
  -----------------------------------------------------------------------------

  -- Déclaration des signaux
  signal clk_16mhz                          : std_logic;
  signal locked                             : std_logic;
  signal rst_sys                            : std_logic;
  signal en_8khz                            : std_logic;
  signal btnu_ar, btnl_ar, btnc_ar, btnr_ar : std_logic;

begin
  -- Instantiation IP Xilinx pour la gestion d'horloge
  inst_clk_wiz : clk_wiz
    port map (
      clk_in1  => clk_100mhz_i,
      clk_out1 => clk_16mhz,
      reset    => rst_i,
      locked   => locked
      );

  rst_sys <= not(locked);

  -- Instantiation diviseur d'horloge 1/2000
  inst_divise_clk : divise_clk_2000
    port map (
      rst_i => rst_sys,
      clk_i => clk_16mhz,
      en_o  => en_8khz
      );

  -- Instantiation filtre antirebond pour le bouton Haut
  inst_ar_btnu : antirebond
    port map (
      rst_i => rst_sys,
      clk_i => clk_16mhz,
      en_i  => en_8khz,
      btn_i => btnu_i,
      btn_o => btnu_ar
      );

  -- Instantiation machine à état compteur
  inst_msa : msa_compteur
    port map (
      clk_i          => clk_16mhz,
      rst_i          => rst_sys,
      btn_i          => btnu_ar,
      interrupteur_i => sw_i(0),            --pas besoin de filtre antirebond
      compteur_o     => dels_o(3 downto 0)  --directement relie aux DEL
      );

  -- Instantiation filtre antirebond pour le bouton Guauche (labo_1 section 3)
  inst_ar_btnl : antirebond
    port map (
      rst_i => rst_sys,
      clk_i => clk_16mhz,
      en_i  => en_8khz,
      btn_i => btnl_i,
      btn_o => btnl_ar
      );

  -- Instantiation filtre antirebond pour le bouton Centre (labo_1 section 3)
  inst_ar_btnc : antirebond
    port map (
      rst_i => rst_sys,
      clk_i => clk_16mhz,
      en_i  => en_8khz,
      btn_i => btnc_i,
      btn_o => btnc_ar
      );

  -- Instantiation filtre antirebond pour le bouton Droit (labo_1 section 3)
  inst_ar_btnr : antirebond
    port map (
      rst_i => rst_sys,
      clk_i => clk_16mhz,
      en_i  => en_8khz,
      btn_i => btnr_i,
      btn_o => btnr_ar
      );

  -----------------------------------------------------------------------------
  -- Laboratoire 1, section 2 : Retirer les '--' en début de ligne pour activer
  -- l'instanciation du composant clingote_DEL
  -----------------------------------------------------------------------------
  -- inst_clignote_DEL : clignote_DEL
  --   port map (
  --     rst_i => rst_sys,
  --     clk_i => clk_16mhz,
  --     sw_i  => sw_i(1),
  --     del_o => dels_o(4)
  --     );
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Laboratoire 1, section 2 : Ajouter '--' en début de ligne pour désactiver
  -- l'assignation suivante.
  -----------------------------------------------------------------------------
  dels_o(4) <= sw_i(1);
  -----------------------------------------------------------------------------

  -----------------------------------------------------------------------------
  -- Laboratoire 1, section 3 : Ajouter '--' en début de ligne pour désactiver
  -- l'assignation suivante.
  -----------------------------------------------------------------------------
  dels_o(5) <= btnl_ar and btnc_ar and btnr_ar;
  -----------------------------------------------------------------------------

end arch_top_level_compteur;
