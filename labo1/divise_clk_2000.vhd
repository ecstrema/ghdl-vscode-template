library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity divise_clk_2000 is
  port (
    rst_i : in  std_logic;
    clk_i : in  std_logic;
    en_o  : out std_logic
    );
end divise_clk_2000;

architecture arch_divise_clk_2000 of divise_clk_2000 is

  signal cntdiv_r   : std_logic_vector (11 downto 0);
  signal div_temp_r : std_logic;

begin

  en_o <= div_temp_r;

  process (clk_i, rst_i)
  begin
    if rst_i = '1' then
      div_temp_r <= '0';
      cntdiv_r   <= (others => '0');
    elsif rising_edge(clk_i) then
      -- Inverse la sortie après 2000/2 cycles d'horloge
      if unsigned(cntdiv_r) >= 999 then
        div_temp_r <= not(div_temp_r);
        cntdiv_r   <= (others => '0');
      else
        div_temp_r <= div_temp_r;
        cntdiv_r   <= std_logic_vector(unsigned(cntdiv_r) + 1);
      end if;
    end if;
  end process;
end arch_divise_clk_2000;
