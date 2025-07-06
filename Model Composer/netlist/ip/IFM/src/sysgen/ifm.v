`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif

`timescale 1 ns / 10 ps
// Generated from Simulink block Trial/IFM_struct
module ifm_struct (
  input [1-1:0] datavalid,
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk_1,
  input ce_1
);
  wire [16-1:0] imagpart_net;
  wire [1-1:0] datavalid_net;
  wire ce_net;
  wire clk_net;
  wire [16-1:0] realpart_net;
  assign datavalid_net = datavalid;
  assign imagpart_net = imagpart;
  assign realpart_net = realpart;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block 
module ifm_default_clock_driver (
  input ifm_sysclk,
  input ifm_sysce,
  input ifm_sysclr,
  output ifm_clk1,
  output ifm_ce1
);
  xlclockdriver #(
    .period(1),
    .log_2_period(1)
  )
  clockdriver (
    .sysclk(ifm_sysclk),
    .sysce(ifm_sysce),
    .sysclr(ifm_sysclr),
    .clk(ifm_clk1),
    .ce(ifm_ce1)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block 
(* core_generation_info = "ifm,sysgen_core_2025_1,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplus,part=xczu9eg,speed=-2-e,package=ffvb1156,synthesis_language=verilog,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=1,interface_doc=0,ce_clr=0,clock_period=3.33333,system_simulink_period=3.33333e-09,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.0002,accum=3,addsub=1,cmult=3,constant=2,convert=20,cordic_v6_0=2,counter=3,delay=27,divide=3,inv=3,logical=5,mult=2,negate=2,product_macro=2,register=2,relational=2,}" *)
module ifm (
  input [1-1:0] datavalid,
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk
);
  wire ce_1_net;
  wire clk_1_net;
  ifm_default_clock_driver ifm_default_clock_driver (
    .ifm_sysclk(clk),
    .ifm_sysce(1'b1),
    .ifm_sysclr(1'b0),
    .ifm_clk1(clk_1_net),
    .ifm_ce1(ce_1_net)
  );
  ifm_struct ifm_struct (
    .datavalid(datavalid),
    .imagpart(imagpart),
    .realpart(realpart),
    .clk_1(clk_1_net),
    .ce_1(ce_1_net)
  );
endmodule
