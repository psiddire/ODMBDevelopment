// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.2 (lin64) Build 2708876 Wed Nov  6 21:39:14 MST 2019
// Date        : Tue Jun 14 18:40:14 2022
// Host        : higgs.physics.ucsb.edu running 64-bit Scientific Linux release 7.9 (Nitrogen)
// Command     : write_verilog -force -mode synth_stub
//               /net/cms26/cms26r0/psiddire/ODMB/KCU105_GBT_1Link/source/core_sources/rx_frmclk_pll_stub.v
// Design      : rx_frmclk_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module rx_frmclk_pll(clkfb_in, clk_out1, clkfb_out, reset, locked, 
  clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clkfb_in,clk_out1,clkfb_out,reset,locked,clk_in1" */;
  input clkfb_in;
  output clk_out1;
  output clkfb_out;
  input reset;
  output locked;
  input clk_in1;
endmodule
