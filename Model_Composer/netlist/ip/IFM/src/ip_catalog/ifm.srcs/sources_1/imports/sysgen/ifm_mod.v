`timescale 1 ns / 10 ps
// Generated from Simulink block 
module ifm_stub (
  input [1-1:0] datavalid,
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk,
  output [82-1:0] estimated_frequency_2_delay,
  output [82-1:0] estimated_frequency_4_delay,
  output [1-1:0] estimated_frequency_2_delay_valid,
  output [1-1:0] estimated_frequency_4_delay_valid
);
  IFM_0 sysgen_dut (
    .datavalid(datavalid),
    .imagpart(imagpart),
    .realpart(realpart),
    .clk(clk),
    .estimated_frequency_2_delay(estimated_frequency_2_delay),
    .estimated_frequency_4_delay(estimated_frequency_4_delay),
    .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid),
    .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid)
  );
endmodule
