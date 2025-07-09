//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
//Date        : Wed Jul  9 16:38:11 2025
//Host        : DESKTOP-5G0J4EJ running 64-bit major release  (build 9200)
//Command     : generate_target IFM_bd.bd
//Design      : IFM_bd
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CORE_GENERATION_INFO = "IFM_bd,IP_Integrator,{x_ipVendor=xilinx.com,x_ipLibrary=BlockDiagram,x_ipName=IFM_bd,x_ipVersion=1.00.a,x_ipLanguage=VERILOG,numBlks=1,numReposBlks=1,numNonXlnxBlks=1,numHierBlks=0,maxHierDepth=0,numSysgenBlks=1,numHlsBlks=0,numHdlrefBlks=0,numPkgbdBlks=0,bdsource=SYSGEN,synth_mode=Hierarchical}" *) (* HW_HANDOFF = "IFM_bd.hwdef" *) 
module IFM_bd
   (clk,
    datavalid,
    gateway_out,
    gateway_out1,
    imagpart,
    realpart);
  (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK.CLK CLK" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME CLK.CLK, CLK_DOMAIN IFM_bd_clk, FREQ_HZ 100000000, FREQ_TOLERANCE_HZ 0, INSERT_VIP 0, PHASE 0.0" *) input clk;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.DATAVALID DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.DATAVALID, LAYERED_METADATA undef" *) input [0:0]datavalid;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.GATEWAY_OUT DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.GATEWAY_OUT, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 82} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 18} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}" *) output [81:0]gateway_out;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.GATEWAY_OUT1 DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.GATEWAY_OUT1, LAYERED_METADATA xilinx.com:interface:datatypes:1.0 {DATA {datatype {name {attribs {resolve_type immediate dependency {} format string minimum {} maximum {}} value {}} bitwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 82} bitoffset {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 0} real {fixed {fractwidth {attribs {resolve_type immediate dependency {} format long minimum {} maximum {}} value 18} signed {attribs {resolve_type immediate dependency {} format bool minimum {} maximum {}} value true}}}}}}" *) output [81:0]gateway_out1;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.IMAGPART DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.IMAGPART, LAYERED_METADATA undef" *) input [15:0]imagpart;
  (* X_INTERFACE_INFO = "xilinx.com:signal:data:1.0 DATA.REALPART DATA" *) (* X_INTERFACE_PARAMETER = "XIL_INTERFACENAME DATA.REALPART, LAYERED_METADATA undef" *) input [15:0]realpart;

  wire clk;
  wire [0:0]datavalid;
  wire [81:0]gateway_out;
  wire [81:0]gateway_out1;
  wire [15:0]imagpart;
  wire [15:0]realpart;

  IFM_bd_IFM_1_0 IFM_1
       (.clk(clk),
        .datavalid(datavalid),
        .gateway_out(gateway_out),
        .gateway_out1(gateway_out1),
        .imagpart(imagpart),
        .realpart(realpart));
endmodule
