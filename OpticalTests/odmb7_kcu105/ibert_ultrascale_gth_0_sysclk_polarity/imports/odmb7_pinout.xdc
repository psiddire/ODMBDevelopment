# ODMB7 UltraScale FPGA Pinout XDC file
# ----------------------------------------------------------------------------------------------------------------------

# Location constraints for differential reference clock buffers
# Note: the IP core-level XDC constrains the transceiver channel data pin locations
# ----------------------------------------------------------------------------------------------------------------------

# ----------------------------------------------------------------------------------------------------------------------
# Clock pins
# ----------------------------------------------------------------------------------------------------------------------

set_property package_pin AK17 [get_ports CMS_CLK_FPGA_P]
set_property package_pin AK16 [get_ports CMS_CLK_FPGA_N]
set_property IOSTANDARD LVDS  [get_ports CMS_CLK_FPGA_P]
set_property IOSTANDARD LVDS  [get_ports CMS_CLK_FPGA_N]

set_property package_pin AK22 [get_ports gth_sysclkp_i]
set_property package_pin AK23 [get_ports gth_sysclkn_i]
set_property IOSTANDARD LVDS  [get_ports gth_sysclkp_i]
set_property IOSTANDARD LVDS  [get_ports gth_sysclkn_i]

set_property package_pin E18  [get_ports GP_CLK_7_P]
set_property package_pin E17  [get_ports GP_CLK_7_N]
set_property IOSTANDARD LVDS  [get_ports GP_CLK_7_P]
set_property IOSTANDARD LVDS  [get_ports GP_CLK_7_N]

set_property package_pin AF6 [get_ports REF_CLK_1_P]
set_property package_pin AF5 [get_ports REF_CLK_1_N]
set_property package_pin P6  [get_ports REF_CLK_2_P]
set_property package_pin P5  [get_ports REF_CLK_2_N]
set_property package_pin V6  [get_ports gth_refclk0p_i[0]]
set_property package_pin V5  [get_ports gth_refclk0n_i[0]]
set_property package_pin AB6 [get_ports REF_CLK_4_P]
set_property package_pin AB5 [get_ports REF_CLK_4_N]
set_property package_pin M6  [get_ports REF_CLK_5_P]
set_property package_pin M5  [get_ports REF_CLK_5_N]
set_property package_pin T6  [get_ports gth_refclk1p_i[0]]
set_property package_pin T5  [get_ports gth_refclk1n_i[0]]

# set_property DIFF_TERM TRUE  [get_ports REF_CLK_1_P]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_1_N]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_2_P]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_2_N]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_3_P]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_3_N]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_4_P]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_4_N]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_5_P]
# set_property DIFF_TERM TRUE  [get_ports REF_CLK_5_N]
# set_property DIFF_TERM TRUE  [get_ports CLK_125_REF_P]
# set_property DIFF_TERM TRUE  [get_ports CLK_125_REF_N]

set_property PACKAGE_PIN K20        [get_ports EMCCLK]
set_property IOSTANDARD LVCMOS18    [get_ports EMCCLK]
# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {IBUFG_EMCCLK/O}]

set_property PACKAGE_PIN AJ16       [get_ports LF_CLK]
set_property IOSTANDARD LVCMOS18    [get_ports LF_CLK]
# set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets {IBUFG_LFCLK/O}]

# ----------------------------------------------------------------------------------------------------------------------
# Optical TX/RX pins
# ----------------------------------------------------------------------------------------------------------------------
set_property package_pin AP2 [get_ports  DAQ_RX_P[0]]
set_property package_pin AP1 [get_ports  DAQ_RX_N[0]]
set_property package_pin AM2 [get_ports  DAQ_RX_P[1]]
set_property package_pin AM1 [get_ports  DAQ_RX_N[1]]
set_property package_pin AK2 [get_ports  DAQ_RX_P[2]]
set_property package_pin AK1 [get_ports  DAQ_RX_N[2]]
set_property package_pin AJ4 [get_ports  DAQ_RX_P[3]]
set_property package_pin AJ3 [get_ports  DAQ_RX_N[3]]
set_property package_pin AH2 [get_ports  DAQ_RX_P[4]]
set_property package_pin AH1 [get_ports  DAQ_RX_N[4]]
set_property package_pin AF2 [get_ports  DAQ_RX_P[5]]
set_property package_pin AF1 [get_ports  DAQ_RX_N[5]]
set_property package_pin AD2 [get_ports  DAQ_RX_P[6]]
set_property package_pin AD1 [get_ports  DAQ_RX_N[6]]
set_property package_pin AB2 [get_ports  DAQ_RX_P[7]]
set_property package_pin AB1 [get_ports  DAQ_RX_N[7]]
set_property package_pin Y2  [get_ports  DAQ_RX_P[8]]
set_property package_pin Y1  [get_ports  DAQ_RX_N[8]]
set_property package_pin V2  [get_ports  DAQ_RX_P[9]]
set_property package_pin V1  [get_ports  DAQ_RX_N[9]]
set_property package_pin T2  [get_ports  DAQ_RX_P[10]]
set_property package_pin T1  [get_ports  DAQ_RX_N[10]]
set_property package_pin P2  [get_ports  DAQ_SPY_RX_P]
set_property package_pin P1  [get_ports  DAQ_SPY_RX_N]
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
set_property package_pin R4  [get_ports  SPY_TX_P]
set_property package_pin R3  [get_ports  SPY_TX_N]

