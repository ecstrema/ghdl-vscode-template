library ieee;
use ieee.std_logic_1164.all;

entity top_level_compteur_tb is
end top_level_compteur_tb;

architecture arch_top_level_compteur_tb of top_level_compteur_tb is

  -- Component Declaration for the Unit Under Test (UUT)
  component top_level_compteur
    port(
      rst_i        : in  std_logic;
      clk_100mhz_i : in  std_logic;
      btnl_i       : in  std_logic;
      btnc_i       : in  std_logic;
      btnr_i       : in  std_logic;
      btnu_i       : in  std_logic;
      sw_i         : in  std_logic_vector(1 downto 0);
      dels_o       : out std_logic_vector(5 downto 0)
      );
  end component;

--Inputs
  signal rst_i                          : std_logic                    := '0';
  signal clk_100mhz_i                   : std_logic                    := '0';
  signal btnu_i, btnl_i, btnc_i, btnr_i : std_logic                    := '0';
  signal sw_i                           : std_logic_vector(1 downto 0) := "00";

--Outputs
  signal dels_o : std_logic_vector(5 downto 0);

-- Clock period definitions
  constant CLK_100MHZ_PERIOD : time := 10 ns;

begin

  -- Instantiate the Unit Under Test (UUT)
  uut : top_level_compteur
    port map (
      rst_i        => rst_i,
      clk_100mhz_i => clk_100mhz_i,
      btnl_i       => btnl_i,
      btnc_i       => btnc_i,
      btnr_i       => btnr_i,
      btnu_i       => btnu_i,
      sw_i         => sw_i,
      dels_o       => dels_o
      );

  -- Clock definition
  clk_100mhz_i <= not clk_100mhz_i after CLK_100MHZ_PERIOD/2;

  -- Stimulus process
  stim_proc : process
  begin
    rst_i <= '1';
    sw_i(0) <= '0';
    wait for 20 ns;
    rst_i <= '0';
    wait; -- wait forever
  end process;

  -- Button press stimulation
  btnu_i <= not btnu_i after 1500 us;

end arch_top_level_compteur_tb;
