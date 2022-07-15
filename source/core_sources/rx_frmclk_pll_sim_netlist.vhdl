-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
-- Date        : Tue Jun 14 18:40:15 2022
-- Host        : higgs.physics.ucsb.edu running 64-bit Scientific Linux release 7.9 (Nitrogen)
-- Command     : write_vhdl -force -mode funcsim
--               /net/cms26/cms26r0/psiddire/ODMB/KCU105_GBT_1Link/source/core_sources/rx_frmclk_pll_sim_netlist.vhdl
-- Design      : rx_frmclk_pll
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xcku040-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity rx_frmclk_pll_rx_frmclk_pll_clk_wiz is
  port (
    clkfb_in : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clkfb_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
  attribute ORIG_REF_NAME : string;
  attribute ORIG_REF_NAME of rx_frmclk_pll_rx_frmclk_pll_clk_wiz : entity is "rx_frmclk_pll_clk_wiz";
end rx_frmclk_pll_rx_frmclk_pll_clk_wiz;

architecture STRUCTURE of rx_frmclk_pll_rx_frmclk_pll_clk_wiz is
  signal clk_in1_rx_frmclk_pll : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CDDCDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKFBOUTB_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKFBSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKINSTOPPED_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT0B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT1_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT1B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT2_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT2B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT3_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT3B_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT4_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT5_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_CLKOUT6_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_DRDY_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_PSDONE_UNCONNECTED : STD_LOGIC;
  signal NLW_mmcme3_adv_inst_DO_UNCONNECTED : STD_LOGIC_VECTOR ( 15 downto 0 );
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of clkin1_ibuf : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of clkin1_ibuf : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of clkin1_ibuf : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of clkin1_ibuf : label is "AUTO";
  attribute BOX_TYPE of mmcme3_adv_inst : label is "PRIMITIVE";
begin
clkin1_ibuf: unisim.vcomponents.IBUF
    generic map(
      IOSTANDARD => "DEFAULT"
    )
        port map (
      I => clk_in1,
      O => clk_in1_rx_frmclk_pll
    );
mmcme3_adv_inst: unisim.vcomponents.MMCME3_ADV
    generic map(
      BANDWIDTH => "OPTIMIZED",
      CLKFBOUT_MULT_F => 25.000000,
      CLKFBOUT_PHASE => 0.000000,
      CLKFBOUT_USE_FINE_PS => "FALSE",
      CLKIN1_PERIOD => 8.333000,
      CLKIN2_PERIOD => 0.000000,
      CLKOUT0_DIVIDE_F => 25.000000,
      CLKOUT0_DUTY_CYCLE => 0.500000,
      CLKOUT0_PHASE => 0.000000,
      CLKOUT0_USE_FINE_PS => "FALSE",
      CLKOUT1_DIVIDE => 1,
      CLKOUT1_DUTY_CYCLE => 0.500000,
      CLKOUT1_PHASE => 0.000000,
      CLKOUT1_USE_FINE_PS => "FALSE",
      CLKOUT2_DIVIDE => 1,
      CLKOUT2_DUTY_CYCLE => 0.500000,
      CLKOUT2_PHASE => 0.000000,
      CLKOUT2_USE_FINE_PS => "FALSE",
      CLKOUT3_DIVIDE => 1,
      CLKOUT3_DUTY_CYCLE => 0.500000,
      CLKOUT3_PHASE => 0.000000,
      CLKOUT3_USE_FINE_PS => "FALSE",
      CLKOUT4_CASCADE => "FALSE",
      CLKOUT4_DIVIDE => 1,
      CLKOUT4_DUTY_CYCLE => 0.500000,
      CLKOUT4_PHASE => 0.000000,
      CLKOUT4_USE_FINE_PS => "FALSE",
      CLKOUT5_DIVIDE => 1,
      CLKOUT5_DUTY_CYCLE => 0.500000,
      CLKOUT5_PHASE => 0.000000,
      CLKOUT5_USE_FINE_PS => "FALSE",
      CLKOUT6_DIVIDE => 1,
      CLKOUT6_DUTY_CYCLE => 0.500000,
      CLKOUT6_PHASE => 0.000000,
      CLKOUT6_USE_FINE_PS => "FALSE",
      COMPENSATION => "ZHOLD",
      DIVCLK_DIVIDE => 3,
      IS_CLKFBIN_INVERTED => '0',
      IS_CLKIN1_INVERTED => '0',
      IS_CLKIN2_INVERTED => '0',
      IS_CLKINSEL_INVERTED => '0',
      IS_PSEN_INVERTED => '0',
      IS_PSINCDEC_INVERTED => '0',
      IS_PWRDWN_INVERTED => '0',
      IS_RST_INVERTED => '0',
      REF_JITTER1 => 0.010000,
      REF_JITTER2 => 0.010000,
      SS_EN => "FALSE",
      SS_MODE => "CENTER_HIGH",
      SS_MOD_PERIOD => 10000,
      STARTUP_WAIT => "FALSE"
    )
        port map (
      CDDCDONE => NLW_mmcme3_adv_inst_CDDCDONE_UNCONNECTED,
      CDDCREQ => '0',
      CLKFBIN => clkfb_in,
      CLKFBOUT => clkfb_out,
      CLKFBOUTB => NLW_mmcme3_adv_inst_CLKFBOUTB_UNCONNECTED,
      CLKFBSTOPPED => NLW_mmcme3_adv_inst_CLKFBSTOPPED_UNCONNECTED,
      CLKIN1 => clk_in1_rx_frmclk_pll,
      CLKIN2 => '0',
      CLKINSEL => '1',
      CLKINSTOPPED => NLW_mmcme3_adv_inst_CLKINSTOPPED_UNCONNECTED,
      CLKOUT0 => clk_out1,
      CLKOUT0B => NLW_mmcme3_adv_inst_CLKOUT0B_UNCONNECTED,
      CLKOUT1 => NLW_mmcme3_adv_inst_CLKOUT1_UNCONNECTED,
      CLKOUT1B => NLW_mmcme3_adv_inst_CLKOUT1B_UNCONNECTED,
      CLKOUT2 => NLW_mmcme3_adv_inst_CLKOUT2_UNCONNECTED,
      CLKOUT2B => NLW_mmcme3_adv_inst_CLKOUT2B_UNCONNECTED,
      CLKOUT3 => NLW_mmcme3_adv_inst_CLKOUT3_UNCONNECTED,
      CLKOUT3B => NLW_mmcme3_adv_inst_CLKOUT3B_UNCONNECTED,
      CLKOUT4 => NLW_mmcme3_adv_inst_CLKOUT4_UNCONNECTED,
      CLKOUT5 => NLW_mmcme3_adv_inst_CLKOUT5_UNCONNECTED,
      CLKOUT6 => NLW_mmcme3_adv_inst_CLKOUT6_UNCONNECTED,
      DADDR(6 downto 0) => B"0000000",
      DCLK => '0',
      DEN => '0',
      DI(15 downto 0) => B"0000000000000000",
      DO(15 downto 0) => NLW_mmcme3_adv_inst_DO_UNCONNECTED(15 downto 0),
      DRDY => NLW_mmcme3_adv_inst_DRDY_UNCONNECTED,
      DWE => '0',
      LOCKED => locked,
      PSCLK => '0',
      PSDONE => NLW_mmcme3_adv_inst_PSDONE_UNCONNECTED,
      PSEN => '0',
      PSINCDEC => '0',
      PWRDWN => '0',
      RST => reset
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity rx_frmclk_pll is
  port (
    clkfb_in : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clkfb_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of rx_frmclk_pll : entity is true;
end rx_frmclk_pll;

architecture STRUCTURE of rx_frmclk_pll is
begin
inst: entity work.rx_frmclk_pll_rx_frmclk_pll_clk_wiz
     port map (
      clk_in1 => clk_in1,
      clk_out1 => clk_out1,
      clkfb_in => clkfb_in,
      clkfb_out => clkfb_out,
      locked => locked,
      reset => reset
    );
end STRUCTURE;
