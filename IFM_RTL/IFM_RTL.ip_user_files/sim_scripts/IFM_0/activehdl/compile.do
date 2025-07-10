transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib activehdl/xbip_utils_v3_0_14
vlib activehdl/c_reg_fd_v12_0_10
vlib activehdl/xbip_dsp48_wrapper_v3_0_7
vlib activehdl/xbip_pipe_v3_0_10
vlib activehdl/c_addsub_v12_0_20
vlib activehdl/c_counter_binary_v12_0_21
vlib activehdl/xil_defaultlib
vlib activehdl/axi_utils_v2_0_10
vlib activehdl/mult_gen_v12_0_23
vlib activehdl/floating_point_v7_1_20
vlib activehdl/cmpy_v6_0_26
vlib activehdl/cordic_v6_0_24
vlib activehdl/floating_point_v7_0_25
vlib activehdl/div_gen_v5_1_24

vmap xbip_utils_v3_0_14 activehdl/xbip_utils_v3_0_14
vmap c_reg_fd_v12_0_10 activehdl/c_reg_fd_v12_0_10
vmap xbip_dsp48_wrapper_v3_0_7 activehdl/xbip_dsp48_wrapper_v3_0_7
vmap xbip_pipe_v3_0_10 activehdl/xbip_pipe_v3_0_10
vmap c_addsub_v12_0_20 activehdl/c_addsub_v12_0_20
vmap c_counter_binary_v12_0_21 activehdl/c_counter_binary_v12_0_21
vmap xil_defaultlib activehdl/xil_defaultlib
vmap axi_utils_v2_0_10 activehdl/axi_utils_v2_0_10
vmap mult_gen_v12_0_23 activehdl/mult_gen_v12_0_23
vmap floating_point_v7_1_20 activehdl/floating_point_v7_1_20
vmap cmpy_v6_0_26 activehdl/cmpy_v6_0_26
vmap cordic_v6_0_24 activehdl/cordic_v6_0_24
vmap floating_point_v7_0_25 activehdl/floating_point_v7_0_25
vmap div_gen_v5_1_24 activehdl/div_gen_v5_1_24

vcom -work xbip_utils_v3_0_14 -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_10 -93  \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_7 -93  \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_10 -93  \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work c_addsub_v12_0_20 -93  \
"../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \

vcom -work c_counter_binary_v12_0_21 -93  \
"../../../ipstatic/hdl/c_counter_binary_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_c_counter_binary_v12_0_i0/sim/ifm_c_counter_binary_v12_0_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_c_counter_binary_v12_0_i1/sim/ifm_c_counter_binary_v12_0_i1.vhd" \

vcom -work axi_utils_v2_0_10 -93  \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_23 -93  \
"../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work floating_point_v7_1_20 -93  \
"../../../ipstatic/hdl/floating_point_v7_1_vh_rfs.vhd" \

vcom -work cmpy_v6_0_26 -93  \
"../../../ipstatic/hdl/cmpy_v6_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_cmpy_v6_0_i0/sim/ifm_cmpy_v6_0_i0.vhd" \

vcom -work cordic_v6_0_24 -93  \
"../../../ipstatic/hdl/cordic_v6_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_cordic_v6_0_i0/sim/ifm_cordic_v6_0_i0.vhd" \

vcom -work floating_point_v7_0_25 -93  \
"../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work div_gen_v5_1_24 -93  \
"../../../ipstatic/hdl/div_gen_v5_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_div_gen_v5_1_i0/sim/ifm_div_gen_v5_1_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_div_gen_v5_1_i1/sim/ifm_div_gen_v5_1_i1.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i0/sim/ifm_mult_gen_v12_0_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i1/sim/ifm_mult_gen_v12_0_i1.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i2/sim/ifm_mult_gen_v12_0_i2.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../ipstatic/work/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" -l xbip_utils_v3_0_14 -l c_reg_fd_v12_0_10 -l xbip_dsp48_wrapper_v3_0_7 -l xbip_pipe_v3_0_10 -l c_addsub_v12_0_20 -l c_counter_binary_v12_0_21 -l xil_defaultlib -l axi_utils_v2_0_10 -l mult_gen_v12_0_23 -l floating_point_v7_1_20 -l cmpy_v6_0_26 -l cordic_v6_0_24 -l floating_point_v7_0_25 -l div_gen_v5_1_24 \
"../../../ipstatic/work/hdl/synth_reg.v" \
"../../../ipstatic/work/hdl/synth_reg_w_init.v" \
"../../../ipstatic/work/hdl/convert_type.v" \
"../../../ipstatic/work/hdl/xlclockdriver_rd.v" \
"../../../ipstatic/work/hdl/ifm_entity_declarations.v" \
"../../../ipstatic/work/hdl/ifm.v" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/sim/IFM_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

