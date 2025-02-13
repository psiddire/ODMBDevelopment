--------------------------------------------------------------------------------
--  (c) Copyright 2013-2018 Xilinx, Inc. All rights reserved.
--
--  This file contains confidential and proprietary information
--  of Xilinx, Inc. and is protected under U.S. and
--  international copyright and other intellectual property
--  laws.
--
--  DISCLAIMER
--  This disclaimer is not a license and does not grant any
--  rights to the materials distributed herewith. Except as
--  otherwise provided in a valid license issued to you by
--  Xilinx, and to the maximum extent permitted by applicable
--  law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
--  WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
--  AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
--  BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
--  INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
--  (2) Xilinx shall not be liable (whether in contract or tort,
--  including negligence, or under any other theory of
--  liability) for any loss or damage of any kind or nature
--  related to, arising under or in connection with these
--  materials, including for any direct, or any indirect,
--  special, incidental, or consequential loss or damage
--  (including loss of data, profits, goodwill, or any type of
--  loss or damage suffered as a result of any action brought
--  by a third party) even if such damage or loss was
--  reasonably foreseeable or Xilinx had been advised of the
--  possibility of the same.
--
--  CRITICAL APPLICATIONS
--  Xilinx products are not designed or intended to be fail-
--  safe, or for use in any application requiring fail-safe
--  performance, such as life-support or safety devices or
--  systems, Class III medical devices, nuclear facilities,
--  applications related to the deployment of airbags, or any
--  other applications that could lead to death, personal
--  injury, or severe property or environmental damage
--  (individually and collectively, "Critical
--  Applications"). Customer assumes the sole risk and
--  liability of any use of Xilinx products in Critical
--  Applications, subject only to applicable laws and
--  regulations governing limitations on product liability.
--
--  THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
--  PART OF THIS FILE AT ALL TIMES.
--------------------------------------------------------------------------------

library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

use ieee.std_logic_misc.all;

entity gtwiz_kcu_test_top is
  generic (
    g_SFP_PATTERN : integer range 0 to 3 := 0 -- 0: PRBS pattern, 1: counter pattern
  );
  port (

    -- reference clk from si570
    mgtrefclk0_x0y3_p : in std_logic;
    mgtrefclk0_x0y3_n : in std_logic;

    -- Serial data ports for transceiver at bank 226
    sfp_ch0_rx_n       : in std_logic;
    sfp_ch0_rx_p       : in std_logic;
    sfp_ch0_tx_n       : out std_logic;
    sfp_ch0_tx_p       : out std_logic;

    sfp_ch1_rx_n       : in std_logic;
    sfp_ch1_rx_p       : in std_logic;
    sfp_ch1_tx_n       : out std_logic;
    sfp_ch1_tx_p       : out std_logic;

    -- -- Serial data ports for transceiver for bank 227
    -- fmc_cfg0_rx_n      : in  std_logic_vector(3 downto 0);
    -- fmc_cfg0_rx_p      : in  std_logic_vector(3 downto 0);
    -- fmc_cfg0_tx_n      : out std_logic_vector(3 downto 0);
    -- fmc_cfg0_tx_p      : out std_logic_vector(3 downto 0);

    -- -- Serial data ports for transceiver for bank 228 
    -- fmc_cfg2_rx_n      : in  std_logic_vector(3 downto 0);
    -- fmc_cfg2_rx_p      : in  std_logic_vector(3 downto 0);
    -- fmc_cfg2_tx_n      : out std_logic_vector(3 downto 0);
    -- fmc_cfg2_tx_p      : out std_logic_vector(3 downto 0);

    -- Ports in quad 228, mimicking ODMB7 ones
    DAQ_TX_P     : out std_logic_vector(4 downto 1); -- B04 TX, output to FED
    DAQ_TX_N     : out std_logic_vector(4 downto 1); -- B04 TX, output to FED
    B04_RX_P     : in std_logic_vector(4 downto 2); -- B04 RX, no use yet
    B04_RX_N     : in std_logic_vector(4 downto 2); -- B04 RX, no use yet
    BCK_PRS_P    : in std_logic; -- B04_RX1_P
    BCK_PRS_N    : in std_logic; -- B04_RX1_N

    -- synthesis translate_off
    hb_gtwiz_reset_all_in : in std_logic; --simonly
    link_down_latched_reset_in : in std_logic; --simonly
    link_status_out_sim : out std_logic; --simonly
    -- synthesis translate_on

    -- 300 MHz clk_in
    clk_in_p          : in std_logic;
    clk_in_n          : in std_logic;
    sel_si570_clk     : out std_logic

  );
end gtwiz_kcu_test_top;

architecture Behavioral of gtwiz_kcu_test_top is

  component mgt_sfp is
  port (
    mgtrefclk       : in  std_logic; -- buffer'ed reference clock signal
    txusrclk        : out std_logic; -- USRCLK for TX data preparation
    rxusrclk        : out std_logic; -- USRCLK for RX data readout
    sysclk          : in  std_logic; -- clock for the helper block, 80 MHz
    
    -- Serial data ports for transceiver at bank 226
    sfp_ch0_rx_n    : in  std_logic;
    sfp_ch0_rx_p    : in  std_logic;
    sfp_ch0_tx_n    : out std_logic;
    sfp_ch0_tx_p    : out std_logic;
    
    sfp_ch1_rx_n    : in  std_logic;
    sfp_ch1_rx_p    : in  std_logic;
    sfp_ch1_tx_n    : out std_logic;
    sfp_ch1_tx_p    : out std_logic;
    
    txready         : out std_logic; -- Flag for tx reset done
    rxready         : out std_logic; -- Flag for rx reset done

    -- Transmitter signals
    txdata_ch0      : in std_logic_vector(31 downto 0);  -- Data to be transmitted
    txdata_ch1      : in std_logic_vector(31 downto 0);  -- Data to be transmitted
    txdata_valid    : in std_logic_vector(1 downto 0);   -- Flag for valid data;
    txdiffctrl_ch0  : in std_logic_vector(3 downto 0);  -- Controls the TX voltage swing
    txdiffctrl_ch1  : in std_logic_vector(3 downto 0);  -- Controls the TX voltage swing
    loopback        : in std_logic_vector(2 downto 0);  -- For internal loopback tests
    
    -- Receiver signals
    rxdata_ch0      : out std_logic_vector(31 downto 0);  -- Data received
    rxdata_ch1      : out std_logic_vector(31 downto 0);  -- Data received
    rxdata_valid    : out std_logic_vector(1  downto 0);  -- Flag for valid data;
    bad_rx          : out std_logic_vector(1  downto 0);  -- Flag for fiber errors;
    
    -- PRBS signals
    prbs_type       : in  std_logic_vector(3 downto 0);
    prbs_tx_en      : in  std_logic_vector(1 downto 0);
    prbs_rx_en      : in  std_logic_vector(1 downto 0);
    prbs_en_tst_cnt : in  std_logic_vector(15 downto 0);
    prbs_err_cnt    : out std_logic_vector(15 downto 0);
    
    -- Clock for the gtwizard system
    reset           : in  std_logic
  );
  end component;

  component mgt_ddu is
    generic (
      NCHANNL     : integer range 1 to 4 := 4;  -- number of (firmware) channels (max of TX/RX links)
      NRXLINK     : integer range 1 to 4 := 4;  -- number of (physical) RX links
      NTXLINK     : integer range 1 to 4 := 4;  -- number of (physical) TX links
      TXDATAWIDTH : integer := 16;              -- transmitter user data width
      RXDATAWIDTH  : integer := 16               -- receiver user data width
      );
    port (
      mgtrefclk    : in  std_logic; -- buffer'ed reference clock signal
      txusrclk     : out std_logic; -- USRCLK for TX data readout
      rxusrclk     : out std_logic; -- USRCLK for RX data readout
      sysclk       : in  std_logic; -- clock for the helper block, 80 MHz
      daq_tx_n     : out std_logic_vector(NTXLINK-1 downto 0);
      daq_tx_p     : out std_logic_vector(NTXLINK-1 downto 0);
      bck_rx_n     : in  std_logic; -- for back pressure / loopback
      bck_rx_p     : in  std_logic; -- for back pressure / loopback
      b04_rx_n     : in  std_logic_vector(3 downto 1); -- for back pressure / loopback
      b04_rx_p     : in  std_logic_vector(3 downto 1); -- for back pressure / loopback
      txdata_ch0   : in std_logic_vector(TXDATAWIDTH-1 downto 0);  -- Data received
      txdata_ch1   : in std_logic_vector(TXDATAWIDTH-1 downto 0);  -- Data received
      txdata_ch2   : in std_logic_vector(TXDATAWIDTH-1 downto 0);  -- Data received
      txdata_ch3   : in std_logic_vector(TXDATAWIDTH-1 downto 0);  -- Data received
      txd_valid    : in std_logic_vector(NTXLINK downto 1);   -- Flag for valid data;
      rxdata_ch0   : out std_logic_vector(RXDATAWIDTH-1 downto 0);  -- Data received
      rxdata_ch1   : out std_logic_vector(RXDATAWIDTH-1 downto 0);  -- Data received
      rxdata_ch2   : out std_logic_vector(RXDATAWIDTH-1 downto 0);  -- Data received
      rxdata_ch3   : out std_logic_vector(RXDATAWIDTH-1 downto 0);  -- Data received
      rxd_valid    : out std_logic_vector(NRXLINK downto 1);   -- Flag for valid data;
      bad_rx       : out std_logic_vector(NRXLINK downto 1);   -- Flag for fiber errors;
      rxready      : out std_logic; -- Flag for rx reset done
      txready      : out std_logic; -- Flag for tx reset done
      prbs_type    : in  std_logic_vector(3 downto 0);
      prbs_rx_en   : in  std_logic_vector(NRXLINK downto 1);
      prbs_tst_cnt : in  std_logic_vector(15 downto 0);
      prbs_err_cnt : out std_logic_vector(15 downto 0);
      reset        : in  std_logic
      );
  end component;

  component gtwiz_example_init is
  port (
    clk_freerun_in : in std_logic := '0';
    reset_all_in : in std_logic := '0';
    tx_init_done_in : in std_logic := '0';
    rx_init_done_in : in std_logic := '0';
    rx_data_good_in : in std_logic := '0';
    reset_all_out : out std_logic := '0';
    reset_rx_out : out std_logic := '0';
    init_done_out : out std_logic := '0';
    retry_ctr_out : out std_logic_vector(3 downto 0) := (others=> '0')
  );
  end component;

  component gtwiz_prbs_any is
  generic (
    CHK_MODE : integer := 0;
    INV_PATTERN : integer := 0;
    POLY_LENGHT : integer := 31;
    POLY_TAP : integer := 3;
    NBITS : integer := 16
  );
  port (
    rst : in std_logic := '0';
    clk : in std_logic := '0';
    data_in : in std_logic_vector(NBITS-1 downto 0) := (others=> '0');
    en : in std_logic := '0';
    data_out : out std_logic_vector(NBITS-1 downto 0) := (others=> '0')
  );
  end component;

  component clk_mgr is
  port (
    clk_in1    : in  std_logic := '0';
    -- clk_out160 : out std_logic := '0';
    clk_out80  : out std_logic := '0';
    clk_out40  : out std_logic := '0'
  );
  end component;

  component ila is
  port (
    clk : in std_logic := '0';
    probe0 : in std_logic_vector(191 downto 0) := (others=> '0')
    -- probe1 : in std_logic_vector(15 downto 0) := (others=> '0')
  );
  end component;

  component gtwiz_kcu_sfp_vio_0
  port (
    clk : in std_logic;
    probe_in0 : in std_logic;
    probe_in1 : in std_logic;
    probe_in2 : in std_logic;
    probe_in3 : in std_logic_vector(3 downto 0);
    probe_in4 : in std_logic_vector(1 downto 0);
    probe_in5 : in std_logic_vector(1 downto 0);
    probe_in6 : in std_logic_vector(1 downto 0);
    probe_in7 : in std_logic;
    probe_in8 : in std_logic;
    probe_in9 : in std_logic;
    probe_out0 : out std_logic;
    probe_out1 : out std_logic;
    probe_out2 : out std_logic;
    probe_out3 : out std_logic;
    probe_out4 : out std_logic;
    probe_out5 : out std_logic;
    probe_out6 : out std_logic
  );
  end component;

  component gtwiz_example_bit_synchronizer
  port (
    clk_in: in std_logic := '0';
    i_in: in std_logic := '0';
    o_out: out std_logic := '0'
  );
  end component;

  component gtwiz_example_reset_synchronizer
  port (
    clk_in: in std_logic := '0';
    rst_in: in std_logic := '0';
    rst_out: out std_logic := '0'
  );
  end component;

  signal link_status_out: std_logic := '0';
  signal link_down_latched_out: std_logic := '1';

  -- Synchronize the latched link down reset input and the VIO-driven signal into the free-running clock domain
  -- signals passed to wizard
  signal gthrxn_int: std_logic_vector(1 downto 0) := (others=> '0');
  signal gthrxp_int: std_logic_vector(1 downto 0) := (others=> '0');
  signal gthtxn_int: std_logic_vector(1 downto 0) := (others=> '0');
  signal gthtxp_int: std_logic_vector(1 downto 0) := (others=> '0');
  signal gtwiz_userclk_tx_reset_int : std_logic := '0';
  signal gtwiz_userclk_tx_srcclk_int : std_logic := '0';
  signal gtwiz_userclk_tx_usrclk_int : std_logic := '0';
  signal gtwiz_userclk_tx_usrclk2_int : std_logic := '0';
  signal gtwiz_userclk_tx_active_int : std_logic := '0';
  signal gtwiz_userclk_rx_reset_int : std_logic := '0';
  signal gtwiz_userclk_rx_srcclk_int : std_logic := '0';
  signal gtwiz_userclk_rx_usrclk_int : std_logic := '0';
  signal gtwiz_userclk_rx_usrclk2_int : std_logic := '0';
  signal gtwiz_userclk_rx_active_int : std_logic := '0';
  signal gtwiz_reset_clk_freerun_int : std_logic := '0';
  signal gtwiz_reset_tx_pll_and_datapath_int : std_logic := '0';
  signal gtwiz_reset_tx_datapath_int : std_logic := '0';
  signal gtwiz_reset_rx_pll_and_datapath_int : std_logic := '0';
  signal gtwiz_reset_rx_datapath_int : std_logic := '0';
  signal gtwiz_reset_rx_cdr_stable_int : std_logic := '0';
  signal gtwiz_reset_tx_done_int : std_logic := '0';
  signal gtwiz_reset_rx_done_int : std_logic := '0';
  signal gtwiz_userdata_tx_int : std_logic_vector(63 downto 0) := (others=> '0');
  signal gtwiz_userdata_rx_int : std_logic_vector(63 downto 0) := (others=> '0');
  signal gtrefclk00_int : std_logic := '0';
  signal qpll0outclk_int : std_logic := '0';
  signal qpll0outrefclk_int : std_logic := '0';
  signal rx8b10ben_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal rxcommadeten_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal rxlpmen_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal rxmcommaalignen_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal rxpcommaalignen_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal tx8b10ben_int : std_logic_vector(1 downto 0) := (others=> '1');
  signal txctrl0_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal txctrl1_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal txctrl2_int : std_logic_vector(15 downto 0) := (others=> '0');
  signal gtpowergood_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal rxbyteisaligned_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal rxbyterealign_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal rxcommadet_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal rxctrl0_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal rxctrl1_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal rxctrl2_int : std_logic_vector(15 downto 0) := (others=> '0');
  signal rxctrl3_int : std_logic_vector(15 downto 0) := (others=> '0');
  signal rxpmaresetdone_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal txpmaresetdone_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal hb_gtwiz_reset_all_int : std_logic := '0';

  -- signals needed for in-system IBERT
  signal drpaddr_int : std_logic_vector(17 downto 0) := (others=> '0');
  signal drpclk_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal drpdi_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal drpen_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal drpwe_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal eyescanreset_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal rxrate_int : std_logic_vector(5 downto 0) := (others=> '0');
  signal txdiffctrl_int : std_logic_vector(7 downto 0) := (others=> '0');
  signal txpostcursor_int : std_logic_vector(9 downto 0) := (others=> '0');
  signal txprecursor_int : std_logic_vector(9 downto 0) := (others=> '0');
  signal drpdo_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal drprdy_int : std_logic_vector(1 downto 0) := (others=> '0');

  -- signals local to this wrapper
  -- signal hb_gtwiz_reset_all_in : std_logic := '0';
  signal hb0_gtwiz_userclk_tx_reset_int : std_logic := '0';
  signal hb0_gtwiz_userclk_rx_reset_int : std_logic := '0';

  signal hb0_gtwiz_userclk_tx_srcclk_int : std_logic := '0';
  signal hb0_gtwiz_userclk_tx_usrclk_int : std_logic := '0';
  signal hb0_gtwiz_userclk_tx_usrclk2_int : std_logic := '0';
  signal hb0_gtwiz_userclk_tx_active_int : std_logic := '0';

  signal hb0_gtwiz_userclk_rx_srcclk_int : std_logic := '0';
  signal hb0_gtwiz_userclk_rx_usrclk_int : std_logic := '0';
  signal hb0_gtwiz_userclk_rx_usrclk2_int : std_logic := '0';
  signal hb0_gtwiz_userclk_rx_active_int : std_logic := '0';

  -- reset related
  signal hb_gtwiz_reset_clk_freerun_in : std_logic := '0';
  signal hb_gtwiz_reset_clk_freerun_buf_int : std_logic := '0';

  signal hb_gtwiz_reset_all_vio_int : std_logic := '0';
  signal hb_gtwiz_reset_all_buf_int : std_logic := '0';
  signal hb_gtwiz_reset_all_init_int : std_logic := '0';

  signal sm_link : std_logic := '0'; -- most likely set it to 1 wont work, need to come up with a counter
  signal init_done_int : std_logic := '0';
  signal init_retry_ctr_int : std_logic_vector(3 downto 0) := (others=> '0');

  signal hb0_gtwiz_reset_tx_pll_and_datapath_int : std_logic := '0';
  signal hb0_gtwiz_reset_tx_datapath_int : std_logic := '0';
  signal hb_gtwiz_reset_rx_pll_and_datapath_int : std_logic := '0';
  signal hb_gtwiz_reset_rx_datapath_init_int : std_logic := '0';
  signal hb_gtwiz_reset_rx_datapath_int : std_logic := '0';

  -- serial data
  signal hb0_gtwiz_userdata_tx_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal hb1_gtwiz_userdata_tx_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal hb0_gtwiz_userdata_rx_int : std_logic_vector(31 downto 0) := (others=> '0');
  signal hb1_gtwiz_userdata_rx_int : std_logic_vector(31 downto 0) := (others=> '0');

  signal txready_int : std_logic := '0';
  signal rxready_int : std_logic := '0';
  signal rxdata_valid_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal bad_rx_int : std_logic_vector(1 downto 0) := (others=> '0');

  -- ref clock
  signal mgtrefclk0_x0y3_int: std_logic := '0';

  -- System clocks
  signal sysclk160 : std_logic := '0';
  signal sysclk80  : std_logic := '0';
  signal sysclk40  : std_logic := '0';
  signal sysclk10  : std_logic := '0';
  signal inclk_buf : std_logic := '0';

  -- ila
  signal ila_data_tx: std_logic_vector(191 downto 0) := (others=> '0');
  signal ila_data_rx: std_logic_vector(191 downto 0) := (others=> '0');
  signal sm_link_counter : unsigned(6 downto 0) := (others=> '0');

  -- vio related
  signal gtpowergood_vio_sync : std_logic_vector(1 downto 0) := (others=> '0');
  signal txpmaresetdone_vio_sync: std_logic_vector(1 downto 0) := (others=> '0');
  signal rxpmaresetdone_vio_sync: std_logic_vector(1 downto 0) := (others=> '0');
  signal gtwiz_reset_rx_done_vio_sync: std_logic;
  signal gtwiz_reset_tx_done_vio_sync: std_logic;
  signal link_down_latched_reset_vio_int: std_logic;
  signal link_down_latched_reset_sync: std_logic;
  signal hb_gtwiz_reset_rx_datapath_vio_int: std_logic;
  signal hb_gtwiz_reset_rx_pll_and_datapath_vio_int: std_logic;
  signal rxdata_errctr_reset_vio_int : std_logic;

  -- tx data generation
  signal ch0_txctrl2_int: std_logic_vector(7 downto 0) := (others=> '0');
  signal ch1_txctrl2_int: std_logic_vector(7 downto 0) := (others=> '0');
  signal gtwiz_tx_stimulus_reset_int : std_logic := '0';
  signal gtwiz_tx_stimulus_reset_sync : std_logic := '0';
  signal hb0_gtwiz_reset_rx_done_int : std_logic := '0';

  signal txdata_valid_int : std_logic_vector(1 downto 0) :=(others=> '0');
  signal txdata_prbs_int : std_logic_vector(31 downto 0) :=(others=> '0');
  signal ch0_rxdata_prbs_anyerr : std_logic_vector(31 downto 0) :=(others=> '0');
  signal ch1_rxdata_prbs_anyerr : std_logic_vector(31 downto 0) :=(others=> '0');

  signal ch0_txdata_reg : std_logic_vector(31 downto 0) :=(others=> '0');
  signal ch1_txdata_reg : std_logic_vector(31 downto 0) :=(others=> '0');

  signal txdata_init_ctr : unsigned(15 downto 0) := (others=> '0');
  signal txdata_gen_ctr :  unsigned(15 downto 0) := (others=> '0');

  -- rx data checking
  signal prbs_match_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal loopback_int : std_logic_vector(2 downto 0) := (others=> '0');

  signal ch0_rxctrl2_int: std_logic_vector(7 downto 0) := (others=> '0');
  signal ch1_rxctrl2_int: std_logic_vector(7 downto 0) := (others=> '0');

  signal ch0_rxdata_gen_ctr : unsigned(15 downto 0) := (others=> '0');
  signal ch1_rxdata_gen_ctr : unsigned(15 downto 0) := (others=> '0');

  signal ch0_rxdata_err_ctr : unsigned(16 downto 0) := (others=> '0');
  signal ch1_rxdata_err_ctr : unsigned(16 downto 0) := (others=> '0');
  signal hb0_rxdata_nml_ctr : unsigned(63 downto 0) := (others=> '0');

  --===============================--
  -- MGT signals for DDU channels
  --===============================--
  constant DDU_NTXLINK : integer := 4;
  constant DDU_NRXLINK : integer := 4;
  constant DDUTXDWIDTH : integer := 16;
  constant DDURXDWIDTH : integer := 16;

  signal usrclk_ddu_tx : std_logic; -- USRCLK for TX data preparation
  signal usrclk_ddu_rx : std_logic; -- USRCLK for RX data readout
  signal ddu_txdata1 : std_logic_vector(DDUTXDWIDTH-1 downto 0);   -- Data to be transmitted
  signal ddu_txdata2 : std_logic_vector(DDUTXDWIDTH-1 downto 0);   -- Data to be transmitted
  signal ddu_txdata3 : std_logic_vector(DDUTXDWIDTH-1 downto 0);   -- Data to be transmitted
  signal ddu_txdata4 : std_logic_vector(DDUTXDWIDTH-1 downto 0);   -- Data to be transmitted
  signal ddu_txd_valid : std_logic_vector(DDU_NTXLINK downto 1);   -- Flag for tx valid data;
  signal ddu_rxdata1 : std_logic_vector(DDURXDWIDTH-1 downto 0);   -- Data received
  signal ddu_rxdata2 : std_logic_vector(DDURXDWIDTH-1 downto 0);   -- Data received
  signal ddu_rxdata3 : std_logic_vector(DDURXDWIDTH-1 downto 0);   -- Data received
  signal ddu_rxdata4 : std_logic_vector(DDURXDWIDTH-1 downto 0);   -- Data received
  signal ddu_rxd_valid : std_logic_vector(DDU_NRXLINK downto 1);   -- Flag for rx valid data;
  signal ddu_bad_rx : std_logic_vector(DDU_NRXLINK downto 1);   -- Flag for fiber errors;
  signal ddu_rxready : std_logic; -- Flag for rx reset done
  signal ddu_txready : std_logic; -- Flag for rx reset done
  signal ddu_reset : std_logic;

  signal ddu_prbs_type : std_logic_vector(3 downto 0) := (others => '0');
  signal ddu_prbs_tx_en : std_logic_vector(DDU_NTXLINK downto 1) := (others => '0');
  signal ddu_prbs_rx_en : std_logic_vector(DDU_NRXLINK downto 1) := (others => '0');
  signal ddu_prbs_tst_cnt : std_logic_vector(15 downto 0) := (others => '0');
  signal ddu_prbs_err_cnt : std_logic_vector(15 downto 0) := (others => '0');

  signal txdata_ddu_prbs_int : std_logic_vector(DDUTXDWIDTH-1 downto 0) := (others => '0');
  signal txdata_ddu_cntr_int : std_logic_vector(DDUTXDWIDTH-1 downto 0) := (others => '0');
  signal txd_valid_ddu_int : std_logic_vector(4 downto 1) := (others => '0');

  signal txd_ddu_init_ctr : unsigned(15 downto 0) := (others => '0');
  signal txd_ddu_gen_ctr  : unsigned(15 downto 0) := (others => '0');

  signal txd_valid_vio_int : std_logic := '0';
  signal prbsgen_reset_vio_int : std_logic := '0';

  type t_mgt_misc_cntr is record
    errcntr : unsigned(16 downto 0);
    nmlcntr : unsigned(63 downto 0);
  end record;

  type t_mgt_misc_cntr_arr is array (integer range <>) of t_mgt_misc_cntr;
  signal ddu_rxdata_cntr : t_mgt_misc_cntr_arr(1 to 4);
  signal prbs_match_ddu : std_logic_vector(4 downto 1) := (others => '0');

  -- prbs signals <-- not used yet
  signal prbs_type_int : std_logic_vector(3 downto 0) := (others=> '0');
  signal prbs_tx_en_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal prbs_rx_en_int : std_logic_vector(1 downto 0) := (others=> '0');
  signal prbs_en_tst_cnt_int : std_logic_vector(15 downto 0) := (others=> '0');
  signal prbs_err_cnt_int : std_logic_vector(15 downto 0) := (others=> '0');

  attribute dont_touch : string;
  attribute dont_touch of bit_synchronizer_link_down_latched_reset_inst: label is "true";
  attribute dont_touch of gtwiz_tx_stimulus_reset_synchronizer_inst: label is "true";

begin
  -- for kcu105
  sel_si570_clk <= '0';

  -- The TX user clocking helper block should be held in reset until the clock source of that block is known to be
  -- stable. The following assignment is an example of how that stability can be determined, based on the selected TX
  -- user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  gtwiz_userclk_tx_reset_int <= hb0_gtwiz_userclk_tx_reset_int;
  hb0_gtwiz_userclk_tx_reset_int   <= txpmaresetdone_int(0) nand txpmaresetdone_int(1);
  hb0_gtwiz_userclk_tx_srcclk_int  <= gtwiz_userclk_tx_srcclk_int;
  hb0_gtwiz_userclk_tx_usrclk_int  <= gtwiz_userclk_tx_usrclk_int;
  hb0_gtwiz_userclk_tx_usrclk2_int <= gtwiz_userclk_tx_usrclk2_int;
  hb0_gtwiz_userclk_tx_active_int  <= gtwiz_userclk_tx_active_int;

  -- The RX user clocking helper block should be held in reset until the clock source of that block is known to be
  -- stable. The following assignment is an example of how that stability can be determined, based on the selected RX
  -- user clock source. Replace the assignment with the appropriate signal or logic to achieve that behavior as needed.
  gtwiz_userclk_rx_reset_int <= hb0_gtwiz_userclk_rx_reset_int;
  hb0_gtwiz_userclk_rx_reset_int   <= rxpmaresetdone_int(0) nand rxpmaresetdone_int(1);
  hb0_gtwiz_userclk_rx_srcclk_int  <= gtwiz_userclk_rx_srcclk_int;
  hb0_gtwiz_userclk_rx_usrclk_int  <= gtwiz_userclk_rx_usrclk_int;
  hb0_gtwiz_userclk_rx_usrclk2_int <= gtwiz_userclk_rx_usrclk2_int;
  hb0_gtwiz_userclk_rx_active_int  <= gtwiz_userclk_rx_active_int;

  ibufg_i : IBUFGDS
  port map(
    I => clk_in_p,
    IB => clk_in_n,
    O => inclk_buf 
  );

  -- clock management
  clk_mgr_i : clk_mgr
  port map(
    clk_in1    => inclk_buf,
    -- clk_out160 => sysclk160,
    clk_out80  => sysclk80,
    clk_out40  => sysclk40
    -- clk_out10  => sysclk10
  );

  -- reset signals
  -- hb_gtwiz_reset_clk_freerun_in <= sysclk80;
  -- bufg_clk_freerun_inst: BUFG port map(I => hb_gtwiz_reset_clk_freerun_in, O => hb_gtwiz_reset_clk_freerun_buf_int );
  hb_gtwiz_reset_clk_freerun_buf_int <= sysclk80;

  hb_gtwiz_reset_all_int <= hb_gtwiz_reset_all_init_int or hb_gtwiz_reset_all_vio_int
                            -- synthesis translate_off
                            or hb_gtwiz_reset_all_in
                            -- synthesis translate_on
                            ;

  -- synthesis translate_off
  link_status_out_sim <= link_status_out;
  -- synthesis translate_on

  -- The example initialization module interacts with the reset controller helper block and other example design logic
  -- to retry failed reset attempts in order to mitigate bring-up issues such as initially-unavilable reference clocks
  -- or data connections. It also resets the receiver in the event of link loss in an attempt to regain link, so please
  -- note the possibility that this behavior can have the effect of overriding or disturbing user-provided inputs that
  -- destabilize the data stream. It is a demonstration only and can be modified to suit your system needs.

  process(hb_gtwiz_reset_clk_freerun_buf_int)
  begin
      if (rising_edge(hb_gtwiz_reset_clk_freerun_buf_int)) then
        if (sm_link_counter < x"43") then
          sm_link <= '0';
          sm_link_counter <= sm_link_counter + 1;
        elsif (and_reduce(prbs_match_int) = '1') then
          sm_link <= '1';
        else 
          sm_link_counter <= (others => '0');
        end if;
      end if;
  end process;

  example_init_inst : gtwiz_example_init
  port map (
    clk_freerun_in    => hb_gtwiz_reset_clk_freerun_buf_int,
    reset_all_in      => hb_gtwiz_reset_all_int,
    tx_init_done_in   => txready_int,
    rx_init_done_in   => rxready_int,
    rx_data_good_in   => sm_link,
    reset_all_out     => hb_gtwiz_reset_all_init_int,
    reset_rx_out      => hb_gtwiz_reset_rx_datapath_init_int,
    init_done_out     => init_done_int,
    retry_ctr_out     => init_retry_ctr_int
  );

  -- Declare signals which connect the VIO instance to the initialization module for debug purposes
  -- leave it untouched in this vhdl example
  gtwiz_reset_tx_pll_and_datapath_int <= hb0_gtwiz_reset_tx_pll_and_datapath_int;

  gtwiz_reset_tx_datapath_int <= hb0_gtwiz_reset_tx_datapath_int;

  hb_gtwiz_reset_rx_datapath_int <= hb_gtwiz_reset_rx_datapath_init_int or hb_gtwiz_reset_rx_datapath_vio_int;

  -- reference clk
  IBUFDS_GTE3_q227_inst : IBUFDS_GTE3
    generic map (
     REFCLK_EN_TX_PATH => '0',
     REFCLK_HROW_CK_SEL => "00",
     REFCLK_ICNTL_RX => "00"
    )
    port map (
    O => mgtrefclk0_x0y3_int,
    I => mgtrefclk0_x0y3_p,
    IB => mgtrefclk0_x0y3_n,
    CEB => '0'
    -- ODIV2  -- uncounnectd
    );

  gtrefclk00_int <= mgtrefclk0_x0y3_int;

  -- enable 8b10b and comma detection
  tx8b10ben_int <= "11";
  rx8b10ben_int <= "11";
  rxcommadeten_int <= "11";
  rxmcommaalignen_int <= "11";
  rxpcommaalignen_int <= "11";

  -- ===================================================================================================================
  -- VIO FOR HARDWARE BRING-UP AND DEBUG
  -- ===================================================================================================================

  -- Synchronize the latched link down reset input and the VIO-driven signal into the free-running clock domain
  bit_synchronizer_link_down_latched_reset_inst: gtwiz_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => link_down_latched_reset_vio_int,
    o_out  => link_down_latched_reset_sync
  );

  -- Reset the latched link down indicator when the synchronized latched link down reset signal is high. Otherwise, set
  -- the latched link down indicator upon losing link. This indicator is available for user reference.

  process (hb_gtwiz_reset_clk_freerun_buf_int)
  begin
    if (rising_edge(hb_gtwiz_reset_clk_freerun_buf_int) ) then
      if (link_down_latched_reset_sync = '1') then
        link_down_latched_out <= '0';
      elsif (sm_link = '0') then
        link_down_latched_out <= '1';
      end if;
    end if;
  end process;

  -- Assign the link status indicator to the top-level two-state output for user reference
  link_status_out <= sm_link;

  -- Synchronize the example stimulus reset condition into the txusrclk2 domain
  -- gtwiz_tx_stimulus_reset_int <= hb_gtwiz_reset_all_int or (not hb0_gtwiz_reset_rx_done_int) or (not hb0_gtwiz_userclk_tx_active_int);
  gtwiz_tx_stimulus_reset_int <= hb_gtwiz_reset_all_int; -- modulized one do not have active or done signals output
  hb0_gtwiz_reset_rx_done_int <= gtwiz_reset_rx_done_int;

  gtwiz_tx_stimulus_reset_synchronizer_inst : gtwiz_example_reset_synchronizer
  port map (
    clk_in  => hb0_gtwiz_userclk_tx_usrclk2_int,
    rst_in  => gtwiz_tx_stimulus_reset_int,
    rst_out => gtwiz_tx_stimulus_reset_sync
  );

  ---------------------------------------------------------------------------------------------------------------------
  -- PRBS stimulus and checking
  ---------------------------------------------------------------------------------------------------------------------
  userdata_gen_prbs : if g_SFP_PATTERN = 0 generate

    -- TX PRBS pattern generation
    prbs_stimulus_inst : gtwiz_prbs_any
    generic map (
      CHK_MODE    => 0,
      INV_PATTERN => 1,
      POLY_LENGHT => 31,
      POLY_TAP    => 28,
      NBITS       => 32
    )
    port map (
      RST      => hb_gtwiz_reset_all_int,
      CLK      => gtwiz_userclk_tx_usrclk2_int,
      DATA_IN  => (others => '0'),
      EN       => '1',
      DATA_OUT => txdata_prbs_int
    );
  
    hb0_gtwiz_userdata_tx_int <= txdata_prbs_int;
    hb1_gtwiz_userdata_tx_int <= txdata_prbs_int;

    txdata_init_inst : process (gtwiz_userclk_tx_usrclk2_int)
    begin
      if (rising_edge(gtwiz_userclk_tx_usrclk2_int)) then
        if (gtwiz_tx_stimulus_reset_sync = '1') then
          txdata_valid_int <= "00";
          txdata_init_ctr <= x"0000";
        elsif (txdata_init_ctr < 100 or rxready_int = '0') then
          txdata_valid_int <= "00";
          txdata_init_ctr <= txdata_init_ctr + 1;
        else
          txdata_valid_int <= "11";
        end if;
      end if;
    end process;

    -- RX PRBS pattern checking
    prbs_checking_inst0 : gtwiz_prbs_any
    generic map (
      CHK_MODE    => 1,
      INV_PATTERN => 1,
      POLY_LENGHT => 31,
      POLY_TAP    => 28,
      NBITS       => 32
    )
    port map (
      RST      => hb_gtwiz_reset_all_int,
      CLK      => gtwiz_userclk_rx_usrclk2_int,
      DATA_IN  => hb0_gtwiz_userdata_rx_int,
      EN       => rxdata_valid_int(0),
      DATA_OUT => ch0_rxdata_prbs_anyerr
    );

    prbs_checking_inst1 : gtwiz_prbs_any
    generic map (
      CHK_MODE    => 1,
      INV_PATTERN => 1,
      POLY_LENGHT => 31,
      POLY_TAP    => 28,
      NBITS       => 32
    )
    port map (
      RST      => hb_gtwiz_reset_all_int,
      CLK      => gtwiz_userclk_rx_usrclk2_int,
      DATA_IN  => hb1_gtwiz_userdata_rx_int,
      EN       => rxdata_valid_int(1),
      DATA_OUT => ch1_rxdata_prbs_anyerr
    );

    prbs_match_int(0) <= not or_reduce(ch0_rxdata_prbs_anyerr);
    prbs_match_int(1) <= not or_reduce(ch1_rxdata_prbs_anyerr);

  end generate;

  ---------------------------------------------------------------------------------------------------------------------
  -- User-data generate, checking
  ---------------------------------------------------------------------------------------------------------------------
  userdata_gen_counter : if g_SFP_PATTERN = 1 generate
    txctrl0_int <= (others => '0'); -- unused in 8b10b
    txctrl1_int <= (others => '0'); -- unused in 8b10b
    txctrl2_int <= ch1_txctrl2_int & ch0_txctrl2_int;

    hb0_gtwiz_userdata_tx_int <= ch0_txdata_reg;
    hb1_gtwiz_userdata_tx_int <= ch1_txdata_reg;

    txdata_gen_inst : process (gtwiz_userclk_tx_usrclk2_int)
    begin
      if (rising_edge(gtwiz_userclk_tx_usrclk2_int)) then
        if (gtwiz_tx_stimulus_reset_sync = '1') then
          ch0_txdata_reg <= x"0000_0000";
          ch1_txdata_reg <= x"0000_0000";
          txdata_valid_int <= "00";
          txdata_gen_ctr <= x"0000";
          txdata_init_ctr <= x"0000";
        else
          if (txdata_init_ctr < 100 or rxready_int = '0') then
            ch0_txdata_reg <= x"0000_0000"; -- will be replaced by the IDLE word
            ch1_txdata_reg <= x"0000_0000"; -- will be replaced by the IDLE word
            txdata_valid_int <= "00";
            txdata_init_ctr <= txdata_init_ctr + 1;
          -- elsif (txdata_gen_ctr(7 downto 0) = x"0") then
          --   ch0_txdata_reg  <= std_logic_vector(txdata_gen_ctr) & x"503C";
          --   ch1_txdata_reg  <= (not std_logic_vector(txdata_gen_ctr)) & x"503C";
          --   txdata_valid_int <= "11";
          else
            ch0_txdata_reg  <= (not std_logic_vector(txdata_gen_ctr)) & std_logic_vector(txdata_gen_ctr);
            ch1_txdata_reg  <= std_logic_vector(txdata_gen_ctr) & (not std_logic_vector(txdata_gen_ctr));
            txdata_valid_int <= "11";
          end if;
          txdata_gen_ctr <= txdata_gen_ctr + 1;
        end if;
      end if;
    end process;

    -- The RX checking part
    -- Synchronize the example stimulus reset condition into the txusrclk2 domain

    -- gtwiz_rx_stimulus_reset_int <= hb_gtwiz_reset_all_int or (not hb0_gtwiz_reset_rx_done_int) or (not hb0_gtwiz_userclk_rx_active_int);
    -- gtwiz_rx_checking_reset_synchronizer_inst : gtwiz_example_reset_synchronizer
    --   port map (
    --     clk_in  => hb0_gtwiz_userclk_rx_usrclk2_int,
    --     rst_in  => gtwiz_rx_stimulus_reset_int,
    --     rst_out => gtwiz_rx_stimulus_reset_sync
    --   );

    -- ch0_rxctrl2_int <= rxctrl2_int(7 downto 0);
    -- ch1_rxctrl2_int <= rxctrl2_int(15 downto 8);
    ch0_rxctrl2_int <= x"0" & "000" & rxdata_valid_int(0);
    ch1_rxctrl2_int <= x"0" & "000" & rxdata_valid_int(1);

    rxdata_checking_ch0 : process (hb0_gtwiz_userclk_rx_usrclk2_int)
    begin
      if (rising_edge(hb0_gtwiz_userclk_rx_usrclk2_int) and rxdata_valid_int(0) = '1') then
        if (ch0_rxdata_gen_ctr = 0) then
          if (hb0_gtwiz_userdata_rx_int(31 downto 16) = (not hb0_gtwiz_userdata_rx_int(15 downto 0))) then
            ch0_rxdata_gen_ctr <= unsigned(hb0_gtwiz_userdata_rx_int(15 downto 0)) - 1;
          end if;
        else
          -- if (hb0_gtwiz_userdata_rx_int(15 downto 0) = x"503C") then
          --   if (std_logic_vector(ch0_rxdata_gen_ctr) /= hb0_gtwiz_userdata_rx_int(31 downto 16)) then
          --     prbs_match_int(0) <= '0';
          --   end if;
          --   ch0_rxdata_gen_ctr <= unsigned(hb0_gtwiz_userdata_rx_int(31 downto 16)) - 1;
          if (((not std_logic_vector(ch0_rxdata_gen_ctr)) & std_logic_vector(ch0_rxdata_gen_ctr)) = hb0_gtwiz_userdata_rx_int) then
            prbs_match_int(0) <= '1';
            ch0_rxdata_gen_ctr <= ch0_rxdata_gen_ctr - 1;
          else 
            prbs_match_int(0) <= '0';
            ch0_rxdata_gen_ctr <= x"0000";
          end if;
        end if;
      end if;
    end process;

    rxdata_checking_ch1 : process (hb0_gtwiz_userclk_rx_usrclk2_int)
    begin
      if (rising_edge(hb0_gtwiz_userclk_rx_usrclk2_int) and rxdata_valid_int(1) = '1') then
        if (ch1_rxdata_gen_ctr = 0) then
          if (hb1_gtwiz_userdata_rx_int(31 downto 16) = (not hb1_gtwiz_userdata_rx_int(15 downto 0))) then
            ch1_rxdata_gen_ctr <= unsigned(hb1_gtwiz_userdata_rx_int(15 downto 0)) + 1;
          end if;
        else
          -- if (hb1_gtwiz_userdata_rx_int(15 downto 0) = x"503C") then
          --   if (std_logic_vector(ch1_rxdata_gen_ctr) /= hb1_gtwiz_userdata_rx_int(31 downto 16)) then
          --     prbs_match_int(1) <= '0';
          --   end if;
          --   ch1_rxdata_gen_ctr <= unsigned(hb1_gtwiz_userdata_rx_int(31 downto 16)) + 1;
          if (((not std_logic_vector(ch1_rxdata_gen_ctr)) & std_logic_vector(ch1_rxdata_gen_ctr)) = hb1_gtwiz_userdata_rx_int) then
            prbs_match_int(1) <= '1';
            ch1_rxdata_gen_ctr <= ch1_rxdata_gen_ctr + 1;
          else 
            prbs_match_int(1) <= '0';
            ch1_rxdata_gen_ctr <= x"0000";
          end if;
        end if;
      end if;
    end process;

    ila_data_rx(79 downto 64) <= std_logic_vector(ch0_rxdata_gen_ctr);
    ila_data_rx(95 downto 80) <= std_logic_vector(ch1_rxdata_gen_ctr);

  end generate;

  -- ILA for tx data
  ila_data_tx(31 downto 0)  <= hb0_gtwiz_userdata_tx_int;
  ila_data_tx(63 downto 32) <= hb1_gtwiz_userdata_tx_int;
  ila_data_tx(71 downto 64) <= ch0_txctrl2_int;
  ila_data_tx(79 downto 72) <= ch1_txctrl2_int;

  ila_tx_inst : ila
  port map (
    clk => hb0_gtwiz_userclk_tx_usrclk2_int,
    probe0 => ila_data_tx
  );

  -- -- Error rate counting, reusing the gen_ctr as total rate first
  -- -- wire [15:0] ch0_rxdata_gen_ctr = hb0_rxdata_nml_ctr[15:0];
  -- -- wire [15:0] ch1_rxdata_gen_ctr = hb0_rxdata_nml_ctr[31:16];
  -- -- wire [7:0]  ext_rxdata_nml_ctr = hb0_rxdata_nml_ctr[39:32];

  -- wire rxdata_errctr_reset_vio_int;

  rxdata_errcounting_i : process (hb0_gtwiz_userclk_rx_usrclk2_int)
  begin
    if (rising_edge(hb0_gtwiz_userclk_rx_usrclk2_int)) then
      if (rxdata_errctr_reset_vio_int = '1') then
        hb0_rxdata_nml_ctr <= (others => '0');
        ch0_rxdata_err_ctr <= (others => '0');
        ch1_rxdata_err_ctr <= (others => '0');
      elsif (rxready_int = '1') then
        hb0_rxdata_nml_ctr <= hb0_rxdata_nml_ctr + 1;
        if (prbs_match_int(0) = '0') then
          ch0_rxdata_err_ctr <= ch0_rxdata_err_ctr + 1;
        end if;
        if (prbs_match_int(1) = '0') then
          ch1_rxdata_err_ctr <= ch1_rxdata_err_ctr + 1;
        end if;
      end if;
    end if;
  end process;

  ila_data_rx(31 downto 0)  <= hb0_gtwiz_userdata_rx_int;
  ila_data_rx(63 downto 32) <= hb1_gtwiz_userdata_rx_int;
  ila_data_rx(97 downto 96) <= rxdata_valid_int;
  ila_data_rx(99 downto 98) <= bad_rx_int;
  ila_data_rx(100) <= hb_gtwiz_reset_all_int;
  ila_data_rx(101) <= txready_int;
  ila_data_rx(102) <= rxready_int;
  ila_data_rx(119 downto 118) <= prbs_match_int;
  ila_data_rx(135 downto 120) <= std_logic_vector(ch0_rxdata_err_ctr(16 downto 1));
  ila_data_rx(151 downto 136) <= std_logic_vector(ch1_rxdata_err_ctr(16 downto 1));
  ila_data_rx(191 downto 152) <= std_logic_vector(hb0_rxdata_nml_ctr(39 downto 0));


  ila_rx_inst : ila
  port map(
    clk => hb0_gtwiz_userclk_rx_usrclk2_int,
    probe0 => ila_data_rx
  );

  gtwiz_kcu_test_vio_0_inst : gtwiz_kcu_sfp_vio_0
  port map (
    clk => hb_gtwiz_reset_clk_freerun_buf_int,
    probe_in0 => link_status_out,
    probe_in1 => link_down_latched_out,
    probe_in2 => init_done_int,
    probe_in3 => init_retry_ctr_int,
    probe_in4 => gtpowergood_vio_sync,
    probe_in5 => txpmaresetdone_vio_sync,
    probe_in6 => rxpmaresetdone_vio_sync,
    probe_in7 => gtwiz_reset_tx_done_vio_sync,
    probe_in8 => gtwiz_reset_rx_done_vio_sync,
    probe_in9 => and_reduce(prbs_match_int),
    probe_out0 => hb_gtwiz_reset_all_vio_int,
    probe_out1 => hb0_gtwiz_reset_tx_pll_and_datapath_int,
    probe_out2 => hb0_gtwiz_reset_tx_datapath_int,
    probe_out3 => hb_gtwiz_reset_rx_pll_and_datapath_vio_int,
    probe_out4 => hb_gtwiz_reset_rx_datapath_vio_int,
    probe_out5 => link_down_latched_reset_vio_int,
    probe_out6 => rxdata_errctr_reset_vio_int
  );

  mgt_sfp_inst : mgt_sfp
    port map (
      mgtrefclk       => gtrefclk00_int,
      txusrclk        => gtwiz_userclk_tx_usrclk2_int,
      rxusrclk        => gtwiz_userclk_rx_usrclk2_int,
      sysclk          => hb_gtwiz_reset_clk_freerun_buf_int,
      sfp_ch0_rx_n    => sfp_ch0_rx_n,
      sfp_ch0_rx_p    => sfp_ch0_rx_p,
      sfp_ch0_tx_n    => sfp_ch0_tx_n,
      sfp_ch0_tx_p    => sfp_ch0_tx_p,
      sfp_ch1_rx_n    => sfp_ch1_rx_n,
      sfp_ch1_rx_p    => sfp_ch1_rx_p,
      sfp_ch1_tx_n    => sfp_ch1_tx_n,
      sfp_ch1_tx_p    => sfp_ch1_tx_p,
      txready         => txready_int,
      rxready         => rxready_int,
      txdata_ch0      => hb0_gtwiz_userdata_tx_int,
      txdata_ch1      => hb1_gtwiz_userdata_tx_int,
      txdata_valid    => txdata_valid_int,
      txdiffctrl_ch0  => "1100",          -- fix value
      txdiffctrl_ch1  => "1100",          -- fix value
      loopback        => loopback_int,
      rxdata_ch0      => hb0_gtwiz_userdata_rx_int,
      rxdata_ch1      => hb1_gtwiz_userdata_rx_int,
      rxdata_valid    => rxdata_valid_int,
      bad_rx          => bad_rx_int,
      prbs_type       => prbs_type_int,
      prbs_tx_en      => prbs_tx_en_int,
      prbs_rx_en      => prbs_rx_en_int,
      prbs_en_tst_cnt => prbs_en_tst_cnt_int,
      prbs_err_cnt    => prbs_err_cnt_int,
      reset           => hb_gtwiz_reset_all_int
      );

  --================================--
  -- Mimicking test for DDU links
  --================================--

  ddu_txdata1 <= txdata_ddu_prbs_int;
  ddu_txdata2 <= txdata_ddu_prbs_int;
  ddu_txdata3 <= txdata_ddu_cntr_int;
  ddu_txdata4 <= txdata_ddu_cntr_int;
  ddu_txd_valid <= txd_valid_ddu_int;

  -- PRBS generation
  prbs_stimulus_ddu_inst : gtwiz_prbs_any
    generic map (
      CHK_MODE    => 0,
      INV_PATTERN => 1,
      POLY_LENGHT => 31,
      POLY_TAP    => 28,
      NBITS       => DDUTXDWIDTH
      )
    port map (
      RST      => prbsgen_reset_vio_int,
      CLK      => usrclk_ddu_tx,
      DATA_IN  => (others => '0'),
      EN       => '1',
      DATA_OUT => txdata_ddu_prbs_int
      );

  txdata_ddu_gen_inst : process (usrclk_ddu_tx)
  begin
    if (rising_edge(usrclk_ddu_tx)) then
      if (prbsgen_reset_vio_int = '1') then
        txd_valid_ddu_int <= x"0";
        txdata_ddu_cntr_int <= (others => '0');
        txd_ddu_init_ctr <= x"0000";
      else
        if (txd_ddu_init_ctr < 100 or ddu_rxready = '0') then
          txdata_ddu_cntr_int <= (others => '0');
          txd_valid_ddu_int <= x"0";
          txd_ddu_init_ctr <= txd_ddu_init_ctr + 1;
        else
          -- txdata_ddu_cntr_int <= x"503C" & std_logic_vector(txd_ddu_gen_ctr);
          txdata_ddu_cntr_int(15 downto 0) <= std_logic_vector(txd_ddu_gen_ctr);
          txd_valid_ddu_int <= (others => txd_valid_vio_int);
        end if;
        txd_ddu_gen_ctr <= txd_ddu_gen_ctr + 1;
      end if;
    end if;
  end process;

  rxdata_errcounting_ddu : process (usrclk_ddu_rx)
  begin
    if (rising_edge(usrclk_ddu_rx)) then
      if (rxdata_errctr_reset_vio_int = '1') then
        for I in 1 to DDU_NRXLINK loop
          ddu_rxdata_cntr(I).nmlcntr <= (others => '0');
          ddu_rxdata_cntr(I).errcntr <= (others => '0');
        end loop;
      elsif (ddu_rxready = '1') then
        for I in 1 to DDU_NRXLINK loop
          ddu_rxdata_cntr(I).nmlcntr <= ddu_rxdata_cntr(I).nmlcntr + 1;
          if (prbs_match_ddu(I) = '0') then
            ddu_rxdata_cntr(I).errcntr <= ddu_rxdata_cntr(I).errcntr + 1;
          end if;
        end loop;
      end if;
    end if;
  end process;

  u_ddu_gth : mgt_ddu
    generic map (
      NCHANNL     => 4,            -- number of (firmware) channels (max of TX/RX links)
      NRXLINK     => DDU_NRXLINK,  -- number of (physical) RX links
      NTXLINK     => DDU_NTXLINK,  -- number of (physical) TX links
      TXDATAWIDTH => DDUTXDWIDTH,  -- transmitter user data width
      RXDATAWIDTH => DDURXDWIDTH   -- receiver user data width
      )
    port map (
      mgtrefclk    => mgtrefclk0_x0y3_int,
      txusrclk     => usrclk_ddu_tx,
      rxusrclk     => usrclk_ddu_rx,
      sysclk       => sysclk80,
      daq_tx_n     => DAQ_TX_N,
      daq_tx_p     => DAQ_TX_P,
      bck_rx_n     => BCK_PRS_N,
      bck_rx_p     => BCK_PRS_P,
      b04_rx_n     => B04_RX_N,
      b04_rx_p     => B04_RX_P,
      txdata_ch0   => ddu_txdata1,
      txdata_ch1   => ddu_txdata2,
      txdata_ch2   => ddu_txdata3,
      txdata_ch3   => ddu_txdata4,
      txd_valid    => ddu_txd_valid,
      rxdata_ch0   => ddu_rxdata1,
      rxdata_ch1   => ddu_rxdata2,
      rxdata_ch2   => ddu_rxdata3,
      rxdata_ch3   => ddu_rxdata4,
      rxd_valid    => ddu_rxd_valid,
      bad_rx       => ddu_bad_rx,
      rxready      => ddu_rxready,
      txready      => ddu_txready,
      prbs_type    => ddu_prbs_type,
      prbs_rx_en   => ddu_prbs_rx_en,
      prbs_tst_cnt => ddu_prbs_tst_cnt,
      prbs_err_cnt => ddu_prbs_err_cnt,
      reset        => ddu_reset
      );

  -- ILA and VIO for debugging
  mgt_ddu_vio_inst : gtwiz_kcu_sfp_vio_0
    port map (
      clk => sysclk80,
      probe_in0 => ddu_rxready,
      probe_in1 => ddu_txready,
      probe_in2 => '0',
      probe_in3 => prbs_match_ddu,
      probe_in4 => ddu_rxd_valid(2 downto 1),
      probe_in5 => ddu_bad_rx(2 downto 1),
      probe_in6 => "00",
      probe_in7 => '0',
      probe_in8 => '0',
      probe_in9 => '0',
      probe_out0 => open,
      probe_out1 => open,
      probe_out2 => open,
      probe_out3 => ddu_reset,
      probe_out4 => txd_valid_vio_int,
      probe_out5 => prbsgen_reset_vio_int,
      probe_out6 => open
      );


end Behavioral;
