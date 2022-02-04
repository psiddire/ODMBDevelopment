//------------------------------------------------------------------------------
//  (c) Copyright 2013-2018 Xilinx, Inc. All rights reserved.
//
//  This file contains confidential and proprietary information
//  of Xilinx, Inc. and is protected under U.S. and
//  international copyright and other intellectual property
//  laws.
//
//  DISCLAIMER
//  This disclaimer is not a license and does not grant any
//  rights to the materials distributed herewith. Except as
//  otherwise provided in a valid license issued to you by
//  Xilinx, and to the maximum extent permitted by applicable
//  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
//  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
//  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
//  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
//  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
//  (2) Xilinx shall not be liable (whether in contract or tort,
//  including negligence, or under any other theory of
//  liability) for any loss or damage of any kind or nature
//  related to, arising under or in connection with these
//  materials, including for any direct, or any indirect,
//  special, incidental, or consequential loss or damage
//  (including loss of data, profits, goodwill, or any type of
//  loss or damage suffered as a result of any action brought
//  by a third party) even if such damage or loss was
//  reasonably foreseeable or Xilinx had been advised of the
//  possibility of the same.
//
//  CRITICAL APPLICATIONS
//  Xilinx products are not designed or intended to be fail-
//  safe, or for use in any application requiring fail-safe
//  performance, such as life-support or safety devices or
//  systems, Class III medical devices, nuclear facilities,
//  applications related to the deployment of airbags, or any
//  other applications that could lead to death, personal
//  injury, or severe property or environmental damage
//  (individually and collectively, "Critical
//  Applications"). Customer assumes the sole risk and
//  liability of any use of Xilinx products in Critical
//  Applications, subject only to applicable laws and
//  regulations governing limitations on product liability.
//
//  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
//  PART OF THIS FILE AT ALL TIMES.
//------------------------------------------------------------------------------


