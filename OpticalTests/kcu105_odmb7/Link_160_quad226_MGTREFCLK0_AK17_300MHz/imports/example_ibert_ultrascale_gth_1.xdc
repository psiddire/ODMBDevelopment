
# file: ibert_ultrascale_gth_1.xdc
####################################################################################
##   ____  ____ 
##  /   /\/   /
## /___/  \  /    Vendor: Xilinx
## \   \   \/     Version : 2012.3
##  \   \         Application : IBERT Ultrascale
##  /   /         Filename : example_ibert_ultrascale_gth_1.xdc
## /___/   /\     
## \   \  /  \ 
##  \___\/\___\
##
##
## 
## Generated by Xilinx IBERT 7Series 
##**************************************************************************
##
## Icon Constraints
##
create_clock -name D_CLK -period 3.333 [get_ports gth_sysclkp_i]
set_clock_groups -group [get_clocks D_CLK -include_generated_clocks] -asynchronous
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER true [get_debug_cores dbg_hub]

##gth_refclk lock constraints
##
set_property PACKAGE_PIN P6 [get_ports gth_refclk0p_i[0]]
set_property PACKAGE_PIN P5 [get_ports gth_refclk0n_i[0]]
set_property PACKAGE_PIN M6 [get_ports gth_refclk1p_i[0]]
set_property PACKAGE_PIN M5 [get_ports gth_refclk1n_i[0]]
##
## Refclk constraints
##
create_clock -name gth_refclk0_3 -period 6.25 [get_ports gth_refclk0p_i[0]]
create_clock -name gth_refclk1_3 -period 6.25 [get_ports gth_refclk1p_i[0]]
set_clock_groups -group [get_clocks gth_refclk0_3 -include_generated_clocks] -asynchronous
set_clock_groups -group [get_clocks gth_refclk1_3 -include_generated_clocks] -asynchronous
##
## System clock pin locs and timing constraints
##
set_property PACKAGE_PIN AK17 [get_ports gth_sysclkp_i]
set_property IOSTANDARD LVDS [get_ports gth_sysclkp_i]

