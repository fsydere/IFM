`ifndef xlConvPkgIncluded
`include "conv_pkg.v"
`endif

`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/2 Delay Avarage Freq
module ifm_2_delay_avarage_freq (
  input [36-1:0] inst_freq,
  input [1-1:0] inst_freq_valid,
  input clk_1,
  input ce_1,
  output [82-1:0] espected_frequency,
  output [1-1:0] espected_frequency_valid
);
  wire [1-1:0] delay1_q_net_x0;
  wire [16-1:0] constant_op_net;
  wire [36-1:0] cmult_p_net;
  wire [82-1:0] register_q_net;
  wire [64-1:0] convert_dout_net;
  wire [16-1:0] counter_op_net;
  wire [1-1:0] delay1_q_net;
  wire ce_net;
  wire [64-1:0] accumulator1_q_net;
  wire clk_net;
  wire [64-1:0] convert1_dout_net;
  wire [1-1:0] delay2_q_net;
  wire [1-1:0] delay_q_net;
  wire [1-1:0] divide_result_tvalid_net;
  wire logical1_y_net;
  wire [1-1:0] relational_op_net;
  wire [1-1:0] logical_y_net;
  wire divide_b_tready_net;
  wire [1-1:0] inverter_op_net;
  wire [82-1:0] divide_op_net;
  wire divide_a_tready_net;
  assign espected_frequency = register_q_net;
  assign espected_frequency_valid = delay2_q_net;
  assign cmult_p_net = inst_freq;
  assign delay1_q_net = inst_freq_valid;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  sysgen_accum_0932bf0451 accumulator1 (
    .clr(1'b0),
    .b(cmult_p_net),
    .rst(delay1_q_net_x0),
    .en(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(accumulator1_q_net)
  );
  sysgen_constant_71d0fa22b7 constant (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(26),
    .dout_width(64),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert (
    .clr(1'b0),
    .en(1'b1),
    .din(counter_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(26),
    .din_width(64),
    .dout_arith(2),
    .dout_bin_pt(26),
    .dout_width(64),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert1 (
    .clr(1'b0),
    .en(1'b1),
    .din(accumulator1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert1_dout_net)
  );
  ifm_xlcounter_free #(
    .core_name0("ifm_c_counter_binary_v12_0_i0"),
    .op_arith(`xlUnsigned),
    .op_width(16)
  )
  counter (
    .clr(1'b0),
    .rst(delay1_q_net_x0),
    .en(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(counter_op_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay (
    .en(1'b1),
    .rst(1'b0),
    .d(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay1 (
    .en(1'b1),
    .rst(1'b0),
    .d(logical_y_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay1_q_net_x0)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay2 (
    .en(1'b1),
    .rst(1'b0),
    .d(divide_result_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay2_q_net)
  );
  xldivider_generator_35fbedb0beb337359c74de660051a815 divide (
    .a_tvalid(logical_y_net),
    .a(convert1_dout_net),
    .b_tvalid(logical1_y_net),
    .b(convert_dout_net),
    .clk(clk_net),
    .ce(ce_net),
    .a_tready(divide_a_tready_net),
    .b_tready(divide_b_tready_net),
    .result_tvalid(divide_result_tvalid_net),
    .op(divide_op_net)
  );
  sysgen_inverter_c9b1913825 inverter (
    .clr(1'b0),
    .ip(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(inverter_op_net)
  );
  sysgen_logical_5f99e03888 logical (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(delay_q_net),
    .d1(inverter_op_net),
    .y(logical_y_net)
  );
  sysgen_logical_5f99e03888 logical1 (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(logical_y_net),
    .d1(relational_op_net),
    .y(logical1_y_net)
  );
  ifm_xlregister #(
    .d_width(82),
    .init_value(82'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000)
  )
  register (
    .rst(1'b0),
    .d(divide_op_net),
    .en(divide_result_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(register_q_net)
  );
  sysgen_relational_639524f7d0 relational (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .a(counter_op_net),
    .b(constant_op_net),
    .op(relational_op_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/2 Delay Instantenous Frequency
module ifm_2_delay_instantenous_frequency (
  input [32-1:0] real_part,
  input [32-1:0] imag_part,
  input [32-1:0] real_part_d2,
  input [32-1:0] imag_part_d2,
  input [1-1:0] datavalid,
  input clk_1,
  input ce_1,
  output [36-1:0] inst_freq,
  output [1-1:0] inst_freq_valid
);
  wire [32-1:0] sync_real_q_net;
  wire [32-1:0] sync_imag_q_net;
  wire [32-1:0] d2_q_net;
  wire [36-1:0] cmult_p_net;
  wire [1-1:0] delay1_q_net;
  wire [16-1:0] cordic_6_0_m_axis_dout_tdata_phase_net;
  wire delay_q_net;
  wire [32-1:0] convert1_dout_net;
  wire clk_net;
  wire [65-1:0] product_p_im_net;
  wire [32-1:0] d2_1_q_net;
  wire [32-1:0] convert_dout_net;
  wire ce_net;
  wire [32-1:0] convert2_dout_net;
  wire [65-1:0] product_p_re_net;
  wire [1-1:0] x2_delay_envelope_y_net;
  wire [32-1:0] convert4_dout_net;
  wire cordic_6_0_m_axis_dout_tvalid_net;
  wire [32-1:0] negate_op_net;
  wire [32-1:0] convert5_dout_net;
  assign inst_freq = cmult_p_net;
  assign inst_freq_valid = delay1_q_net;
  assign sync_real_q_net = real_part;
  assign sync_imag_q_net = imag_part;
  assign d2_q_net = real_part_d2;
  assign d2_1_q_net = imag_part_d2;
  assign x2_delay_envelope_y_net = datavalid;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  ifm_xlcmult #(
    .a_arith(`xlSigned),
    .a_bin_pt(13),
    .a_width(16),
    .b_bin_pt(13),
    .c_a_type(0),
    .c_a_width(16),
    .c_b_type(1),
    .c_b_width(20),
    .c_output_width(36),
    .core_name0("ifm_mult_gen_v12_0_i0"),
    .extra_registers(0),
    .multsign(2),
    .overflow(1),
    .p_arith(`xlSigned),
    .p_bin_pt(26),
    .p_width(36),
    .quantization(1),
    .zero_const(0)
  )
  cmult (
    .clr(1'b0),
    .core_clr(1'b1),
    .en(1'b1),
    .rst(1'b0),
    .a(cordic_6_0_m_axis_dout_tdata_phase_net),
    .clk(clk_net),
    .ce(ce_net),
    .core_clk(clk_net),
    .core_ce(ce_net),
    .p(cmult_p_net)
  );
  xlcordic_e7d35e72b5cb482ad566b77f7180ad07 cordic_6_0 (
    .s_axis_cartesian_tvalid(delay_q_net),
    .s_axis_cartesian_tdata_imag(convert2_dout_net),
    .s_axis_cartesian_tdata_real(convert1_dout_net),
    .clk(clk_net),
    .ce(ce_net),
    .m_axis_dout_tvalid(cordic_6_0_m_axis_dout_tvalid_net),
    .m_axis_dout_tdata_phase(cordic_6_0_m_axis_dout_tdata_phase_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert (
    .clr(1'b0),
    .en(1'b1),
    .din(d2_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(60),
    .din_width(65),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert1 (
    .clr(1'b0),
    .en(1'b1),
    .din(product_p_re_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert1_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(60),
    .din_width(65),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert2 (
    .clr(1'b0),
    .en(1'b1),
    .din(product_p_im_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert2_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert4 (
    .clr(1'b0),
    .en(1'b1),
    .din(sync_imag_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert4_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert5 (
    .clr(1'b0),
    .en(1'b1),
    .din(sync_real_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert5_dout_net)
  );
  ifm_xldelay #(
    .latency(5),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay (
    .en(1'b1),
    .rst(1'b0),
    .d(x2_delay_envelope_y_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay1 (
    .en(1'b1),
    .rst(1'b0),
    .d(cordic_6_0_m_axis_dout_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay1_q_net)
  );
  sysgen_negate_1669d33fdd negate (
    .clr(1'b0),
    .ip(d2_1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(negate_op_net)
  );
  xlifm_cmpy_v6_0_i0_9fd912a9e0b52b9c73a886bb5266b0bf product (
    .a_re(convert5_dout_net),
    .a_im(convert4_dout_net),
    .b_re(convert_dout_net),
    .b_im(negate_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .p_re(product_p_re_net),
    .p_im(product_p_im_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/4 Delay Avarage Freq
module ifm_4_delay_avarage_freq (
  input [36-1:0] inst_freq,
  input [1-1:0] inst_freq_valid,
  input clk_1,
  input ce_1,
  output [82-1:0] espected_frequency,
  output [1-1:0] espected_frequency_valid
);
  wire [64-1:0] convert_dout_net;
  wire divide_b_tready_net;
  wire [16-1:0] counter_op_net;
  wire [1-1:0] delay_q_net;
  wire [1-1:0] logical_y_net;
  wire [64-1:0] convert1_dout_net;
  wire [1-1:0] divide_result_tvalid_net;
  wire [82-1:0] divide_op_net;
  wire logical1_y_net;
  wire divide_a_tready_net;
  wire [1-1:0] inverter_op_net;
  wire [1-1:0] relational_op_net;
  wire [36-1:0] cmult_p_net;
  wire [16-1:0] constant_op_net;
  wire [82-1:0] register_q_net;
  wire clk_net;
  wire ce_net;
  wire [1-1:0] delay2_q_net;
  wire [64-1:0] accumulator1_q_net;
  wire [1-1:0] delay1_q_net;
  wire [1-1:0] delay1_q_net_x0;
  assign espected_frequency = register_q_net;
  assign espected_frequency_valid = delay2_q_net;
  assign cmult_p_net = inst_freq;
  assign delay1_q_net = inst_freq_valid;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  sysgen_accum_0932bf0451 accumulator1 (
    .clr(1'b0),
    .b(cmult_p_net),
    .rst(delay1_q_net_x0),
    .en(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(accumulator1_q_net)
  );
  sysgen_constant_4ef91a5823 constant (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(1),
    .din_bin_pt(0),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(26),
    .dout_width(64),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert (
    .clr(1'b0),
    .en(1'b1),
    .din(counter_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(26),
    .din_width(64),
    .dout_arith(2),
    .dout_bin_pt(26),
    .dout_width(64),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert1 (
    .clr(1'b0),
    .en(1'b1),
    .din(accumulator1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert1_dout_net)
  );
  ifm_xlcounter_free #(
    .core_name0("ifm_c_counter_binary_v12_0_i0"),
    .op_arith(`xlUnsigned),
    .op_width(16)
  )
  counter (
    .clr(1'b0),
    .rst(delay1_q_net_x0),
    .en(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(counter_op_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay (
    .en(1'b1),
    .rst(1'b0),
    .d(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay1 (
    .en(1'b1),
    .rst(1'b0),
    .d(logical_y_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay1_q_net_x0)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay2 (
    .en(1'b1),
    .rst(1'b0),
    .d(divide_result_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay2_q_net)
  );
  xldivider_generator_35fbedb0beb337359c74de660051a815 divide (
    .a_tvalid(logical_y_net),
    .a(convert1_dout_net),
    .b_tvalid(logical1_y_net),
    .b(convert_dout_net),
    .clk(clk_net),
    .ce(ce_net),
    .a_tready(divide_a_tready_net),
    .b_tready(divide_b_tready_net),
    .result_tvalid(divide_result_tvalid_net),
    .op(divide_op_net)
  );
  sysgen_inverter_c9b1913825 inverter (
    .clr(1'b0),
    .ip(delay1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(inverter_op_net)
  );
  sysgen_logical_5f99e03888 logical (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(delay_q_net),
    .d1(inverter_op_net),
    .y(logical_y_net)
  );
  sysgen_logical_5f99e03888 logical1 (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(logical_y_net),
    .d1(relational_op_net),
    .y(logical1_y_net)
  );
  ifm_xlregister #(
    .d_width(82),
    .init_value(82'b0000000000000000000000000000000000000000000000000000000000000000000000000000000000)
  )
  register (
    .rst(1'b0),
    .d(divide_op_net),
    .en(divide_result_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(register_q_net)
  );
  sysgen_relational_639524f7d0 relational (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .a(counter_op_net),
    .b(constant_op_net),
    .op(relational_op_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/4 Delay Instantenous Frequency
module ifm_4_delay_instantenous_frequency (
  input [32-1:0] real_part,
  input [32-1:0] imag_part,
  input [32-1:0] real_part_d4,
  input [32-1:0] imag_part_d4,
  input [1-1:0] datavalid,
  input clk_1,
  input ce_1,
  output [36-1:0] inst_freq,
  output [1-1:0] inst_freq_valid
);
  wire [32-1:0] convert_dout_net;
  wire [32-1:0] d4_1_q_net;
  wire [32-1:0] d4_q_net;
  wire [32-1:0] convert2_dout_net;
  wire [36-1:0] cmult_p_net;
  wire clk_net;
  wire [1-1:0] delay1_q_net;
  wire [1-1:0] x4_delay_envelope_y_net;
  wire ce_net;
  wire [32-1:0] sync_real_q_net;
  wire [16-1:0] cordic_6_0_m_axis_dout_tdata_phase_net;
  wire cordic_6_0_m_axis_dout_tvalid_net;
  wire delay_q_net;
  wire [32-1:0] sync_imag_q_net;
  wire [32-1:0] convert1_dout_net;
  wire [32-1:0] convert5_dout_net;
  wire [32-1:0] convert4_dout_net;
  wire [65-1:0] product_p_im_net;
  wire [65-1:0] product_p_re_net;
  wire [32-1:0] negate_op_net;
  assign inst_freq = cmult_p_net;
  assign inst_freq_valid = delay1_q_net;
  assign sync_real_q_net = real_part;
  assign sync_imag_q_net = imag_part;
  assign d4_q_net = real_part_d4;
  assign d4_1_q_net = imag_part_d4;
  assign x4_delay_envelope_y_net = datavalid;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  ifm_xlcmult #(
    .a_arith(`xlSigned),
    .a_bin_pt(13),
    .a_width(16),
    .b_bin_pt(13),
    .c_a_type(0),
    .c_a_width(16),
    .c_b_type(1),
    .c_b_width(20),
    .c_output_width(36),
    .core_name0("ifm_mult_gen_v12_0_i1"),
    .extra_registers(0),
    .multsign(2),
    .overflow(1),
    .p_arith(`xlSigned),
    .p_bin_pt(26),
    .p_width(36),
    .quantization(1),
    .zero_const(0)
  )
  cmult (
    .clr(1'b0),
    .core_clr(1'b1),
    .en(1'b1),
    .rst(1'b0),
    .a(cordic_6_0_m_axis_dout_tdata_phase_net),
    .clk(clk_net),
    .ce(ce_net),
    .core_clk(clk_net),
    .core_ce(ce_net),
    .p(cmult_p_net)
  );
  xlcordic_e7d35e72b5cb482ad566b77f7180ad07 cordic_6_0 (
    .s_axis_cartesian_tvalid(delay_q_net),
    .s_axis_cartesian_tdata_imag(convert2_dout_net),
    .s_axis_cartesian_tdata_real(convert1_dout_net),
    .clk(clk_net),
    .ce(ce_net),
    .m_axis_dout_tvalid(cordic_6_0_m_axis_dout_tvalid_net),
    .m_axis_dout_tdata_phase(cordic_6_0_m_axis_dout_tdata_phase_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert (
    .clr(1'b0),
    .en(1'b1),
    .din(d4_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(60),
    .din_width(65),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert1 (
    .clr(1'b0),
    .en(1'b1),
    .din(product_p_re_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert1_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(60),
    .din_width(65),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert2 (
    .clr(1'b0),
    .en(1'b1),
    .din(product_p_im_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert2_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert4 (
    .clr(1'b0),
    .en(1'b1),
    .din(sync_imag_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert4_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(30),
    .din_width(32),
    .dout_arith(2),
    .dout_bin_pt(30),
    .dout_width(32),
    .latency(1),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert5 (
    .clr(1'b0),
    .en(1'b1),
    .din(sync_real_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert5_dout_net)
  );
  ifm_xldelay #(
    .latency(5),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay (
    .en(1'b1),
    .rst(1'b0),
    .d(x4_delay_envelope_y_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  delay1 (
    .en(1'b1),
    .rst(1'b0),
    .d(cordic_6_0_m_axis_dout_tvalid_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(delay1_q_net)
  );
  sysgen_negate_1669d33fdd negate (
    .clr(1'b0),
    .ip(d4_1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(negate_op_net)
  );
  xlifm_cmpy_v6_0_i0_9fd912a9e0b52b9c73a886bb5266b0bf product (
    .a_re(convert5_dout_net),
    .a_im(convert4_dout_net),
    .b_re(convert_dout_net),
    .b_im(negate_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .p_re(product_p_re_net),
    .p_im(product_p_im_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection/Delay - Envelope Operations
module ifm_delay_envelope_operations (
  input [32-1:0] real_x0,
  input [32-1:0] imag,
  input [1-1:0] envelope,
  input clk_1,
  input ce_1,
  output [1-1:0] envelope_2_delay,
  output [1-1:0] envelope_4_delay,
  output [32-1:0] d2_real,
  output [32-1:0] d2_imag,
  output [32-1:0] d4_real,
  output [32-1:0] d4_imag
);
  wire [32-1:0] d2_q_net;
  wire [1-1:0] x4_delay_envelope_y_net;
  wire [32-1:0] d2_1_q_net;
  wire [1-1:0] x2_delay_envelope_y_net;
  wire [32-1:0] d4_q_net;
  wire [32-1:0] d4_1_q_net;
  wire [32-1:0] sync_real_q_net;
  wire [32-1:0] sync_imag_q_net;
  wire ce_net;
  wire [1-1:0] relational_op_net;
  wire clk_net;
  wire [32-1:0] d1_q_net;
  wire [1-1:0] d4_q_net_x0;
  wire [1-1:0] d1_q_net_x0;
  wire [1-1:0] d3_q_net;
  wire [32-1:0] d1_1_q_net;
  wire [1-1:0] d2_q_net_x0;
  wire [32-1:0] d3_q_net_x0;
  wire [32-1:0] d3_1_q_net;
  assign envelope_2_delay = x2_delay_envelope_y_net;
  assign envelope_4_delay = x4_delay_envelope_y_net;
  assign d2_real = d2_q_net;
  assign d2_imag = d2_1_q_net;
  assign d4_real = d4_q_net;
  assign d4_imag = d4_1_q_net;
  assign sync_real_q_net = real_x0;
  assign sync_imag_q_net = imag;
  assign relational_op_net = envelope;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  sysgen_logical_2283bfdd69 x2_delay_envelope (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(d2_q_net_x0),
    .d1(d1_q_net_x0),
    .d2(relational_op_net),
    .y(x2_delay_envelope_y_net)
  );
  sysgen_logical_f09796fb8a x4_delay_envelope (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .d0(d4_q_net_x0),
    .d1(d3_q_net),
    .d2(d2_q_net_x0),
    .d3(d1_q_net_x0),
    .d4(relational_op_net),
    .y(x4_delay_envelope_y_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d1_x0 (
    .en(1'b1),
    .rst(1'b0),
    .d(sync_real_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d1_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d1_1 (
    .en(1'b1),
    .rst(1'b0),
    .d(sync_imag_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d1_1_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d2_x0 (
    .en(1'b1),
    .rst(1'b0),
    .d(d1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d2_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d2_1 (
    .en(1'b1),
    .rst(1'b0),
    .d(d1_1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d2_1_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d3 (
    .en(1'b1),
    .rst(1'b0),
    .d(d2_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d3_q_net_x0)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d3_1 (
    .en(1'b1),
    .rst(1'b0),
    .d(d2_1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d3_1_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d4 (
    .en(1'b1),
    .rst(1'b0),
    .d(d3_q_net_x0),
    .clk(clk_net),
    .ce(ce_net),
    .q(d4_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  d4_1 (
    .en(1'b1),
    .rst(1'b0),
    .d(d3_1_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d4_1_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  d1 (
    .en(1'b1),
    .rst(1'b0),
    .d(relational_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d1_q_net_x0)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  d2 (
    .en(1'b1),
    .rst(1'b0),
    .d(d1_q_net_x0),
    .clk(clk_net),
    .ce(ce_net),
    .q(d2_q_net_x0)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  d3_x0 (
    .en(1'b1),
    .rst(1'b0),
    .d(d2_q_net_x0),
    .clk(clk_net),
    .ce(ce_net),
    .q(d3_q_net)
  );
  ifm_xldelay #(
    .latency(1),
    .reg_retiming(0),
    .reset(0),
    .width(1)
  )
  d4_x0 (
    .en(1'b1),
    .rst(1'b0),
    .d(d3_q_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(d4_q_net_x0)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection/Signal Detection
module ifm_signal_detection (
  input [16-1:0] real_x0,
  input [16-1:0] imag,
  input clk_1,
  input ce_1,
  output [32-1:0] filtered_sync_real_out,
  output [32-1:0] filtered_sync_imag_out,
  output [1-1:0] envelope
);
  wire [32-1:0] sync_real_q_net;
  wire [65-1:0] sumsquares_s_net;
  wire clk_net;
  wire [65-1:0] constant_op_net;
  wire fir_compiler_7_1_m_axis_data_tvalid_net;
  wire fir_compiler_7_2_s_axis_data_tready_net;
  wire [16-1:0] convert2_dout_net;
  wire [64-1:0] squareimag_p_net;
  wire ce_net;
  wire [16-1:0] convert1_dout_net;
  wire [1-1:0] relational_op_net;
  wire [32-1:0] sync_imag_q_net;
  wire fir_compiler_7_1_s_axis_data_tready_net;
  wire [32-1:0] fir_compiler_7_1_m_axis_data_tdata_real_net;
  wire fir_compiler_7_2_m_axis_data_tvalid_net;
  wire [32-1:0] fir_compiler_7_2_m_axis_data_tdata_real_net;
  wire [64-1:0] squarereal_p_net;
  assign filtered_sync_real_out = sync_real_q_net;
  assign filtered_sync_imag_out = sync_imag_q_net;
  assign envelope = relational_op_net;
  assign convert1_dout_net = real_x0;
  assign convert2_dout_net = imag;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  sysgen_constant_4f8fbab6ff constant (
    .clk(1'b0),
    .ce(1'b0),
    .clr(1'b0),
    .op(constant_op_net)
  );
  xlfir_compiler_c244ef529eeaf835047e7e0f24cc326a fir_compiler_7_1 (
    .s_axis_data_tdata_real(convert1_dout_net),
    .src_clk(clk_net),
    .src_ce(ce_net),
    .clk(clk_net),
    .ce(ce_net),
    .clk_logic_1(clk_net),
    .ce_logic_1(ce_net),
    .s_axis_data_tready(fir_compiler_7_1_s_axis_data_tready_net),
    .m_axis_data_tvalid(fir_compiler_7_1_m_axis_data_tvalid_net),
    .m_axis_data_tdata_real(fir_compiler_7_1_m_axis_data_tdata_real_net)
  );
  xlfir_compiler_c244ef529eeaf835047e7e0f24cc326a fir_compiler_7_2 (
    .s_axis_data_tdata_real(convert2_dout_net),
    .src_clk(clk_net),
    .src_ce(ce_net),
    .clk(clk_net),
    .ce(ce_net),
    .clk_logic_1(clk_net),
    .ce_logic_1(ce_net),
    .s_axis_data_tready(fir_compiler_7_2_s_axis_data_tready_net),
    .m_axis_data_tvalid(fir_compiler_7_2_m_axis_data_tvalid_net),
    .m_axis_data_tdata_real(fir_compiler_7_2_m_axis_data_tdata_real_net)
  );
  sysgen_relational_d45e0623b9 relational (
    .clr(1'b0),
    .a(sumsquares_s_net),
    .b(constant_op_net),
    .clk(clk_net),
    .ce(ce_net),
    .op(relational_op_net)
  );
  sysgen_mult_58e40784a9 squareimag (
    .clr(1'b0),
    .a(fir_compiler_7_2_m_axis_data_tdata_real_net),
    .b(fir_compiler_7_2_m_axis_data_tdata_real_net),
    .clk(clk_net),
    .ce(ce_net),
    .p(squareimag_p_net)
  );
  sysgen_mult_58e40784a9 squarereal (
    .clr(1'b0),
    .a(fir_compiler_7_1_m_axis_data_tdata_real_net),
    .b(fir_compiler_7_1_m_axis_data_tdata_real_net),
    .clk(clk_net),
    .ce(ce_net),
    .p(squarereal_p_net)
  );
  sysgen_addsub_393851444a sumsquares (
    .clr(1'b0),
    .a(squarereal_p_net),
    .b(squareimag_p_net),
    .clk(clk_net),
    .ce(ce_net),
    .s(sumsquares_s_net)
  );
  ifm_xldelay #(
    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  sync_imag (
    .en(1'b1),
    .rst(1'b0),
    .d(fir_compiler_7_2_m_axis_data_tdata_real_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(sync_imag_q_net)
  );
  ifm_xldelay #(
    .latency(3),
    .reg_retiming(0),
    .reset(0),
    .width(32)
  )
  sync_real (
    .en(1'b1),
    .rst(1'b0),
    .d(fir_compiler_7_1_m_axis_data_tdata_real_net),
    .clk(clk_net),
    .ce(ce_net),
    .q(sync_real_q_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection
module ifm_envelope_detection (
  input [16-1:0] real_x0,
  input [16-1:0] imag,
  input clk_1,
  input ce_1,
  output [1-1:0] envelope_2_delay,
  output [1-1:0] envelope_4_delay,
  output [32-1:0] original_real,
  output [32-1:0] original_imag,
  output [32-1:0] d2_real,
  output [32-1:0] d2_imag,
  output [32-1:0] d4_real,
  output [32-1:0] d4_imag
);
  wire [32-1:0] sync_imag_q_net;
  wire [1-1:0] x4_delay_envelope_y_net;
  wire [32-1:0] d4_q_net;
  wire [1-1:0] x2_delay_envelope_y_net;
  wire [32-1:0] d2_q_net;
  wire [32-1:0] d4_1_q_net;
  wire [16-1:0] convert2_dout_net;
  wire ce_net;
  wire [32-1:0] d2_1_q_net;
  wire clk_net;
  wire [1-1:0] relational_op_net;
  wire [16-1:0] convert1_dout_net;
  wire [32-1:0] sync_real_q_net;
  assign envelope_2_delay = x2_delay_envelope_y_net;
  assign envelope_4_delay = x4_delay_envelope_y_net;
  assign original_real = sync_real_q_net;
  assign original_imag = sync_imag_q_net;
  assign d2_real = d2_q_net;
  assign d2_imag = d2_1_q_net;
  assign d4_real = d4_q_net;
  assign d4_imag = d4_1_q_net;
  assign convert1_dout_net = real_x0;
  assign convert2_dout_net = imag;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  ifm_delay_envelope_operations delay_envelope_operations (
    .real_x0(sync_real_q_net),
    .imag(sync_imag_q_net),
    .envelope(relational_op_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .envelope_2_delay(x2_delay_envelope_y_net),
    .envelope_4_delay(x4_delay_envelope_y_net),
    .d2_real(d2_q_net),
    .d2_imag(d2_1_q_net),
    .d4_real(d4_q_net),
    .d4_imag(d4_1_q_net)
  );
  ifm_signal_detection signal_detection (
    .real_x0(convert1_dout_net),
    .imag(convert2_dout_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .filtered_sync_real_out(sync_real_q_net),
    .filtered_sync_imag_out(sync_imag_q_net),
    .envelope(relational_op_net)
  );
endmodule
`timescale 1 ns / 10 ps
// Generated from Simulink block IFM_ModelComposer/IFM_struct
module ifm_struct (
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk_1,
  input ce_1,
  output [82-1:0] estimated_frequency_2_delay,
  output [1-1:0] estimated_frequency_2_delay_valid,
  output [82-1:0] estimated_frequency_4_delay,
  output [1-1:0] estimated_frequency_4_delay_valid
);
  wire [16-1:0] imagpart_net;
  wire [16-1:0] realpart_net;
  wire [82-1:0] register_q_net_x0;
  wire [1-1:0] delay2_q_net_x0;
  wire [82-1:0] register_q_net;
  wire [1-1:0] delay2_q_net;
  wire ce_net;
  wire [1-1:0] delay1_q_net_x0;
  wire [32-1:0] d4_1_q_net;
  wire [32-1:0] sync_imag_q_net;
  wire [32-1:0] d2_q_net;
  wire [32-1:0] sync_real_q_net;
  wire [1-1:0] delay1_q_net;
  wire [36-1:0] cmult_p_net_x0;
  wire [16-1:0] convert1_dout_net;
  wire [32-1:0] d4_q_net;
  wire [16-1:0] convert2_dout_net;
  wire [32-1:0] d2_1_q_net;
  wire clk_net;
  wire [36-1:0] cmult_p_net;
  wire [1-1:0] x4_delay_envelope_y_net;
  wire [1-1:0] x2_delay_envelope_y_net;
  assign estimated_frequency_2_delay = register_q_net_x0;
  assign estimated_frequency_2_delay_valid = delay2_q_net_x0;
  assign estimated_frequency_4_delay = register_q_net;
  assign estimated_frequency_4_delay_valid = delay2_q_net;
  assign imagpart_net = imagpart;
  assign realpart_net = realpart;
  assign clk_net = clk_1;
  assign ce_net = ce_1;
  ifm_2_delay_avarage_freq x2_delay_avarage_freq (
    .inst_freq(cmult_p_net_x0),
    .inst_freq_valid(delay1_q_net_x0),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .espected_frequency(register_q_net_x0),
    .espected_frequency_valid(delay2_q_net_x0)
  );
  ifm_2_delay_instantenous_frequency x2_delay_instantenous_frequency (
    .real_part(sync_real_q_net),
    .imag_part(sync_imag_q_net),
    .real_part_d2(d2_q_net),
    .imag_part_d2(d2_1_q_net),
    .datavalid(x2_delay_envelope_y_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .inst_freq(cmult_p_net_x0),
    .inst_freq_valid(delay1_q_net_x0)
  );
  ifm_4_delay_avarage_freq x4_delay_avarage_freq (
    .inst_freq(cmult_p_net),
    .inst_freq_valid(delay1_q_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .espected_frequency(register_q_net),
    .espected_frequency_valid(delay2_q_net)
  );
  ifm_4_delay_instantenous_frequency x4_delay_instantenous_frequency (
    .real_part(sync_real_q_net),
    .imag_part(sync_imag_q_net),
    .real_part_d4(d4_q_net),
    .imag_part_d4(d4_1_q_net),
    .datavalid(x4_delay_envelope_y_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .inst_freq(cmult_p_net),
    .inst_freq_valid(delay1_q_net)
  );
  ifm_envelope_detection envelope_detection (
    .real_x0(convert1_dout_net),
    .imag(convert2_dout_net),
    .clk_1(clk_net),
    .ce_1(ce_net),
    .envelope_2_delay(x2_delay_envelope_y_net),
    .envelope_4_delay(x4_delay_envelope_y_net),
    .original_real(sync_real_q_net),
    .original_imag(sync_imag_q_net),
    .d2_real(d2_q_net),
    .d2_imag(d2_1_q_net),
    .d4_real(d4_q_net),
    .d4_imag(d4_1_q_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert1 (
    .clr(1'b0),
    .en(1'b1),
    .din(realpart_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert1_dout_net)
  );
  ifm_xlconvert #(
    .bool_conversion(0),
    .din_arith(2),
    .din_bin_pt(15),
    .din_width(16),
    .dout_arith(2),
    .dout_bin_pt(15),
    .dout_width(16),
    .latency(0),
    .overflow(`xlWrap),
    .quantization(`xlTruncate)
  )
  convert2 (
    .clr(1'b0),
    .en(1'b1),
    .din(imagpart_net),
    .clk(clk_net),
    .ce(ce_net),
    .dout(convert2_dout_net)
  );
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
(* core_generation_info = "ifm,sysgen_core_2025_1,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplus,part=xczu9eg,speed=-2-e,package=ffvb1156,synthesis_language=verilog,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=1,interface_doc=0,ce_clr=0,clock_period=3.33333,system_simulink_period=3.33333e-09,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.0002,accum=2,addsub=1,cmult=2,constant=3,convert=16,cordic_v6_0=2,counter=2,delay=24,divide=2,fir_compiler_v7_2=2,inv=2,logical=6,mult=2,negate=2,product_macro=2,register=2,relational=3,}" *)
module ifm (
  input [16-1:0] imagpart,
  input [16-1:0] realpart,
  input clk,
  output [82-1:0] estimated_frequency_2_delay,
  output [1-1:0] estimated_frequency_2_delay_valid,
  output [82-1:0] estimated_frequency_4_delay,
  output [1-1:0] estimated_frequency_4_delay_valid
);
  wire clk_1_net;
  wire ce_1_net;
  ifm_default_clock_driver ifm_default_clock_driver (
    .ifm_sysclk(clk),
    .ifm_sysce(1'b1),
    .ifm_sysclr(1'b0),
    .ifm_clk1(clk_1_net),
    .ifm_ce1(ce_1_net)
  );
  ifm_struct ifm_struct (
    .imagpart(imagpart),
    .realpart(realpart),
    .clk_1(clk_1_net),
    .ce_1(ce_1_net),
    .estimated_frequency_2_delay(estimated_frequency_2_delay),
    .estimated_frequency_2_delay_valid(estimated_frequency_2_delay_valid),
    .estimated_frequency_4_delay(estimated_frequency_4_delay),
    .estimated_frequency_4_delay_valid(estimated_frequency_4_delay_valid)
  );
endmodule
