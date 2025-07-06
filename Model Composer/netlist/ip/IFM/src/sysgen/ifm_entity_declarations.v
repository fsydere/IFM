//-----------------------------------------------------------------
// Vitis Model Composer version 2025.1 Verilog source file.
//
// Copyright(C) 1995-2022 by Xilinx, Inc. All rights reserved.
// Copyright(C) 2022-2025 by Advanced Micro Devices, Inc. All rights reserved.
//
// This text/file contains proprietary, confidential information of Xilinx,
// Inc., is distributed under license from Xilinx, Inc., and may be used,
// copied and/or disclosed only pursuant to the terms of a valid license
// agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
// this text/file solely for design, simulation, implementation and
// creation of design files limited to Xilinx devices or technologies.
// Use with non-Xilinx devices or technologies is expressly prohibited
// and immediately terminates your license unless covered by a separate
// agreement.
//
// Xilinx is providing this design, code, or information "as is" solely
// for use in developing programs and solutions for Xilinx devices.  By
// providing this design, code, or information as one possible
// implementation of this feature, application or standard, Xilinx is
// making no representation that this implementation is free from any
// claims of infringement.  You are responsible for obtaining any rights
// you may require for your implementation.  Xilinx expressly disclaims
// any warranty whatsoever with respect to the adequacy of the
// implementation, including but not limited to warranties of
// merchantability or fitness for a particular purpose.
//
// Xilinx products are not intended for use in life support appliances,
// devices, or systems.  Use in such applications is expressly prohibited.
//
// Any modifications that are made to the source code are done at the user's
// sole risk and will be unsupported.
//
// This copyright and support notice must be retained as part of this
// text at all times.
//-----------------------------------------------------------------

`include "conv_pkg.v"
`timescale 1 ns / 10 ps


module ifm_xlconvert (din, clk, ce, clr, en, dout);

