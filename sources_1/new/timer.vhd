library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity timer is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           digit_o : out STD_LOGIC_VECTOR (31 downto 0);
           start_stop_button_i : in STD_LOGIC);
end timer;


architecture Behavioral of timer is
alias cyfra1: std_logic_vector(6 downto 0) is digit_o(7 downto 1);
alias cyfra2: std_logic_vector(6 downto 0) is digit_o(15 downto 9);
alias cyfra3: std_logic_vector(6 downto 0) is digit_o(23 downto 17);
alias cyfra4: std_logic_vector(6 downto 0) is digit_o(31 downto 25);

signal sync, start_stop_stable_old : std_logic:='0';
signal divided_freq : std_logic:='0';
signal start_stop_stable : std_logic:='0';

type state is (start, stop, reset);
signal current_state : state:=reset;
signal next_state : state:=reset;

begin
divider: process(clk_i)
    variable N: INTEGER:=100000;
    variable counter: INTEGER:=0;
    
    begin
    if rising_edge(clk_i) then  
    if  counter=N/2-1 then
    counter:=0;
    divided_freq <= not divided_freq;
    else 
    counter:=counter+1;
    end if;
    
     
    
    end if;
    end process divider;  
--do sygnalu 100hz
seq: process(divided_freq, rst_i) is
variable counter1: INTEGER:=0;
variable counter2: INTEGER:=0;
variable counter3: INTEGER:=0;
variable counter4: INTEGER:=0;
variable delay_prcs:INTEGER:=0;  
variable delay_cntr: integer;
begin
     
     
     
    
     

    if rising_edge(divided_freq) then
    
    
    if(sync=start_stop_stable) then
    delay_cntr := 0;
    else
    delay_cntr := delay_cntr + 1;
    end if;
    if(delay_cntr = 4) then --zmienic counter jakos ale nwm jak
    start_stop_stable <= sync;
    delay_cntr := 0;
    end if;
    
    if rst_i='1' then
    current_state <= reset;
    end if; 
    
    delay_prcs:=delay_prcs+1;
    if delay_prcs=10 then
    
    current_state <= next_state;
   
    sync <= start_stop_button_i;
    
    start_stop_stable_old <= start_stop_stable;
   
    
    
     
    
        if current_state = start then
    
    counter1:=counter1+1;
        if counter1=10 then
        counter2:=counter2+1;
        counter1:=0;
        end if;
        if counter2=10 then
        counter3:=counter3+1;
        counter2:=0;
        end if;
        if counter3=10 then
        counter4:=counter4+1;
        counter3:=0;
        end if;
        if counter4=6 then
        counter1:=11;
        counter2:=11;
        counter3:=11;
        counter4:=11;
        end if;
   
        end if;
        if current_state = stop then
    null;
        end if;
        if current_state = reset then 
    counter1:=0;
    counter2:=0;
    counter3:=0;
    counter4:=0;
        end if; 
    delay_prcs:=0;
     jedynka: case counter1 is 
    when 0 =>
    cyfra1 <= "0000001";
    when 1 =>
    cyfra1 <= "1001111";
    when 2 =>
    cyfra1 <= "0010010";
    when 3 =>
    cyfra1 <= "0000110";
    when 4 =>
    cyfra1 <= "1001100";
    when 5 =>   
    cyfra1 <= "0110100";
    when 6 =>
    cyfra1 <= "0100000";
    when 7 =>
    cyfra1 <= "0001101";
    when 8 =>
    cyfra1 <= "0000000";
    when 9 =>
    cyfra1 <= "0001100";
    when 11 =>
    cyfra1 <= "1111110";
    when others =>
    cyfra1 <= "0011100";
    end case jedynka;
   dwojka: case counter2 is 
    when 0 =>
    cyfra2 <= "0000001";
    when 1 =>
    cyfra2 <= "1001111";
    when 2 =>
    cyfra2 <= "0010010";
    when 3 =>
    cyfra2 <= "0000110";
    when 4 =>
    cyfra2 <= "1001100";
    when 5 =>   
    cyfra2 <= "0110100";
    when 6 =>
    cyfra2<= "0100000";
    when 7 =>
    cyfra2<= "0001101";
    when 8 =>
    cyfra2 <= "0000000";
    when 9 =>
    cyfra2 <= "0001100";
    when 11 =>
    cyfra2 <= "1111110";
    when others =>
    cyfra2 <= "0011100";
    end case;          
   trojka: case counter3 is 
    when 0 =>
    cyfra3 <= "0000001";
    when 1 =>
    cyfra3 <= "1001111";
    when 2 =>
    cyfra3 <= "0010010";
    when 3 =>
    cyfra3 <= "0000110";
    when 4 =>
    cyfra3 <= "1001100";
    when 5 =>   
    cyfra3 <= "0110100";
    when 6 =>
    cyfra3 <= "0100000";
    when 7 =>
    cyfra3 <= "0001101";
    when 8 =>
    cyfra3 <= "0000000";
    when 9 =>
    cyfra3 <= "0001100";
    when 11 =>
    cyfra3 <= "1111110";
    when others =>
    cyfra3 <= "0011100";
    end case; 
   czworka: case counter4 is
    when 0 =>
    cyfra4 <= "0000001";
    when 1 =>
    cyfra4 <= "1001111";
    when 2 =>
    cyfra4 <= "0010010";
    when 3 =>
    cyfra4 <= "0000110";
    when 4 =>
    cyfra4 <= "1001100";
    when 5 =>   
    cyfra4 <= "0110100";
    when 6 =>
    cyfra4 <= "0100000";
    when 7 =>
    cyfra4 <= "0001101";
    when 8 =>
    cyfra4 <= "0000000";
    when 9 =>
    cyfra4 <= "0001100";
    when 11 =>
    cyfra4 <= "1111110";
    when others =>
    cyfra4 <= "0011100";
    end case; 
    end if;
    end if;
end process;


comb: process(current_state, start_stop_stable_old, start_stop_stable) is
 
    begin
   if start_stop_stable_old='0' and start_stop_stable='1' then
    case current_state is
    when reset =>
    next_state <= start;
    when stop =>
    next_state <= reset;   
    when start =>   
    next_state <= stop;
    end case;
    else
    next_state <= current_state;
    end if;
    
  
end process;

digit_o(24)<='1';
digit_o(16)<='0';
digit_o(8)<='1';
digit_o(0)<='1';

end Behavioral;