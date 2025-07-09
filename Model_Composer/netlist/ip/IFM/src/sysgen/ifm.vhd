-- Generated from Simulink block IFM_ModelComposer/IFM/2 Delay Avarage Freq
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_2_delay_avarage_freq is
  port (
    inst_freq : in std_logic_vector( 36-1 downto 0 );
    inst_freq_valid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    espected_frequency : out std_logic_vector( 82-1 downto 0 )
  );
end ifm_2_delay_avarage_freq;
architecture structural of ifm_2_delay_avarage_freq is 
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal accumulator1_q_net : std_logic_vector( 64-1 downto 0 );
  signal delay1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 82-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
  signal counter_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 64-1 downto 0 );
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 64-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal divide_a_tready_net : std_logic;
  signal divide_b_tready_net : std_logic;
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal logical1_y_net : std_logic;
  signal divide_result_tvalid_net : std_logic;
  signal divide_op_net : std_logic_vector( 82-1 downto 0 );
begin
  espected_frequency <= register_q_net;
  cmult_p_net <= inst_freq;
  delay1_q_net <= inst_freq_valid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  accumulator1 : entity xil_defaultlib.sysgen_accum_c364465375 
  port map (
    clr => '0',
    b => cmult_p_net,
    rst => delay1_q_net_x0,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => accumulator1_q_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_963501f8f9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 26,
    dout_width => 64,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 26,
    din_width => 64,
    dout_arith => 2,
    dout_bin_pt => 26,
    dout_width => 64,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => accumulator1_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  counter : entity xil_defaultlib.ifm_xlcounter_free 
  generic map (
    core_name0 => "ifm_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 16
  )
  port map (
    clr => '0',
    rst => delay1_q_net_x0,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net_x0
  );
  divide : entity xil_defaultlib.xldivider_generator_030fd2ddfbdd126871b119df6562236b 
  port map (
    a_tvalid => logical_y_net(0),
    a => convert1_dout_net,
    b_tvalid => logical1_y_net,
    b => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    a_tready => divide_a_tready_net,
    b_tready => divide_b_tready_net,
    result_tvalid => divide_result_tvalid_net,
    op => divide_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ce66081e64 
  port map (
    clr => '0',
    ip => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_9cab5becb9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_q_net,
    d1 => inverter_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_9cab5becb9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical_y_net,
    d1 => relational_op_net,
    y(0) => logical1_y_net
  );
  register_x0 : entity xil_defaultlib.ifm_xlregister 
  generic map (
    d_width => 82,
    init_value => b"0000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  )
  port map (
    rst => "0",
    d => divide_op_net,
    en(0) => divide_result_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_635c380d6f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    op => relational_op_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/2 Delay Instantenous Frequency
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_2_delay_instantenous_frequency is
  port (
    real_part : in std_logic_vector( 16-1 downto 0 );
    imag_part : in std_logic_vector( 16-1 downto 0 );
    real_part_d2 : in std_logic_vector( 16-1 downto 0 );
    imag_part_d2 : in std_logic_vector( 16-1 downto 0 );
    datavalid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    inst_freq : out std_logic_vector( 36-1 downto 0 );
    inst_freq_valid : out std_logic_vector( 1-1 downto 0 )
  );
end ifm_2_delay_instantenous_frequency;
architecture structural of ifm_2_delay_instantenous_frequency is 
  signal cordic_6_0_m_axis_dout_tdata_phase_net : std_logic_vector( 16-1 downto 0 );
  signal cordic_6_0_m_axis_dout_tvalid_net : std_logic;
  signal delay_q_net : std_logic;
  signal convert2_dout_net : std_logic_vector( 35-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 35-1 downto 0 );
  signal d2_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal d2_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal product_p_re_net : std_logic_vector( 35-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 17-1 downto 0 );
  signal negate_op_net : std_logic_vector( 17-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 17-1 downto 0 );
  signal product_p_im_net : std_logic_vector( 35-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 17-1 downto 0 );
  signal clk_net : std_logic;
  signal x2_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal ce_net : std_logic;
begin
  inst_freq <= cmult_p_net;
  inst_freq_valid <= delay1_q_net;
  real_component_q_net <= real_part;
  imag_component_q_net <= imag_part;
  d2_q_net <= real_part_d2;
  d2_1_q_net <= imag_part_d2;
  x2_tap_envelope_y_net <= datavalid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  cmult : entity xil_defaultlib.ifm_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_bin_pt => 13,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 20,
    c_output_width => 36,
    core_name0 => "ifm_mult_gen_v12_0_i0",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 26,
    p_width => 36,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => cordic_6_0_m_axis_dout_tdata_phase_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cordic_6_0 : entity xil_defaultlib.xlcordic_0b74b5d3e3217f3b6f828490f82e0b77 
  port map (
    s_axis_cartesian_tvalid => delay_q_net,
    s_axis_cartesian_tdata_imag => convert2_dout_net,
    s_axis_cartesian_tdata_real => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    m_axis_dout_tvalid => cordic_6_0_m_axis_dout_tvalid_net,
    m_axis_dout_tdata_phase => cordic_6_0_m_axis_dout_tdata_phase_net
  );
  convert : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => d2_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 35,
    dout_arith => 2,
    dout_bin_pt => 33,
    dout_width => 35,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_re_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 35,
    dout_arith => 2,
    dout_bin_pt => 33,
    dout_width => 35,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_im_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert4 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => imag_component_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => real_component_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert5_dout_net
  );
  delay : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 5,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => x2_tap_envelope_y_net,
    clk => clk_net,
    ce => ce_net,
    q(0) => delay_q_net
  );
  delay1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d(0) => cordic_6_0_m_axis_dout_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  negate : entity xil_defaultlib.sysgen_negate_1f96a59208 
  port map (
    clr => '0',
    ip => d2_1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => negate_op_net
  );
  product : entity xil_defaultlib.xlifm_cmpy_v6_0_i0_5ea665b0a4fb0bfa292c62e9e1e6ea82 
  port map (
    a_re => convert5_dout_net,
    a_im => convert4_dout_net,
    b_re => convert_dout_net,
    b_im => negate_op_net,
    clk => clk_net,
    ce => ce_net,
    p_re => product_p_re_net,
    p_im => product_p_im_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/4 Delay Avarage Freq
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_4_delay_avarage_freq is
  port (
    inst_freq : in std_logic_vector( 36-1 downto 0 );
    inst_freq_valid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    espected_frequency : out std_logic_vector( 82-1 downto 0 )
  );
end ifm_4_delay_avarage_freq;
architecture structural of ifm_4_delay_avarage_freq is 
  signal register_q_net : std_logic_vector( 82-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
  signal logical_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 64-1 downto 0 );
  signal delay1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal counter_op_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal constant_op_net : std_logic_vector( 16-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 64-1 downto 0 );
  signal accumulator1_q_net : std_logic_vector( 64-1 downto 0 );
  signal ce_net : std_logic;
  signal relational_op_net : std_logic_vector( 1-1 downto 0 );
  signal divide_b_tready_net : std_logic;
  signal divide_a_tready_net : std_logic;
  signal logical1_y_net : std_logic;
  signal inverter_op_net : std_logic_vector( 1-1 downto 0 );
  signal divide_op_net : std_logic_vector( 82-1 downto 0 );
  signal divide_result_tvalid_net : std_logic;
begin
  espected_frequency <= register_q_net;
  cmult_p_net <= inst_freq;
  delay1_q_net <= inst_freq_valid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  accumulator1 : entity xil_defaultlib.sysgen_accum_c364465375 
  port map (
    clr => '0',
    b => cmult_p_net,
    rst => delay1_q_net_x0,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => accumulator1_q_net
  );
  constant_x0 : entity xil_defaultlib.sysgen_constant_216518edcd 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant_op_net
  );
  convert : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 26,
    dout_width => 64,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => counter_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 26,
    din_width => 64,
    dout_arith => 2,
    dout_bin_pt => 26,
    dout_width => 64,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => accumulator1_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  counter : entity xil_defaultlib.ifm_xlcounter_free 
  generic map (
    core_name0 => "ifm_c_counter_binary_v12_0_i0",
    op_arith => xlUnsigned,
    op_width => 16
  )
  port map (
    clr => '0',
    rst => delay1_q_net_x0,
    en => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => logical_y_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net_x0
  );
  divide : entity xil_defaultlib.xldivider_generator_030fd2ddfbdd126871b119df6562236b 
  port map (
    a_tvalid => logical_y_net(0),
    a => convert1_dout_net,
    b_tvalid => logical1_y_net,
    b => convert_dout_net,
    clk => clk_net,
    ce => ce_net,
    a_tready => divide_a_tready_net,
    b_tready => divide_b_tready_net,
    result_tvalid => divide_result_tvalid_net,
    op => divide_op_net
  );
  inverter : entity xil_defaultlib.sysgen_inverter_ce66081e64 
  port map (
    clr => '0',
    ip => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => inverter_op_net
  );
  logical : entity xil_defaultlib.sysgen_logical_9cab5becb9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => delay_q_net,
    d1 => inverter_op_net,
    y => logical_y_net
  );
  logical1 : entity xil_defaultlib.sysgen_logical_9cab5becb9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => logical_y_net,
    d1 => relational_op_net,
    y(0) => logical1_y_net
  );
  register_x0 : entity xil_defaultlib.ifm_xlregister 
  generic map (
    d_width => 82,
    init_value => b"0000000000000000000000000000000000000000000000000000000000000000000000000000000000"
  )
  port map (
    rst => "0",
    d => divide_op_net,
    en(0) => divide_result_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => register_q_net
  );
  relational : entity xil_defaultlib.sysgen_relational_635c380d6f 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant_op_net,
    op => relational_op_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/4 Delay Instantenous Frequency
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_4_delay_instantenous_frequency is
  port (
    real_part : in std_logic_vector( 16-1 downto 0 );
    imag_part : in std_logic_vector( 16-1 downto 0 );
    real_part_d4 : in std_logic_vector( 16-1 downto 0 );
    imag_part_d4 : in std_logic_vector( 16-1 downto 0 );
    datavalid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    inst_freq : out std_logic_vector( 36-1 downto 0 );
    inst_freq_valid : out std_logic_vector( 1-1 downto 0 )
  );
