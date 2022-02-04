
// file: clockManager_exdes.v
// 
// (c) Copyright 2008 - 2013 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 

//----------------------------------------------------------------------------
// Clocking wizard example design
//----------------------------------------------------------------------------
// This example design instantiates the created clocking network, where each
//   output clock drives a counter. The high bit of each counter is ported.
//----------------------------------------------------------------------------

`timescale 1ps/1ps

module clockManager_exdes 
 (
  // Reset that only drives logic in example design
  input         COUNTER_RESET,
  output [4:1]   CLK_OUT,
  // High bits of counters driven by clocks
  output [4:1]  COUNT,
 // Clock in ports
  input         clk_in1
 );

  // Parameters for the counters
  //-------------------------------
 localparam  ONE_NS      = 1000;
 localparam time PER1    = 10*ONE_NS;
 localparam time PER1_1  = PER1/2;  
 // Counter width
  localparam    C_W       = 16;
  // Clock to Q delay of 100ps
  localparam TCQ  = 100;
  // Number of counters
  localparam    NUM_C     = 4;
  genvar        count_gen;
  // Create reset for the counters
  wire          reset_int = COUNTER_RESET;

  (* ASYNC_REG = "TRUE" *)  reg [NUM_C:1] rst_sync;
  (* ASYNC_REG = "TRUE" *)  reg [NUM_C:1] rst_sync_int;
  (* ASYNC_REG = "TRUE" *)  reg [NUM_C:1] rst_sync_int1;
  (* ASYNC_REG = "TRUE" *)  reg [NUM_C:1] rst_sync_int2;


  // Declare the clocks and counters
  wire [NUM_C:1] clk_int;
  wire [NUM_C:1] clk;
  reg [C_W-1:0]  counter [NUM_C:1];
  wire      clk_in1_buf;
  wire      clk_in2_buf;
  wire      clkfb_in_buf;



  // Insert BUFGs on all input clocks that don't already have them
  //--------------------------------------------------------------
  BUFG clkin1_buf
   (.O (clk_in1_buf),
    .I (clk_in1));



  // Instantiation of the clocking network
  //--------------------------------------
  clockManager clknetwork
   (
    // Clock out ports
    .clk_out40           (clk_int[1]),
    .clk_out10           (clk_int[2]),
    .clk_out80           (clk_int[3]),
    .clk_out160           (clk_int[4]),
   // Clock in ports
    .clk_in1            (clk_in1_buf)
);
genvar clk_out_pins;

generate 
  for (clk_out_pins = 1; clk_out_pins <= NUM_C; clk_out_pins = clk_out_pins + 1) 
  begin: gen_outclk_oddr
  ODDRE1 
  clkout_oddr
    (.Q  (CLK_OUT[clk_out_pins]),
     .C  (clk_int[clk_out_pins]),
     .D1 (1'b1),
     .D2 (1'b0),
     .SR (1'b0));
  end
endgenerate


  // Connect the output clocks to the design
  //-----------------------------------------
  assign clk[1] = clk_int[1];
  assign clk[2] = clk_int[2];
  assign clk[3] = clk_int[3];
  assign clk[4] = clk_int[4];


  // Reset synchronizer
  //-----------------------------------
  generate for (count_gen = 1; count_gen <= NUM_C; count_gen = count_gen + 1) begin: counters_1
    always @(posedge reset_int or posedge clk[count_gen]) begin
       if (reset_int) begin
            rst_sync[count_gen] <= 1'b1;
            rst_sync_int[count_gen]<= 1'b1;
            rst_sync_int1[count_gen]<= 1'b1;
            rst_sync_int2[count_gen]<= 1'b1;
       end
       else begin
            rst_sync[count_gen] <= 1'b0;
            rst_sync_int[count_gen] <= rst_sync[count_gen];     
            rst_sync_int1[count_gen] <= rst_sync_int[count_gen]; 
            rst_sync_int2[count_gen] <= rst_sync_int1[count_gen];
       end
    end
  end
  endgenerate

  // Output clock sampling
  //-----------------------------------
  generate for (count_gen = 1; count_gen <= NUM_C; count_gen = count_gen + 1) begin: counters

    always @(posedge clk[count_gen] or posedge rst_sync_int2[count_gen]) begin
      if (rst_sync_int2[count_gen]) begin
        counter[count_gen] <= #TCQ { C_W { 1'b 0 } };
      end else begin
        counter[count_gen] <= #TCQ counter[count_gen] + 1'b 1;
      end
    end
    // alias the high bit of each counter to the corresponding
    //   bit in the output bus
    assign COUNT[count_gen] = counter[count_gen][C_W-1];
  end
  endgenerate


endmodule
