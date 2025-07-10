onbreak {quit -f}
onerror {quit -f}

vsim -voptargs="+acc"  -L xil_defaultlib -L xbip_utils_v3_0_14 -L c_reg_fd_v12_0_10 -L xbip_dsp48_wrapper_v3_0_7 -L xbip_pipe_v3_0_10 -L c_addsub_v12_0_20 -L c_counter_binary_v12_0_21 -L axi_utils_v2_0_10 -L mult_gen_v12_0_23 -L floating_point_v7_1_20 -L cmpy_v6_0_26 -L cordic_v6_0_24 -L floating_point_v7_0_25 -L div_gen_v5_1_24 -L unisims_ver -L unimacro_ver -L secureip -lib xil_defaultlib xil_defaultlib.IFM_0 xil_defaultlib.glbl

set NumericStdNoWarnings 1
set StdArithNoWarnings 1

do {wave.do}

view wave
view structure
view signals

do {IFM_0.udo}

run 1000ns

quit -force
