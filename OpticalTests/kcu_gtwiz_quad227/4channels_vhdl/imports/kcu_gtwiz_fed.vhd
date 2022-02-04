library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

library UNISIM;
use UNISIM.VComponents.all;

use ieee.std_logic_misc.all;

entity kcu_gtwiz_fed is
  generic (
    DATAWIDTH : integer := 32;
    NLINK : integer := 4
    );
  port (
    -- Differential reference clock inputs
    REF_CLK_3_P : in std_logic;
    REF_CLK_3_N : in std_logic;

    -- Serial data ports for transceiver channels
    DAQ_TX_P     : out std_logic_vector(NLINK-1 downto 0); -- B04 TX, output to FED
    DAQ_TX_N     : out std_logic_vector(NLINK-1 downto 0); -- B04 TX, output to FED
    B04_RX_P     : in std_logic_vector(NLINK-1 downto 1); -- B04 RX, no use yet
    B04_RX_N     : in std_logic_vector(NLINK-1 downto 1); -- B04 RX, no use yet
    BCK_PRS_P    : in std_logic; -- B04_RX1_P
    BCK_PRS_N    : in std_logic; -- B04_RX1_N

    -- Configuration
    sel_si570_clk_i : out std_logic;
    CLK_IN_P        : in std_logic;
    CLK_IN_N        : in std_logic
  );
end kcu_gtwiz_fed;

