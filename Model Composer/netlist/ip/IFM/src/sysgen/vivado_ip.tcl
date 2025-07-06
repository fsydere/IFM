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
lappend params_list CONFIG.Input_Width {35}
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
lappend params_list CONFIG.APortWidth {17}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.ATUSERWidth {1}
lappend params_list CONFIG.BPortWidth {17}
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
lappend params_list CONFIG.MinimumLatency {4}
lappend params_list CONFIG.MultType {Use_Mults}
lappend params_list CONFIG.OptimizeGoal {Performance}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutputWidth {35}
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
if {[lsearch $existingipslist ifm_mult_gen_v12_0_i2] < 0} {
create_ip -name mult_gen -version 12.0 -vendor xilinx.com -library ip -module_name ifm_mult_gen_v12_0_i2
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_mult_gen_v12_0_i2}
lappend params_list CONFIG.ccmimp {Distributed_Memory}
lappend params_list CONFIG.clockenable {false}
lappend params_list CONFIG.constvalue {4294967296}
lappend params_list CONFIG.internaluser {0}
lappend params_list CONFIG.multtype {Constant_Coefficient_Multiplier}
lappend params_list CONFIG.outputwidthhigh {95}
lappend params_list CONFIG.outputwidthlow {0}
lappend params_list CONFIG.pipestages {0}
lappend params_list CONFIG.portatype {Signed}
lappend params_list CONFIG.portawidth {48}
lappend params_list CONFIG.portbtype {Unsigned}
lappend params_list CONFIG.portbwidth {48}
lappend params_list CONFIG.syncclear {false}
lappend params_list CONFIG.use_custom_output_width {true}

set_property -dict $params_list [get_ips ifm_mult_gen_v12_0_i2]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_c_counter_binary_v12_0_i1] < 0} {
create_ip -name c_counter_binary -version 12.0 -vendor xilinx.com -library ip -module_name ifm_c_counter_binary_v12_0_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_c_counter_binary_v12_0_i1}
lappend params_list CONFIG.ainit_value {0}
lappend params_list CONFIG.ce {true}
lappend params_list CONFIG.count_mode {UP}
lappend params_list CONFIG.fb_latency {0}
lappend params_list CONFIG.final_count_value {1}
lappend params_list CONFIG.implementation {Fabric}
lappend params_list CONFIG.increment_value {1}
lappend params_list CONFIG.latency {1}
lappend params_list CONFIG.load {false}
lappend params_list CONFIG.output_width {15}
lappend params_list CONFIG.restrict_count {false}
lappend params_list CONFIG.sclr {false}
lappend params_list CONFIG.sinit {true}
lappend params_list CONFIG.sinit_value {0}
lappend params_list CONFIG.sset {false}
lappend params_list CONFIG.sync_ce_priority {Sync_Overrides_CE}
lappend params_list CONFIG.sync_threshold_output {false}
lappend params_list CONFIG.syncctrlpriority {Reset_Overrides_Set}

set_property -dict $params_list [get_ips ifm_c_counter_binary_v12_0_i1]
}


set existingipslist [get_ips]
if {[lsearch $existingipslist ifm_div_gen_v5_1_i1] < 0} {
create_ip -name div_gen -version 5.1 -vendor xilinx.com -library ip -module_name ifm_div_gen_v5_1_i1
set params_list [list]
lappend params_list CONFIG.Component_Name {ifm_div_gen_v5_1_i1}
lappend params_list CONFIG.ACLKEN {false}
lappend params_list CONFIG.ARESETN {false}
lappend params_list CONFIG.FlowControl {Blocking}
lappend params_list CONFIG.OptimizeGoal {Resources}
lappend params_list CONFIG.OutTLASTBehv {Null}
lappend params_list CONFIG.OutTready {false}
lappend params_list CONFIG.algorithm_type {Radix2}
lappend params_list CONFIG.clocks_per_division {1}
lappend params_list CONFIG.divide_by_zero_detect {false}
lappend params_list CONFIG.dividend_and_quotient_width {48}
lappend params_list CONFIG.dividend_has_tlast {false}
lappend params_list CONFIG.dividend_has_tuser {false}
lappend params_list CONFIG.dividend_tuser_width {1}
lappend params_list CONFIG.divisor_has_tlast {false}
lappend params_list CONFIG.divisor_has_tuser {false}
lappend params_list CONFIG.divisor_tuser_width {1}
lappend params_list CONFIG.divisor_width {49}
lappend params_list CONFIG.fractional_width {30}
lappend params_list CONFIG.latency {83}
lappend params_list CONFIG.latency_configuration {Automatic}
lappend params_list CONFIG.operand_sign {Signed}
lappend params_list CONFIG.remainder_type {Fractional}

set_property -dict $params_list [get_ips ifm_div_gen_v5_1_i1]
}


validate_ip [get_ips]
