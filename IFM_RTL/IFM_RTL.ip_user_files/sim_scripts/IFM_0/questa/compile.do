vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xbip_utils_v3_0_14
vlib questa_lib/msim/c_reg_fd_v12_0_10
vlib questa_lib/msim/xbip_dsp48_wrapper_v3_0_7
vlib questa_lib/msim/xbip_pipe_v3_0_10
vlib questa_lib/msim/c_addsub_v12_0_20
vlib questa_lib/msim/c_counter_binary_v12_0_21
vlib questa_lib/msim/xil_defaultlib
vlib questa_lib/msim/axi_utils_v2_0_10
vlib questa_lib/msim/mult_gen_v12_0_23
vlib questa_lib/msim/floating_point_v7_1_20
vlib questa_lib/msim/cmpy_v6_0_26
vlib questa_lib/msim/cordic_v6_0_24
vlib questa_lib/msim/floating_point_v7_0_25
vlib questa_lib/msim/div_gen_v5_1_24

vmap xbip_utils_v3_0_14 questa_lib/msim/xbip_utils_v3_0_14
vmap c_reg_fd_v12_0_10 questa_lib/msim/c_reg_fd_v12_0_10
vmap xbip_dsp48_wrapper_v3_0_7 questa_lib/msim/xbip_dsp48_wrapper_v3_0_7
vmap xbip_pipe_v3_0_10 questa_lib/msim/xbip_pipe_v3_0_10
vmap c_addsub_v12_0_20 questa_lib/msim/c_addsub_v12_0_20
vmap c_counter_binary_v12_0_21 questa_lib/msim/c_counter_binary_v12_0_21
vmap xil_defaultlib questa_lib/msim/xil_defaultlib
vmap axi_utils_v2_0_10 questa_lib/msim/axi_utils_v2_0_10
vmap mult_gen_v12_0_23 questa_lib/msim/mult_gen_v12_0_23
vmap floating_point_v7_1_20 questa_lib/msim/floating_point_v7_1_20
vmap cmpy_v6_0_26 questa_lib/msim/cmpy_v6_0_26
vmap cordic_v6_0_24 questa_lib/msim/cordic_v6_0_24
vmap floating_point_v7_0_25 questa_lib/msim/floating_point_v7_0_25
vmap div_gen_v5_1_24 questa_lib/msim/div_gen_v5_1_24

vcom -work xbip_utils_v3_0_14  -93  \
"../../../ipstatic/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work c_reg_fd_v12_0_10  -93  \
"../../../ipstatic/hdl/c_reg_fd_v12_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_7  -93  \
"../../../ipstatic/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_10  -93  \
"../../../ipstatic/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work c_addsub_v12_0_20  -93  \
"../../../ipstatic/hdl/c_addsub_v12_0_vh_rfs.vhd" \

vcom -work c_counter_binary_v12_0_21  -93  \
"../../../ipstatic/hdl/c_counter_binary_v12_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_c_counter_binary_v12_0_i0/sim/ifm_c_counter_binary_v12_0_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_c_counter_binary_v12_0_i1/sim/ifm_c_counter_binary_v12_0_i1.vhd" \

vcom -work axi_utils_v2_0_10  -93  \
"../../../ipstatic/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_23  -93  \
"../../../ipstatic/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work floating_point_v7_1_20  -93  \
"../../../ipstatic/hdl/floating_point_v7_1_vh_rfs.vhd" \

vcom -work cmpy_v6_0_26  -93  \
"../../../ipstatic/hdl/cmpy_v6_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_cmpy_v6_0_i0/sim/ifm_cmpy_v6_0_i0.vhd" \

vcom -work cordic_v6_0_24  -93  \
"../../../ipstatic/hdl/cordic_v6_0_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_cordic_v6_0_i0/sim/ifm_cordic_v6_0_i0.vhd" \

vcom -work floating_point_v7_0_25  -93  \
"../../../ipstatic/hdl/floating_point_v7_0_vh_rfs.vhd" \

vcom -work div_gen_v5_1_24  -93  \
"../../../ipstatic/hdl/div_gen_v5_1_vh_rfs.vhd" \

vcom -work xil_defaultlib  -93  \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_div_gen_v5_1_i0/sim/ifm_div_gen_v5_1_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_div_gen_v5_1_i1/sim/ifm_div_gen_v5_1_i1.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i0/sim/ifm_mult_gen_v12_0_i0.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i1/sim/ifm_mult_gen_v12_0_i1.vhd" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/ifm_mult_gen_v12_0_i2/sim/ifm_mult_gen_v12_0_i2.vhd" \

vlog -work xil_defaultlib  -incr -mfcu  "+incdir+../../../ipstatic/work/hdl" "+incdir+../../../../../../../../../Xilinx/2025.1/Vivado/data/rsb/busdef" \
"../../../ipstatic/work/hdl/synth_reg.v" \
"../../../ipstatic/work/hdl/synth_reg_w_init.v" \
"../../../ipstatic/work/hdl/convert_type.v" \
"../../../ipstatic/work/hdl/xlclockdriver_rd.v" \
"../../../ipstatic/work/hdl/ifm_entity_declarations.v" \
"../../../ipstatic/work/hdl/ifm.v" \
"../../../../IFM_RTL.gen/sources_1/ip/IFM_0/sim/IFM_0.v" \

vlog -work xil_defaultlib \
"glbl.v"

