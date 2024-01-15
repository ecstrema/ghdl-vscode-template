library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.Numeric_std.all;

entity antirebond is
  port (
    rst_i : in  std_logic;
    clk_i : in  std_logic;
    en_i  : in  std_logic;
    btn_i : in  std_logic;
    btn_o : out std_logic
    );
end antirebond;

architecture arch_antirebond of antirebond is

  signal btn_shiftreg_r : std_logic_vector (7 downto 0);
  signal btn_clean_r    : std_logic;
  signal en_r           : std_logic;

begin

  btn_o <= btn_clean_r;

  en_reg : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      en_r <= '0';
    elsif rising_edge(clk_i) then
      en_r <= en_i;
    end if;
  end process;

  debouncing_process : process(clk_i, rst_i)
  begin
    if rst_i = '1' then
      btn_shiftreg_r <= (others => '0');
      btn_clean_r    <= '0';
    elsif rising_edge(clk_i) then
      if en_i = '1' and en_r = '0' then
        btn_shiftreg_r <= btn_shiftreg_r(6 downto 0) & btn_i;
        if btn_shiftreg_r = "11111111" then
          btn_clean_r <= '1';
        elsif btn_shiftreg_r = "00000000" then
          btn_clean_r <= '0';
        else
          btn_clean_r <= btn_clean_r;
        end if;
      end if;
    end if;
  end process;
end arch_antirebond;