end ifm_4_delay_instantenous_frequency;
architecture structural of ifm_4_delay_instantenous_frequency is 
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal x4_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal d4_q_net : std_logic_vector( 16-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal d4_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert5_dout_net : std_logic_vector( 17-1 downto 0 );
  signal cordic_6_0_m_axis_dout_tdata_phase_net : std_logic_vector( 16-1 downto 0 );
  signal product_p_im_net : std_logic_vector( 35-1 downto 0 );
  signal convert4_dout_net : std_logic_vector( 17-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 17-1 downto 0 );
  signal cordic_6_0_m_axis_dout_tvalid_net : std_logic;
  signal convert1_dout_net : std_logic_vector( 35-1 downto 0 );
  signal delay_q_net : std_logic;
  signal convert2_dout_net : std_logic_vector( 35-1 downto 0 );
  signal product_p_re_net : std_logic_vector( 35-1 downto 0 );
  signal negate_op_net : std_logic_vector( 17-1 downto 0 );
begin
  inst_freq <= cmult_p_net;
  inst_freq_valid <= delay1_q_net;
  real_component_q_net <= real_part;
  imag_component_q_net <= imag_part;
  d4_q_net <= real_part_d4;
  d4_1_q_net <= imag_part_d4;
  x4_tap_envelope_y_net <= datavalid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  cmult : entity xil_defaultlib.ifm_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 13,
    a_width => 16,
    b_bin_pt => 13,
    c_a_type => 0,
    c_a_width => 16,
    c_b_type => 1,
    c_b_width => 20,
    c_output_width => 36,
    core_name0 => "ifm_mult_gen_v12_0_i1",
    extra_registers => 0,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 26,
    p_width => 36,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => cordic_6_0_m_axis_dout_tdata_phase_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  cordic_6_0 : entity xil_defaultlib.xlcordic_0b74b5d3e3217f3b6f828490f82e0b77 
  port map (
    s_axis_cartesian_tvalid => delay_q_net,
    s_axis_cartesian_tdata_imag => convert2_dout_net,
    s_axis_cartesian_tdata_real => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    m_axis_dout_tvalid => cordic_6_0_m_axis_dout_tvalid_net,
    m_axis_dout_tdata_phase => cordic_6_0_m_axis_dout_tdata_phase_net
  );
  convert : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => d4_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert1 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 35,
    dout_arith => 2,
    dout_bin_pt => 33,
    dout_width => 35,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_re_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 35,
    dout_arith => 2,
    dout_bin_pt => 33,
    dout_width => 35,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => product_p_im_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert4 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => imag_component_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert5 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 17,
    latency => 1,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => real_component_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert5_dout_net
  );
  delay : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 5,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => x4_tap_envelope_y_net,
    clk => clk_net,
    ce => ce_net,
    q(0) => delay_q_net
  );
  delay1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d(0) => cordic_6_0_m_axis_dout_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  negate : entity xil_defaultlib.sysgen_negate_1f96a59208 
  port map (
    clr => '0',
    ip => d4_1_q_net,
    clk => clk_net,
    ce => ce_net,
    op => negate_op_net
  );
  product : entity xil_defaultlib.xlifm_cmpy_v6_0_i0_5ea665b0a4fb0bfa292c62e9e1e6ea82 
  port map (
    a_re => convert5_dout_net,
    a_im => convert4_dout_net,
    b_re => convert_dout_net,
    b_im => negate_op_net,
    clk => clk_net,
    ce => ce_net,
    p_re => product_p_re_net,
    p_im => product_p_im_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection/Envelope Detection
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_envelope_detection_x0 is
  port (
    in1 : in std_logic_vector( 16-1 downto 0 );
    in2 : in std_logic_vector( 16-1 downto 0 );
    in3 : in std_logic_vector( 48-1 downto 0 );
    in4 : in std_logic_vector( 96-1 downto 0 );
    in5 : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    envelope_2_delay : out std_logic_vector( 1-1 downto 0 );
    envelope_4_delay : out std_logic_vector( 1-1 downto 0 );
    d2_real : out std_logic_vector( 16-1 downto 0 );
    d2_imag : out std_logic_vector( 16-1 downto 0 );
    d4_real : out std_logic_vector( 16-1 downto 0 );
    d4_imag : out std_logic_vector( 16-1 downto 0 )
  );
end ifm_envelope_detection_x0;
architecture structural of ifm_envelope_detection_x0 is 
  signal d4_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 96-1 downto 0 );
  signal d2_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal d4_q_net : std_logic_vector( 1-1 downto 0 );
  signal d3_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal envelope_detector_op_net : std_logic_vector( 1-1 downto 0 );
  signal threshold_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal d4_q_net_x0 : std_logic_vector( 16-1 downto 0 );
  signal d2_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal x2_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 48-1 downto 0 );
  signal d1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal d2_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal x4_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal d1_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal d3_q_net : std_logic_vector( 16-1 downto 0 );
  signal d3_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal d1_q_net : std_logic_vector( 16-1 downto 0 );
