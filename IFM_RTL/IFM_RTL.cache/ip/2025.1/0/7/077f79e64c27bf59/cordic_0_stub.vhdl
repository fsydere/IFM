-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2025.1 (lin64) Build 6140274 Wed May 21 22:58:25 MDT 2025
-- Date        : Sat Jul  5 16:12:50 2025
-- Host        : fsy-MS-7D99 running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ cordic_0_stub.vhdl
-- Design      : cordic_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg400-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    aclk : in STD_LOGIC;
    s_axis_phase_tvalid : in STD_LOGIC;
    s_axis_phase_tdata : in STD_LOGIC_VECTOR ( 31 downto 0 );
    s_axis_cartesian_tvalid : in STD_LOGIC;
    s_axis_cartesian_tdata : in STD_LOGIC_VECTOR ( 63 downto 0 );
    m_axis_dout_tvalid : out STD_LOGIC;
    m_axis_dout_tdata : out STD_LOGIC_VECTOR ( 79 downto 0 )
  );

  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "cordic_0,cordic_v6_0_24,{}";
  attribute core_generation_info : string;
  attribute core_generation_info of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "cordic_0,cordic_v6_0_24,{x_ipProduct=Vivado 2025.1,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=cordic,x_ipVersion=6.0,x_ipCoreRevision=24,x_ipLanguage=VERILOG,x_ipSimLanguage=MIXED,C_ARCHITECTURE=2,C_CORDIC_FUNCTION=0,C_COARSE_ROTATE=1,C_DATA_FORMAT=0,C_XDEVICEFAMILY=zynq,C_HAS_ACLKEN=0,C_HAS_ACLK=1,C_HAS_S_AXIS_CARTESIAN=1,C_HAS_S_AXIS_PHASE=1,C_HAS_ARESETN=0,C_INPUT_WIDTH=32,C_ITERATIONS=0,C_OUTPUT_WIDTH=36,C_PHASE_FORMAT=0,C_PIPELINE_MODE=-2,C_PRECISION=0,C_ROUND_MODE=0,C_SCALE_COMP=0,C_THROTTLE_SCHEME=3,C_TLAST_RESOLUTION=0,C_HAS_S_AXIS_PHASE_TUSER=0,C_HAS_S_AXIS_PHASE_TLAST=0,C_S_AXIS_PHASE_TDATA_WIDTH=32,C_S_AXIS_PHASE_TUSER_WIDTH=1,C_HAS_S_AXIS_CARTESIAN_TUSER=0,C_HAS_S_AXIS_CARTESIAN_TLAST=0,C_S_AXIS_CARTESIAN_TDATA_WIDTH=64,C_S_AXIS_CARTESIAN_TUSER_WIDTH=1,C_M_AXIS_DOUT_TDATA_WIDTH=80,C_M_AXIS_DOUT_TUSER_WIDTH=1}";
  attribute downgradeipidentifiedwarnings : string;
  attribute downgradeipidentifiedwarnings of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is "yes";
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "aclk,s_axis_phase_tvalid,s_axis_phase_tdata[31:0],s_axis_cartesian_tvalid,s_axis_cartesian_tdata[63:0],m_axis_dout_tvalid,m_axis_dout_tdata[79:0]";
  attribute x_interface_info : string;
  attribute x_interface_info of aclk : signal is "xilinx.com:signal:clock:1.0 aclk_intf CLK";
  attribute x_interface_mode : string;
  attribute x_interface_mode of aclk : signal is "slave aclk_intf";
  attribute x_interface_parameter : string;
  attribute x_interface_parameter of aclk : signal is "XIL_INTERFACENAME aclk_intf, ASSOCIATED_BUSIF M_AXIS_DOUT:S_AXIS_PHASE:S_AXIS_CARTESIAN, ASSOCIATED_RESET aresetn, ASSOCIATED_CLKEN aclken, FREQ_HZ 1000000, FREQ_TOLERANCE_HZ 0, PHASE 0.0, INSERT_VIP 0";
  attribute x_interface_info of s_axis_phase_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS_PHASE TVALID";
  attribute x_interface_mode of s_axis_phase_tvalid : signal is "slave S_AXIS_PHASE";
  attribute x_interface_parameter of s_axis_phase_tvalid : signal is "XIL_INTERFACENAME S_AXIS_PHASE, TDATA_NUM_BYTES 4, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of s_axis_phase_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS_PHASE TDATA";
  attribute x_interface_info of s_axis_cartesian_tvalid : signal is "xilinx.com:interface:axis:1.0 S_AXIS_CARTESIAN TVALID";
  attribute x_interface_mode of s_axis_cartesian_tvalid : signal is "slave S_AXIS_CARTESIAN";
  attribute x_interface_parameter of s_axis_cartesian_tvalid : signal is "XIL_INTERFACENAME S_AXIS_CARTESIAN, TDATA_NUM_BYTES 8, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of s_axis_cartesian_tdata : signal is "xilinx.com:interface:axis:1.0 S_AXIS_CARTESIAN TDATA";
  attribute x_interface_info of m_axis_dout_tvalid : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DOUT TVALID";
  attribute x_interface_mode of m_axis_dout_tvalid : signal is "master M_AXIS_DOUT";
  attribute x_interface_parameter of m_axis_dout_tvalid : signal is "XIL_INTERFACENAME M_AXIS_DOUT, TDATA_NUM_BYTES 10, TDEST_WIDTH 0, TID_WIDTH 0, TUSER_WIDTH 0, HAS_TREADY 0, HAS_TSTRB 0, HAS_TKEEP 0, HAS_TLAST 0, FREQ_HZ 100000000, PHASE 0.0, LAYERED_METADATA undef, INSERT_VIP 0";
  attribute x_interface_info of m_axis_dout_tdata : signal is "xilinx.com:interface:axis:1.0 M_AXIS_DOUT TDATA";
  attribute x_core_info : string;
  attribute x_core_info of stub : architecture is "cordic_v6_0_24,Vivado 2025.1";
begin
end;