# ----------------------------------------------------------------------------------------------------------------------
# Optical control pins
# ----------------------------------------------------------------------------------------------------------------------
set_property package_pin  E12      [get_ports DAQ_SPY_SEL]
set_property IOSTANDARD   LVCMOS18 [get_ports DAQ_SPY_SEL]

set_property package_pin  K11      [get_ports RX12_I2C_ENA]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_I2C_ENA]
set_property package_pin  J11      [get_ports RX12_SDA]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_SDA]
set_property package_pin  H12      [get_ports RX12_SCL]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_SCL]
set_property package_pin  G12      [get_ports RX12_CS_B]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_CS_B]
set_property package_pin  F12      [get_ports RX12_RST_B]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_RST_B]
set_property package_pin  G9       [get_ports RX12_INT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_INT_B]
set_property package_pin  F9       [get_ports RX12_PRESENT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports RX12_PRESENT_B]

set_property package_pin  J13      [get_ports TX12_I2C_ENA]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_I2C_ENA]
set_property package_pin  H13      [get_ports TX12_SDA]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_SDA]
set_property package_pin  L12      [get_ports TX12_SCL]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_SCL]
set_property package_pin  G10      [get_ports TX12_CS_B]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_CS_B]
set_property package_pin  F10      [get_ports TX12_RST_B]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_RST_B]
set_property package_pin  J8       [get_ports TX12_INT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_INT_B]
set_property package_pin  H8       [get_ports TX12_PRESENT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports TX12_PRESENT_B]

set_property package_pin  K12      [get_ports B04_I2C_ENA]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_I2C_ENA]
set_property package_pin  L13      [get_ports B04_SDA]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_SDA]
set_property package_pin  K13      [get_ports B04_SCL]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_SCL]
set_property package_pin  H11      [get_ports B04_CS_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_CS_B]
set_property package_pin  G11      [get_ports B04_RST_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_RST_B]
set_property package_pin  K10      [get_ports B04_INT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_INT_B]
set_property package_pin  J10      [get_ports B04_PRESENT_B]
set_property IOSTANDARD   LVCMOS18 [get_ports B04_PRESENT_B]

set_property package_pin  A8       [get_ports SPY_I2C_ENA]
set_property IOSTANDARD   LVCMOS18 [get_ports SPY_I2C_ENA]
set_property package_pin  H9       [get_ports SPY_SDA]
set_property IOSTANDARD   LVCMOS18 [get_ports SPY_SDA]
set_property package_pin  J9       [get_ports SPY_SCL]
set_property IOSTANDARD   LVCMOS18 [get_ports SPY_SCL]
set_property package_pin  F8       [get_ports SPY_SD]
set_property IOSTANDARD   LVCMOS18 [get_ports SPY_SD]
set_property package_pin  E8       [get_ports SPY_TDIS]
set_property IOSTANDARD   LVCMOS18 [get_ports SPY_TDIS]

# ----------------------------------------------------------------------------------------------------------------------
# Selector pins
# ----------------------------------------------------------------------------------------------------------------------
set_property PACKAGE_PIN U21        [get_ports KUS_DL_SEL]
set_property IOSTANDARD  LVCMOS18   [get_ports KUS_DL_SEL]

set_property PACKAGE_PIN T23        [get_ports FPGA_SEL]
set_property IOSTANDARD  LVCMOS18   [get_ports FPGA_SEL]

set_property PACKAGE_PIN W29        [get_ports RST_CLKS_B]
set_property IOSTANDARD  LVCMOS18   [get_ports RST_CLKS_B]

set_property PACKAGE_PIN L9         [get_ports DONE]
set_property IOSTANDARD  LVCMOS18   [get_ports DONE]

set_property PACKAGE_PIN AN14       [get_ports CCB_HARDRST_B]
set_property IOSTANDARD  LVCMOS18   [get_ports CCB_HARDRST_B]
set_property PACKAGE_PIN AP14       [get_ports CCB_SOFT_RST]
set_property IOSTANDARD  LVCMOS18   [get_ports CCB_SOFT_RST]