begin
  envelope_2_delay <= x2_tap_envelope_y_net;
  envelope_4_delay <= x4_tap_envelope_y_net;
  d2_real <= d2_q_net;
  d2_imag <= d2_1_q_net;
  d4_real <= d4_q_net_x0;
  d4_imag <= d4_1_q_net;
  real_component_q_net <= in1;
  imag_component_q_net <= in2;
  delay3_q_net <= in3;
  cmult_p_net <= in4;
  threshold_delay_q_net <= in5;
  clk_net <= clk_1;
  ce_net <= ce_1;
  x2_tap_envelope : entity xil_defaultlib.sysgen_logical_2b7798e14d 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d2_q_net_x0,
    d1 => d1_q_net_x0,
    d2 => envelope_detector_op_net,
    y => x2_tap_envelope_y_net
  );
  x4_tap_envelope : entity xil_defaultlib.sysgen_logical_f582056370 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => d4_q_net,
    d1 => d3_q_net_x0,
    d2 => d2_q_net_x0,
    d3 => d1_q_net_x0,
    d4 => envelope_detector_op_net,
    y => x4_tap_envelope_y_net
  );
  d1_x0 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => real_component_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net
  );
  d1_1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => imag_component_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_1_q_net
  );
  d2_x0 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net
  );
  d2_1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d1_1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d2_1_q_net
  );
  d3 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d2_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net
  );
  d3_1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d2_1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d3_1_q_net
  );
  d4 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d3_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d4_q_net_x0
  );
  d4_1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => d3_1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => d4_1_q_net
  );
  envelope_detector : entity xil_defaultlib.sysgen_relational_5a14bcad5f 
  port map (
    clr => '0',
    a => delay3_q_net,
    b => cmult_p_net,
    en => threshold_delay_q_net,
    clk => clk_net,
    ce => ce_net,
    op => envelope_detector_op_net
  );
  d1 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => envelope_detector_op_net,
    clk => clk_net,
    ce => ce_net,
    q => d1_q_net_x0
  );
  d2 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => d1_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d2_q_net_x0
  );
  d3_x0 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => d2_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d3_q_net_x0
  );
  d4_x0 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d => d3_q_net_x0,
    clk => clk_net,
    ce => ce_net,
    q => d4_q_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection/Threshold Detection
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_threshold_detection is
  port (
    real : in std_logic_vector( 16-1 downto 0 );
    imag : in std_logic_vector( 16-1 downto 0 );
    valid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    sync_real_part : out std_logic_vector( 16-1 downto 0 );
    sync_imag_part : out std_logic_vector( 16-1 downto 0 );
    instantaneous_power : out std_logic_vector( 48-1 downto 0 );
    x6db_linearthreshold : out std_logic_vector( 96-1 downto 0 );
    thresholdvalid : out std_logic_vector( 1-1 downto 0 )
  );
