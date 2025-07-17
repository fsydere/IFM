#-----------------------------------------------------------------
# Vitis Model Composer version 2025.1 IP Tcl source file.
#
# Copyright(C) 1995-2022 by Xilinx, Inc. All rights reserved.
# Copyright(C) 2022-2025 by Advanced Micro Devices, Inc. All rights reserved.
#
# This text/file contains proprietary, confidential information of Xilinx,
# Inc., is distributed under license from Xilinx, Inc., and may be used,
# copied and/or disclosed only pursuant to the terms of a valid license
# agreement with Xilinx, Inc.  Xilinx hereby grants you a license to use
# this text/file solely for design, simulation, implementation and
# creation of design files limited to Xilinx devices or technologies.
# Use with non-Xilinx devices or technologies is expressly prohibited
# and immediately terminates your license unless covered by a separate
# agreement.
#
# Xilinx is providing this design, code, or information "as is" solely
# for use in developing programs and solutions for Xilinx devices.  By
# providing this design, code, or information as one possible
# implementation of this feature, application or standard, Xilinx is
# making no representation that this implementation is free from any
# claims of infringement.  You are responsible for obtaining any rights
# you may require for your implementation.  Xilinx expressly disclaims
# any warranty whatsoever with respect to the adequacy of the
# implementation, including but not limited to warranties of
# merchantability or fitness for a particular purpose.
#
# Xilinx products are not intended for use in life support appliances,
# devices, or systems.  Use in such applications is expressly prohibited.
#
# Any modifications that are made to the source code are done at the user's
# sole risk and will be unsupported.
#
# This copyright and support notice must be retained as part of this
# text at all times.
#-----------------------------------------------------------------

set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_c_counter_binary_v12_0_i0] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name ifm_c_counter_binary_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_c_counter_binary_v12_0_i0}
lappend params_list CONFIG.ainit_value {0}
lappend params_list CONFIG.ce {true}
lappend params_list CONFIG.count_mode {UP}
lappend params_list CONFIG.fb_latency {0}
lappend params_list CONFIG.final_count_value {1}
lappend params_list CONFIG.implementation {Fabric}
lappend params_list CONFIG.increment_value {1}
lappend params_list CONFIG.latency {1}
lappend params_list CONFIG.load {false}
lappend params_list CONFIG.output_width {16}
lappend params_list CONFIG.restrict_count {false}
lappend params_list CONFIG.sclr {false}
lappend params_list CONFIG.sinit {true}
lappend params_list CONFIG.sinit_value {0}
lappend params_list CONFIG.sset {false}
lappend params_list CONFIG.sync_ce_priority {Sync_Overrides_CE}
lappend params_list CONFIG.sync_threshold_output {false}
lappend params_list CONFIG.syncctrlpriority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips ifm_c_counter_binary_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_div_gen_v5_1_i0] < 0} {
create_ip -name div_gen -version 5.1 -vendor xilinx.com -library ip -module_name ifm_div_gen_v5_1_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_div_gen_v5_1_i0}
lappend params_list CONFIG.ACLKEN {false}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.FlowControl {Blocking}
lappend params_list CONFIG.OptimizeGoal {Resources}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutTready {false}
lappend params_list CONFIG.algorithm_type {High_Radix}
lappend params_list CONFIG.clocks_per_division {1}
lappend params_list CONFIG.divide_by_zero_detect {false}
lappend params_list CONFIG.dividend_and_quotient_width {64}
lappend params_list CONFIG.dividend_has_tlast {false}
lappend params_list CONFIG.dividend_has_tuser {false}
lappend params_list CONFIG.dividend_tuser_width {1}
lappend params_list CONFIG.divisor_has_tlast {false}
lappend params_list CONFIG.divisor_has_tuser {false}
lappend params_list CONFIG.divisor_tuser_width {1}
lappend params_list CONFIG.divisor_width {64}
lappend params_list CONFIG.fractional_width {18}
lappend params_list CONFIG.latency {45}
lappend params_list CONFIG.latency_configuration {Automatic}
lappend params_list CONFIG.operand_sign {Signed}
lappend params_list CONFIG.remainder_type {Fractional}

