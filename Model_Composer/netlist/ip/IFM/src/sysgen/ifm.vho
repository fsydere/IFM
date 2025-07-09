  sysgen_dut : entity xil_defaultlib.ifm 
  port map (
    datavalid => datavalid,
    imagpart => imagpart,
    realpart => realpart,
    clk => clk,
    gateway_out => gateway_out,
    gateway_out1 => gateway_out1
  );
