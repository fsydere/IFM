-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
entity ifm_stub is
  port (
    datavalid : in std_logic_vector( 1-1 downto 0 );
    imagpart : in std_logic_vector( 16-1 downto 0 );
    realpart : in std_logic_vector( 16-1 downto 0 );
    clk : in std_logic;
    gateway_out : out std_logic_vector( 82-1 downto 0 );
    gateway_out1 : out std_logic_vector( 82-1 downto 0 )
  );
end ifm_stub;
architecture structural of ifm_stub is 
begin
  sysgen_dut : entity xil_defaultlib.ifm 
  port map (
    datavalid => datavalid,
    imagpart => imagpart,
    realpart => realpart,
    clk => clk,
    gateway_out => gateway_out,
    gateway_out1 => gateway_out1
  );
end structural;