set_property -dict $params_list [get_ips ifm_div_gen_v5_1_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_mult_gen_v12_0_i0] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name ifm_mult_gen_v12_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_mult_gen_v12_0_i0}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {true}
lappend params_list CONFIG.constvalue {195570}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {35}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {1}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {16}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {20}
lappend params_list CONFIG.syncclear {true}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips ifm_mult_gen_v12_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_cordic_v6_0_i0] < 0} {
create_ip -name cordic -version 6.0 -vendor xilinx.com -library ip -module_name ifm_cordic_v6_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_cordic_v6_0_i0}
lappend params_list CONFIG.ACLKEN {true}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.Architectural_Configuration {Parallel}
lappend params_list CONFIG.Coarse_Rotation {true}
lappend params_list CONFIG.Compensation_Scaling {No_Scale_Compensation}
lappend params_list CONFIG.Data_Format {SignedFraction}
lappend params_list CONFIG.Functional_Selection {Arc_Tan}
lappend params_list CONFIG.Input_Width {32}
lappend params_list CONFIG.Iterations {0}
lappend params_list CONFIG.Output_Width {16}
lappend params_list CONFIG.Phase_Format {Radians}
lappend params_list CONFIG.Pipelining_Mode {Maximum}
lappend params_list CONFIG.Precision {0}
lappend params_list CONFIG.Round_Mode {Truncate}
lappend params_list CONFIG.cartesian_has_tlast {false}
lappend params_list CONFIG.cartesian_has_tuser {false}
lappend params_list CONFIG.cartesian_tuser_width {1}
lappend params_list CONFIG.flow_control {NonBlocking}
lappend params_list CONFIG.optimize_goal {Performance}
lappend params_list CONFIG.out_tlast_behv {Null}
lappend params_list CONFIG.out_tready {false}
lappend params_list CONFIG.phase_has_tlast {false}
lappend params_list CONFIG.phase_has_tuser {false}
lappend params_list CONFIG.phase_tuser_width {1}

set_property -dict $params_list [get_ips ifm_cordic_v6_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_cmpy_v6_0_i0] < 0} {
create_ip -name cmpy -version 6.0 -vendor xilinx.com -library ip -module_name ifm_cmpy_v6_0_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_cmpy_v6_0_i0}
lappend params_list CONFIG.ACLKEN {true}
lappend params_list CONFIG.APortWidth {32}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.ATUSERWidth {1}
lappend params_list CONFIG.BPortWidth {32}
lappend params_list CONFIG.BTUSERWidth {1}
lappend params_list CONFIG.CTRLTUSERWidth {1}
lappend params_list CONFIG.FlowControl {NonBlocking}
lappend params_list CONFIG.HasATLAST {false}
lappend params_list CONFIG.HasATUSER {false}
lappend params_list CONFIG.HasBTLAST {false}
lappend params_list CONFIG.HasBTUSER {false}
lappend params_list CONFIG.HasCTRLTLAST {false}
lappend params_list CONFIG.HasCTRLTUSER {false}
lappend params_list CONFIG.LatencyConfig {Manual}
lappend params_list CONFIG.MinimumLatency {10}
lappend params_list CONFIG.MultType {Use_Mults}
lappend params_list CONFIG.OptimizeGoal {Performance}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutputWidth {65}
lappend params_list CONFIG.RoundMode {Truncate}