//Parameter Definitions
   parameter din_width= 16;
   parameter din_bin_pt= 4;
   parameter din_arith= `xlUnsigned;
   parameter dout_width= 8;
   parameter dout_bin_pt= 2;
   parameter dout_arith= `xlUnsigned;
   parameter en_width = 1;
   parameter en_bin_pt = 0;
   parameter en_arith = `xlUnsigned;
   parameter bool_conversion = 0;
   parameter latency = 0;
   parameter quantization= `xlTruncate;
   parameter overflow= `xlWrap;

//Port Declartions
   input [din_width-1:0] din;
   input clk, ce, clr;
   input [en_width-1:0] en;
   output [dout_width-1:0] dout;

//Wire Declartions
   wire [dout_width-1:0]   result;
   wire internal_ce;
   assign internal_ce = ce & en[0];

generate
 if (bool_conversion == 1)
    begin:bool_converion_generate
       assign result = din;
    end
 else
    begin:std_conversion
       convert_type #(din_width,
                      din_bin_pt,
                      din_arith,
		              dout_width,
                      dout_bin_pt,
                      dout_arith,
                      quantization,
                      overflow)
        conv_udp (.inp(din), .res(result));
    end
endgenerate

generate
if (latency > 0)
     begin:latency_test
	synth_reg # (dout_width, latency)
	  reg1 (
	       .i(result),
	       .ce(internal_ce),
	       .clr(clr),
	       .clk(clk),
	       .o(dout));
     end
else
     begin:latency0
	assign dout = result;
     end
endgenerate

endmodule

`timescale 1 ns / 10 ps
module sysgen_accum_0932bf0451 (
  input [(36 - 1):0] b,
  input [(1 - 1):0] rst,
  input [(1 - 1):0] en,
  output [(64 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire signed [(36 - 1):0] b_17_24;
  wire rst_17_27;
  wire en_17_32;
  reg signed [(64 - 1):0] accum_reg_39_23 = 64'b0000000000000000000000000000000000000000000000000000000000000000;
  wire accum_reg_39_23_rst;
  wire accum_reg_39_23_en;
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b1;
  wire signed [(64 - 1):0] cast_49_42;
  reg signed [(65 - 1):0] accum_reg_join_45_1;
  reg accum_reg_join_45_1_en;
  reg accum_reg_join_45_1_rst;
  assign b_17_24 = b;
  assign rst_17_27 = rst;
  assign en_17_32 = en;
  always @(posedge clk)
    begin:proc_accum_reg_39_23
      if (((ce == 1'b1) && (accum_reg_39_23_rst == 1'b1)))
        begin
          accum_reg_39_23 <= 64'b0000000000000000000000000000000000000000000000000000000000000000;
        end
      else if (((ce == 1'b1) && (accum_reg_39_23_en == 1'b1)))
        begin
          accum_reg_39_23 <= accum_reg_39_23 + cast_49_42;
        end
    end
  assign cast_49_42 = {{28{b_17_24[35]}}, b_17_24[35:0]};
  always @(accum_reg_39_23 or cast_49_42 or en_17_32 or rst_17_27)
    begin:proc_if_45_1
      if (rst_17_27)
        begin
          accum_reg_join_45_1_rst = 1'b1;
        end
      else if (en_17_32)
        begin
          accum_reg_join_45_1_rst = 1'b0;
        end
      else 
        begin
          accum_reg_join_45_1_rst = 1'b0;
        end
      if (en_17_32)
        begin
          accum_reg_join_45_1_en = 1'b1;
        end
      else 
        begin
          accum_reg_join_45_1_en = 1'b0;
        end
    end
  assign accum_reg_39_23_rst = accum_reg_join_45_1_rst;
  assign accum_reg_39_23_en = accum_reg_join_45_1_en;
  assign q = accum_reg_39_23;
endmodule
`timescale 1 ns / 10 ps
module ifm_xldelay #(parameter width = -1, latency = -1, reg_retiming = 0, reset = 0)
  (input [width-1:0] d,
   input ce, clk, en, rst,
   output [width-1:0] q);

generate
  if ((latency == 0) || ((reg_retiming == 0) && (reset == 0)))
  begin:srl_delay
    synth_reg # (width, latency)
      reg1 (
        .i(d),
        .ce(ce & en),
        .clr(1'b0),
        .clk(clk),
        .o(q));
  end

  if ((latency>=1) && ((reg_retiming) || (reset)))
  begin:reg_delay
    synth_reg_reg # (width, latency)
      reg2 (
        .i(d),
        .ce(ce & en),
        .clr(rst),
        .clk(clk),
        .o(q));
  end
endgenerate
endmodule
`timescale 1 ns / 10 ps
module sysgen_inverter_c9b1913825 (
  input [(1 - 1):0] ip,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire ip_1_26;
  reg op_mem_22_20[0:(1 - 1)];
  initial
    begin
      op_mem_22_20[0] = 1'b0;
    end
  wire op_mem_22_20_front_din;
  wire op_mem_22_20_back;
  wire op_mem_22_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  wire internal_ip_12_1_bitnot;
  assign ip_1_26 = ip;
  assign op_mem_22_20_back = op_mem_22_20[0];
  always @(posedge clk)
    begin:proc_op_mem_22_20
      integer i;
      if (((ce == 1'b1) && (op_mem_22_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_22_20[0] <= op_mem_22_20_front_din;
        end
    end
  assign internal_ip_12_1_bitnot = ~ip_1_26;
  assign op_mem_22_20_push_front_pop_back_en = 1'b0;
  assign op = internal_ip_12_1_bitnot;
endmodule
`timescale 1 ns / 10 ps
module sysgen_logical_5f99e03888 (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign fully_2_1_bit = d0_1_24 & d1_1_27;
  assign y = fully_2_1_bit;
endmodule
`timescale 1 ns / 10 ps
module ifm_xlregister (d, rst, en, ce, clk, q);
   parameter d_width = 5;
   parameter init_value = 'b0;

   input [d_width-1:0] d;
   input rst, en, ce, clk;
   output [d_width-1:0] q;

   wire internal_clr, internal_ce;

   assign internal_clr = rst & ce;
   assign internal_ce  = ce & en;

   synth_reg_w_init #(.width(d_width),
                      .init_index(2),
                      .init_value(init_value),
                      .latency(1))
   synth_reg_inst(.i(d),
                  .ce(internal_ce),
                  .clr(internal_clr),
                  .clk(clk),
                  .o(q));
endmodule

`timescale 1 ns / 10 ps
module sysgen_negate_edd45ee5a2 (
  input [(16 - 1):0] ip,
  output [(17 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] ip_18_25;
  localparam signed [(17 - 1):0] const_value = 17'sb00000000000000000;
  reg signed [(17 - 1):0] op_mem_48_20[0:(1 - 1)];
  initial
    begin
      op_mem_48_20[0] = 17'b00000000000000000;
    end
  wire signed [(17 - 1):0] op_mem_48_20_front_din;
  wire signed [(17 - 1):0] op_mem_48_20_back;
  wire op_mem_48_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b0;
  wire signed [(17 - 1):0] cast_35_24;
  wire signed [(17 - 1):0] internal_ip_35_9_neg;
  reg signed [(17 - 1):0] internal_ip_join_30_1;
  localparam signed [(17 - 1):0] const_value_x_000002 = 17'sb00000000000000000;
  assign ip_18_25 = ip;
  assign op_mem_48_20_back = op_mem_48_20[0];
  always @(posedge clk)
    begin:proc_op_mem_48_20
      integer i;
      if (((ce == 1'b1) && (op_mem_48_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_48_20[0] <= op_mem_48_20_front_din;
        end
    end
  assign cast_35_24 = {{1{ip_18_25[15]}}, ip_18_25[15:0]};
  assign internal_ip_35_9_neg = -cast_35_24;
  always @(internal_ip_35_9_neg)
    begin:proc_if_30_1
      if (1'b0)
        begin
          internal_ip_join_30_1 = const_value_x_000002;
        end
      else 
        begin
          internal_ip_join_30_1 = internal_ip_35_9_neg;
        end
    end
  assign op_mem_48_20_front_din = internal_ip_join_30_1;
  assign op_mem_48_20_push_front_pop_back_en = 1'b1;
  assign op = op_mem_48_20_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_logical_2283bfdd69 (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  input [(1 - 1):0] d2,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire d2_1_30;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign fully_2_1_bit = d0_1_24 & d1_1_27 & d2_1_30;
  assign y = fully_2_1_bit;
endmodule
`timescale 1 ns / 10 ps
module sysgen_logical_f09796fb8a (
  input [(1 - 1):0] d0,
  input [(1 - 1):0] d1,
  input [(1 - 1):0] d2,
  input [(1 - 1):0] d3,
  input [(1 - 1):0] d4,
  output [(1 - 1):0] y,
  input clk,
  input ce,
  input clr);
  wire d0_1_24;
  wire d1_1_27;
  wire d2_1_30;
  wire d3_1_33;
  wire d4_1_36;
  wire fully_2_1_bit;
  assign d0_1_24 = d0;
  assign d1_1_27 = d1;
  assign d2_1_30 = d2;
  assign d3_1_33 = d3;
  assign d4_1_36 = d4;
  assign fully_2_1_bit = d0_1_24 & d1_1_27 & d2_1_30 & d3_1_33 & d4_1_36;
  assign y = fully_2_1_bit;
endmodule
`timescale 1 ns / 10 ps
module sysgen_constant_117d343824 (
  output [(15 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 15'b111010100101111;
endmodule
`timescale 1 ns / 10 ps
module sysgen_constant_18e0b164c6 (
  output [(49 - 1):0] op,
  input clk,
  input ce,
  input clr);
  assign op = 49'b0000011101010011000000000000000000000000000000000;
endmodule
`timescale 1 ns / 10 ps
module sysgen_delay_276c9536e2 (
  input [(1 - 1):0] d,
  output [(1 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire d_1_22;
  reg op_mem_20_24[0:(3 - 1)];
  initial
    begin
      op_mem_20_24[0] = 1'b0;
      op_mem_20_24[1] = 1'b0;
      op_mem_20_24[2] = 1'b0;
    end
  wire op_mem_20_24_front_din;
  wire op_mem_20_24_back;
  wire op_mem_20_24_push_front_pop_back_en;
  localparam [(2 - 1):0] const_value = 2'b11;
  assign d_1_22 = d;
  assign op_mem_20_24_back = op_mem_20_24[2];
  always @(posedge clk)
    begin:proc_op_mem_20_24
      integer i;
      if (((ce == 1'b1) && (op_mem_20_24_push_front_pop_back_en == 1'b1)))
        begin
          for (i=2; i>=1; i=i-1)
            begin
              op_mem_20_24[i] <= op_mem_20_24[i-1];
            end
          op_mem_20_24[0] <= op_mem_20_24_front_din;
        end
    end
  assign op_mem_20_24_front_din = d_1_22;
  assign op_mem_20_24_push_front_pop_back_en = 1'b1;
  assign q = op_mem_20_24_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_delay_090567c2fd (
  input [(1 - 1):0] d,
  output [(1 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire d_1_22;
  reg op_mem_20_24[0:(1 - 1)];
  initial
    begin
      op_mem_20_24[0] = 1'b0;
    end
  wire op_mem_20_24_front_din;
  wire op_mem_20_24_back;
  wire op_mem_20_24_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  assign d_1_22 = d;
  assign op_mem_20_24_back = op_mem_20_24[0];
  always @(posedge clk)
    begin:proc_op_mem_20_24
      integer i;
      if (((ce == 1'b1) && (op_mem_20_24_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_20_24[0] <= op_mem_20_24_front_din;
        end
    end
  assign op_mem_20_24_front_din = d_1_22;
  assign op_mem_20_24_push_front_pop_back_en = 1'b1;
  assign q = op_mem_20_24_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_relational_e29186f284 (
  input [(48 - 1):0] a,
  input [(96 - 1):0] b,
  input [(1 - 1):0] en,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire signed [(48 - 1):0] a_1_31;
  wire signed [(96 - 1):0] b_1_34;
  wire en_1_37;
  reg op_mem_45_22[0:(1 - 1)];
  initial
    begin
      op_mem_45_22[0] = 1'b0;
    end
  wire op_mem_45_22_front_din;
  wire op_mem_45_22_back;
  wire op_mem_45_22_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value = 1'b1;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b0;
  reg signed [(48 - 1):0] a_join_13_3;
  localparam signed [(48 - 1):0] const_value_x_000001 = 48'sb000000000000000000000000000000000000000000000000;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b0;
  reg signed [(96 - 1):0] b_join_16_3;
  localparam signed [(96 - 1):0] const_value_x_000003 = 96'sb000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000;
  wire signed [(96 - 1):0] cast_32_12;
  wire result_32_3_rel;
  reg op_mem_shift_join_47_3;
  reg op_mem_shift_join_47_3_en;
  assign a_1_31 = a;
  assign b_1_34 = b;
  assign en_1_37 = en;
  assign op_mem_45_22_back = op_mem_45_22[0];
  always @(posedge clk)
    begin:proc_op_mem_45_22
      integer i;
      if (((ce == 1'b1) && (op_mem_45_22_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_45_22[0] <= op_mem_45_22_front_din;
        end
    end
  always @(a_1_31)
    begin:proc_if_13_3
      if (1'b0)
        begin
          a_join_13_3 = const_value_x_000001;
        end
      else 
        begin
          a_join_13_3 = a_1_31;
        end
    end
  always @(b_1_34)
    begin:proc_if_16_3
      if (1'b0)
        begin
          b_join_16_3 = const_value_x_000003;
        end
      else 
        begin
          b_join_16_3 = b_1_34;
        end
    end
  assign cast_32_12 = {{18{a_join_13_3[47]}}, a_join_13_3[47:0], 30'b000000000000000000000000000000};
  assign result_32_3_rel = cast_32_12 >= b_join_16_3;
  always @(en_1_37 or result_32_3_rel)
    begin:proc_if_47_3
      if (en_1_37)
        begin
          op_mem_shift_join_47_3_en = 1'b1;
        end
      else 
        begin
          op_mem_shift_join_47_3_en = 1'b0;
        end
      op_mem_shift_join_47_3 = result_32_3_rel;
    end
  assign op_mem_45_22_front_din = op_mem_shift_join_47_3;
  assign op_mem_45_22_push_front_pop_back_en = op_mem_shift_join_47_3_en;
  assign op = op_mem_45_22_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_relational_634c61e574 (
  input [(15 - 1):0] a,
  input [(15 - 1):0] b,
  output [(1 - 1):0] op,
  input clk,
  input ce,
  input clr);
  wire [(15 - 1):0] a_1_31;
  wire [(15 - 1):0] b_1_34;
  localparam [(1 - 1):0] const_value = 1'b1;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b0;
  reg [(15 - 1):0] a_join_13_3;
  localparam [(15 - 1):0] const_value_x_000001 = 15'b000000000000000;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b0;
  reg [(15 - 1):0] b_join_16_3;
  localparam [(15 - 1):0] const_value_x_000003 = 15'b000000000000000;
  wire result_22_3_rel;
  assign a_1_31 = a;
  assign b_1_34 = b;
  always @(a_1_31)
    begin:proc_if_13_3
      if (1'b0)
        begin
          a_join_13_3 = const_value_x_000001;
        end
      else 
        begin
          a_join_13_3 = a_1_31;
        end
    end
  always @(b_1_34)
    begin:proc_if_16_3
      if (1'b0)
        begin
          b_join_16_3 = const_value_x_000003;
        end
      else 
        begin
          b_join_16_3 = b_1_34;
        end
    end
  assign result_22_3_rel = a_join_13_3 == b_join_16_3;
  assign op = result_22_3_rel;
endmodule
`timescale 1 ns / 10 ps
module sysgen_mult_97eaf9b52a (
  input [(16 - 1):0] a,
  input [(16 - 1):0] b,
  output [(32 - 1):0] p,
  input clk,
  input ce,
  input clr);
  wire signed [(16 - 1):0] a_1_22;
  wire signed [(16 - 1):0] b_1_25;
  localparam signed [(32 - 1):0] const_value = 32'sb00000000000000000000000000000000;
  reg signed [(32 - 1):0] op_mem_65_20[0:(3 - 1)];
  initial
    begin
      op_mem_65_20[0] = 32'b00000000000000000000000000000000;
      op_mem_65_20[1] = 32'b00000000000000000000000000000000;
      op_mem_65_20[2] = 32'b00000000000000000000000000000000;
    end
  wire signed [(32 - 1):0] op_mem_65_20_front_din;
  wire signed [(32 - 1):0] op_mem_65_20_back;
  wire op_mem_65_20_push_front_pop_back_en;
  localparam [(2 - 1):0] const_value_x_000000 = 2'b11;
  localparam [(6 - 1):0] const_value_x_000001 = 6'b100000;
  localparam [(5 - 1):0] const_value_x_000002 = 5'b11110;
  wire signed [(32 - 1):0] mult_46_56;
  assign a_1_22 = a;
  assign b_1_25 = b;
  assign op_mem_65_20_back = op_mem_65_20[2];
  always @(posedge clk)
    begin:proc_op_mem_65_20
      integer i;
      if (((ce == 1'b1) && (op_mem_65_20_push_front_pop_back_en == 1'b1)))
        begin
          for (i=2; i>=1; i=i-1)
            begin
              op_mem_65_20[i] <= op_mem_65_20[i-1];
            end
          op_mem_65_20[0] <= op_mem_65_20_front_din;
        end
    end
  assign mult_46_56 = (a_1_22 * b_1_25);
  assign op_mem_65_20_front_din = mult_46_56;
  assign op_mem_65_20_push_front_pop_back_en = 1'b1;
  assign p = op_mem_65_20_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_addsub_4ae43238ba (
  input [(32 - 1):0] a,
  input [(32 - 1):0] b,
  output [(32 - 1):0] s,
  input clk,
  input ce,
  input clr);
  wire signed [(32 - 1):0] a_17_32;
  wire signed [(32 - 1):0] b_17_35;
  localparam [(32 - 1):0] const_value = 32'b00000000000000000000000000000000;
  reg [(32 - 1):0] op_mem_91_20[0:(1 - 1)];
  initial
    begin
      op_mem_91_20[0] = 32'b00000000000000000000000000000000;
    end
  wire [(32 - 1):0] op_mem_91_20_front_din;
  wire [(32 - 1):0] op_mem_91_20_back;
  wire op_mem_91_20_push_front_pop_back_en;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b0;
  reg [(1 - 1):0] cout_mem_92_22[0:(1 - 1)];
  initial
    begin
      cout_mem_92_22[0] = 1'b0;
    end
  wire [(1 - 1):0] cout_mem_92_22_front_din;
  wire [(1 - 1):0] cout_mem_92_22_back;
  wire cout_mem_92_22_push_front_pop_back_en;
  wire [(3 - 1):0] prev_mode_93_22_next;
  wire [(3 - 1):0] prev_mode_93_22;
  wire [(3 - 1):0] prev_mode_93_22_reg_i;
  wire [(3 - 1):0] prev_mode_93_22_reg_o;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000002 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000003 = 1'b0;
  localparam [(1 - 1):0] const_value_x_000004 = 1'b0;
  wire signed [(33 - 1):0] cast_69_18;
  wire signed [(33 - 1):0] cast_69_22;
  wire signed [(33 - 1):0] internal_s_69_5_addsub;
  localparam [(1 - 1):0] const_value_x_000005 = 1'b0;
  wire [(32 - 1):0] cast_internal_s_83_3_convert;
  localparam [(1 - 1):0] const_value_x_000006 = 1'b0;
  localparam [(3 - 1):0] const_value_x_000007 = 3'b000;
  assign a_17_32 = a;
  assign b_17_35 = b;
  assign op_mem_91_20_back = op_mem_91_20[0];
  always @(posedge clk)
    begin:proc_op_mem_91_20
      integer i;
      if (((ce == 1'b1) && (op_mem_91_20_push_front_pop_back_en == 1'b1)))
        begin
          op_mem_91_20[0] <= op_mem_91_20_front_din;
        end
    end
  assign cout_mem_92_22_back = cout_mem_92_22[0];
  always @(posedge clk)
    begin:proc_cout_mem_92_22
      integer i_x_000000;
      if (((ce == 1'b1) && (cout_mem_92_22_push_front_pop_back_en == 1'b1)))
        begin
          cout_mem_92_22[0] <= cout_mem_92_22_front_din;
        end
    end
  assign prev_mode_93_22_reg_i = prev_mode_93_22_next;
  assign prev_mode_93_22 = prev_mode_93_22_reg_o;
  defparam prev_mode_93_22_reg_inst.init_index = 2;
  defparam prev_mode_93_22_reg_inst.init_value = 3'b010;
  defparam prev_mode_93_22_reg_inst.latency = 1;
  defparam prev_mode_93_22_reg_inst.width = 3;
  synth_reg_w_init prev_mode_93_22_reg_inst(.ce(ce), .clk(clk), .clr(clr), .i(prev_mode_93_22_reg_i), .o(prev_mode_93_22_reg_o));
  assign cast_69_18 = {{1{a_17_32[31]}}, a_17_32[31:0]};
  assign cast_69_22 = {{1{b_17_35[31]}}, b_17_35[31:0]};
  assign internal_s_69_5_addsub = cast_69_18 + cast_69_22;
  assign cast_internal_s_83_3_convert = {internal_s_69_5_addsub[31:0]};
  assign op_mem_91_20_front_din = cast_internal_s_83_3_convert;
  assign op_mem_91_20_push_front_pop_back_en = 1'b1;
  assign cout_mem_92_22_front_din = const_value_x_000006;
  assign cout_mem_92_22_push_front_pop_back_en = 1'b1;
  assign prev_mode_93_22_next = const_value_x_000007;
  assign s = op_mem_91_20_back;
endmodule
`timescale 1 ns / 10 ps
module sysgen_accum_122e1effc2 (
  input [(32 - 1):0] b,
  input [(1 - 1):0] en,
  output [(48 - 1):0] q,
  input clk,
  input ce,
  input clr);
  wire [(32 - 1):0] b_17_24;
  wire en_17_32;
  reg [(48 - 1):0] accum_reg_39_23 = 48'b000000000000000000000000000000000000000000000000;
  wire accum_reg_39_23_en;
  localparam [(1 - 1):0] const_value = 1'b0;
  localparam [(1 - 1):0] const_value_x_000000 = 1'b1;
  localparam [(1 - 1):0] const_value_x_000001 = 1'b1;
  wire [(48 - 1):0] cast_49_42;
  reg [(49 - 1):0] accum_reg_join_45_1;
  reg accum_reg_join_45_1_en;
  assign b_17_24 = b;
  assign en_17_32 = en;
  always @(posedge clk)
    begin:proc_accum_reg_39_23
      if (((ce == 1'b1) && (accum_reg_39_23_en == 1'b1)))
        begin
          accum_reg_39_23 <= accum_reg_39_23 + cast_49_42;
        end
    end
  assign cast_49_42 = {16'b0000000000000000, b_17_24[31:0]};
  always @(accum_reg_39_23 or cast_49_42 or en_17_32)
    begin:proc_if_45_1
      if (en_17_32)
        begin
          accum_reg_join_45_1_en = 1'b1;
        end
      else 
        begin
          accum_reg_join_45_1_en = 1'b0;
        end
    end
  assign accum_reg_39_23_en = accum_reg_join_45_1_en;
  assign q = accum_reg_39_23;
endmodule
module ifm_xlcmult (a, ce, clr, clk, core_ce, core_clr, core_clk, rst, en, p);
 
 parameter core_name0= "";
 parameter a_width= 4;
 parameter a_bin_pt= 2;
 parameter a_arith= `xlSigned;
 parameter b_width= 4;
 parameter b_bin_pt= 2;
 parameter b_arith= `xlSigned;
 parameter p_width= 8;
 parameter p_bin_pt= 2;
 parameter p_arith= `xlSigned;
 parameter rst_width= 1;
 parameter rst_bin_pt= 0;
 parameter rst_arith= `xlUnsigned;
 parameter en_width= 1;
 parameter en_bin_pt= 0;
 parameter en_arith= `xlUnsigned;
 parameter multsign= `xlSigned;
 parameter quantization= `xlTruncate;
 parameter overflow= `xlWrap;
 parameter extra_registers= 0;
 parameter c_a_width= 7;
 parameter c_b_width= 7;
 parameter c_a_type= 0;
 parameter c_b_type= 0;
 parameter c_type= 0;
 parameter const_bin_pt= 1;
 parameter c_output_width= 16;
 parameter zero_const = 0;
 
 input [a_width-1:0] a;
 input  ce;
 input  clr;
 input  clk;
 input  core_ce;
 input  core_clr;
 input  core_clk;
 input [rst_width-1:0] rst;
 input [en_width-1:0] en;
 output [p_width-1:0] p;
 
 wire [c_a_width-1:0] #0.1 tmp_a;
 wire [c_output_width-1:0] tmp_p;
 wire [p_width-1:0] conv_p;
 wire  real_a,real_p;
 wire  nd;
 wire  internal_ce;
 wire  internal_clr;
 wire  internal_core_ce;
 
 assign internal_ce = ce & en[0];
 assign internal_core_ce = core_ce & en[0];
 assign internal_clr = (clr | rst[0]) & ce;
 assign nd = internal_ce;
 
 zero_ext # (a_width,c_a_width) zero_ext_a(.inp(a),.res(tmp_a));
 
 convert_type # (c_output_width, a_bin_pt+b_bin_pt, multsign,
                            p_width, p_bin_pt, p_arith, quantization, overflow)
 convert_p(.inp(tmp_p),.res(conv_p));
 
 generate



if (core_name0 == "ifm_mult_gen_v12_0_i0") 
     begin:comp0
ifm_mult_gen_v12_0_i0 core_instance0 ( 
      .SCLR(internal_clr),
      .CLK(clk),
      .CE(internal_ce),
      .P(tmp_p),
      .A(tmp_a) 
       ); 
     end 

if (core_name0 == "ifm_mult_gen_v12_0_i1") 
     begin:comp1
ifm_mult_gen_v12_0_i1 core_instance1 ( 
      .SCLR(internal_clr),
      .CLK(clk),
      .CE(internal_ce),
      .P(tmp_p),
      .A(tmp_a) 
       ); 
     end 

if (core_name0 == "ifm_mult_gen_v12_0_i2") 
     begin:comp2
ifm_mult_gen_v12_0_i2 core_instance2 ( 
      .P(tmp_p),
      .A(tmp_a) 
       ); 
     end 

 endgenerate
 
 generate
  if ((extra_registers > 0) && (zero_const == 0))
      begin:latency_gt_0
 	synth_reg # (p_width, extra_registers) 
 	  reg1 (
 	       .i(conv_p), 
 	       .ce(internal_ce),
 	       .clr(internal_clr),
 	       .clk(clk),
 	       .o(p)
                );
      end
     
    if ((extra_registers == 0) && (zero_const == 0))
      begin:latency_eq_0
 	assign p = conv_p;
      end
 
    if (zero_const == 1)
      begin:zero_constant
 	assign p = {p_width{1'b0}};
      end
 endgenerate
 
 endmodule

module ifm_xlcounter_free  (ce, clr, clk, op, up, load, din, en, rst);
 
 parameter core_name0= "";
 parameter op_width= 5;
 parameter op_arith= `xlSigned;
 
 input ce, clr, clk;
 input up, load;
 input [op_width-1:0] din;
 input en, rst;
 output [op_width-1:0] op;
 
 parameter [(8*op_width)-1:0] oneStr = { op_width{"1"}}; 
 
 wire  core_sinit;
 wire  core_ce;
 wire [op_width-1:0] op_net;
 
    assign core_ce = ce & en;
    assign core_sinit = (clr | rst) & ce;
    assign op = op_net;
 
 generate



if (core_name0 == "ifm_c_counter_binary_v12_0_i0") 
     begin:comp0
ifm_c_counter_binary_v12_0_i0 core_instance0 ( 
        .CLK(clk),
        .CE(core_ce),
        .SINIT(core_sinit),
        .Q(op_net) 
       ); 
     end 

endgenerate 
 endmodule
module ifm_xlcounter_limit (ce, clr, clk, op, up, en, rst);
 
 parameter core_name0= "";
 parameter op_width= 5;
 parameter op_arith= `xlSigned;
 parameter cnt_63_48 = 0;
 parameter cnt_47_32 = 0;
 parameter cnt_31_16 = 0;
 parameter cnt_15_0  = 0;
 parameter count_limited= 0;
 
    input  ce, clr, clk;
    input rst, en;  
    input up;
    output [op_width-1:0] op;
 
 parameter [63:0] cnt_to = { cnt_63_48[15:0], cnt_47_32[15:0], cnt_31_16[15:0], cnt_15_0[15:0]};
 parameter [(8*op_width)-1:0] oneStr = { op_width{"1"}}; 
    
 reg op_thresh0;
 wire core_sinit, core_ce;
 wire rst_overrides_en;
 wire [op_width-1:0] op_net;
 
    assign op = op_net;
    assign core_ce = ce & en;
    assign rst_overrides_en = rst | en;
    
 generate
 
    if (count_limited == 1)
      begin :limit
 	always @(op_net)
 	  begin:eq_cnt_to
 	     op_thresh0 = (op_net == cnt_to[op_width-1:0])? 1'b1 : 1'b0;
 	  end
         assign core_sinit = (op_thresh0 | clr | rst) & ce & rst_overrides_en;
      end
    if (count_limited == 0)
      begin :no_limit
 	assign core_sinit = (clr | rst) & ce & rst_overrides_en;
      end



if (core_name0 == "ifm_c_counter_binary_v12_0_i1") 
     begin:comp0
ifm_c_counter_binary_v12_0_i1 core_instance0 ( 
        .CLK(clk),
        .CE(core_ce),
        .SINIT(core_sinit),
        .Q(op_net) 
       ); 
     end 

endgenerate
 
 endmodule


`timescale 1 ns / 10 ps
module  xldivider_generator_35fbedb0beb337359c74de660051a815 (a,a_tready,a_tvalid,b,b_tready,b_tvalid,ce,clk,op,result_tvalid);

input[63:0] a;
output a_tready;
input a_tvalid;
input[63:0] b;
output b_tready;
input b_tvalid;
input ce;
input clk;
output[81:0] op;
output result_tvalid;
wire[87:0] m_axis_dout_tdata_net;
wire[81:0] m_axis_dout_tdata_shift_in_net;
wire[81:0] m_axis_dout_tdata_shift_out_net;
wire[63:0] s_axis_dividend_tdata_net;
wire[63:0] s_axis_divisor_tdata_net;
  assign m_axis_dout_tdata_shift_in_net = m_axis_dout_tdata_net[81 : 0];
  assign op = m_axis_dout_tdata_shift_out_net;
  assign s_axis_dividend_tdata_net[63 : 0] = a;
  assign s_axis_divisor_tdata_net[63 : 0] = b;
  shift_op # ( .inp_width(82), .result_width(82), .shift_value(0), .shift_dir(0))
shift_op_m_axis_dout_tdata_shift_in_net(.inp(m_axis_dout_tdata_shift_in_net), .res(m_axis_dout_tdata_shift_out_net));

  ifm_div_gen_v5_1_i0 ifm_div_gen_v5_1_i0_instance(
      .aclk(clk),
      .m_axis_dout_tdata(m_axis_dout_tdata_net),
      .m_axis_dout_tvalid(result_tvalid),
      .s_axis_dividend_tdata(s_axis_dividend_tdata_net),
      .s_axis_dividend_tready(a_tready),
      .s_axis_dividend_tvalid(a_tvalid),
      .s_axis_divisor_tdata(s_axis_divisor_tdata_net),
      .s_axis_divisor_tready(b_tready),
      .s_axis_divisor_tvalid(b_tvalid)
    );

 endmodule



`timescale 1 ns / 10 ps
module  xlcordic_4466f51b23fa2d0b5b38a3bbfad0b000 (ce,clk,m_axis_dout_tdata_phase,m_axis_dout_tvalid,s_axis_cartesian_tdata_imag,s_axis_cartesian_tdata_real,s_axis_cartesian_tvalid);

input ce;
input clk;
output[15:0] m_axis_dout_tdata_phase;
output m_axis_dout_tvalid;
input[34:0] s_axis_cartesian_tdata_imag;
input[34:0] s_axis_cartesian_tdata_real;
input s_axis_cartesian_tvalid;
wire[15:0] m_axis_dout_tdata_net;
wire[79:0] s_axis_cartesian_tdata_net;
  assign m_axis_dout_tdata_phase = m_axis_dout_tdata_net[15 : 0];
  assign s_axis_cartesian_tdata_net[79 : 75] = 5'b0;
  assign s_axis_cartesian_tdata_net[74 : 40] = s_axis_cartesian_tdata_imag;
  assign s_axis_cartesian_tdata_net[39 : 35] = 5'b0;
  assign s_axis_cartesian_tdata_net[34 : 0] = s_axis_cartesian_tdata_real;
  ifm_cordic_v6_0_i0 ifm_cordic_v6_0_i0_instance(
      .aclk(clk),
      .aclken(ce),
      .m_axis_dout_tdata(m_axis_dout_tdata_net),
      .m_axis_dout_tvalid(m_axis_dout_tvalid),
      .s_axis_cartesian_tdata(s_axis_cartesian_tdata_net),
      .s_axis_cartesian_tvalid(s_axis_cartesian_tvalid)
    );

 endmodule



`timescale 1 ns / 10 ps
module  xlifm_cmpy_v6_0_i0_90479674483ca40bd316442220988f91 (a_im,a_re,b_im,b_re,ce,clk,p_im,p_re);

input[16:0] a_im;
input[16:0] a_re;
input[16:0] b_im;
input[16:0] b_re;
input ce;
input clk;
output[34:0] p_im;
output[34:0] p_re;
wire[79:0] m_axis_dout_tdata_net;
wire m_axis_dout_tvalid;
wire[47:0] s_axis_a_tdata_net;
wire[47:0] s_axis_b_tdata_net;
  assign p_im = m_axis_dout_tdata_net[74 : 40];
  assign p_re = m_axis_dout_tdata_net[34 : 0];
  assign s_axis_a_tdata_net[47 : 41] = 7'b0;
  assign s_axis_a_tdata_net[40 : 24] = a_im;
  assign s_axis_a_tdata_net[23 : 17] = 7'b0;
  assign s_axis_a_tdata_net[16 : 0] = a_re;
  assign s_axis_b_tdata_net[47 : 41] = 7'b0;
  assign s_axis_b_tdata_net[40 : 24] = b_im;
  assign s_axis_b_tdata_net[23 : 17] = 7'b0;
  assign s_axis_b_tdata_net[16 : 0] = b_re;
  ifm_cmpy_v6_0_i0 ifm_cmpy_v6_0_i0_instance(
      .aclk(clk),
      .aclken(ce),
      .m_axis_dout_tdata(m_axis_dout_tdata_net),
      .m_axis_dout_tvalid(m_axis_dout_tvalid),
      .s_axis_a_tdata(s_axis_a_tdata_net),
      .s_axis_a_tvalid(ce),
      .s_axis_b_tdata(s_axis_b_tdata_net),
      .s_axis_b_tvalid(ce)
    );

 endmodule



`timescale 1 ns / 10 ps
module  xldivider_generator_0c1a81ab8d5b5ba34e262088a482075b (a,a_tready,a_tvalid,b,b_tready,b_tvalid,ce,clk,op,result_tvalid);

input[47:0] a;
output a_tready;
input a_tvalid;
input[48:0] b;
output b_tready;
input b_tvalid;
input ce;
input clk;
output[77:0] op;
output result_tvalid;
wire[79:0] m_axis_dout_tdata_net;
wire[77:0] m_axis_dout_tdata_shift_in_net;
wire[77:0] m_axis_dout_tdata_shift_out_net;
wire[47:0] s_axis_dividend_tdata_net;
wire[55:0] s_axis_divisor_tdata_net;
  assign m_axis_dout_tdata_shift_in_net = m_axis_dout_tdata_net[77 : 0];
  assign op = m_axis_dout_tdata_shift_out_net;
  assign s_axis_dividend_tdata_net[47 : 0] = a;
  assign s_axis_divisor_tdata_net[55 : 49] = 7'b0;
  assign s_axis_divisor_tdata_net[48 : 0] = b;
  shift_op # ( .inp_width(78), .result_width(78), .shift_value(0), .shift_dir(0))
shift_op_m_axis_dout_tdata_shift_in_net(.inp(m_axis_dout_tdata_shift_in_net), .res(m_axis_dout_tdata_shift_out_net));

  ifm_div_gen_v5_1_i1 ifm_div_gen_v5_1_i1_instance(
      .aclk(clk),
      .m_axis_dout_tdata(m_axis_dout_tdata_net),
      .m_axis_dout_tvalid(result_tvalid),
      .s_axis_dividend_tdata(s_axis_dividend_tdata_net),
      .s_axis_dividend_tready(a_tready),
      .s_axis_dividend_tvalid(a_tvalid),
      .s_axis_divisor_tdata(s_axis_divisor_tdata_net),
      .s_axis_divisor_tready(b_tready),
      .s_axis_divisor_tvalid(b_tvalid)
    );

 endmodule