architecture Behavioral of kcu_gtwiz_fed is

  component gtwizard_ultrascale_0_example_wrapper is
    port (
      gthrxn_in                          : in  std_logic_vector(NLINK-1 downto 0);
      gthrxp_in                          : in  std_logic_vector(NLINK-1 downto 0);
      gthtxn_out                         : out std_logic_vector(NLINK-1 downto 0);
      gthtxp_out                         : out std_logic_vector(NLINK-1 downto 0);
      gtwiz_userclk_tx_reset_in          : in  std_logic;
      gtwiz_userclk_tx_srcclk_out        : out std_logic;
      gtwiz_userclk_tx_usrclk_out        : out std_logic;
      gtwiz_userclk_tx_usrclk2_out       : out std_logic;
      gtwiz_userclk_tx_active_out        : out std_logic;
      gtwiz_userclk_rx_reset_in          : in  std_logic;
      gtwiz_userclk_rx_srcclk_out        : out std_logic;
      gtwiz_userclk_rx_usrclk_out        : out std_logic;
      gtwiz_userclk_rx_usrclk2_out       : out std_logic;
      gtwiz_userclk_rx_active_out        : out std_logic;
      gtwiz_reset_clk_freerun_in         : in  std_logic;
      gtwiz_reset_all_in                 : in  std_logic;
      gtwiz_reset_tx_pll_and_datapath_in : in  std_logic;
      gtwiz_reset_tx_datapath_in         : in  std_logic;
      gtwiz_reset_rx_pll_and_datapath_in : in  std_logic;
      gtwiz_reset_rx_datapath_in         : in  std_logic;
      gtwiz_reset_rx_cdr_stable_out      : out std_logic;
      gtwiz_reset_tx_done_out            : out std_logic;
      gtwiz_reset_rx_done_out            : out std_logic;
      gtwiz_userdata_tx_in               : in  std_logic_vector(NLINK*DATAWIDTH-1 downto 0);
      gtwiz_userdata_rx_out              : out std_logic_vector(NLINK*DATAWIDTH-1 downto 0);
      gtrefclk00_in                      : in  std_logic;
      qpll0outclk_out                    : out std_logic;
      qpll0outrefclk_out                 : out std_logic;
      rx8b10ben_in                       : in  std_logic_vector(NLINK-1 downto 0);
      rxchbonden_in                      : in  std_logic_vector(NLINK-1 downto 0);
      rxchbondi_in                       : in  std_logic_vector(5*NLINK-1 downto 0);
      rxchbondlevel_in                   : in  std_logic_vector(3*NLINK-1 downto 0);
      rxchbondmaster_in                  : in  std_logic_vector(NLINK-1 downto 0);
      rxchbondslave_in                   : in  std_logic_vector(NLINK-1 downto 0);
      rxcommadeten_in                    : in  std_logic_vector(NLINK-1 downto 0);
      rxlpmen_in                         : in  std_logic_vector(NLINK-1 downto 0);
      rxmcommaalignen_in                 : in  std_logic_vector(NLINK-1 downto 0);
      rxpcommaalignen_in                 : in  std_logic_vector(NLINK-1 downto 0);
      rxpolarity_in                      : in  std_logic_vector(NLINK-1 downto 0);
      tx8b10ben_in                       : in  std_logic_vector(NLINK-1 downto 0);
      txctrl0_in                         : in  std_logic_vector(16*NLINK-1 downto 0);
      txctrl1_in                         : in  std_logic_vector(16*NLINK-1 downto 0);
      txctrl2_in                         : in  std_logic_vector(8*NLINK-1 downto 0);
      txpolarity_in                      : in  std_logic_vector(NLINK-1 downto 0);
      gtpowergood_out                    : out std_logic_vector(NLINK-1 downto 0);
      rxbyteisaligned_out                : out std_logic_vector(NLINK-1 downto 0);
      rxbyterealign_out                  : out std_logic_vector(NLINK-1 downto 0);
      rxchanbondseq_out                  : out std_logic_vector(NLINK-1 downto 0);
      rxchanisaligned_out                : out std_logic_vector(NLINK-1 downto 0);
      rxchanrealign_out                  : out std_logic_vector(NLINK-1 downto 0);
      rxchbondo_out                      : out std_logic_vector(5*NLINK-1 downto 0);
      rxcommadet_out                     : out std_logic_vector(NLINK-1 downto 0);
      rxctrl0_out                        : out std_logic_vector(16*NLINK-1 downto 0);
      rxctrl1_out                        : out std_logic_vector(16*NLINK-1 downto 0);
      rxctrl2_out                        : out std_logic_vector(8*NLINK-1 downto 0);
      rxctrl3_out                        : out std_logic_vector(8*NLINK-1 downto 0);
      rxpmaresetdone_out                 : out std_logic_vector(NLINK-1 downto 0);
      rxprbserr_out                      : out std_logic_vector(NLINK-1 downto 0);
      rxprbslocked_out                   : out std_logic_vector(NLINK-1 downto 0);
      txpmaresetdone_out                 : out std_logic_vector(NLINK-1 downto 0)
    );
  end component;

  component gtwizard_ultrascale_0_example_stimulus_8b10b is
    port (
      gtwiz_reset_all_in          : in std_logic;
      gtwiz_userclk_tx_usrclk2_in : in std_logic;
      gtwiz_userclk_tx_active_in  : in std_logic;
      txctrl0_out                 : out std_logic_vector(15 downto 0);
      txctrl1_out                 : out std_logic_vector(15 downto 0);
      txctrl2_out                 : out std_logic_vector(7 downto 0);
      txdata_out                  : out std_logic_vector(31 downto 0)
      );
  end component;

  component gtwizard_ultrascale_0_example_checking_8b10b is
    port (
      gtwiz_reset_all_in          : in std_logic;
      gtwiz_userclk_rx_usrclk2_in : in std_logic;
      gtwiz_userclk_rx_active_in  : in std_logic;
      rxctrl0_in                  : in std_logic_vector(15 downto 0);
      rxctrl1_in                  : in std_logic_vector(15 downto 0);
      rxctrl2_in                  : in std_logic_vector(7 downto 0);
      rxctrl3_in                  : in std_logic_vector(7 downto 0);
      rxdata_in                   : in std_logic_vector(31 downto 0);
      prbs_match_out              : out std_logic
      );
  end component;

  component clockManager is
    port (
      clk_in1   : in  std_logic;
      clk_out1  : out std_logic;
      clk_out2  : out std_logic
     );
  end component;

  component ila_0 is
    port (
      clk    : in std_logic;
      probe0 : in std_logic_vector(777 downto 0)
      );
  end component;

  component gtwizard_ultrascale_0_example_bit_synchronizer
    port (
      clk_in : in std_logic;
      i_in   : in std_logic;
      o_out  : out std_logic
      );
  end component;

  component gtwizard_ultrascale_0_example_reset_synchronizer
    port (
      clk_in  : in std_logic;
      rst_in  : in std_logic;
      rst_out : out std_logic
      );
  end component;

  component gtwizard_ultrascale_0_example_init
    port (
      clk_freerun_in  : in std_logic;
      reset_all_in    : in std_logic;
      tx_init_done_in : in std_logic;
      rx_init_done_in : in std_logic;
      rx_data_good_in : in std_logic;
      reset_all_out   : out std_logic;
      reset_rx_out    : out std_logic;
      init_done_out   : out std_logic;
      retry_ctr_out   : out std_logic_vector(3 downto 0)
    );
  end component;

  component vio_0
    port (
      clk        : in std_logic;
      probe_in0  : in std_logic;
      probe_in1  : in std_logic;
      probe_in2  : in std_logic;
      probe_in3  : in std_logic_vector(3 downto 0);
      probe_in4  : in std_logic_vector(3 downto 0);
      probe_in5  : in std_logic_vector(3 downto 0);
      probe_in6  : in std_logic_vector(3 downto 0);
      probe_in7  : in std_logic;
      probe_in8  : in std_logic;
      probe_in9  : in std_logic_vector(3 downto 0);
      probe_in10 : in std_logic_vector(3 downto 0);
      probe_out0 : out std_logic;
      probe_out1 : out std_logic;
      probe_out2 : out std_logic;
      probe_out3 : out std_logic;
      probe_out4 : out std_logic;
      probe_out5 : out std_logic;
      probe_out6 : out std_logic_vector(11 downto 0);
      probe_out7 : out std_logic_vector(15 downto 0);
      probe_out8 : out std_logic_vector(15 downto 0);
      probe_out9 : out std_logic_vector(3 downto 0);
      probe_out10 : out std_logic_vector(3 downto 0);
      probe_out11 : out std_logic
      );
  end component;

  signal hb_gtwiz_reset_all_in : std_logic;
  signal link_down_latched_reset_in : std_logic;
  signal link_status_out : std_logic;
  signal link_down_latched_out : std_logic := '1';

  -- PER-CHANNEL SIGNAL ASSIGNMENTS
  signal gthrxn_int : std_logic_vector(NLINK-1 downto 0);
  signal gthrxp_int : std_logic_vector(NLINK-1 downto 0);
  signal gthtxn_int : std_logic_vector(NLINK-1 downto 0);
  signal gthtxp_int : std_logic_vector(NLINK-1 downto 0);

  signal gtwiz_userclk_tx_reset_int              : std_logic;
  signal hb0_gtwiz_userclk_tx_reset_int          : std_logic;
  signal gtwiz_userclk_tx_srcclk_int             : std_logic;
  signal hb0_gtwiz_userclk_tx_srcclk_int         : std_logic;
  signal gtwiz_userclk_tx_usrclk_int             : std_logic;
  signal hb0_gtwiz_userclk_tx_usrclk_int         : std_logic;
  signal gtwiz_userclk_tx_usrclk2_int            : std_logic;
  signal hb0_gtwiz_userclk_tx_usrclk2_int        : std_logic;
  signal gtwiz_userclk_tx_active_int             : std_logic;
  signal hb0_gtwiz_userclk_tx_active_int         : std_logic;
  signal gtwiz_userclk_rx_reset_int              : std_logic;
  signal hb0_gtwiz_userclk_rx_reset_int          : std_logic;
  signal gtwiz_userclk_rx_srcclk_int             : std_logic;
  signal hb0_gtwiz_userclk_rx_srcclk_int         : std_logic;
  signal gtwiz_userclk_rx_usrclk_int             : std_logic;
  signal hb0_gtwiz_userclk_rx_usrclk_int         : std_logic;
  signal gtwiz_userclk_rx_usrclk2_int            : std_logic;
  signal hb0_gtwiz_userclk_rx_usrclk2_int        : std_logic;
  signal gtwiz_userclk_rx_active_int             : std_logic;
  signal hb0_gtwiz_userclk_rx_active_int         : std_logic;

  signal gtwiz_reset_all_int                     : std_logic;
  signal hb0_gtwiz_reset_all_int                 : std_logic := '0';
  signal gtwiz_reset_tx_pll_and_datapath_int     : std_logic;
  signal hb0_gtwiz_reset_tx_pll_and_datapath_int : std_logic;
  signal gtwiz_reset_tx_datapath_int             : std_logic;
  signal hb0_gtwiz_reset_tx_datapath_int         : std_logic;
  signal gtwiz_reset_rx_pll_and_datapath_int     : std_logic;
  signal hb0_gtwiz_reset_rx_pll_and_datapath_int : std_logic := '0';
  signal gtwiz_reset_rx_datapath_int             : std_logic;
  signal hb0_gtwiz_reset_rx_datapath_int         : std_logic := '0';
  signal gtwiz_reset_rx_cdr_stable_int           : std_logic;
  signal hb0_gtwiz_reset_rx_cdr_stable_int       : std_logic;
  signal gtwiz_reset_tx_done_int                 : std_logic;
  signal hb0_gtwiz_reset_tx_done_int             : std_logic;
  signal gtwiz_reset_rx_done_int                 : std_logic;
  signal hb0_gtwiz_reset_rx_done_int             : std_logic;

  signal gtwiz_userdata_tx_int     : std_logic_vector(NLINK*DATAWIDTH-1 downto 0);
  signal hb0_gtwiz_userdata_tx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb1_gtwiz_userdata_tx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb2_gtwiz_userdata_tx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb3_gtwiz_userdata_tx_int : std_logic_vector(DATAWIDTH-1 downto 0);

  signal gtwiz_userdata_rx_int     : std_logic_vector(NLINK*DATAWIDTH-1 downto 0);
  signal hb0_gtwiz_userdata_rx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb1_gtwiz_userdata_rx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb2_gtwiz_userdata_rx_int : std_logic_vector(DATAWIDTH-1 downto 0);
  signal hb3_gtwiz_userdata_rx_int : std_logic_vector(DATAWIDTH-1 downto 0);

  signal gtrefclk00_int         : std_logic;
  signal cm0_gtrefclk00_int     : std_logic;
  signal qpll0outclk_int        : std_logic;
  signal cm0_qpll0outclk_int    : std_logic;
  signal qpll0outrefclk_int     : std_logic;
  signal cm0_qpll0outrefclk_int : std_logic;

  constant ST_LINK_DOWN      : std_logic := '0';
  constant ST_LINK_UP        : std_logic := '1';
  signal sm_link             : std_logic;
  signal link_ctr            : std_logic_vector(6 downto 0);

  signal rx8b10ben_int       : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal tx8b10ben_int       : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal txpolarity_int      : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal rxpolarity_int      : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal gtpowergood_int     : std_logic_vector(NLINK-1 downto 0);

  signal rxlpmen_int         : std_logic_vector(NLINK-1 downto 0); --not sliced
  signal rxcommadet_int      : std_logic_vector(NLINK-1 downto 0);
  signal rxcommadeten_int    : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal rxmcommaalignen_int : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal rxpcommaalignen_int : std_logic_vector(NLINK-1 downto 0) := (others => '1');

  signal rxbyteisaligned_int : std_logic_vector(NLINK-1 downto 0);
  signal rxbyterealign_int   : std_logic_vector(NLINK-1 downto 0);
  signal rxchanisaligned_int : std_logic_vector(NLINK-1 downto 0);
  signal rxchanrealign_int   : std_logic_vector(NLINK-1 downto 0);

  signal rxchbonden_int      : std_logic_vector(NLINK-1 downto 0) := (others => '1');
  signal rxchbondi_int       : std_logic_vector(5*NLINK-1 downto 0);
  signal rxchbondo_int       : std_logic_vector(5*NLINK-1 downto 0);
  signal rxchbondlevel_int   : std_logic_vector(3*NLINK-1 downto 0);
  signal rxchbondmaster_int  : std_logic_vector(NLINK-1 downto 0) := (1 => '1', others => '0');
  signal rxchbondslave_int   : std_logic_vector(NLINK-1 downto 0) := (1 => '0', others => '1');
  signal rxchanbondseq_int   : std_logic_vector(NLINK-1 downto 0);

  signal rxpmaresetdone_int  : std_logic_vector(NLINK-1 downto 0);
  signal rxprbserr_int       : std_logic_vector(NLINK-1 downto 0);
  signal rxprbslocked_int    : std_logic_vector(NLINK-1 downto 0);
  signal txpmaresetdone_int  : std_logic_vector(NLINK-1 downto 0);

  signal rxctrl0_int : std_logic_vector(16*NLINK-1 downto 0);
  signal rxctrl1_int : std_logic_vector(16*NLINK-1 downto 0);
  signal rxctrl2_int : std_logic_vector(8*NLINK-1 downto 0);
  signal rxctrl3_int : std_logic_vector(8*NLINK-1 downto 0);

  signal txctrl0_int : std_logic_vector(16*NLINK-1 downto 0);
  signal txctrl1_int : std_logic_vector(16*NLINK-1 downto 0);
  signal txctrl2_int : std_logic_vector(8*NLINK-1 downto 0);

  signal clk_out40     : std_logic;
  signal clk_out80     : std_logic;
  signal inclk_buf     : std_logic;
  signal REF_CLK_3_int : std_logic;

  signal prbs_match_int       : std_logic_vector(NLINK-1 downto 0);
  signal prbs_error_any_sync  : std_logic;
  signal prbs_error_any_async : std_logic;

  signal hb0_rxdata_nml_ctr : std_logic_vector(39 downto 0);
  signal ch0_rxdata_err_ctr : std_logic_vector(15 downto 0);
  signal ch1_rxdata_err_ctr : std_logic_vector(15 downto 0);
  signal ch2_rxdata_err_ctr : std_logic_vector(15 downto 0);
  signal ch3_rxdata_err_ctr : std_logic_vector(15 downto 0);
  signal rxdata_errctr_reset_vio_async : std_logic := '0';
  signal rxdata_errctr_reset_vio_int   : std_logic := '0';

  signal ila_data : std_logic_vector(777 downto 0) := (others => '0');

  signal loopback_int       : std_logic_vector(11 downto 0);
  signal init_done_int      : std_logic := '0';
  signal init_retry_ctr_int : std_logic_vector(3 downto 0) := (others => '0');

  signal hb_gtwiz_reset_all_vio_int  : std_logic;
  signal hb_gtwiz_reset_all_buf_int  : std_logic;
  signal hb_gtwiz_reset_all_init_int : std_logic;
  signal hb_gtwiz_reset_all_int      : std_logic;

  signal hb_gtwiz_reset_clk_freerun_in      : std_logic;
  signal hb_gtwiz_reset_clk_freerun_buf_int : std_logic;
  signal link_down_latched_reset_vio_int : std_logic;
  signal link_down_latched_reset_sync : std_logic;
  signal hb_gtwiz_reset_rx_pll_and_datapath_int : std_logic := '0';
  signal hb_gtwiz_reset_rx_datapath_int : std_logic;
  signal hb_gtwiz_reset_rx_pll_and_datapath_vio_int : std_logic;
  signal hb_gtwiz_reset_rx_datapath_vio_int : std_logic;
  signal hb_gtwiz_reset_rx_datapath_init_int : std_logic;

  signal gtpowergood_vio_sync : std_logic_vector(3 downto 0);
  signal txpmaresetdone_vio_sync : std_logic_vector(3 downto 0);
  signal rxpmaresetdone_vio_sync : std_logic_vector(3 downto 0);
  signal gtwiz_reset_tx_done_vio_sync : std_logic;
  signal gtwiz_reset_rx_done_vio_sync : std_logic;
  signal rxprbserr_vio_sync : std_logic_vector(3 downto 0);
  signal rxprbslocked_vio_sync : std_logic_vector(3 downto 0);
  signal rxprbssel_vio_async : std_logic_vector(15 downto 0);
  signal txprbsforceerr_vio_async : std_logic_vector(3 downto 0);
  signal rxprbscntreset_vio_async : std_logic_vector(3 downto 0);
  signal txprbssel_vio_async : std_logic_vector(15 downto 0);

  signal reset_all : std_logic;
  signal link_reset : std_logic;

