library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity display is
    Port ( rst_i : in STD_LOGIC;
           clk_i : in STD_LOGIC;
           digit_i : in STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end display;


architecture Behavioral of display is
alias cyfra1: std_logic_vector(7 downto 0) is digit_i(7 downto 0);
alias cyfra2: std_logic_vector(7 downto 0) is digit_i(15 downto 8);
alias cyfra3: std_logic_vector(7 downto 0) is digit_i(23 downto 16);
alias cyfra4: std_logic_vector(7 downto 0) is digit_i(31 downto 24);
signal divided_freq: std_logic:='0'; 


begin
mux: process(divided_freq) 
variable counter: INTEGER:=0;
begin
    if rising_edge(divided_freq) then
   
    case counter is   
    when 0 =>
        led7_seg_o <= cyfra1;
        led7_an_o <= "1110";
    when 1 =>
        led7_seg_o <= cyfra2;
        led7_an_o <= "1101";
    when 2 =>
        led7_seg_o <= cyfra3;
        led7_an_o <= "1011";
    when 3 =>
        led7_seg_o <= cyfra4;
        led7_an_o <= "0111";
    when others =>
    counter:=0;
    led7_seg_o <= cyfra1;
    led7_an_o <= "1110";
    end case;
    counter:=counter+1;
    end if;
    end process mux;


 divider: process(clk_i, rst_i)
    variable N: INTEGER:=100000;
    variable counter: INTEGER:=0;
    begin
    if rising_edge(clk_i) then  
    if rst_i='1' then
    divided_freq <= '0';
    counter:=0;
    elsif  counter=N/2-1 then
    counter:=0;
    divided_freq <= not divided_freq;
    else 
    counter:=counter+1;
    end if;
    end if;
    end process divider;

end Behavioral;
