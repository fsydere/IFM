`timescale 1 ns / 10 ps
// Generated from Simulink block 
module ifm_stub (
  input [1-1:0] datavalid,
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk
);
  ifm sysgen_dut (
    .datavalid(datavalid),
    .imagpart(imagpart),
    .realpart(realpart),
    .clk(clk)
  );
endmodule