# ----------------------------------------------------------------------------------------------------------------------
# SYSMON pins
# ----------------------------------------------------------------------------------------------------------------------
set_property PACKAGE_PIN   AN8      [get_ports SYSMON_P[0]]
set_property PACKAGE_PIN   AP8      [get_ports SYSMON_N[0]]
set_property PACKAGE_PIN   AN9      [get_ports SYSMON_P[1]]
set_property PACKAGE_PIN   AP9      [get_ports SYSMON_N[1]]
set_property PACKAGE_PIN   AH9      [get_ports SYSMON_P[2]]
set_property PACKAGE_PIN   AH8      [get_ports SYSMON_N[2]]
set_property PACKAGE_PIN   AD10     [get_ports SYSMON_P[3]]
set_property PACKAGE_PIN   AE10     [get_ports SYSMON_N[3]]
set_property PACKAGE_PIN   AD11     [get_ports SYSMON_P[4]]
set_property PACKAGE_PIN   AE11     [get_ports SYSMON_N[4]]
set_property PACKAGE_PIN   AH13     [get_ports SYSMON_P[5]]
set_property PACKAGE_PIN   AJ13     [get_ports SYSMON_N[5]]
set_property PACKAGE_PIN   AK13     [get_ports SYSMON_P[6]]
set_property PACKAGE_PIN   AL13     [get_ports SYSMON_N[6]]
set_property PACKAGE_PIN   AM12     [get_ports SYSMON_P[7]]
set_property PACKAGE_PIN   AN12     [get_ports SYSMON_N[7]]
set_property PACKAGE_PIN   AK10     [get_ports SYSMON_P[8]]
set_property PACKAGE_PIN   AL9      [get_ports SYSMON_N[8]]
set_property PACKAGE_PIN   AL10     [get_ports SYSMON_P[9]]
set_property PACKAGE_PIN   AM10     [get_ports SYSMON_N[9]]
set_property PACKAGE_PIN   AD9      [get_ports SYSMON_P[10]]
set_property PACKAGE_PIN   AD8      [get_ports SYSMON_N[10]]
set_property PACKAGE_PIN   AE8      [get_ports SYSMON_P[11]]
set_property PACKAGE_PIN   AF8      [get_ports SYSMON_N[11]]
set_property PACKAGE_PIN   AE12     [get_ports SYSMON_P[12]]
set_property PACKAGE_PIN   AF12     [get_ports SYSMON_N[12]]
set_property PACKAGE_PIN   AE13     [get_ports SYSMON_P[13]]
set_property PACKAGE_PIN   AF13     [get_ports SYSMON_N[13]]
set_property PACKAGE_PIN   AK12     [get_ports SYSMON_P[14]]
set_property PACKAGE_PIN   AL12     [get_ports SYSMON_N[14]]
set_property PACKAGE_PIN   AM11     [get_ports SYSMON_P[15]]
set_property PACKAGE_PIN   AN11     [get_ports SYSMON_N[15]]

set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[0]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[0]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[1]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[1]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[2]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[2]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[3]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[3]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[4]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[4]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[5]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[5]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[6]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[6]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[7]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[7]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[8]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[8]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[9]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[9]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[10]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[10]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[11]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[11]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[12]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[12]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[13]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[13]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[14]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[14]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_P[15]]
set_property IOSTANDARD ANALOG      [get_ports SYSMON_N[15]]

set_property PACKAGE_PIN  AN13      [get_ports ADC_CS_B[0]]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_CS_B[0]]
set_property PACKAGE_PIN  AP13      [get_ports ADC_CS_B[1]]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_CS_B[1]]
set_property PACKAGE_PIN  AK11      [get_ports ADC_CS_B[2]]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_CS_B[2]]
set_property PACKAGE_PIN  AP11      [get_ports ADC_CS_B[3]]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_CS_B[3]]
set_property PACKAGE_PIN  AP10      [get_ports ADC_CS_B[4]]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_CS_B[4]]
set_property PACKAGE_PIN  AG10      [get_ports ADC_SCK]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_SCK]
set_property PACKAGE_PIN  AF10      [get_ports ADC_DIN]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_DIN]
set_property PACKAGE_PIN  AG11      [get_ports ADC_DOUT]
set_property IOSTANDARD   LVCMOS18  [get_ports ADC_DOUT]

# ----------------------------------------------------------------------------------------------------------------------
# LED pins
# ----------------------------------------------------------------------------------------------------------------------
set_property PACKAGE_PIN P20        [get_ports LEDS_CFV[0]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[0]]
set_property PACKAGE_PIN T27        [get_ports LEDS_CFV[1]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[1]]
set_property PACKAGE_PIN N22        [get_ports LEDS_CFV[2]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[2]]
set_property PACKAGE_PIN R27        [get_ports LEDS_CFV[3]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[3]]
set_property PACKAGE_PIN T25        [get_ports LEDS_CFV[4]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[4]]
set_property PACKAGE_PIN R26        [get_ports LEDS_CFV[5]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[5]]
set_property PACKAGE_PIN R25        [get_ports LEDS_CFV[6]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[6]]
set_property PACKAGE_PIN T24        [get_ports LEDS_CFV[7]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[7]]
set_property PACKAGE_PIN R23        [get_ports LEDS_CFV[8]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[8]]
set_property PACKAGE_PIN P23        [get_ports LEDS_CFV[9]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[9]]
set_property PACKAGE_PIN P21        [get_ports LEDS_CFV[10]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[10]]
set_property PACKAGE_PIN M22        [get_ports LEDS_CFV[11]]
set_property IOSTANDARD LVCMOS18    [get_ports LEDS_CFV[11]]

