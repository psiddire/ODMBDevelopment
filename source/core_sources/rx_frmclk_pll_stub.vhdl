-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
-- Date        : Tue Jun 14 18:40:14 2022
-- Host        : higgs.physics.ucsb.edu running 64-bit Scientific Linux release 7.9 (Nitrogen)
-- Command     : write_vhdl -force -mode synth_stub
--               /net/cms26/cms26r0/psiddire/ODMB/KCU105_GBT_1Link/source/core_sources/rx_frmclk_pll_stub.vhdl
-- Design      : rx_frmclk_pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku040-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity rx_frmclk_pll is
  Port ( 
    clkfb_in : in STD_LOGIC;
    clk_out1 : out STD_LOGIC;
    clkfb_out : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end rx_frmclk_pll;

architecture stub of rx_frmclk_pll is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clkfb_in,clk_out1,clkfb_out,reset,locked,clk_in1";
begin
end;
