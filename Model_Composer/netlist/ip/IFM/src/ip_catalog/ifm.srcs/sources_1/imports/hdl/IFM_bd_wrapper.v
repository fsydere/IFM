//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2025.1 (win64) Build 6140274 Thu May 22 00:12:29 MDT 2025
//Date        : Fri Jul 11 14:27:41 2025
//Host        : fsydere running 64-bit major release  (build 9200)
//Command     : generate_target IFM_bd_wrapper.bd
//Design      : IFM_bd_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module IFM_bd_wrapper
   (clk,
    datavalid,
    estimated_frequency_2_delay,
    estimated_frequency_2_delay_valid,
    estimated_frequency_4_delay,
    estimated_frequency_4_delay_valid,
    imagpart,
    realpart);
  input clk;
  input [0:0]datavalid;
  output [81:0]estimated_frequency_2_delay;
  output [0:0]estimated_frequency_2_delay_valid;
  output [81:0]estimated_frequency_4_delay;
  output [0:0]estimated_frequency_4_delay_valid;
  input [15:0]imagpart;
  input [15:0]realpart;

  wire clk;
  wire [0:0]datavalid;
  wire [81:0]estimated_frequency_2_delay;
  wire [0:0]estimated_frequency_2_delay_valid;
  wire [81:0]estimated_frequency_4_delay;
  wire [0:0]estimated_frequency_4_delay_valid;
  wire [15:0]imagpart;
  wire [15:0]realpart;

  IFM_bd IFM_bd_i
       (.clk(clk),
        .datavalid(datavalid),
        .estimated_frequency_2_delay(estimated_frequency_2_delay),
        .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid),
        .estimated_frequency_4_delay(estimated_frequency_4_delay),
        .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid),
        .imagpart(imagpart),
        .realpart(realpart));
endmodule