`timescale 1ps/1ps

// =====================================================================================================================
// This example design top module instantiates the example design wrapper; slices vectored ports for per-channel
// assignment; and instantiates example resources such as buffers, pattern generators, and pattern checkers for core
// demonstration purposes
// =====================================================================================================================

module gtwizard_ultrascale_0_example_top (

  // Differential reference clock inputs
  input  wire mgtrefclk0_x0y3_p,
  input  wire mgtrefclk0_x0y3_n,

  // Serial data ports for transceiver channel 0
  input  wire ch0_gthrxn_in,
  input  wire ch0_gthrxp_in,
  output wire ch0_gthtxn_out,
  output wire ch0_gthtxp_out,

  // Serial data ports for transceiver channel 1
  input  wire ch1_gthrxn_in,
  input  wire ch1_gthrxp_in,
  output wire ch1_gthtxn_out,
  output wire ch1_gthtxp_out,

  // Serial data ports for transceiver channel 2
  input  wire ch2_gthrxn_in,
  input  wire ch2_gthrxp_in,
  output wire ch2_gthtxn_out,
  output wire ch2_gthtxp_out,

  // Serial data ports for transceiver channel 3
  input  wire ch3_gthrxn_in,
  input  wire ch3_gthrxp_in,
  output wire ch3_gthtxn_out,
  output wire ch3_gthtxp_out,

  input  wire sel_si570_clk_i,
  input  wire CLK_IN_P,
  input  wire CLK_IN_N				  

  // // User-provided ports for reset helper block(s)
  // input  wire hb_gtwiz_reset_clk_freerun_in,
  // input  wire hb_gtwiz_reset_all_in,

  // // PRBS-based link status ports
  // input  wire link_down_latched_reset_in,
  // output wire link_status_out,
  // output reg  link_down_latched_out = 1'b1

);


   wire       hb_gtwiz_reset_all_in;
   wire       link_down_latched_reset_in;
   wire       link_status_out;
   reg        link_down_latched_out = 1'b1;

   assign sel_si570_clk_i = 1'b0;
   

  // ===================================================================================================================
  // PER-CHANNEL SIGNAL ASSIGNMENTS
  // ===================================================================================================================

  // The core and example design wrapper vectorize ports across all enabled transceiver channel and common instances for
  // simplicity and compactness. This example design top module assigns slices of each vector to individual, per-channel
  // signal vectors for use if desired. Signals which connect to helper blocks are prefixed "hb#", signals which connect
  // to transceiver common primitives are prefixed "cm#", and signals which connect to transceiver channel primitives
  // are prefixed "ch#", where "#" is the sequential resource number.

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gthrxn_int;
  assign gthrxn_int[0:0] = ch0_gthrxn_in;
  assign gthrxn_int[1:1] = ch1_gthrxn_in;
  assign gthrxn_int[2:2] = ch2_gthrxn_in;
  assign gthrxn_int[3:3] = ch3_gthrxn_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gthrxp_int;
  assign gthrxp_int[0:0] = ch0_gthrxp_in;
  assign gthrxp_int[1:1] = ch1_gthrxp_in;
  assign gthrxp_int[2:2] = ch2_gthrxp_in;
  assign gthrxp_int[3:3] = ch3_gthrxp_in;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gthtxn_int;
  assign ch0_gthtxn_out = gthtxn_int[0:0];
  assign ch1_gthtxn_out = gthtxn_int[1:1];
  assign ch2_gthtxn_out = gthtxn_int[2:2];
  assign ch3_gthtxn_out = gthtxn_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gthtxp_int;
  assign ch0_gthtxp_out = gthtxp_int[0:0];
  assign ch1_gthtxp_out = gthtxp_int[1:1];
  assign ch2_gthtxp_out = gthtxp_int[2:2];
  assign ch3_gthtxp_out = gthtxp_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_tx_reset_int;
  assign gtwiz_userclk_tx_reset_int[0:0] = hb0_gtwiz_userclk_tx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_srcclk_int;
  assign hb0_gtwiz_userclk_tx_srcclk_int = gtwiz_userclk_tx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk_int;
  assign hb0_gtwiz_userclk_tx_usrclk_int = gtwiz_userclk_tx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_tx_usrclk2_int;
  assign hb0_gtwiz_userclk_tx_usrclk2_int = gtwiz_userclk_tx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_tx_active_int;
  wire [0:0] hb0_gtwiz_userclk_tx_active_int;
  assign hb0_gtwiz_userclk_tx_active_int = gtwiz_userclk_tx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_reset_int;
  wire [0:0] hb0_gtwiz_userclk_rx_reset_int;
  assign gtwiz_userclk_rx_reset_int[0:0] = hb0_gtwiz_userclk_rx_reset_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_srcclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_srcclk_int;
  assign hb0_gtwiz_userclk_rx_srcclk_int = gtwiz_userclk_rx_srcclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk_int;
  assign hb0_gtwiz_userclk_rx_usrclk_int = gtwiz_userclk_rx_usrclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_usrclk2_int;
  wire [0:0] hb0_gtwiz_userclk_rx_usrclk2_int;
  assign hb0_gtwiz_userclk_rx_usrclk2_int = gtwiz_userclk_rx_usrclk2_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_userclk_rx_active_int;
  wire [0:0] hb0_gtwiz_userclk_rx_active_int;
  assign hb0_gtwiz_userclk_rx_active_int = gtwiz_userclk_rx_active_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_clk_freerun_int;
  wire [0:0] hb0_gtwiz_reset_clk_freerun_int = 1'b0;
  assign gtwiz_reset_clk_freerun_int[0:0] = hb0_gtwiz_reset_clk_freerun_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_all_int;
  wire [0:0] hb0_gtwiz_reset_all_int = 1'b0;
  assign gtwiz_reset_all_int[0:0] = hb0_gtwiz_reset_all_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_pll_and_datapath_int;
  assign gtwiz_reset_tx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_tx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_tx_datapath_int;
  assign gtwiz_reset_tx_datapath_int[0:0] = hb0_gtwiz_reset_tx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_pll_and_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  assign gtwiz_reset_rx_pll_and_datapath_int[0:0] = hb0_gtwiz_reset_rx_pll_and_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_datapath_int;
  wire [0:0] hb0_gtwiz_reset_rx_datapath_int = 1'b0;
  assign gtwiz_reset_rx_datapath_int[0:0] = hb0_gtwiz_reset_rx_datapath_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_cdr_stable_int;
  wire [0:0] hb0_gtwiz_reset_rx_cdr_stable_int;
  assign hb0_gtwiz_reset_rx_cdr_stable_int = gtwiz_reset_rx_cdr_stable_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_tx_done_int;
  wire [0:0] hb0_gtwiz_reset_tx_done_int;
  assign hb0_gtwiz_reset_tx_done_int = gtwiz_reset_tx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtwiz_reset_rx_done_int;
  wire [0:0] hb0_gtwiz_reset_rx_done_int;
  assign hb0_gtwiz_reset_rx_done_int = gtwiz_reset_rx_done_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [127:0] gtwiz_userdata_tx_int;
  wire [31:0] hb0_gtwiz_userdata_tx_int;
  wire [31:0] hb1_gtwiz_userdata_tx_int;
  wire [31:0] hb2_gtwiz_userdata_tx_int;
  wire [31:0] hb3_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[31:0] = hb0_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[63:32] = hb1_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[95:64] = hb2_gtwiz_userdata_tx_int;
  assign gtwiz_userdata_tx_int[127:96] = hb3_gtwiz_userdata_tx_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [127:0] gtwiz_userdata_rx_int;
  wire [31:0] hb0_gtwiz_userdata_rx_int;
  wire [31:0] hb1_gtwiz_userdata_rx_int;
  wire [31:0] hb2_gtwiz_userdata_rx_int;
  wire [31:0] hb3_gtwiz_userdata_rx_int;
  assign hb0_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[31:0];
  assign hb1_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[63:32];
  assign hb2_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[95:64];
  assign hb3_gtwiz_userdata_rx_int = gtwiz_userdata_rx_int[127:96];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] gtrefclk00_int;
  wire [0:0] cm0_gtrefclk00_int;
  assign gtrefclk00_int[0:0] = cm0_gtrefclk00_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outclk_int;
  wire [0:0] cm0_qpll0outclk_int;
  assign cm0_qpll0outclk_int = qpll0outclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [0:0] qpll0outrefclk_int;
  wire [0:0] cm0_qpll0outrefclk_int;
  assign cm0_qpll0outrefclk_int = qpll0outrefclk_int[0:0];

  //--------------------------------------------------------------------------------------------------------------------
  wire [35:0] drpaddr_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpclk_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] drpdi_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpen_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drpwe_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] eyescanreset_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rx8b10ben_int;
  wire [0:0] ch0_rx8b10ben_int = 1'b1;
  wire [0:0] ch1_rx8b10ben_int = 1'b1;
  wire [0:0] ch2_rx8b10ben_int = 1'b1;
  wire [0:0] ch3_rx8b10ben_int = 1'b1;
  assign rx8b10ben_int[0:0] = ch0_rx8b10ben_int;
  assign rx8b10ben_int[1:1] = ch1_rx8b10ben_int;
  assign rx8b10ben_int[2:2] = ch2_rx8b10ben_int;
  assign rx8b10ben_int[3:3] = ch3_rx8b10ben_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxcommadeten_int;
  wire [0:0] ch0_rxcommadeten_int = 1'b1;
  wire [0:0] ch1_rxcommadeten_int = 1'b1;
  wire [0:0] ch2_rxcommadeten_int = 1'b1;
  wire [0:0] ch3_rxcommadeten_int = 1'b1;
  assign rxcommadeten_int[0:0] = ch0_rxcommadeten_int;
  assign rxcommadeten_int[1:1] = ch1_rxcommadeten_int;
  assign rxcommadeten_int[2:2] = ch2_rxcommadeten_int;
  assign rxcommadeten_int[3:3] = ch3_rxcommadeten_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxlpmen_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxmcommaalignen_int;
  wire [0:0] ch0_rxmcommaalignen_int = 1'b1;
  wire [0:0] ch1_rxmcommaalignen_int = 1'b1;
  wire [0:0] ch2_rxmcommaalignen_int = 1'b1;
  wire [0:0] ch3_rxmcommaalignen_int = 1'b1;
  assign rxmcommaalignen_int[0:0] = ch0_rxmcommaalignen_int;
  assign rxmcommaalignen_int[1:1] = ch1_rxmcommaalignen_int;
  assign rxmcommaalignen_int[2:2] = ch2_rxmcommaalignen_int;
  assign rxmcommaalignen_int[3:3] = ch3_rxmcommaalignen_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpcommaalignen_int;
  wire [0:0] ch0_rxpcommaalignen_int = 1'b1;
  wire [0:0] ch1_rxpcommaalignen_int = 1'b1;
  wire [0:0] ch2_rxpcommaalignen_int = 1'b1;
  wire [0:0] ch3_rxpcommaalignen_int = 1'b1;
  assign rxpcommaalignen_int[0:0] = ch0_rxpcommaalignen_int;
  assign rxpcommaalignen_int[1:1] = ch1_rxpcommaalignen_int;
  assign rxpcommaalignen_int[2:2] = ch2_rxpcommaalignen_int;
  assign rxpcommaalignen_int[3:3] = ch3_rxpcommaalignen_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [11:0] rxrate_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] tx8b10ben_int;
  wire [0:0] ch0_tx8b10ben_int = 1'b1;
  wire [0:0] ch1_tx8b10ben_int = 1'b1;
  wire [0:0] ch2_tx8b10ben_int = 1'b1;
  wire [0:0] ch3_tx8b10ben_int = 1'b1;
  assign tx8b10ben_int[0:0] = ch0_tx8b10ben_int;
  assign tx8b10ben_int[1:1] = ch1_tx8b10ben_int;
  assign tx8b10ben_int[2:2] = ch2_tx8b10ben_int;
  assign tx8b10ben_int[3:3] = ch3_tx8b10ben_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] txctrl0_int;
  wire [15:0] ch0_txctrl0_int;
  wire [15:0] ch1_txctrl0_int;
  wire [15:0] ch2_txctrl0_int;
  wire [15:0] ch3_txctrl0_int;
  assign txctrl0_int[15:0] = ch0_txctrl0_int;
  assign txctrl0_int[31:16] = ch1_txctrl0_int;
  assign txctrl0_int[47:32] = ch2_txctrl0_int;
  assign txctrl0_int[63:48] = ch3_txctrl0_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] txctrl1_int;
  wire [15:0] ch0_txctrl1_int;
  wire [15:0] ch1_txctrl1_int;
  wire [15:0] ch2_txctrl1_int;
  wire [15:0] ch3_txctrl1_int;
  assign txctrl1_int[15:0] = ch0_txctrl1_int;
  assign txctrl1_int[31:16] = ch1_txctrl1_int;
  assign txctrl1_int[47:32] = ch2_txctrl1_int;
  assign txctrl1_int[63:48] = ch3_txctrl1_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [31:0] txctrl2_int;
  wire [7:0] ch0_txctrl2_int;
  wire [7:0] ch1_txctrl2_int;
  wire [7:0] ch2_txctrl2_int;
  wire [7:0] ch3_txctrl2_int;
  assign txctrl2_int[7:0] = ch0_txctrl2_int;
  assign txctrl2_int[15:8] = ch1_txctrl2_int;
  assign txctrl2_int[23:16] = ch2_txctrl2_int;
  assign txctrl2_int[31:24] = ch3_txctrl2_int;

  //--------------------------------------------------------------------------------------------------------------------
  wire [15:0] txdiffctrl_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txpostcursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [19:0] txprecursor_int;
  // This vector is not sliced because it is directly assigned in a debug core instance below

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] drpdo_int;
  wire [15:0] ch0_drpdo_int;
  wire [15:0] ch1_drpdo_int;
  wire [15:0] ch2_drpdo_int;
  wire [15:0] ch3_drpdo_int;
  assign ch0_drpdo_int = drpdo_int[15:0];
  assign ch1_drpdo_int = drpdo_int[31:16];
  assign ch2_drpdo_int = drpdo_int[47:32];
  assign ch3_drpdo_int = drpdo_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] drprdy_int;
  wire [0:0] ch0_drprdy_int;
  wire [0:0] ch1_drprdy_int;
  wire [0:0] ch2_drprdy_int;
  wire [0:0] ch3_drprdy_int;
  assign ch0_drprdy_int = drprdy_int[0:0];
  assign ch1_drprdy_int = drprdy_int[1:1];
  assign ch2_drprdy_int = drprdy_int[2:2];
  assign ch3_drprdy_int = drprdy_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] gtpowergood_int;
  wire [0:0] ch0_gtpowergood_int;
  wire [0:0] ch1_gtpowergood_int;
  wire [0:0] ch2_gtpowergood_int;
  wire [0:0] ch3_gtpowergood_int;
  assign ch0_gtpowergood_int = gtpowergood_int[0:0];
  assign ch1_gtpowergood_int = gtpowergood_int[1:1];
  assign ch2_gtpowergood_int = gtpowergood_int[2:2];
  assign ch3_gtpowergood_int = gtpowergood_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxbyteisaligned_int;
  wire [0:0] ch0_rxbyteisaligned_int;
  wire [0:0] ch1_rxbyteisaligned_int;
  wire [0:0] ch2_rxbyteisaligned_int;
  wire [0:0] ch3_rxbyteisaligned_int;
  assign ch0_rxbyteisaligned_int = rxbyteisaligned_int[0:0];
  assign ch1_rxbyteisaligned_int = rxbyteisaligned_int[1:1];
  assign ch2_rxbyteisaligned_int = rxbyteisaligned_int[2:2];
  assign ch3_rxbyteisaligned_int = rxbyteisaligned_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxbyterealign_int;
  wire [0:0] ch0_rxbyterealign_int;
  wire [0:0] ch1_rxbyterealign_int;
  wire [0:0] ch2_rxbyterealign_int;
  wire [0:0] ch3_rxbyterealign_int;
  assign ch0_rxbyterealign_int = rxbyterealign_int[0:0];
  assign ch1_rxbyterealign_int = rxbyterealign_int[1:1];
  assign ch2_rxbyterealign_int = rxbyterealign_int[2:2];
  assign ch3_rxbyterealign_int = rxbyterealign_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxcommadet_int;
  wire [0:0] ch0_rxcommadet_int;
  wire [0:0] ch1_rxcommadet_int;
  wire [0:0] ch2_rxcommadet_int;
  wire [0:0] ch3_rxcommadet_int;
  assign ch0_rxcommadet_int = rxcommadet_int[0:0];
  assign ch1_rxcommadet_int = rxcommadet_int[1:1];
  assign ch2_rxcommadet_int = rxcommadet_int[2:2];
  assign ch3_rxcommadet_int = rxcommadet_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] rxctrl0_int;
  wire [15:0] ch0_rxctrl0_int;
  wire [15:0] ch1_rxctrl0_int;
  wire [15:0] ch2_rxctrl0_int;
  wire [15:0] ch3_rxctrl0_int;
  assign ch0_rxctrl0_int = rxctrl0_int[15:0];
  assign ch1_rxctrl0_int = rxctrl0_int[31:16];
  assign ch2_rxctrl0_int = rxctrl0_int[47:32];
  assign ch3_rxctrl0_int = rxctrl0_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [63:0] rxctrl1_int;
  wire [15:0] ch0_rxctrl1_int;
  wire [15:0] ch1_rxctrl1_int;
  wire [15:0] ch2_rxctrl1_int;
  wire [15:0] ch3_rxctrl1_int;
  assign ch0_rxctrl1_int = rxctrl1_int[15:0];
  assign ch1_rxctrl1_int = rxctrl1_int[31:16];
  assign ch2_rxctrl1_int = rxctrl1_int[47:32];
  assign ch3_rxctrl1_int = rxctrl1_int[63:48];

  //--------------------------------------------------------------------------------------------------------------------
  wire [31:0] rxctrl2_int;
  wire [7:0] ch0_rxctrl2_int;
  wire [7:0] ch1_rxctrl2_int;
  wire [7:0] ch2_rxctrl2_int;
  wire [7:0] ch3_rxctrl2_int;
  assign ch0_rxctrl2_int = rxctrl2_int[7:0];
  assign ch1_rxctrl2_int = rxctrl2_int[15:8];
  assign ch2_rxctrl2_int = rxctrl2_int[23:16];
  assign ch3_rxctrl2_int = rxctrl2_int[31:24];

  //--------------------------------------------------------------------------------------------------------------------
  wire [31:0] rxctrl3_int;
  wire [7:0] ch0_rxctrl3_int;
  wire [7:0] ch1_rxctrl3_int;
  wire [7:0] ch2_rxctrl3_int;
  wire [7:0] ch3_rxctrl3_int;
  assign ch0_rxctrl3_int = rxctrl3_int[7:0];
  assign ch1_rxctrl3_int = rxctrl3_int[15:8];
  assign ch2_rxctrl3_int = rxctrl3_int[23:16];
  assign ch3_rxctrl3_int = rxctrl3_int[31:24];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] rxpmaresetdone_int;
  wire [0:0] ch0_rxpmaresetdone_int;
  wire [0:0] ch1_rxpmaresetdone_int;
  wire [0:0] ch2_rxpmaresetdone_int;
  wire [0:0] ch3_rxpmaresetdone_int;
  assign ch0_rxpmaresetdone_int = rxpmaresetdone_int[0:0];
  assign ch1_rxpmaresetdone_int = rxpmaresetdone_int[1:1];
  assign ch2_rxpmaresetdone_int = rxpmaresetdone_int[2:2];
  assign ch3_rxpmaresetdone_int = rxpmaresetdone_int[3:3];

  //--------------------------------------------------------------------------------------------------------------------
  wire [3:0] txpmaresetdone_int;
  wire [0:0] ch0_txpmaresetdone_int;
  wire [0:0] ch1_txpmaresetdone_int;
  wire [0:0] ch2_txpmaresetdone_int;
  wire [0:0] ch3_txpmaresetdone_int;
  assign ch0_txpmaresetdone_int = txpmaresetdone_int[0:0];
  assign ch1_txpmaresetdone_int = txpmaresetdone_int[1:1];
  assign ch2_txpmaresetdone_int = txpmaresetdone_int[2:2];
  assign ch3_txpmaresetdone_int = txpmaresetdone_int[3:3];


  // ===================================================================================================================
  // BUFFERS
  // ===================================================================================================================

  // Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
  // initialization block as well as the VIO-sourced reset
  wire hb_gtwiz_reset_all_vio_int;
  wire hb_gtwiz_reset_all_buf_int;
  wire hb_gtwiz_reset_all_init_int;
  wire hb_gtwiz_reset_all_int;

  IBUF ibuf_hb_gtwiz_reset_all_inst (
    .I (hb_gtwiz_reset_all_in),
    .O (hb_gtwiz_reset_all_buf_int)
  );

  assign hb_gtwiz_reset_all_int = hb_gtwiz_reset_all_buf_int || hb_gtwiz_reset_all_init_int || hb_gtwiz_reset_all_vio_int;

  wire inclk_buf;
   IBUFGDS IBUFGDS_inst (
   .O(inclk_buf), // Clock buffer output
   .I(CLK_IN_P), // Diff_p clock buffer input (connect directly to top-level port)
   .IB(CLK_IN_N) // Diff_n clock buffer input (connect directly to top-level port)
   );

   wire clk_out40;
   wire clk_out80;

   clockManager clockManager_i
    (
    // Clock out ports
    .clk_out1(clk_out40),     // output clk_out1
    .clk_out2(clk_out80),     // output clk_out2
    // Clock in ports
    .clk_in1(inclk_buf)
    );
    // input clk_in300

  // Globally buffer the free-running input clock
  wire hb_gtwiz_reset_clk_freerun_buf_int;
  assign hb_gtwiz_reset_clk_freerun_in = clk_out40;
   
  BUFG bufg_clk_freerun_inst (
    .I (hb_gtwiz_reset_clk_freerun_in),
    .O (hb_gtwiz_reset_clk_freerun_buf_int)
  );

  // Instantiate a differential reference clock buffer for each reference clock differential pair in this configuration,
  // and assign the single-ended output of each differential reference clock buffer to the appropriate PLL input signal

  // Differential reference clock buffer for MGTREFCLK0_X0Y3
  wire mgtrefclk0_x0y3_int;

  IBUFDS_GTE3 #(
    .REFCLK_EN_TX_PATH  (1'b0),
    .REFCLK_HROW_CK_SEL (2'b00),
    .REFCLK_ICNTL_RX    (2'b00)
  ) IBUFDS_GTE3_MGTREFCLK0_X0Y3_INST (
    .I     (mgtrefclk0_x0y3_p),
    .IB    (mgtrefclk0_x0y3_n),
    .CEB   (1'b0),
    .O     (mgtrefclk0_x0y3_int),
    .ODIV2 ()
  );

  assign cm0_gtrefclk00_int = mgtrefclk0_x0y3_int;


  // ===================================================================================================================
  // USER CLOCKING RESETS
  // ===================================================================================================================

  // The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_tx_reset_int = ~(&txpmaresetdone_int);

  // The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  // stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  // user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  assign hb0_gtwiz_userclk_rx_reset_int = ~(&rxpmaresetdone_int);


  // ===================================================================================================================
  // PRBS STIMULUS, CHECKING, AND LINK MANAGEMENT
  // ===================================================================================================================

  // PRBS stimulus
  // -------------------------------------------------------------------------------------------------------------------

  // PRBS-based data stimulus module for transceiver channel 0
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_stimulus_8b10b example_stimulus_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch0_txctrl0_int),
    .txctrl1_out                 (ch0_txctrl1_int),
    .txctrl2_out                 (ch0_txctrl2_int),
    .txdata_out                  (hb0_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 1
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_stimulus_8b10b example_stimulus_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch1_txctrl0_int),
    .txctrl1_out                 (ch1_txctrl1_int),
    .txctrl2_out                 (ch1_txctrl2_int),
    .txdata_out                  (hb1_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 2
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_stimulus_8b10b example_stimulus_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch2_txctrl0_int),
    .txctrl1_out                 (ch2_txctrl1_int),
    .txctrl2_out                 (ch2_txctrl2_int),
    .txdata_out                  (hb2_gtwiz_userdata_tx_int)
  );

  // PRBS-based data stimulus module for transceiver channel 3
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_stimulus_8b10b example_stimulus_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_tx_usrclk2_in (hb0_gtwiz_userclk_tx_usrclk2_int),
    .gtwiz_userclk_tx_active_in  (hb0_gtwiz_userclk_tx_active_int),
    .txctrl0_out                 (ch3_txctrl0_int),
    .txctrl1_out                 (ch3_txctrl1_int),
    .txctrl2_out                 (ch3_txctrl2_int),
    .txdata_out                  (hb3_gtwiz_userdata_tx_int)
  );

  // PRBS checking
  // -------------------------------------------------------------------------------------------------------------------

  // Declare a signal vector of PRBS match indicators, with one indicator bit per transceiver channel
  wire [3:0] prbs_match_int;

  // PRBS-based data checking module for transceiver channel 0
  gtwizard_ultrascale_0_example_checking_8b10b example_checking_inst0 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch0_rxctrl0_int),
    .rxctrl1_in                  (ch0_rxctrl1_int),
    .rxctrl2_in                  (ch0_rxctrl2_int),
    .rxctrl3_in                  (ch0_rxctrl3_int),
    .rxdata_in                   (hb0_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[0])
  );

  // PRBS-based data checking module for transceiver channel 1
  gtwizard_ultrascale_0_example_checking_8b10b example_checking_inst1 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch1_rxctrl0_int),
    .rxctrl1_in                  (ch1_rxctrl1_int),
    .rxctrl2_in                  (ch1_rxctrl2_int),
    .rxctrl3_in                  (ch1_rxctrl3_int),
    .rxdata_in                   (hb1_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[1])
  );

  // PRBS-based data checking module for transceiver channel 2
  gtwizard_ultrascale_0_example_checking_8b10b example_checking_inst2 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch2_rxctrl0_int),
    .rxctrl1_in                  (ch2_rxctrl1_int),
    .rxctrl2_in                  (ch2_rxctrl2_int),
    .rxctrl3_in                  (ch2_rxctrl3_int),
    .rxdata_in                   (hb2_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[2])
  );

  // PRBS-based data checking module for transceiver channel 3
  gtwizard_ultrascale_0_example_checking_8b10b example_checking_inst3 (
    .gtwiz_reset_all_in          (hb_gtwiz_reset_all_int || ~hb0_gtwiz_reset_rx_done_int ),
    .gtwiz_userclk_rx_usrclk2_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .gtwiz_userclk_rx_active_in  (hb0_gtwiz_userclk_rx_active_int),
    .rxctrl0_in                  (ch3_rxctrl0_int),
    .rxctrl1_in                  (ch3_rxctrl1_int),
    .rxctrl2_in                  (ch3_rxctrl2_int),
    .rxctrl3_in                  (ch3_rxctrl3_int),
    .rxdata_in                   (hb3_gtwiz_userdata_rx_int),
    .prbs_match_out              (prbs_match_int[3])
  );

  // PRBS match and related link management
  // -------------------------------------------------------------------------------------------------------------------

  // Perform a bitwise NAND of all PRBS match indicators, creating a combinatorial indication of any PRBS mismatch
  // across all transceiver channels
  wire prbs_error_any_async = ~(&prbs_match_int);
  wire prbs_error_any_sync;

  // Synchronize the PRBS mismatch indicator the free-running clock domain, using a reset synchronizer with asynchronous
  // reset and synchronous removal
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_reset_synchronizer reset_synchronizer_prbs_match_all_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .rst_in (prbs_error_any_async),
    .rst_out(prbs_error_any_sync)
  );

  // Implement an example link status state machine using a simple leaky bucket mechanism. The link status indicates
  // the continual PRBS match status to both the top-level observer and the initialization state machine, while being
  // tolerant of occasional bit errors. This is an example and can be modified as necessary.
  localparam ST_LINK_DOWN = 1'b0;
  localparam ST_LINK_UP   = 1'b1;
  reg        sm_link      = ST_LINK_DOWN;
  reg [6:0]  link_ctr     = 7'd0;

  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    case (sm_link)
      // The link is considered to be down when the link counter initially has a value less than 67. When the link is
      // down, the counter is incremented on each cycle where all PRBS bits match, but reset whenever any PRBS mismatch
      // occurs. When the link counter reaches 67, transition to the link up state.
      ST_LINK_DOWN: begin
        if (prbs_error_any_sync !== 1'b0) begin
          link_ctr <= 7'd0;
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
          else
            sm_link <= ST_LINK_UP;
        end
      end

      // When the link is up, the link counter is decreased by 34 whenever any PRBS mismatch occurs, but is increased by
      // only 1 on each cycle where all PRBS bits match, up to its saturation point of 67. If the link counter reaches
      // 0 (including rollover protection), transition to the link down state.
      ST_LINK_UP: begin
        if (prbs_error_any_sync !== 1'b0) begin
          if (link_ctr > 7'd33) begin
            link_ctr <= link_ctr - 7'd34;
            if (link_ctr == 7'd34)
              sm_link  <= ST_LINK_DOWN;
          end
          else begin
            link_ctr <= 7'd0;
            sm_link  <= ST_LINK_DOWN;
          end
        end
        else begin
          if (link_ctr < 7'd67)
            link_ctr <= link_ctr + 7'd1;
        end
      end
    endcase
  end

  // Synchronize the latched link down reset input and the VIO-driven signal into the free-running clock domain
  wire link_down_latched_reset_vio_int;
  wire link_down_latched_reset_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_link_down_latched_reset_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (link_down_latched_reset_in || link_down_latched_reset_vio_int),
    .o_out  (link_down_latched_reset_sync)
  );

  // Reset the latched link down indicator when the synchronized latched link down reset signal is high. Otherwise, set
  // the latched link down indicator upon losing link. This indicator is available for user reference.
  always @(posedge hb_gtwiz_reset_clk_freerun_buf_int) begin
    if (link_down_latched_reset_sync)
      link_down_latched_out <= 1'b0;
    else if (!sm_link)
      link_down_latched_out <= 1'b1;
  end

  // Assign the link status indicator to the top-level two-state output for user reference
  assign link_status_out = sm_link;


  // ===================================================================================================================
  // INITIALIZATION
  // ===================================================================================================================

  // Declare the receiver reset signals that interface to the reset controller helper block. For this configuration,
  // which uses the same PLL type for transmitter and receiver, the "reset RX PLL and datapath" feature is not used.
  wire hb_gtwiz_reset_rx_pll_and_datapath_int = 1'b0;
  wire hb_gtwiz_reset_rx_datapath_int;

  // Declare signals which connect the VIO instance to the initialization module for debug purposes
  wire       init_done_int;
  wire [3:0] init_retry_ctr_int;

  // Combine the receiver reset signals form the initialization module and the VIO to drive the appropriate reset
  // controller helper block reset input
  wire hb_gtwiz_reset_rx_pll_and_datapath_vio_int;
  wire hb_gtwiz_reset_rx_datapath_vio_int;
  wire hb_gtwiz_reset_rx_datapath_init_int;

  assign hb_gtwiz_reset_rx_datapath_int = hb_gtwiz_reset_rx_datapath_init_int || hb_gtwiz_reset_rx_datapath_vio_int;

  // The example initialization module interacts with the reset controller helper block and other example design logic
  // to retry failed reset attempts in order to mitigate bring-up issues such as initially-unavilable reference clocks
  // or data connections. It also resets the receiver in the event of link loss in an attempt to regain link, so please
  // note the possibility that this behavior can have the effect of overriding or disturbing user-provided inputs that
  // destabilize the data stream. It is a demonstration only and can be modified to suit your system needs.
  gtwizard_ultrascale_0_example_init example_init_inst (
    .clk_freerun_in  (hb_gtwiz_reset_clk_freerun_buf_int),
    .reset_all_in    (hb_gtwiz_reset_all_int),
    .tx_init_done_in (gtwiz_reset_tx_done_int),
    .rx_init_done_in (gtwiz_reset_rx_done_int),
    .rx_data_good_in (sm_link),
    .reset_all_out   (hb_gtwiz_reset_all_init_int),
    .reset_rx_out    (hb_gtwiz_reset_rx_datapath_init_int),
    .init_done_out   (init_done_int),
    .retry_ctr_out   (init_retry_ctr_int)
  );


  // ===================================================================================================================
  // VIO FOR HARDWARE BRING-UP AND DEBUG
  // ===================================================================================================================

  // Synchronize gtpowergood into the free-running clock domain for VIO usage
  wire [3:0] gtpowergood_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[0]),
    .o_out  (gtpowergood_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[1]),
    .o_out  (gtpowergood_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[2]),
    .o_out  (gtpowergood_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtpowergood_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtpowergood_int[3]),
    .o_out  (gtpowergood_vio_sync[3])
  );

  // Synchronize txpmaresetdone into the free-running clock domain for VIO usage
  wire [3:0] txpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[0]),
    .o_out  (txpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[1]),
    .o_out  (txpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[2]),
    .o_out  (txpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_txpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (txpmaresetdone_int[3]),
    .o_out  (txpmaresetdone_vio_sync[3])
  );

  // Synchronize rxpmaresetdone into the free-running clock domain for VIO usage
  wire [3:0] rxpmaresetdone_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[0]),
    .o_out  (rxpmaresetdone_vio_sync[0])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_1_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[1]),
    .o_out  (rxpmaresetdone_vio_sync[1])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_2_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[2]),
    .o_out  (rxpmaresetdone_vio_sync[2])
  );

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_rxpmaresetdone_3_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (rxpmaresetdone_int[3]),
    .o_out  (rxpmaresetdone_vio_sync[3])
  );

  // Synchronize gtwiz_reset_tx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_tx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_tx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_tx_done_int[0]),
    .o_out  (gtwiz_reset_tx_done_vio_sync[0])
  );

  // Synchronize gtwiz_reset_rx_done into the free-running clock domain for VIO usage
  wire [0:0] gtwiz_reset_rx_done_vio_sync;

  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_gtwiz_reset_rx_done_0_inst (
    .clk_in (hb_gtwiz_reset_clk_freerun_buf_int),
    .i_in   (gtwiz_reset_rx_done_int[0]),
    .o_out  (gtwiz_reset_rx_done_vio_sync[0])
  );
  
  wire [0:0] rxdata_errctr_reset_vio_async;  
  wire [0:0] rxdata_errctr_reset_int;
  (* DONT_TOUCH = "TRUE" *)
  gtwizard_ultrascale_0_example_bit_synchronizer bit_synchronizer_vio_rxdata_errctr_inst (
    .clk_in (hb0_gtwiz_userclk_rx_usrclk2_int),
    .i_in   (rxdata_errctr_reset_vio_async),
    .o_out  (rxdata_errctr_reset_int)
  );
    
  reg [39:0] hb0_rxdata_nml_ctr;
  reg [15:0] ch0_rxdata_err_ctr;
  reg [15:0] ch1_rxdata_err_ctr;
  reg [15:0] ch2_rxdata_err_ctr;
  reg [15:0] ch3_rxdata_err_ctr;
  always @(posedge hb0_gtwiz_userclk_rx_usrclk2_int) begin
    if (rxdata_errctr_reset_int == 1'b1) begin
      hb0_rxdata_nml_ctr <= 40'd0;
      ch0_rxdata_err_ctr <= 16'd0;
      ch1_rxdata_err_ctr <= 16'd0;
      ch2_rxdata_err_ctr <= 16'd0;
      ch3_rxdata_err_ctr <= 16'd0;
    end
    else if (gtwiz_reset_rx_done_int == 1'b1)
      hb0_rxdata_nml_ctr <= hb0_rxdata_nml_ctr + 40'd1;
      if (prbs_match_int[0] == 1'b0)
        ch0_rxdata_err_ctr <= ch0_rxdata_err_ctr + 1;
      if (prbs_match_int[1] == 1'b0)
        ch1_rxdata_err_ctr <= ch1_rxdata_err_ctr + 1;
      if (prbs_match_int[2] == 1'b0)
        ch2_rxdata_err_ctr <= ch2_rxdata_err_ctr + 1;
      if (prbs_match_int[3] == 1'b0)
        ch3_rxdata_err_ctr <= ch3_rxdata_err_ctr + 1;
  end

  wire [617:0] ila_data; 
  
  assign ila_data[127:0] = gtwiz_userdata_rx_int;
  assign ila_data[255:128] = gtwiz_userdata_tx_int;
  assign ila_data[259:256] = prbs_match_int;
  assign ila_data[260] = hb0_gtwiz_userclk_rx_usrclk2_int;
  assign ila_data[261] = hb0_gtwiz_userclk_rx_active_int;
  assign ila_data[262] = hb_gtwiz_reset_all_int;
  assign ila_data[263] = hb0_gtwiz_reset_rx_done_int;
  assign ila_data[264] = hb0_gtwiz_userclk_tx_usrclk2_int;
  assign ila_data[265] = hb0_gtwiz_userclk_tx_active_int;
  assign ila_data[266] = gtwiz_userclk_tx_reset_int;
  assign ila_data[267] = gtwiz_userclk_tx_usrclk_int;
  assign ila_data[268] = gtwiz_userclk_tx_usrclk2_int;
  assign ila_data[269] = gtwiz_userclk_tx_active_int;
  assign ila_data[270] = gtwiz_userclk_rx_reset_int;
  assign ila_data[271] = gtwiz_userclk_rx_usrclk_int;
  assign ila_data[272] = gtwiz_userclk_rx_usrclk2_int;
  assign ila_data[273] = gtwiz_userclk_rx_active_int;
  assign ila_data[309:274] = drpaddr_int;
  assign ila_data[313:310] = drpclk_int;
  assign ila_data[317:314] = drpdi_int;
  assign ila_data[321:318] = drpen_int;
  assign ila_data[325:322] = drpwe_int;
  assign ila_data[329:326] = eyescanreset_int;
  assign ila_data[333:330] = rx8b10ben_int;
  assign ila_data[337:334] = rxcommadeten_int;
  assign ila_data[341:338] = rxlpmen_int;
  assign ila_data[345:342] = rxmcommaalignen_int;
  assign ila_data[349:346] = rxpcommaalignen_int;
  assign ila_data[361:350] = rxrate_int;
  assign ila_data[365:362] = tx8b10ben_int;
  assign ila_data[381:366] = txdiffctrl_int;
  assign ila_data[401:382] = txpostcursor_int;
  assign ila_data[421:402] = txprecursor_int;
  assign ila_data[485:422] = drpdo_int;
  assign ila_data[489:486] = drprdy_int;
  assign ila_data[493:490] = gtpowergood_int;
  assign ila_data[497:494] = rxbyteisaligned_int;
  assign ila_data[501:498] = rxbyterealign_int;
  assign ila_data[505:502] = rxcommadet_int;
  assign ila_data[509:506] = rxpmaresetdone_int;
  assign ila_data[513:510] = txpmaresetdone_int;
  assign ila_data[553:514] = hb0_rxdata_nml_ctr;
  assign ila_data[569:554] = ch0_rxdata_err_ctr;
  assign ila_data[585:570] = ch1_rxdata_err_ctr;
  assign ila_data[601:586] = ch2_rxdata_err_ctr;
  assign ila_data[617:602] = ch3_rxdata_err_ctr;

   ila_0 ila_i (
    .clk(hb_gtwiz_reset_clk_freerun_buf_int), // input wire clk
    //.probe0(ila_trigger), // input wire [7:0]  probe0
    .probe0(ila_data) // input wire [255:0]  probe1
   );

  // Instantiate the VIO IP core for hardware bring-up and debug purposes, connecting relevant debug and analysis
  // signals which have been enabled during Wizard IP customization. This initial set of connected signals is
  // provided as a convenience and example, but more or fewer ports can be used as needed; simply re-customize and
  // re-generate the VIO instance, then connect any exposed signals that are needed. Signals which are synchronous to
  // clocks other than the free-running clock will require synchronization. For usage, refer to Vivado Design Suite
  // User Guide: Programming and Debugging (UG908)
  gtwizard_ultrascale_0_vio_0 gtwizard_ultrascale_0_vio_0_inst (
    .clk (hb_gtwiz_reset_clk_freerun_buf_int)
    ,.probe_in0 (link_status_out)
    ,.probe_in1 (link_down_latched_out)
    ,.probe_in2 (init_done_int)
    ,.probe_in3 (init_retry_ctr_int)
    ,.probe_in4 (gtpowergood_vio_sync)
    ,.probe_in5 (txpmaresetdone_vio_sync)
    ,.probe_in6 (rxpmaresetdone_vio_sync)
    ,.probe_in7 (gtwiz_reset_tx_done_vio_sync)
    ,.probe_in8 (gtwiz_reset_rx_done_vio_sync)
    ,.probe_out0 (hb_gtwiz_reset_all_vio_int)
    ,.probe_out1 (hb0_gtwiz_reset_tx_pll_and_datapath_int)
    ,.probe_out2 (hb0_gtwiz_reset_tx_datapath_int)
    ,.probe_out3 (hb_gtwiz_reset_rx_pll_and_datapath_vio_int)
    ,.probe_out4 (hb_gtwiz_reset_rx_datapath_vio_int)
    ,.probe_out5 (link_down_latched_reset_vio_int)
    ,.probe_out6 (rxdata_errctr_reset_vio_async)
  );


  // ===================================================================================================================
  // IN-SYSTEM IBERT FOR HARDWARE BRING-UP AND LINK ANALYSIS
  // ===================================================================================================================

  // Instantiate the In-System IBERT IP core for hardware bring-up and link analysis purposes. For usage, refer to
  // Vivado Design Suite User Guide: Programming and Debugging (UG908)
  // In-System IBERT IP instance property dictionary is as follows:
  // CONFIG.C_GT_TYPE {GTH} CONFIG.C_GTS_USED {X0Y12 X0Y13 X0Y14 X0Y15} CONFIG.C_ENABLE_INPUT_PORTS {true}
  gtwizard_ultrascale_0_in_system_ibert_0 gtwizard_ultrascale_0_in_system_ibert_0_inst (
    .drpclk_o       (drpclk_int),
    .gt0_drpen_o    (drpen_int[0:0]),
    .gt0_drpwe_o    (drpwe_int[0:0]),
    .gt0_drpaddr_o  (drpaddr_int[8:0]),
    .gt0_drpdi_o    (drpdi_int[15:0]),
    .gt0_drprdy_i   (drprdy_int[0:0]),
    .gt0_drpdo_i    (drpdo_int[15:0]),
    .gt1_drpen_o    (drpen_int[1:1]),
    .gt1_drpwe_o    (drpwe_int[1:1]),
    .gt1_drpaddr_o  (drpaddr_int[17:9]),
    .gt1_drpdi_o    (drpdi_int[31:16]),
    .gt1_drprdy_i   (drprdy_int[1:1]),
    .gt1_drpdo_i    (drpdo_int[31:16]),
    .gt2_drpen_o    (drpen_int[2:2]),
    .gt2_drpwe_o    (drpwe_int[2:2]),
    .gt2_drpaddr_o  (drpaddr_int[26:18]),
    .gt2_drpdi_o    (drpdi_int[47:32]),
    .gt2_drprdy_i   (drprdy_int[2:2]),
    .gt2_drpdo_i    (drpdo_int[47:32]),
    .gt3_drpen_o    (drpen_int[3:3]),
    .gt3_drpwe_o    (drpwe_int[3:3]),
    .gt3_drpaddr_o  (drpaddr_int[35:27]),
    .gt3_drpdi_o    (drpdi_int[63:48]),
    .gt3_drprdy_i   (drprdy_int[3:3]),
    .gt3_drpdo_i    (drpdo_int[63:48]),
    .eyescanreset_o (eyescanreset_int),
    .rxrate_o       (rxrate_int),
    .txdiffctrl_o   (txdiffctrl_int),
    .txprecursor_o  (txprecursor_int),
    .txpostcursor_o (txpostcursor_int),
    .rxlpmen_o      (rxlpmen_int),
    .rxrate_i       ({4{3'b000}}),
    .txdiffctrl_i   ({4{4'b1100}}),
    .txprecursor_i  ({4{5'b00000}}),
    .txpostcursor_i ({4{5'b00000}}),
    .rxlpmen_i      ({4{1'b0}}),
    .rxoutclk_i     ({4{hb0_gtwiz_userclk_rx_usrclk2_int}}),
    .drpclk_i       ({4{hb_gtwiz_reset_clk_freerun_buf_int}}),
    .clk            (hb_gtwiz_reset_clk_freerun_buf_int)
  );


  // ===================================================================================================================
  // EXAMPLE WRAPPER INSTANCE
  // ===================================================================================================================

  // Instantiate the example design wrapper, mapping its enabled ports to per-channel internal signals and example
  // resources as appropriate
  gtwizard_ultrascale_0_example_wrapper example_wrapper_inst (
    .gthrxn_in                               (gthrxn_int)
   ,.gthrxp_in                               (gthrxp_int)
   ,.gthtxn_out                              (gthtxn_int)
   ,.gthtxp_out                              (gthtxp_int)
   ,.gtwiz_userclk_tx_reset_in               (gtwiz_userclk_tx_reset_int)
   ,.gtwiz_userclk_tx_srcclk_out             (gtwiz_userclk_tx_srcclk_int)
   ,.gtwiz_userclk_tx_usrclk_out             (gtwiz_userclk_tx_usrclk_int)
   ,.gtwiz_userclk_tx_usrclk2_out            (gtwiz_userclk_tx_usrclk2_int)
   ,.gtwiz_userclk_tx_active_out             (gtwiz_userclk_tx_active_int)
   ,.gtwiz_userclk_rx_reset_in               (gtwiz_userclk_rx_reset_int)
   ,.gtwiz_userclk_rx_srcclk_out             (gtwiz_userclk_rx_srcclk_int)
   ,.gtwiz_userclk_rx_usrclk_out             (gtwiz_userclk_rx_usrclk_int)
   ,.gtwiz_userclk_rx_usrclk2_out            (gtwiz_userclk_rx_usrclk2_int)
   ,.gtwiz_userclk_rx_active_out             (gtwiz_userclk_rx_active_int)
   ,.gtwiz_reset_clk_freerun_in              ({1{hb_gtwiz_reset_clk_freerun_buf_int}})
   ,.gtwiz_reset_all_in                      ({1{hb_gtwiz_reset_all_int}})
   ,.gtwiz_reset_tx_pll_and_datapath_in      (gtwiz_reset_tx_pll_and_datapath_int)
   ,.gtwiz_reset_tx_datapath_in              (gtwiz_reset_tx_datapath_int)
   ,.gtwiz_reset_rx_pll_and_datapath_in      ({1{hb_gtwiz_reset_rx_pll_and_datapath_int}})
   ,.gtwiz_reset_rx_datapath_in              ({1{hb_gtwiz_reset_rx_datapath_int}})
   ,.gtwiz_reset_rx_cdr_stable_out           (gtwiz_reset_rx_cdr_stable_int)
   ,.gtwiz_reset_tx_done_out                 (gtwiz_reset_tx_done_int)
   ,.gtwiz_reset_rx_done_out                 (gtwiz_reset_rx_done_int)
   ,.gtwiz_userdata_tx_in                    (gtwiz_userdata_tx_int)
   ,.gtwiz_userdata_rx_out                   (gtwiz_userdata_rx_int)
   ,.gtrefclk00_in                           (gtrefclk00_int)
   ,.qpll0outclk_out                         (qpll0outclk_int)
   ,.qpll0outrefclk_out                      (qpll0outrefclk_int)
   ,.drpaddr_in                              (drpaddr_int)
   ,.drpclk_in                               (drpclk_int)
   ,.drpdi_in                                (drpdi_int)
   ,.drpen_in                                (drpen_int)
   ,.drpwe_in                                (drpwe_int)
   ,.eyescanreset_in                         (eyescanreset_int)
   ,.rx8b10ben_in                            (rx8b10ben_int)
   ,.rxcommadeten_in                         (rxcommadeten_int)
   ,.rxlpmen_in                              (rxlpmen_int)
   ,.rxmcommaalignen_in                      (rxmcommaalignen_int)
   ,.rxpcommaalignen_in                      (rxpcommaalignen_int)
   ,.rxrate_in                               (rxrate_int)
   ,.tx8b10ben_in                            (tx8b10ben_int)
   ,.txctrl0_in                              (txctrl0_int)
   ,.txctrl1_in                              (txctrl1_int)
   ,.txctrl2_in                              (txctrl2_int)
   ,.txdiffctrl_in                           (txdiffctrl_int)
   ,.txpostcursor_in                         (txpostcursor_int)
   ,.txprecursor_in                          (txprecursor_int)
   ,.drpdo_out                               (drpdo_int)
   ,.drprdy_out                              (drprdy_int)
   ,.gtpowergood_out                         (gtpowergood_int)
   ,.rxbyteisaligned_out                     (rxbyteisaligned_int)
   ,.rxbyterealign_out                       (rxbyterealign_int)
   ,.rxcommadet_out                          (rxcommadet_int)
   ,.rxctrl0_out                             (rxctrl0_int)
   ,.rxctrl1_out                             (rxctrl1_int)
   ,.rxctrl2_out                             (rxctrl2_int)
   ,.rxctrl3_out                             (rxctrl3_int)
   ,.rxpmaresetdone_out                      (rxpmaresetdone_int)
   ,.txpmaresetdone_out                      (txpmaresetdone_int)
);


endmodule