end ifm_threshold_detection;
architecture structural of ifm_threshold_detection is 
  signal convert4_dout_net : std_logic_vector( 48-1 downto 0 );
  signal ce_net : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal not_op_net : std_logic_vector( 1-1 downto 0 );
  signal clk_net : std_logic;
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal constant1_op_net : std_logic_vector( 15-1 downto 0 );
  signal delay2_q_net : std_logic_vector( 1-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal threshold_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal and_y_net : std_logic_vector( 1-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 48-1 downto 0 );
  signal constant4_op_net : std_logic_vector( 49-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 96-1 downto 0 );
  signal delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal convert6_dout_net : std_logic_vector( 48-1 downto 0 );
  signal convert_dout_net : std_logic_vector( 48-1 downto 0 );
  signal mean_op_net : std_logic_vector( 78-1 downto 0 );
  signal totalsum_q_net : std_logic_vector( 48-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal sumsquares_s_net : std_logic_vector( 32-1 downto 0 );
  signal counter_op_net : std_logic_vector( 15-1 downto 0 );
  signal squarereal_p_net : std_logic_vector( 32-1 downto 0 );
  signal mean_b_tready_net : std_logic;
  signal squarereal1_p_net : std_logic_vector( 32-1 downto 0 );
  signal mean_a_tready_net : std_logic;
  signal noisesampledone_op_net : std_logic;
  signal mean_result_tvalid_net : std_logic;
begin
  sync_real_part <= real_component_q_net;
  sync_imag_part <= imag_component_q_net;
  instantaneous_power <= delay3_q_net;
  x6db_linearthreshold <= cmult_p_net;
  thresholdvalid <= threshold_delay_q_net;
  convert1_dout_net <= real;
  convert2_dout_net <= imag;
  convert3_dout_net <= valid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  and_x0 : entity xil_defaultlib.sysgen_logical_9cab5becb9 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    d0 => not_op_net,
    d1 => delay2_q_net,
    y => and_y_net
  );
  cmult : entity xil_defaultlib.ifm_xlcmult 
  generic map (
    a_arith => xlSigned,
    a_bin_pt => 30,
    a_width => 48,
    b_bin_pt => 30,
    c_a_type => 0,
    c_a_width => 48,
    c_b_type => 1,
    c_b_width => 48,
    c_output_width => 96,
    core_name0 => "ifm_mult_gen_v12_0_i2",
    extra_registers => 1,
    multsign => 2,
    overflow => 1,
    p_arith => xlSigned,
    p_bin_pt => 60,
    p_width => 96,
    quantization => 1,
    zero_const => 0
  )
  port map (
    clr => '0',
    core_clr => '1',
    en => "1",
    rst => "0",
    a => convert4_dout_net,
    clk => clk_net,
    ce => ce_net,
    core_clk => clk_net,
    core_ce => ce_net,
    p => cmult_p_net
  );
  constant1 : entity xil_defaultlib.sysgen_constant_e6723e7fa6 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant1_op_net
  );
  constant4 : entity xil_defaultlib.sysgen_constant_9d51887daf 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    op => constant4_op_net
  );
  convert : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 30,
    din_width => 48,
    dout_arith => 2,
    dout_bin_pt => 30,
    dout_width => 48,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => totalsum_q_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert_dout_net
  );
  convert4 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 30,
    din_width => 78,
    dout_arith => 2,
    dout_bin_pt => 30,
    dout_width => 48,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => mean_op_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert4_dout_net
  );
  convert6 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 1,
    din_bin_pt => 30,
    din_width => 32,
    dout_arith => 2,
    dout_bin_pt => 30,
    dout_width => 48,
    latency => 0,
    overflow => xlSaturate,
    quantization => xlRound
  )
  port map (
    clr => '0',
    en => "1",
    din => sumsquares_s_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert6_dout_net
  );
  counter : entity xil_defaultlib.ifm_xlcounter_limit 
  generic map (
    cnt_15_0 => 29999,
    cnt_31_16 => 0,
    cnt_47_32 => 0,
    cnt_63_48 => 0,
    core_name0 => "ifm_c_counter_binary_v12_0_i1",
    count_limited => 1,
    op_arith => xlUnsigned,
    op_width => 15
  )
  port map (
    rst => "0",
    clr => '0',
    en => and_y_net,
    clk => clk_net,
    ce => ce_net,
    op => counter_op_net
  );
  delay : entity xil_defaultlib.sysgen_delay_92d447c453 
  port map (
    clr => '0',
    d => convert3_dout_net,
    clk => clk_net,
    ce => ce_net,
    q => delay_q_net
  );
  delay1 : entity xil_defaultlib.sysgen_delay_4ebe46bb0c 
  port map (
    clr => '0',
    d => delay_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay1_q_net
  );
  delay2 : entity xil_defaultlib.sysgen_delay_4ebe46bb0c 
  port map (
    clr => '0',
    d => delay1_q_net,
    clk => clk_net,
    ce => ce_net,
    q => delay2_q_net
  );
  delay3 : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 3,
    reg_retiming => 0,
    reset => 0,
    width => 48
  )
  port map (
    en => '1',
    rst => '0',
    d => convert6_dout_net,
    clk => clk_net,
    ce => ce_net,
    q => delay3_q_net
  );
  imag_component : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 8,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => convert2_dout_net,
    clk => clk_net,
    ce => ce_net,
    q => imag_component_q_net
  );
  mean : entity xil_defaultlib.xldivider_generator_86e5138b47e8f2772ffbabe267eef721 
  port map (
    a_tvalid => noisesampledone_op_net,
    a => convert_dout_net,
    b_tvalid => noisesampledone_op_net,
    b => constant4_op_net,
    clk => clk_net,
    ce => ce_net,
    a_tready => mean_a_tready_net,
    b_tready => mean_b_tready_net,
    result_tvalid => mean_result_tvalid_net,
    op => mean_op_net
  );
  not_x0 : entity xil_defaultlib.sysgen_inverter_ce66081e64 
  port map (
    clr => '0',
    ip(0) => noisesampledone_op_net,
    clk => clk_net,
    ce => ce_net,
    op => not_op_net
  );
  noisesampledone : entity xil_defaultlib.sysgen_relational_1984f87bf5 
  port map (
    clk => '0',
    ce => '0',
    clr => '0',
    a => counter_op_net,
    b => constant1_op_net,
    op(0) => noisesampledone_op_net
  );
  real_component : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 8,
    reg_retiming => 0,
    reset => 0,
    width => 16
  )
  port map (
    en => '1',
    rst => '0',
    d => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    q => real_component_q_net
  );
  squarereal : entity xil_defaultlib.sysgen_mult_d56b16d14a 
  port map (
    clr => '0',
    a => convert1_dout_net,
    b => convert1_dout_net,
    clk => clk_net,
    ce => ce_net,
    p => squarereal_p_net
  );
  squarereal1 : entity xil_defaultlib.sysgen_mult_d56b16d14a 
  port map (
    clr => '0',
    a => convert2_dout_net,
    b => convert2_dout_net,
    clk => clk_net,
    ce => ce_net,
    p => squarereal1_p_net
  );
  sumsquares : entity xil_defaultlib.sysgen_addsub_0568f462dc 
  port map (
    clr => '0',
    a => squarereal_p_net,
    b => squarereal1_p_net,
    clk => clk_net,
    ce => ce_net,
    s => sumsquares_s_net
  );
  threshold_delay : entity xil_defaultlib.ifm_xldelay 
  generic map (
    latency => 1,
    reg_retiming => 0,
    reset => 0,
    width => 1
  )
  port map (
    en => '1',
    rst => '0',
    d(0) => mean_result_tvalid_net,
    clk => clk_net,
    ce => ce_net,
    q => threshold_delay_q_net
  );
  totalsum : entity xil_defaultlib.sysgen_accum_da17290608 
  port map (
    clr => '0',
    b => sumsquares_s_net,
    en => not_op_net,
    clk => clk_net,
    ce => ce_net,
    q => totalsum_q_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM/Envelope Detection
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_envelope_detection is
  port (
    real : in std_logic_vector( 16-1 downto 0 );
    imag : in std_logic_vector( 16-1 downto 0 );
    valid : in std_logic_vector( 1-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    envelope_2_delay : out std_logic_vector( 1-1 downto 0 );
    envelope_4_delay : out std_logic_vector( 1-1 downto 0 );
    original_real : out std_logic_vector( 16-1 downto 0 );
    original_imag : out std_logic_vector( 16-1 downto 0 );
    d2_real : out std_logic_vector( 16-1 downto 0 );
    d2_imag : out std_logic_vector( 16-1 downto 0 );
    d4_real : out std_logic_vector( 16-1 downto 0 );
    d4_imag : out std_logic_vector( 16-1 downto 0 )
  );
end ifm_envelope_detection;
architecture structural of ifm_envelope_detection is 
  signal x2_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal x4_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal d2_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal d4_q_net : std_logic_vector( 16-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal d2_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay3_q_net : std_logic_vector( 48-1 downto 0 );
  signal d4_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal ce_net : std_logic;
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 96-1 downto 0 );
  signal threshold_delay_q_net : std_logic_vector( 1-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
begin
  envelope_2_delay <= x2_tap_envelope_y_net;
  envelope_4_delay <= x4_tap_envelope_y_net;
  original_real <= real_component_q_net;
  original_imag <= imag_component_q_net;
  d2_real <= d2_q_net;
  d2_imag <= d2_1_q_net;
  d4_real <= d4_q_net;
  d4_imag <= d4_1_q_net;
  convert1_dout_net <= real;
  convert2_dout_net <= imag;
  convert3_dout_net <= valid;
  clk_net <= clk_1;
  ce_net <= ce_1;
  envelope_detection : entity xil_defaultlib.ifm_envelope_detection_x0 
  port map (
    in1 => real_component_q_net,
    in2 => imag_component_q_net,
    in3 => delay3_q_net,
    in4 => cmult_p_net,
    in5 => threshold_delay_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    envelope_2_delay => x2_tap_envelope_y_net,
    envelope_4_delay => x4_tap_envelope_y_net,
    d2_real => d2_q_net,
    d2_imag => d2_1_q_net,
    d4_real => d4_q_net,
    d4_imag => d4_1_q_net
  );
  threshold_detection : entity xil_defaultlib.ifm_threshold_detection 
  port map (
    real => convert1_dout_net,
    imag => convert2_dout_net,
    valid => convert3_dout_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    sync_real_part => real_component_q_net,
    sync_imag_part => imag_component_q_net,
    instantaneous_power => delay3_q_net,
    x6db_linearthreshold => cmult_p_net,
    thresholdvalid => threshold_delay_q_net
  );
end structural;
-- Generated from Simulink block IFM_ModelComposer/IFM_struct
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_struct is
  port (
    datavalid : in std_logic_vector( 1-1 downto 0 );
    imagpart : in std_logic_vector( 16-1 downto 0 );
    realpart : in std_logic_vector( 16-1 downto 0 );
    clk_1 : in std_logic;
    ce_1 : in std_logic;
    gateway_out : out std_logic_vector( 82-1 downto 0 );
    gateway_out1 : out std_logic_vector( 82-1 downto 0 )
  );
end ifm_struct;
architecture structural of ifm_struct is 
  signal d4_q_net : std_logic_vector( 16-1 downto 0 );
  signal delay1_q_net : std_logic_vector( 1-1 downto 0 );
  signal d4_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal x4_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal convert1_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert2_dout_net : std_logic_vector( 16-1 downto 0 );
  signal convert3_dout_net : std_logic_vector( 1-1 downto 0 );
  signal d2_q_net : std_logic_vector( 16-1 downto 0 );
  signal datavalid_net : std_logic_vector( 1-1 downto 0 );
  signal register_q_net : std_logic_vector( 82-1 downto 0 );
  signal real_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal register_q_net_x0 : std_logic_vector( 82-1 downto 0 );
  signal realpart_net : std_logic_vector( 16-1 downto 0 );
  signal imagpart_net : std_logic_vector( 16-1 downto 0 );
  signal clk_net : std_logic;
  signal ce_net : std_logic;
  signal cmult_p_net_x0 : std_logic_vector( 36-1 downto 0 );
  signal delay1_q_net_x0 : std_logic_vector( 1-1 downto 0 );
  signal imag_component_q_net : std_logic_vector( 16-1 downto 0 );
  signal d2_1_q_net : std_logic_vector( 16-1 downto 0 );
  signal x2_tap_envelope_y_net : std_logic_vector( 1-1 downto 0 );
  signal cmult_p_net : std_logic_vector( 36-1 downto 0 );
begin
  datavalid_net <= datavalid;
  gateway_out <= register_q_net_x0;
  gateway_out1 <= register_q_net;
  imagpart_net <= imagpart;
  realpart_net <= realpart;
  clk_net <= clk_1;
  ce_net <= ce_1;
  x2_delay_avarage_freq : entity xil_defaultlib.ifm_2_delay_avarage_freq 
  port map (
    inst_freq => cmult_p_net_x0,
    inst_freq_valid => delay1_q_net_x0,
    clk_1 => clk_net,
    ce_1 => ce_net,
    espected_frequency => register_q_net_x0
  );
  x2_delay_instantenous_frequency : entity xil_defaultlib.ifm_2_delay_instantenous_frequency 
  port map (
    real_part => real_component_q_net,
    imag_part => imag_component_q_net,
    real_part_d2 => d2_q_net,
    imag_part_d2 => d2_1_q_net,
    datavalid => x2_tap_envelope_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    inst_freq => cmult_p_net_x0,
    inst_freq_valid => delay1_q_net_x0
  );
  x4_delay_avarage_freq : entity xil_defaultlib.ifm_4_delay_avarage_freq 
  port map (
    inst_freq => cmult_p_net,
    inst_freq_valid => delay1_q_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    espected_frequency => register_q_net
  );
  x4_delay_instantenous_frequency : entity xil_defaultlib.ifm_4_delay_instantenous_frequency 
  port map (
    real_part => real_component_q_net,
    imag_part => imag_component_q_net,
    real_part_d4 => d4_q_net,
    imag_part_d4 => d4_1_q_net,
    datavalid => x4_tap_envelope_y_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    inst_freq => cmult_p_net,
    inst_freq_valid => delay1_q_net
  );
  envelope_detection : entity xil_defaultlib.ifm_envelope_detection 
  port map (
    real => convert1_dout_net,
    imag => convert2_dout_net,
    valid => convert3_dout_net,
    clk_1 => clk_net,
    ce_1 => ce_net,
    envelope_2_delay => x2_tap_envelope_y_net,
    envelope_4_delay => x4_tap_envelope_y_net,
    original_real => real_component_q_net,
    original_imag => imag_component_q_net,
    d2_real => d2_q_net,
    d2_imag => d2_1_q_net,
    d4_real => d4_q_net,
    d4_imag => d4_1_q_net
  );
  convert1 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => realpart_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert1_dout_net
  );
  convert2 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 0,
    din_arith => 2,
    din_bin_pt => 15,
    din_width => 16,
    dout_arith => 2,
    dout_bin_pt => 15,
    dout_width => 16,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => imagpart_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert2_dout_net
  );
  convert3 : entity xil_defaultlib.ifm_xlconvert 
  generic map (
    bool_conversion => 1,
    din_arith => 1,
    din_bin_pt => 0,
    din_width => 1,
    dout_arith => 1,
    dout_bin_pt => 0,
    dout_width => 1,
    latency => 0,
    overflow => xlWrap,
    quantization => xlTruncate
  )
  port map (
    clr => '0',
    en => "1",
    din => datavalid_net,
    clk => clk_net,
    ce => ce_net,
    dout => convert3_dout_net
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm_default_clock_driver is
  port (
    ifm_sysclk : in std_logic;
    ifm_sysce : in std_logic;
    ifm_sysclr : in std_logic;
    ifm_clk1 : out std_logic;
    ifm_ce1 : out std_logic
  );
end ifm_default_clock_driver;
architecture structural of ifm_default_clock_driver is 
begin
  clockdriver : entity xil_defaultlib.xlclockdriver 
  generic map (
    period => 1,
    log_2_period => 1
  )
  port map (
    sysclk => ifm_sysclk,
    sysce => ifm_sysce,
    sysclr => ifm_sysclr,
    clk => ifm_clk1,
    ce => ifm_ce1
  );
end structural;
-- Generated from Simulink block 
library IEEE;
use IEEE.std_logic_1164.all;
library xil_defaultlib;
use xil_defaultlib.conv_pkg.all;
entity ifm is
  port (
    datavalid : in std_logic_vector( 1-1 downto 0 );
    imagpart : in std_logic_vector( 16-1 downto 0 );
    realpart : in std_logic_vector( 16-1 downto 0 );
    clk : in std_logic;
    gateway_out : out std_logic_vector( 82-1 downto 0 );
    gateway_out1 : out std_logic_vector( 82-1 downto 0 )
  );
end ifm;
architecture structural of ifm is 
  attribute core_generation_info : string;
  attribute core_generation_info of structural : architecture is "ifm,sysgen_core_2025_1,{,compilation=IP Catalog,block_icon_display=Default,family=zynquplus,part=xczu9eg,speed=-2-e,package=ffvb1156,synthesis_language=vhdl,hdl_library=xil_defaultlib,synthesis_strategy=Vivado Synthesis Defaults,implementation_strategy=Vivado Implementation Defaults,testbench=1,interface_doc=0,ce_clr=0,clock_period=3.33333,system_simulink_period=3.33333e-09,waveform_viewer=0,axilite_interface=0,ip_catalog_plugin=0,hwcosim_burst_mode=0,simulation_time=0.0002,accum=3,addsub=1,cmult=3,constant=4,convert=20,cordic_v6_0=2,counter=3,delay=27,divide=3,inv=3,logical=7,mult=2,negate=2,product_macro=2,register=2,relational=4,}";
  signal clk_1_net : std_logic;
  signal ce_1_net : std_logic;
begin
  ifm_default_clock_driver : entity xil_defaultlib.ifm_default_clock_driver 
  port map (
    ifm_sysclk => clk,
    ifm_sysce => '1',
    ifm_sysclr => '0',
    ifm_clk1 => clk_1_net,
    ifm_ce1 => ce_1_net
  );
  ifm_struct : entity xil_defaultlib.ifm_struct 
  port map (
    datavalid => datavalid,
    imagpart => imagpart,
    realpart => realpart,
    clk_1 => clk_1_net,
    ce_1 => ce_1_net,
    gateway_out => gateway_out,
    gateway_out1 => gateway_out1
  );
end structural;
