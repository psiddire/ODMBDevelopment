
# file: ibert_ultrascale_gth_0.xdc
####################################################################################
##   ____  ____ 
##  /   /\/   /
## /___/  \  /    Vendor: Xilinx
## \   \   \/     Version : 2012.3
##  \   \         Application : IBERT Ultrascale
##  /   /         Filename : example_ibert_ultrascale_gth_0.xdc
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
create_clock -name gp_clk_6 -period 12.5  [get_ports GP_CLK_6_P]
set_clock_groups -group [get_clocks gp_clk_6 -include_generated_clocks] -asynchronous

set_property C_CLK_INPUT_FREQ_HZ 80000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER true [get_debug_cores dbg_hub]

##gth_refclk lock constraints
##
set_property PACKAGE_PIN P6 [get_ports REF_CLK_2_P[0]]
set_property PACKAGE_PIN P5 [get_ports REF_CLK_2_N[0]]
set_property PACKAGE_PIN M6 [get_ports REF_CLK_5_P[0]]
set_property PACKAGE_PIN M5 [get_ports REF_CLK_5_N[0]]
##
## Refclk constraints
##
create_clock -name gth_refclk0_q227 -period 6.25 [get_ports REF_CLK_2_P]
create_clock -name gth_refclk1_q227 -period 6.25 [get_ports REF_CLK_5_P]
set_clock_groups -group [get_clocks gth_refclk0_q227 -include_generated_clocks] -asynchronous
set_clock_groups -group [get_clocks gth_refclk1_q227 -include_generated_clocks] -asynchronous

##
## System clock pin locs and timing constraints
##
set_property package_pin AK22 [get_ports GP_CLK_6_P]
set_property package_pin AK23 [get_ports GP_CLK_6_N]
set_property IOSTANDARD LVDS  [get_ports GP_CLK_6_P]
set_property IOSTANDARD LVDS  [get_ports GP_CLK_6_N]

##
## Optical TX/RX pins
##
set_property package_pin N4  [get_ports  DAQ_TX_P[1]]
set_property package_pin N3  [get_ports  DAQ_TX_N[1]]
set_property package_pin L4  [get_ports  DAQ_TX_P[2]]
set_property package_pin L3  [get_ports  DAQ_TX_N[2]]
set_property package_pin J4  [get_ports  DAQ_TX_P[3]]
set_property package_pin J3  [get_ports  DAQ_TX_N[3]]
set_property package_pin G4  [get_ports  DAQ_TX_P[4]]
set_property package_pin G3  [get_ports  DAQ_TX_N[4]]
set_property package_pin M2  [get_ports  BCK_PRS_P]
set_property package_pin M1  [get_ports  BCK_PRS_N]
set_property package_pin K2  [get_ports  B04_RX_P[2]]
set_property package_pin K1  [get_ports  B04_RX_N[2]]
set_property package_pin H2  [get_ports  B04_RX_P[3]]
set_property package_pin H1  [get_ports  B04_RX_N[3]]
set_property package_pin F2  [get_ports  B04_RX_P[4]]
set_property package_pin F1  [get_ports  B04_RX_N[4]]

##
## Optical control pins
##
set_property package_pin  K12      [get_ports B04_I2C_ENA]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_I2C_ENA]
set_property package_pin  H11      [get_ports B04_CS_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_CS_B]
set_property package_pin  G11      [get_ports B04_RST_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_RST_B]

##
## Selector pins
##
set_property PACKAGE_PIN U21        [get_ports KUS_DL_SEL]
set_property IOSTANDARD  LVCMOS18   [get_ports KUS_DL_SEL]
set_property PACKAGE_PIN T23        [get_ports FPGA_SEL]
set_property IOSTANDARD  LVCMOS18   [get_ports FPGA_SEL]
set_property PACKAGE_PIN W29        [get_ports RST_CLKS_B]
set_property IOSTANDARD  LVCMOS18   [get_ports RST_CLKS_B]

