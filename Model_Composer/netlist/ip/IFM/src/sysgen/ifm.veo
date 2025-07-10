  ifm sysgen_dut (
    .datavalid(datavalid),
    .imagpart(imagpart),
    .realpart(realpart),
    .clk(clk),
    .estimated_frequency_2_delay(estimated_frequency_2_delay),
    .estimated_frequency_4_delay(estimated_frequency_4_delay),
    .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid),
    .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid)
  );
