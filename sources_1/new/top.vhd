library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity top is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           start_stop_button_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end top;

architecture Behavioral of top is 

    component display is
    Port ( rst_i : in STD_LOGIC;
           clk_i : in STD_LOGIC;
           digit_i : in STD_LOGIC_VECTOR (31 downto 0);
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
    end component;
    
    component timer is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           digit_o : out STD_LOGIC_VECTOR (31 downto 0);
           start_stop_button_i : in STD_LOGIC);
    end component;

    signal digit_i : std_logic_vector(31 downto 0);
    
begin
    disp: display port map(
    rst_i => rst_i,
    digit_i=>digit_i,
    clk_i => clk_i,
    led7_an_o => led7_an_o,
    led7_seg_o=>led7_seg_o
    );
    
    tim: timer port map(
    clk_i => clk_i,
    rst_i => rst_i,
    digit_o => digit_i,
    start_stop_button_i => start_stop_button_i
    );
    
end Behavioral;