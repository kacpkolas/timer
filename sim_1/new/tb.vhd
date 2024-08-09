----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.04.2024 17:38:34
-- Design Name: 
-- Module Name: tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb is
--  Port ( );
end tb;

architecture Behavioral of tb is


component top is
    Port ( clk_i : in STD_LOGIC;
           rst_i : in STD_LOGIC;
           start_stop_button_i : in STD_LOGIC;
           led7_an_o : out STD_LOGIC_VECTOR (3 downto 0);
           led7_seg_o : out STD_LOGIC_VECTOR (7 downto 0));
end component;

component bounce is
    Generic ( min_time : TIME := 100 us;
              max_time : TIME := 1 ms;
              max_cnt : INTEGER := 2;
              seed : INTEGER := 777);
    Port ( in_i : in STD_LOGIC;
           out_o : out STD_LOGIC);
end component;

signal clk_i : std_logic:='0';
signal rst_i : std_logic:='0';
signal start_stop_button_i : std_logic:='0';
signal led7_an_o : std_logic_vector(3 downto 0);
signal led7_seg_o : std_logic_vector(7 downto 0);
signal start_stop_dirty : std_logic;
begin
dut: top port map(
clk_i => clk_i,
rst_i=>rst_i,
start_stop_button_i=>start_stop_dirty,
led7_an_o=>led7_an_o,
led7_seg_o=>led7_seg_o
);

bounce_model: bounce port map(
in_i => start_stop_button_i,
out_o => start_stop_dirty
);

clk_i<=not clk_i after 5ns;

stim: process
begin
wait for 200ms;
start_stop_button_i<='1';
wait for 100ms;
start_stop_button_i<='0';
wait for 200ms;
start_stop_button_i<='1';
wait for 100 ms ;
start_stop_button_i<='0';
wait for 200ms;
start_stop_button_i<='1';
wait for 100 ms;
start_stop_button_i<='0';
wait;
end process;
end Behavioral;