set_property -dict $params_list [get_ips ifm_cmpy_v6_0_i0]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_mult_gen_v12_0_i1] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name ifm_mult_gen_v12_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_mult_gen_v12_0_i1}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {true}
lappend params_list CONFIG.constvalue {97785}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {35}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {1}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {16}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {20}
lappend params_list CONFIG.syncclear {true}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips ifm_mult_gen_v12_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_fir_compiler_v7_2_i0] < 0} {
create_ip -name fir_compiler -version 7.2 -vendor xilinx.com -library ip -module_name ifm_fir_compiler_v7_2_i0
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_fir_compiler_v7_2_i0}
lappend params_list CONFIG.BestPrecision {false}
lappend params_list CONFIG.Blank_Output {false}
lappend params_list CONFIG.Channel_Sequence {Basic}
lappend params_list CONFIG.Clock_Frequency {300.0}
lappend params_list CONFIG.CoefficientSource {Vector}
lappend params_list CONFIG.CoefficientVector {binary:16C174A7DE01A2BF2BB8172D6C94A43F822E23DFD6947EBC5A9B87A5CACFACBF20C174A7DE01B23F822E23DFD6947EBC1BC174A7DE01C2BF1CC174A7DE01D23FB20365A640C6E53F1CC174A7DE01D23F1BC174A7DE01C2BF822E23DFD6947EBC20C174A7DE01B23F5A9B87A5CACFACBF822E23DFD6947EBC2BB8172D6C94A43F16C174A7DE01A2BF}
lappend params_list CONFIG.Coefficient_Buffer_Type {Automatic}
lappend params_list CONFIG.Coefficient_Fanout {false}
lappend params_list CONFIG.Coefficient_File {no_coe_file_loaded}
lappend params_list CONFIG.Coefficient_Fractional_Bits {15}
lappend params_list CONFIG.Coefficient_Reload {false}
lappend params_list CONFIG.Coefficient_Sets {1}
lappend params_list CONFIG.Coefficient_Sign {Signed}
lappend params_list CONFIG.Coefficient_Structure {Inferred}
lappend params_list CONFIG.Coefficient_Width {16}
lappend params_list CONFIG.ColumnConfig {9}
lappend params_list CONFIG.Control_Broadcast_Fanout {false}
lappend params_list CONFIG.Control_Column_Fanout {false}
lappend params_list CONFIG.Control_LUT_Pipeline {false}
lappend params_list CONFIG.Control_Path_Fanout {false}
lappend params_list CONFIG.DATA_Has_TLAST {Not_Required}
lappend params_list CONFIG.DATA_TUSER_Width {1}
lappend params_list CONFIG.Data_Buffer_Type {Automatic}
lappend params_list CONFIG.Data_Fractional_Bits {15}
lappend params_list CONFIG.Data_Path_Broadcast {false}
lappend params_list CONFIG.Data_Path_Fanout {false}
lappend params_list CONFIG.Data_Sign {Signed}
lappend params_list CONFIG.Data_Width {16}
lappend params_list CONFIG.Decimation_Rate {1}
lappend params_list CONFIG.Disable_Half_Band_Centre_Tap {false}
lappend params_list CONFIG.DisplayReloadOrder {false}
lappend params_list CONFIG.Filter_Architecture {Systolic_Multiply_Accumulate}
lappend params_list CONFIG.Filter_Selection {1}
lappend params_list CONFIG.Filter_Type {Single_Rate}
lappend params_list CONFIG.GUI_Behaviour {Sysgen_uUPP}
lappend params_list CONFIG.Gen_MIF_Files {false}
lappend params_list CONFIG.Gen_MIF_from_COE {false}
lappend params_list CONFIG.Gen_MIF_from_Spec {false}
lappend params_list CONFIG.HardwareOversamplingRate {1}
lappend params_list CONFIG.Has_ACLKEN {true}
lappend params_list CONFIG.Has_ARESETn {false}
lappend params_list CONFIG.Input_Buffer_Type {Automatic}
lappend params_list CONFIG.Inter_Column_Pipe_Length {4}
lappend params_list CONFIG.Interpolation_Rate {1}
lappend params_list CONFIG.M_DATA_Has_TREADY {false}
lappend params_list CONFIG.M_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.Multi_Column_Support {Automatic}
lappend params_list CONFIG.No_BRAM_Read_First_Mode {false}
lappend params_list CONFIG.No_SRL_Attributes {false}
lappend params_list CONFIG.Num_Reload_Slots {1}
lappend params_list CONFIG.Number_Channels {1}
lappend params_list CONFIG.Number_Paths {1}
lappend params_list CONFIG.Optimal_Column_Lengths {false}
lappend params_list CONFIG.Optimization_Goal {Area}
lappend params_list CONFIG.Optimization_List {None}
lappend params_list CONFIG.Optimization_Selection {None}
lappend params_list CONFIG.Other {false}
lappend params_list CONFIG.Output_Buffer_Type {Automatic}
lappend params_list CONFIG.Output_Rounding_Mode {Full_Precision}
lappend params_list CONFIG.Output_Width {32}
lappend params_list CONFIG.Passband_Max {0.50000000}
lappend params_list CONFIG.Passband_Min {0.00000000}
lappend params_list CONFIG.Pattern_List {P4-0,P4-1,P4-2,P4-3,P4-4}
lappend params_list CONFIG.Pre_Adder_Pipeline {false}
lappend params_list CONFIG.Preference_For_Other_Storage {Automatic}
lappend params_list CONFIG.Quantization {Quantize_Only}
lappend params_list CONFIG.RateSpecification {Maximum_Possible}
lappend params_list CONFIG.Rate_Change_Type {Integer}
lappend params_list CONFIG.Reload_File {no_coe_file_loaded}
lappend params_list CONFIG.Reset_Data_Vector {true}
lappend params_list CONFIG.S_CONFIG_Method {Single}
lappend params_list CONFIG.S_CONFIG_Sync_Mode {On_Vector}
lappend params_list CONFIG.S_DATA_Has_FIFO {false}
lappend params_list CONFIG.S_DATA_Has_TUSER {Not_Required}
lappend params_list CONFIG.SamplePeriod {1}
lappend params_list CONFIG.Sample_Frequency {0.001}
lappend params_list CONFIG.Select_Pattern {All}
lappend params_list CONFIG.Stopband_Max {1.00000000}
lappend params_list CONFIG.Stopband_Min {0.50000000}
lappend params_list CONFIG.Zero_Pack_Factor {1}

set_property -dict $params_list [get_ips ifm_fir_compiler_v7_2_i0]
}


validate_ip [get_ips]