begin

  sel_si570_clk_i <= '0';

  -- Helper Block ASSIGNMENTS
  gtwiz_userclk_tx_reset_int          <= hb0_gtwiz_userclk_tx_reset_int;
  hb0_gtwiz_userclk_tx_srcclk_int     <= gtwiz_userclk_tx_srcclk_int;
  hb0_gtwiz_userclk_tx_usrclk_int     <= gtwiz_userclk_tx_usrclk_int;
  hb0_gtwiz_userclk_tx_usrclk2_int    <= gtwiz_userclk_tx_usrclk2_int;
  hb0_gtwiz_userclk_tx_active_int     <= gtwiz_userclk_tx_active_int;
  gtwiz_userclk_rx_reset_int          <= hb0_gtwiz_userclk_rx_reset_int;
  hb0_gtwiz_userclk_rx_srcclk_int     <= gtwiz_userclk_rx_srcclk_int;
  hb0_gtwiz_userclk_rx_usrclk_int     <= gtwiz_userclk_rx_usrclk_int;
  hb0_gtwiz_userclk_rx_usrclk2_int    <= gtwiz_userclk_rx_usrclk2_int;
  hb0_gtwiz_userclk_rx_active_int     <= gtwiz_userclk_rx_active_int;
  gtwiz_reset_clk_freerun_int         <= hb0_gtwiz_reset_clk_freerun_int;
  gtwiz_reset_all_int                 <= hb0_gtwiz_reset_all_int;
  gtwiz_reset_tx_pll_and_datapath_int <= hb0_gtwiz_reset_tx_pll_and_datapath_int;
  gtwiz_reset_tx_datapath_int         <= hb0_gtwiz_reset_tx_datapath_int;
  gtwiz_reset_rx_pll_and_datapath_int <= hb0_gtwiz_reset_rx_pll_and_datapath_int;
  gtwiz_reset_rx_datapath_int         <= hb0_gtwiz_reset_rx_datapath_int;
  hb0_gtwiz_reset_rx_cdr_stable_int   <= gtwiz_reset_rx_cdr_stable_int;
  hb0_gtwiz_reset_tx_done_int         <= gtwiz_reset_tx_done_int;
  hb0_gtwiz_reset_rx_done_int         <= gtwiz_reset_rx_done_int;

  gtwiz_userdata_tx_int(31 downto 0)   <= hb0_gtwiz_userdata_tx_int;
  gtwiz_userdata_tx_int(63 downto 32)  <= hb1_gtwiz_userdata_tx_int;
  gtwiz_userdata_tx_int(95 downto 64)  <= hb2_gtwiz_userdata_tx_int;
  gtwiz_userdata_tx_int(127 downto 96) <= hb3_gtwiz_userdata_tx_int;

  hb0_gtwiz_userdata_rx_int <= gtwiz_userdata_rx_int(31 downto 0);
  hb1_gtwiz_userdata_rx_int <= gtwiz_userdata_rx_int(63 downto 32);
  hb2_gtwiz_userdata_rx_int <= gtwiz_userdata_rx_int(95 downto 64);
  hb3_gtwiz_userdata_rx_int <= gtwiz_userdata_rx_int(127 downto 96);

  gtrefclk00_int         <= cm0_gtrefclk00_int;
  cm0_qpll0outclk_int    <= qpll0outclk_int;
  cm0_qpll0outrefclk_int <= qpll0outrefclk_int;
  
  ---------------------------------
  -- PER-CHANNEL SIGNAL ASSIGNMENTS
  ---------------------------------
  gthrxn_int(0) <= BCK_PRS_N;
  gthrxn_int(1) <= B04_RX_N(1);
  gthrxn_int(2) <= B04_RX_N(2);
  gthrxn_int(3) <= B04_RX_N(3);

  gthrxp_int(0) <= BCK_PRS_P;
  gthrxp_int(1) <= B04_RX_P(1);
  gthrxp_int(2) <= B04_RX_P(2);
  gthrxp_int(3) <= B04_RX_P(3);

  DAQ_TX_N(0) <= gthtxn_int(0);
  DAQ_TX_N(1) <= gthtxn_int(1);
  DAQ_TX_N(2) <= gthtxn_int(2);
  DAQ_TX_N(3) <= gthtxn_int(3);

  DAQ_TX_P(0) <= gthtxp_int(0);
  DAQ_TX_P(1) <= gthtxp_int(1);
  DAQ_TX_P(2) <= gthtxp_int(2);
  DAQ_TX_P(3) <= gthtxp_int(3);

  ------------------------
  -- Channel Bonding logic
  ------------------------
  rxchbondi_int(4 downto 0) <= rxchbondo_int(9 downto 5);
  rxchbondlevel_int(2 downto 0) <= (0 => '1', others => '0');
  rxchbondi_int(9 downto 5) <= (others => '0');
  rxchbondlevel_int(5 downto 3) <= (4 => '1', others => '0');
  rxchbondi_int(14 downto 10) <= rxchbondo_int(9 downto 5);
  rxchbondlevel_int(8 downto 6) <= (6 => '1', others => '0');
  rxchbondi_int(19 downto 15) <= rxchbondo_int(14 downto 10);
  rxchbondlevel_int(11 downto 9) <= (others => '0');

  ------------------------
  -- BUFFERS
  ------------------------

  -- Buffer the hb_gtwiz_reset_all_in input and logically combine it with the internal signal from the example
  -- initialization block as well as the VIO-sourced reset
  ibuf_hb_gtwiz_reset_all_inst : IBUF
    port map (
      I => hb_gtwiz_reset_all_in,
      O => hb_gtwiz_reset_all_buf_int
    );

  hb_gtwiz_reset_all_int <= hb_gtwiz_reset_all_buf_int or hb_gtwiz_reset_all_init_int or hb_gtwiz_reset_all_vio_int;

  IBUFGDS_inst : IBUFGDS
    port map (
      O  => inclk_buf, -- Clock buffer output
      I  => CLK_IN_P, -- Diff_p clock buffer input
      IB => CLK_IN_N -- Diff_n clock buffer input
    );

  clockManager_i : clockManager
    port map (
      clk_in1  => inclk_buf,
      clk_out1 => clk_out40,
      clk_out2 => clk_out80
    );

  -- Globally buffer the free-running input clock
  hb_gtwiz_reset_clk_freerun_in <= clk_out40;

  bufg_clk_freerun_inst : BUFG
    port map (
      I => hb_gtwiz_reset_clk_freerun_in,
      O => hb_gtwiz_reset_clk_freerun_buf_int
    );

  -- Differential reference clock buffer for MGTREFCLK0_X0Y3
  IBUFDS_GTE3_q227_inst : IBUFDS_GTE3
    generic map (
      REFCLK_EN_TX_PATH  => '0',
      REFCLK_HROW_CK_SEL => "00",
      REFCLK_ICNTL_RX    => "00"
    )
    port map (
      I   => REF_CLK_3_P,
      IB  => REF_CLK_3_N,
      CEB => '0',
      O   => REF_CLK_3_int
      -- ODIV2  -- uncounnectd
    );

  cm0_gtrefclk00_int <= REF_CLK_3_int;

  -- USER CLOCKING RESETS
  hb0_gtwiz_userclk_tx_reset_int <= nand_reduce(txpmaresetdone_int);
  hb0_gtwiz_userclk_rx_reset_int <= nand_reduce(rxpmaresetdone_int);

  reset_all <= hb_gtwiz_reset_all_int or not hb0_gtwiz_reset_rx_done_int;

  -- PRBS-based data stimulus module for transceiver channel 0
  stimulus_inst0 : gtwizard_ultrascale_0_example_stimulus_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_tx_usrclk2_in => hb0_gtwiz_userclk_tx_usrclk2_int,
      gtwiz_userclk_tx_active_in  => hb0_gtwiz_userclk_tx_active_int,
      txctrl0_out                 => txctrl0_int(15 downto 0),
      txctrl1_out                 => txctrl1_int(15 downto 0),
      txctrl2_out                 => txctrl2_int(7 downto 0),
      txdata_out                  => hb0_gtwiz_userdata_tx_int
    );

  -- PRBS-based data stimulus module for transceiver channel 1
  stimulus_inst1 : gtwizard_ultrascale_0_example_stimulus_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_tx_usrclk2_in => hb0_gtwiz_userclk_tx_usrclk2_int,
      gtwiz_userclk_tx_active_in  => hb0_gtwiz_userclk_tx_active_int,
      txctrl0_out                 => txctrl0_int(31 downto 16),
      txctrl1_out                 => txctrl1_int(31 downto 16),
      txctrl2_out                 => txctrl2_int(15 downto 8),
      txdata_out                  => hb1_gtwiz_userdata_tx_int
    );

  -- PRBS-based data stimulus module for transceiver channel 2
  stimulus_inst2 : gtwizard_ultrascale_0_example_stimulus_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_tx_usrclk2_in => hb0_gtwiz_userclk_tx_usrclk2_int,
      gtwiz_userclk_tx_active_in  => hb0_gtwiz_userclk_tx_active_int,
      txctrl0_out                 => txctrl0_int(47 downto 32),
      txctrl1_out                 => txctrl1_int(47 downto 32),
      txctrl2_out                 => txctrl2_int(23 downto 16),
      txdata_out                  => hb2_gtwiz_userdata_tx_int
    );

  -- PRBS-based data stimulus module for transceiver channel 3
  stimulus_inst3 : gtwizard_ultrascale_0_example_stimulus_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_tx_usrclk2_in => hb0_gtwiz_userclk_tx_usrclk2_int,
      gtwiz_userclk_tx_active_in  => hb0_gtwiz_userclk_tx_active_int,
      txctrl0_out                 => txctrl0_int(63 downto 48),
      txctrl1_out                 => txctrl1_int(63 downto 48),
      txctrl2_out                 => txctrl2_int(31 downto 24),
      txdata_out                  => hb3_gtwiz_userdata_tx_int
    );

  -- PRBS-based data checking module for transceiver channel 0
  checking_inst0 : gtwizard_ultrascale_0_example_checking_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_rx_usrclk2_in => hb0_gtwiz_userclk_rx_usrclk2_int,
      gtwiz_userclk_rx_active_in  => hb0_gtwiz_userclk_rx_active_int,
      rxctrl0_in                  => rxctrl0_int(15 downto 0),
      rxctrl1_in                  => rxctrl1_int(15 downto 0),
      rxctrl2_in                  => rxctrl2_int(7 downto 0),
      rxctrl3_in                  => rxctrl3_int(7 downto 0),
      rxdata_in                   => hb0_gtwiz_userdata_rx_int,
      prbs_match_out              => prbs_match_int(0)
    );

  -- PRBS-based data checking module for transceiver channel 1
  checking_inst1 : gtwizard_ultrascale_0_example_checking_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_rx_usrclk2_in => hb0_gtwiz_userclk_rx_usrclk2_int,
      gtwiz_userclk_rx_active_in  => hb0_gtwiz_userclk_rx_active_int,
      rxctrl0_in                  => rxctrl0_int(31 downto 16),
      rxctrl1_in                  => rxctrl1_int(31 downto 16),
      rxctrl2_in                  => rxctrl2_int(15 downto 8),
      rxctrl3_in                  => rxctrl3_int(15 downto 8),
      rxdata_in                   => hb1_gtwiz_userdata_rx_int,
      prbs_match_out              => prbs_match_int(1)
    );

  -- PRBS-based data checking module for transceiver channel 2
  checking_inst2 : gtwizard_ultrascale_0_example_checking_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_rx_usrclk2_in => hb0_gtwiz_userclk_rx_usrclk2_int,
      gtwiz_userclk_rx_active_in  => hb0_gtwiz_userclk_rx_active_int,
      rxctrl0_in                  => rxctrl0_int(47 downto 32),
      rxctrl1_in                  => rxctrl1_int(47 downto 32),
      rxctrl2_in                  => rxctrl2_int(23 downto 16),
      rxctrl3_in                  => rxctrl3_int(23 downto 16),
      rxdata_in                   => hb2_gtwiz_userdata_rx_int,
      prbs_match_out              => prbs_match_int(2)
    );

  -- PRBS-based data checking module for transceiver channel 3
  checking_inst3 : gtwizard_ultrascale_0_example_checking_8b10b
    port map (
      gtwiz_reset_all_in          => reset_all,
      gtwiz_userclk_rx_usrclk2_in => hb0_gtwiz_userclk_rx_usrclk2_int,
      gtwiz_userclk_rx_active_in  => hb0_gtwiz_userclk_rx_active_int,
      rxctrl0_in                  => rxctrl0_int(63 downto 48),
      rxctrl1_in                  => rxctrl1_int(63 downto 48),
      rxctrl2_in                  => rxctrl2_int(31 downto 24),
      rxctrl3_in                  => rxctrl3_int(31 downto 24),
      rxdata_in                   => hb3_gtwiz_userdata_rx_int,
      prbs_match_out              => prbs_match_int(3)
    );

  -- Perform a bitwise NAND of all PRBS match indicators, creating a combinatorial indication of any PRBS mismatch
  -- across all transceiver channels
  prbs_error_any_async <= nand_reduce(prbs_match_int);

  prbs_match_all_inst : gtwizard_ultrascale_0_example_reset_synchronizer
    port map (
      clk_in  => hb_gtwiz_reset_clk_freerun_buf_int,
      rst_in  => prbs_error_any_async,
      rst_out => prbs_error_any_sync
    );

  -- The link status indicates the continual PRBS match status to both the top-level observer and the initialization state machine, while being tolerant of occasional bit errors.
  sm_link  <= ST_LINK_DOWN;
  link_ctr <= "0000000";

  process (hb_gtwiz_reset_clk_freerun_buf_int)
  begin
    if (rising_edge(hb_gtwiz_reset_clk_freerun_buf_int)) then
      case (sm_link) is
        -- The link is considered to be down when the link counter initially has a value less than 67.
        -- When the link is down, the counter is incremented on each cycle where all PRBS bits match, but reset whenever any PRBS mismatch occurs.
        -- When the link counter reaches 67, transition to the link up state.
        when (ST_LINK_DOWN) =>
          if (prbs_error_any_sync = '1') then
            link_ctr <= "0000000";
          else
            if (link_ctr < "1000011") then
              link_ctr <= link_ctr + "0000001";
            else
              sm_link <= ST_LINK_UP;
            end if;
          end if;
        -- When the link is up, the link counter is decreased by 34 whenever any PRBS mismatch occurs, but is increased by only 1 on each cycle where all PRBS bits match, up to its saturation point of 67.
        -- If the link counter reaches 0 (including rollover protection), transition to the link down state.
        when ST_LINK_UP =>
          if (prbs_error_any_sync = '1') then
            if (link_ctr > "0100001") then
              link_ctr <= link_ctr - "0100010";
              if (link_ctr = "0100010") then
                sm_link <= ST_LINK_DOWN;
              end if;
            else
              link_ctr <= "0000000";
              sm_link  <= ST_LINK_DOWN;
            end if;
          else
            if (link_ctr < "0100001") then
              link_ctr <= link_ctr + "0000001";
            end if;
          end if;
      end case;
    end if;
  end process;

  link_reset <= link_down_latched_reset_in or link_down_latched_reset_vio_int;

  link_down_latched_reset_inst : gtwizard_ultrascale_0_example_bit_synchronizer
    port map (
      clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
      i_in   => link_reset,
      o_out  => link_down_latched_reset_sync
    );

  process (hb_gtwiz_reset_clk_freerun_buf_int)
  begin
    if (rising_edge(hb_gtwiz_reset_clk_freerun_buf_int)) then
      if (link_down_latched_reset_sync = '1') then
        link_down_latched_out <= '0';
      else
        if (sm_link = '0') then
          link_down_latched_out <= '1';
        end if;
      end if;
    end if;
  end process;

  -- Assign the link status indicator to the top-level two-state output for user reference
  link_status_out <= sm_link;

  -- INITIALIZATION
  hb_gtwiz_reset_rx_datapath_int <= hb_gtwiz_reset_rx_datapath_init_int or hb_gtwiz_reset_rx_datapath_vio_int;

  init_inst : gtwizard_ultrascale_0_example_init
  port map (
    clk_freerun_in  => hb_gtwiz_reset_clk_freerun_buf_int,
    reset_all_in    => hb_gtwiz_reset_all_int,
    tx_init_done_in => gtwiz_reset_tx_done_int,
    rx_init_done_in => gtwiz_reset_rx_done_int,
    rx_data_good_in => sm_link,
    reset_all_out   => hb_gtwiz_reset_all_init_int,
    reset_rx_out    => hb_gtwiz_reset_rx_datapath_init_int,
    init_done_out   => init_done_int,
    retry_ctr_out   => init_retry_ctr_int
  );

  --------------------------------------
  -- VIO FOR HARDWARE BRING-UP AND DEBUG
  --------------------------------------

  -- Synchronize gtpowergood into the free-running clock domain for VIO usage
  vio_gtpowergood_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtpowergood_int(0),
    o_out  => gtpowergood_vio_sync(0)
  );
  vio_gtpowergood_1_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtpowergood_int(1),
    o_out  => gtpowergood_vio_sync(1)
  );
  vio_gtpowergood_2_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtpowergood_int(2),
    o_out  => gtpowergood_vio_sync(2)
  );
  vio_gtpowergood_3_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtpowergood_int(3),
    o_out  => gtpowergood_vio_sync(3)
  );

  -- Synchronize txpmaresetdone into the free-running clock domain for VIO usage
  vio_txpmaresetdone_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => txpmaresetdone_int(0),
    o_out  => txpmaresetdone_vio_sync(0)
  );
  vio_txpmaresetdone_1_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => txpmaresetdone_int(1),
    o_out  => txpmaresetdone_vio_sync(1)
  );
  vio_txpmaresetdone_2_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => txpmaresetdone_int(2),
    o_out  => txpmaresetdone_vio_sync(2)
  );
  vio_txpmaresetdone_3_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => txpmaresetdone_int(3),
    o_out  => txpmaresetdone_vio_sync(3)
  );

  -- Synchronize rxpmaresetdone into the free-running clock domain for VIO usage
  vio_rxpmaresetdone_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxpmaresetdone_int(0),
    o_out  => rxpmaresetdone_vio_sync(0)
  );
  vio_rxpmaresetdone_1_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxpmaresetdone_int(1),
    o_out  => rxpmaresetdone_vio_sync(1)
  );
  vio_rxpmaresetdone_2_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxpmaresetdone_int(2),
    o_out  => rxpmaresetdone_vio_sync(2)
  );
  vio_rxpmaresetdone_3_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxpmaresetdone_int(3),
    o_out  => rxpmaresetdone_vio_sync(3)
  );

  -- Synchronize gtwiz_reset_tx_done into the free-running clock domain for VIO usage
  vio_gtwiz_reset_tx_done_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtwiz_reset_tx_done_int,
    o_out  => gtwiz_reset_tx_done_vio_sync
  );

  -- Synchronize gtwiz_reset_rx_done into the free-running clock domain for VIO usage
  vio_gtwiz_reset_rx_done_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => gtwiz_reset_rx_done_int,
    o_out  => gtwiz_reset_rx_done_vio_sync
  );

  -- Synchronize rxprbserr into the free-running clock domain for VIO usage
  vio_rxprbserr_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbserr_int(0),
    o_out  => rxprbserr_vio_sync(0)
  );
  vio_rxprbserr_1_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbserr_int(1),
    o_out  => rxprbserr_vio_sync(1)
  );
  vio_rxprbserr_2_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbserr_int(2),
    o_out  => rxprbserr_vio_sync(2)
  );
  vio_rxprbserr_3_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbserr_int(3),
    o_out  => rxprbserr_vio_sync(3)
  );

  -- Synchronize rxprbslocked into the free-running clock domain for VIO usage
  vio_rxprbslocked_0_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbslocked_int(0),
    o_out  => rxprbslocked_vio_sync(0)
  );
  vio_rxprbslocked_1_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbslocked_int(1),
    o_out  => rxprbslocked_vio_sync(1)
  );
  vio_rxprbslocked_2_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbslocked_int(2),
    o_out  => rxprbslocked_vio_sync(2)
  );
  vio_rxprbslocked_3_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => hb_gtwiz_reset_clk_freerun_buf_int,
    i_in   => rxprbslocked_int(3),
    o_out  => rxprbslocked_vio_sync(3)
  );

  -- Bit Error Counter
  vio_rxdata_errctr_inst : gtwizard_ultrascale_0_example_bit_synchronizer
  port map (
    clk_in => gtwiz_userclk_rx_usrclk2_int,
    i_in   => rxdata_errctr_reset_vio_async,
    o_out  => rxdata_errctr_reset_vio_int
  );

  process (hb0_gtwiz_userclk_rx_usrclk2_int)
  begin
    if (rising_edge(hb0_gtwiz_userclk_rx_usrclk2_int)) then
      if (rxdata_errctr_reset_vio_int = '1') then
        hb0_rxdata_nml_ctr <= x"0000000000";
        ch0_rxdata_err_ctr <= x"0000";
        ch1_rxdata_err_ctr <= x"0000";
        ch2_rxdata_err_ctr <= x"0000";
        ch3_rxdata_err_ctr <= x"0000";
      else
        if (gtwiz_reset_rx_done_int = '1') then
          hb0_rxdata_nml_ctr <= hb0_rxdata_nml_ctr + 1;
          if (prbs_match_int(0) = '0') then
            ch0_rxdata_err_ctr <= ch0_rxdata_err_ctr + 1;
          end if;
          if (prbs_match_int(1) = '0') then
            ch1_rxdata_err_ctr <= ch1_rxdata_err_ctr + 1;
          end if;
          if (prbs_match_int(2) = '0') then
            ch2_rxdata_err_ctr <= ch2_rxdata_err_ctr + 1;
          end if;
          if (prbs_match_int(3) = '0') then
            ch3_rxdata_err_ctr <= ch3_rxdata_err_ctr + 1;
          end if;
        end if;
      end if;
    end if;
  end process;

  ila_data(127 downto 0)   <= gtwiz_userdata_rx_int;
  ila_data(255 downto 128) <= gtwiz_userdata_tx_int;
  ila_data(259 downto 256) <= prbs_match_int;
  ila_data(260)            <= gtwiz_userclk_rx_usrclk2_int;
  ila_data(261)            <= gtwiz_userclk_rx_active_int;
  ila_data(262)            <= gtwiz_reset_all_int;
  ila_data(263)            <= gtwiz_reset_rx_done_int;
  ila_data(264)            <= gtwiz_userclk_tx_usrclk2_int;
  ila_data(265)            <= gtwiz_userclk_tx_active_int;
  ila_data(277 downto 274) <= gtpowergood_int;
  ila_data(281 downto 278) <= rx8b10ben_int;
  ila_data(285 downto 282) <= rxlpmen_int;
  ila_data(289 downto 286) <= rxcommadeten_int;
  ila_data(293 downto 290) <= rxmcommaalignen_int;
  ila_data(297 downto 294) <= rxpcommaalignen_int;
  ila_data(301 downto 298) <= rxbyteisaligned_int;
  ila_data(305 downto 302) <= rxbyterealign_int;
  ila_data(309 downto 306) <= rxcommadet_int;
  ila_data(313 downto 310) <= rxpmaresetdone_int;
  ila_data(317 downto 314) <= tx8b10ben_int;
  ila_data(321 downto 318) <= txpmaresetdone_int;
  ila_data(385 downto 322) <= rxctrl0_int;
  ila_data(449 downto 386) <= rxctrl1_int;
  ila_data(481 downto 450) <= rxctrl2_int;
  ila_data(513 downto 482) <= rxctrl3_int;
  ila_data(577 downto 514) <= txctrl0_int;
  ila_data(641 downto 578) <= txctrl1_int;
  ila_data(673 downto 642) <= txctrl2_int;
  ila_data(713 downto 674) <= hb0_rxdata_nml_ctr;
  ila_data(729 downto 714) <= ch0_rxdata_err_ctr;
  ila_data(745 downto 730) <= ch1_rxdata_err_ctr;
  ila_data(761 downto 746) <= ch2_rxdata_err_ctr;
  ila_data(777 downto 762) <= ch3_rxdata_err_ctr;

  ila_i : ila_0
  port map(
    clk    => hb_gtwiz_reset_clk_freerun_buf_int,
    probe0 => ila_data
  );

  vio_i : vio_0
  port map(
    clk         => hb_gtwiz_reset_clk_freerun_buf_int,
    probe_in0   => link_status_out,
    probe_in1   => link_down_latched_out,
    probe_in2   => init_done_int,
    probe_in3   => init_retry_ctr_int,
    probe_in4   => gtpowergood_vio_sync,
    probe_in5   => txpmaresetdone_vio_sync,
    probe_in6   => rxpmaresetdone_vio_sync,
    probe_in7   => gtwiz_reset_tx_done_vio_sync,
    probe_in8   => gtwiz_reset_rx_done_vio_sync,
    probe_in9   => rxprbserr_vio_sync,
    probe_in10  => rxprbslocked_vio_sync,
    probe_out0  => hb_gtwiz_reset_all_vio_int,
    probe_out1  => hb0_gtwiz_reset_tx_pll_and_datapath_int,
    probe_out2  => hb0_gtwiz_reset_tx_datapath_int,
    probe_out3  => hb_gtwiz_reset_rx_pll_and_datapath_vio_int,
    probe_out4  => hb_gtwiz_reset_rx_datapath_vio_int,
    probe_out5  => link_down_latched_reset_vio_int,
    probe_out6  => loopback_int,
    probe_out7  => txprbssel_vio_async,
    probe_out8  => rxprbssel_vio_async,
    probe_out9  => txprbsforceerr_vio_async,
    probe_out10 => rxprbscntreset_vio_async,
    probe_out11 => rxdata_errctr_reset_vio_async
  );

  B04_wrapper_inst : gtwizard_ultrascale_0_example_wrapper
    port map (
      gthrxn_in                          => gthrxn_int,
      gthrxp_in                          => gthrxp_int,
      gthtxn_out                         => gthtxn_int,
      gthtxp_out                         => gthtxp_int,
      gtwiz_userclk_tx_reset_in          => gtwiz_userclk_tx_reset_int,
      gtwiz_userclk_tx_srcclk_out        => gtwiz_userclk_tx_srcclk_int,
      gtwiz_userclk_tx_usrclk_out        => gtwiz_userclk_tx_usrclk_int,
      gtwiz_userclk_tx_usrclk2_out       => gtwiz_userclk_tx_usrclk2_int,
      gtwiz_userclk_tx_active_out        => gtwiz_userclk_tx_active_int,
      gtwiz_userclk_rx_reset_in          => gtwiz_userclk_rx_reset_int,
      gtwiz_userclk_rx_srcclk_out        => gtwiz_userclk_rx_srcclk_int,
      gtwiz_userclk_rx_usrclk_out        => gtwiz_userclk_rx_usrclk_int,
      gtwiz_userclk_rx_usrclk2_out       => gtwiz_userclk_rx_usrclk2_int,
      gtwiz_userclk_rx_active_out        => gtwiz_userclk_rx_active_int,
      gtwiz_reset_clk_freerun_in         => hb_gtwiz_reset_clk_freerun_buf_int,
      gtwiz_reset_all_in                 => hb_gtwiz_reset_all_int,
      gtwiz_reset_tx_pll_and_datapath_in => gtwiz_reset_tx_pll_and_datapath_int,
      gtwiz_reset_tx_datapath_in         => gtwiz_reset_tx_datapath_int,
      gtwiz_reset_rx_pll_and_datapath_in => hb_gtwiz_reset_rx_pll_and_datapath_int,
      gtwiz_reset_rx_datapath_in         => hb_gtwiz_reset_rx_datapath_int,
      gtwiz_reset_rx_cdr_stable_out      => gtwiz_reset_rx_cdr_stable_int,
      gtwiz_reset_tx_done_out            => gtwiz_reset_tx_done_int,
      gtwiz_reset_rx_done_out            => gtwiz_reset_rx_done_int,
      gtwiz_userdata_tx_in               => gtwiz_userdata_tx_int,
      gtwiz_userdata_rx_out              => gtwiz_userdata_rx_int,
      gtrefclk00_in                      => gtrefclk00_int,
      qpll0outclk_out                    => qpll0outclk_int,
      qpll0outrefclk_out                 => qpll0outrefclk_int,
      rx8b10ben_in                       => rx8b10ben_int,
      rxchbonden_in                      => rxchbonden_int,
      rxchbondi_in                       => rxchbondi_int,
      rxchbondlevel_in                   => rxchbondlevel_int,
      rxchbondmaster_in                  => rxchbondmaster_int,
      rxchbondslave_in                   => rxchbondslave_int,
      rxcommadeten_in                    => rxcommadeten_int,
      rxlpmen_in                         => rxlpmen_int,
      rxmcommaalignen_in                 => rxmcommaalignen_int,
      rxpcommaalignen_in                 => rxpcommaalignen_int,
      rxpolarity_in                      => rxpolarity_int,
      tx8b10ben_in                       => tx8b10ben_int,
      txctrl0_in                         => txctrl0_int,
      txctrl1_in                         => txctrl1_int,
      txctrl2_in                         => txctrl2_int,
      txpolarity_in                      => txpolarity_int,
      gtpowergood_out                    => gtpowergood_int,
      rxbyteisaligned_out                => rxbyteisaligned_int,
      rxbyterealign_out                  => rxbyterealign_int,
      rxchanbondseq_out                  => rxchanbondseq_int,
      rxchanisaligned_out                => rxchanisaligned_int,
      rxchanrealign_out                  => rxchanrealign_int,
      rxchbondo_out                      => rxchbondo_int,
      rxcommadet_out                     => rxcommadet_int,
      rxctrl0_out                        => rxctrl0_int,
      rxctrl1_out                        => rxctrl1_int,
      rxctrl2_out                        => rxctrl2_int,
      rxctrl3_out                        => rxctrl3_int,
      rxpmaresetdone_out                 => rxpmaresetdone_int,
      rxprbserr_out                      => rxprbserr_int,
      rxprbslocked_out                   => rxprbslocked_int,
      txpmaresetdone_out                 => txpmaresetdone_int
    );

end Behavioral;
