-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
-- Date        : Thu Jul 10 18:25:12 2025
-- Host        : DESKTOP-5G0J4EJ running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top IFM_bd_IFM_1_0 -prefix
--               IFM_bd_IFM_1_0_ IFM_0_stub.vhdl
-- Design      : IFM_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity IFM_bd_IFM_1_0 is
  Port ( 
    datavalid : in STD_LOGIC_VECTOR ( 0 to 0 );
    imagpart : in STD_LOGIC_VECTOR ( 15 downto 0 );
    realpart : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    estimated_frequency_2_delay : out STD_LOGIC_VECTOR ( 81 downto 0 );
    estimated_frequency_4_delay : out STD_LOGIC_VECTOR ( 81 downto 0 );
    estimated_frequency_2_delay_valid : out STD_LOGIC_VECTOR ( 0 to 0 );
    estimated_frequency_4_delay_valid : out STD_LOGIC_VECTOR ( 0 to 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of IFM_bd_IFM_1_0 : entity is "IFM_0,ifm,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of IFM_bd_IFM_1_0 : entity is "yes";
  attribute IP_DEFINITION_SOURCE : string;
  attribute IP_DEFINITION_SOURCE of IFM_bd_IFM_1_0 : entity is "sysgen";
end IFM_bd_IFM_1_0;

architecture stub of IFM_bd_IFM_1_0 is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "datavalid[0:0],imagpart[15:0],realpart[15:0],clk,estimated_frequency_2_delay[81:0],estimated_frequency_4_delay[81:0],estimated_frequency_2_delay_valid[0:0],estimated_frequency_4_delay_valid[0:0]";
  attribute X_INTERFACE_INFO : string;
  attribute X_INTERFACE_INFO of datavalid : signal is "xilinx.com:signal:data:1.0 datavalid DATA";
  attribute X_INTERFACE_MODE : string;
  attribute X_INTERFACE_MODE of datavalid : signal is "slave";
  attribute X_INTERFACE_PARAMETER : string;
  attribute X_INTERFACE_PARAMETER of datavalid : signal is "XIL_INTERFACENAME datavalid, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of imagpart : signal is "xilinx.com:signal:data:1.0 imagpart DATA";
  attribute X_INTERFACE_MODE of imagpart : signal is "slave";
  attribute X_INTERFACE_PARAMETER of imagpart : signal is "XIL_INTERFACENAME imagpart, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 15} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of realpart : signal is "xilinx.com:signal:data:1.0 realpart DATA";
  attribute X_INTERFACE_MODE of realpart : signal is "slave";
  attribute X_INTERFACE_PARAMETER of realpart : signal is "XIL_INTERFACENAME realpart, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 16} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 15} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of clk : signal is "xilinx.com:signal:clock:1.0 clk CLK";
  attribute X_INTERFACE_MODE of clk : signal is "slave";
  attribute X_INTERFACE_PARAMETER of clk : signal is "XIL_INTERFACENAME clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute X_INTERFACE_INFO of estimated_frequency_2_delay : signal is "xilinx.com:signal:data:1.0 estimated_frequency_2_delay DATA";
  attribute X_INTERFACE_MODE of estimated_frequency_2_delay : signal is "master";
  attribute X_INTERFACE_PARAMETER of estimated_frequency_2_delay : signal is "XIL_INTERFACENAME estimated_frequency_2_delay, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 82} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 18} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of estimated_frequency_4_delay : signal is "xilinx.com:signal:data:1.0 estimated_frequency_4_delay DATA";
  attribute X_INTERFACE_MODE of estimated_frequency_4_delay : signal is "master";
  attribute X_INTERFACE_PARAMETER of estimated_frequency_4_delay : signal is "XIL_INTERFACENAME estimated_frequency_4_delay, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 82} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 18} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}";
  attribute X_INTERFACE_INFO of estimated_frequency_2_delay_valid : signal is "xilinx.com:signal:data:1.0 estimated_frequency_2_delay_valid DATA";
  attribute X_INTERFACE_MODE of estimated_frequency_2_delay_valid : signal is "master";
  attribute X_INTERFACE_PARAMETER of estimated_frequency_2_delay_valid : signal is "XIL_INTERFACENAME estimated_frequency_2_delay_valid, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_INTERFACE_INFO of estimated_frequency_4_delay_valid : signal is "xilinx.com:signal:data:1.0 estimated_frequency_4_delay_valid DATA";
  attribute X_INTERFACE_MODE of estimated_frequency_4_delay_valid : signal is "master";
  attribute X_INTERFACE_PARAMETER of estimated_frequency_4_delay_valid : signal is "XIL_INTERFACENAME estimated_frequency_4_delay_valid, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 1} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value false}}}}}}";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of stub : architecture is "ifm,Vivado 2025.1";
begin
end;
