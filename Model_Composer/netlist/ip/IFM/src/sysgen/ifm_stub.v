`timescale 1 ns / 10 ps
// Generated from Simulink block 
module ifm_stub (
  input [1-1:0] datavalid,
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk,
  output [82-1:0] gateway_out,
  output [82-1:0] gateway_out1
);
  ifm sysgen_dut (
    .datavalid(datavalid),
    .imagpart(imagpart),
    .realpart(realpart),
    .clk(clk),
    .gateway_out(gateway_out),
    .gateway_out1(gateway_out1)
  );
endmodule
