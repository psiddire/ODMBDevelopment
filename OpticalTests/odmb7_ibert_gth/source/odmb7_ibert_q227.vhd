library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;

library unisim;
use unisim.vcomponents.all;

entity odmb7_ibert_q227 is
  generic (
    NCFEB       : integer range 1 to 7 := 7;  -- Number of DCFEBS, 7 for ME1/1, 5
    NQUAD       : integer range 0 to 4 := 1   -- Number of Quads used for IBERT
  );
  PORT (
    --------------------
    -- Clock
    --------------------
    CMS_CLK_FPGA_P : in std_logic;      -- system clock: 40.07897 MHz
    CMS_CLK_FPGA_N : in std_logic;      -- system clock: 40.07897 MHz
    GP_CLK_6_P : in std_logic;          -- clock synthesizer ODIV6: 80 MHz
    GP_CLK_6_N : in std_logic;          -- clock synthesizer ODIV6: 80 MHz
    GP_CLK_7_P : in std_logic;          -- clock synthesizer ODIV7: 80 MHz
    GP_CLK_7_N : in std_logic;          -- clock synthesizer ODIV7: 80 MHz
    REF_CLK_2_P : in std_logic;         -- refclk0 to 227
    REF_CLK_2_N : in std_logic;         -- refclk0 to 227
    REF_CLK_5_P : in std_logic;         -- refclk1 to 227
    REF_CLK_5_N : in std_logic;         -- refclk1 to 227
    REF_CLK_3_P : in std_logic;         -- refclk0 to 226
    REF_CLK_3_N : in std_logic;         -- refclk0 to 226
    CLK_125_REF_P : in std_logic;       -- refclk1 to 226
    CLK_125_REF_N : in std_logic;       -- refclk1 to 226

    --------------------------------
    -- ODMB optical signals
    --------------------------------

    B04_RX_P : in std_logic_vector(4 downto 2); -- B04 RX, no use
    B04_RX_N : in std_logic_vector(4 downto 2); -- B04 RX, no use
    BCK_PRS_P : in std_logic; -- copy of B04_RX_P1
    BCK_PRS_N : in std_logic; -- copy of B04_RX_N1

    DAQ_TX_P : out std_logic_vector(4 downto 1); -- B04 TX, output to FED
    DAQ_TX_N : out std_logic_vector(4 downto 1); -- B04 TX, output to FED

    B04_I2C_ENA   : out std_logic;
    B04_CS_B      : out std_logic;
    B04_RST_B     : out std_logic;

    --------------------------------
    -- Selector and monitor pins
    --------------------------------
    KUS_DL_SEL    : out std_logic;
    FPGA_SEL      : out std_logic;
    RST_CLKS_B    : out std_logic

    );
end odmb7_ibert_q227;

architecture odmb_inst of odmb7_ibert_q227 is

  --------------------------------------
  -- Component and signals for the IBERT test
  --------------------------------------
  component clockManager is
    port (
      clk_in1    : in std_logic;
      clk_out40  : out std_logic;
      clk_out10  : out std_logic;
      clk_out80  : out std_logic;
      clk_out100 : out std_logic;
      clk_out160 : out std_logic
      );
  end component;

  --------------------------------------
  -- Component and signals for the IBERT test
  --------------------------------------
  component ibert_odmb7_quad227
    port (
      txn_o : out std_logic_vector(4*NQUAD-1 downto 0);
      txp_o : out std_logic_vector(4*NQUAD-1 downto 0);
      rxoutclk_o : out std_logic_vector(4*NQUAD-1 downto 0);
      rxn_i : in std_logic_vector(4*NQUAD-1 downto 0);
      rxp_i : in std_logic_vector(4*NQUAD-1 downto 0);
      gtrefclk0_i : in std_logic_vector(NQUAD-1 downto 0);
      gtrefclk1_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk0_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk1_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk0_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk1_i : in std_logic_vector(NQUAD-1 downto 0);
      gtrefclk00_i : in std_logic_vector(NQUAD-1 downto 0);
      gtrefclk10_i : in std_logic_vector(NQUAD-1 downto 0);
      gtrefclk01_i : in std_logic_vector(NQUAD-1 downto 0);
      gtrefclk11_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk00_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk10_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk01_i : in std_logic_vector(NQUAD-1 downto 0);
      gtnorthrefclk11_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk00_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk10_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk01_i : in std_logic_vector(NQUAD-1 downto 0);
      gtsouthrefclk11_i : in std_logic_vector(NQUAD-1 downto 0);
      clk : in std_logic
    );
  end component;

  signal gth_txn_o : std_logic_vector(4*NQUAD-1 downto 0);
  signal gth_txp_o : std_logic_vector(4*NQUAD-1 downto 0);
  signal gth_rxn_i : std_logic_vector(4*NQUAD-1 downto 0);
  signal gth_rxp_i : std_logic_vector(4*NQUAD-1 downto 0);
  signal gth_qrefclk0_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qrefclk1_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk0_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk1_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk0_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk1_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qrefclk00_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qrefclk10_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qrefclk01_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qrefclk11_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk00_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk10_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk01_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qnorthrefclk11_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk00_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk10_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk01_i : std_logic_vector(NQUAD-1 downto 0);
  signal gth_qsouthrefclk11_i : std_logic_vector(NQUAD-1 downto 0);

  signal mgtrefclk0_226_i : std_logic;
  signal mgtrefclk0_226_odiv2 : std_logic;
  signal mgtrefclk1_226_i : std_logic;
  signal mgtrefclk1_226_odiv2 : std_logic;
  signal mgtrefclk0_227_i : std_logic;
  signal mgtrefclk0_227_odiv2 : std_logic;
  signal gth_sysclk_i : std_logic;
  signal clk_sysclk40 : std_logic;
  signal clk_sysclk80 : std_logic;
  signal clk_sysclk100 : std_logic;
  signal clk_cmsclk : std_logic;
  signal clk_gp6 : std_logic;
  signal clk_gp7 : std_logic;
  signal clk_mgtclk0 : std_logic;
  signal clk_mgtclk1 : std_logic;
  signal clk_mgtclk2 : std_logic;

  signal clk_cmsclk_buf : std_logic;
  signal clk_gp6_buf : std_logic;
  signal clk_gp7_buf : std_logic;

begin

  -------------------------------------------------------------------------------------------
  -- Constant driver for selector/reset pins for board to work
  -------------------------------------------------------------------------------------------
  KUS_DL_SEL <= '1';
  FPGA_SEL <= '0';
  RST_CLKS_B <= '1';

  -------------------------------------------------------------------------------------------
  -- Constant driver for firefly selector/reset pins
  -------------------------------------------------------------------------------------------
  B04_I2C_ENA <= '0';
  B04_CS_B <= '1';
  B04_RST_B <= '1';

  u_buf_gth_q2_clk0 : IBUFDS_GTE3
    port map (
      O     => mgtrefclk0_226_i,
      ODIV2 => mgtrefclk0_226_odiv2,
      CEB   => '0',
      I     => REF_CLK_3_P,
      IB    => REF_CLK_3_N
      );

  u_buf_gth_q2_clk1 : IBUFDS_GTE3
    port map (
      O     => mgtrefclk1_226_i,
      ODIV2 => mgtrefclk1_226_odiv2,
      CEB   => '0',
      I     => CLK_125_REF_P,
      IB    => CLK_125_REF_N
      );

  u_buf_gth_q3_clk0 : IBUFDS_GTE3
    port map (
      O     => mgtrefclk0_227_i,
      ODIV2 => mgtrefclk0_227_odiv2,
      CEB   => '0',
      I     => REF_CLK_2_P,
      IB    => REF_CLK_2_N
      );

  -- Using external input clock pin as IBERT sysclk <- option 1
  u_ibufgds_gp7 : IBUFGDS
    generic map (DIFF_TERM => TRUE)
    port map (
      I => GP_CLK_7_P,
      IB => GP_CLK_7_N,
      O => clk_gp7
    );

  u_ibufgds_gp6 : IBUFGDS
    generic map (DIFF_TERM => TRUE)
    port map (
      I => GP_CLK_6_P,
      IB => GP_CLK_6_N,
      O => clk_gp6
      );

  -- Using the clock manager output as IBERT sysclk <- option 2
  u_ibufgds_cms : IBUFGDS
    -- generic map (DIFF_TERM => TRUE)
    port map (
      I => CMS_CLK_FPGA_P,
      IB => CMS_CLK_FPGA_N,
      O => clk_cmsclk
    );

  -- Adding BUFG to the clocks
  u_bufg_gp7 : BUFG port map (I => clk_gp7, O => clk_gp7_buf);
  u_bufg_gp6 : BUFG port map (I => clk_gp6, O => clk_gp6_buf);
  u_bufg_cms : BUFG port map (I => clk_cmsclk, O => clk_cmsclk_buf);

  -- Using optical refclk as IBERT sysclk <- option 3
  u_mgtclk0_q226 : BUFG_GT
    port map(
      I       => mgtrefclk0_226_odiv2,
      O       => clk_mgtclk0,
      CE      => '1',
      CEMASK  => '0',
      CLR     => '0',
      CLRMASK => '0',
      DIV     => "000"
      );

  u_mgtclk0_q227 : BUFG_GT
    port map(
      I       => mgtrefclk0_227_odiv2,
      O       => clk_mgtclk1,
      CE      => '1',
      CEMASK  => '0',
      CLR     => '0',
      CLRMASK => '0',
      DIV     => "000"
      );

  u_mgtclk1_q226 : BUFG_GT
    port map(
      I       => mgtrefclk1_226_i,
      O       => clk_mgtclk2,
      CE      => '1',
      CEMASK  => '0',
      CLR     => '0',
      CLRMASK => '0',
      DIV     => "000"
      );

  -- Extras for LED
  clockManager_i : clockManager
    port map (
      clk_in1   => clk_cmsclk_buf,     -- input 40 MHz
      -- clk_in1_p  => CMS_CLK_FPGA_P,
      -- clk_in1_n  => CMS_CLK_FPGA_N,
      clk_out40 => clk_sysclk40,   -- output 40 MHz
      clk_out80 => clk_sysclk80,    -- output 80 MHz
      clk_out100 => clk_sysclk100    -- output 100 MHz
      );

  -- gth_sysclk_i <= clk_sysclk40;
  -- gth_sysclk_i <= clk_mgtclk2;
  -- gth_sysclk_i <= clk_gp7;
  gth_sysclk_i <= clk_gp6_buf;

  -- DAQ_SPY_SEL <= '1';   -- Priority to test the SPY TX

  -------------------------------------------------------------------------------------------
  -- IBERT signals
  -------------------------------------------------------------------------------------------

  -- Quad 227 <-- there should be at least 1 quad
  gth_rxp_i(4*NQUAD-4) <= BCK_PRS_P;
  gth_rxn_i(4*NQUAD-4) <= BCK_PRS_N;
  gth_rxp_i(4*NQUAD-1 downto 4*NQUAD-3) <= B04_RX_P;
  gth_rxn_i(4*NQUAD-1 downto 4*NQUAD-3) <= B04_RX_N;

  DAQ_TX_P <= gth_txp_o(4*NQUAD-1  downto 4*NQUAD-4);
  DAQ_TX_N <= gth_txn_o(4*NQUAD-1  downto 4*NQUAD-4);

  -- Clocks for Quad 227 refclk0 <-- use refclk2
  gth_qrefclk0_i(NQUAD-1) <= mgtrefclk0_227_i;
  gth_qnorthrefclk0_i(NQUAD-1) <= '0';
  gth_qsouthrefclk0_i(NQUAD-1) <= '0';
  gth_qrefclk00_i(NQUAD-1) <= mgtrefclk0_227_i;
  gth_qrefclk01_i(NQUAD-1) <= '0';
  gth_qnorthrefclk00_i(NQUAD-1) <= '0';
  gth_qnorthrefclk01_i(NQUAD-1) <= '0';
  gth_qsouthrefclk00_i(NQUAD-1) <= '0';
  gth_qsouthrefclk01_i(NQUAD-1) <= '0';

  -- Refclk1 for all quads
  gth_qrefclk1_i <= (others => '0');
  gth_qnorthrefclk1_i <= (others => '0');
  gth_qsouthrefclk1_i <= (others => '0');
  gth_qrefclk10_i <= (others => '0');
  gth_qrefclk11_i <= (others => '0');
  gth_qnorthrefclk10_i <= (others => '0');
  gth_qnorthrefclk11_i <= (others => '0');
  gth_qsouthrefclk10_i <= (others => '0');
  gth_qsouthrefclk11_i <= (others => '0');

  u_ibert_gth_core : ibert_odmb7_quad227
    port map (
      txn_o => gth_txn_o,
      txp_o => gth_txp_o,
      rxn_i => gth_rxn_i,
      rxp_i => gth_rxp_i,
      clk => gth_sysclk_i,
      gtrefclk0_i => gth_qrefclk0_i,
      gtrefclk1_i => gth_qrefclk1_i,
      gtnorthrefclk0_i => gth_qnorthrefclk0_i,
      gtnorthrefclk1_i => gth_qnorthrefclk1_i,
      gtsouthrefclk0_i => gth_qsouthrefclk0_i,
      gtsouthrefclk1_i => gth_qsouthrefclk1_i,
      gtrefclk00_i => gth_qrefclk00_i,
      gtrefclk10_i => gth_qrefclk10_i,
      gtrefclk01_i => gth_qrefclk01_i,
      gtrefclk11_i => gth_qrefclk11_i,
      gtnorthrefclk00_i => gth_qnorthrefclk00_i,
      gtnorthrefclk10_i => gth_qnorthrefclk10_i,
      gtnorthrefclk01_i => gth_qnorthrefclk01_i,
      gtnorthrefclk11_i => gth_qnorthrefclk11_i,
      gtsouthrefclk00_i => gth_qsouthrefclk00_i,
      gtsouthrefclk10_i => gth_qsouthrefclk10_i,
      gtsouthrefclk01_i => gth_qsouthrefclk01_i,
      gtsouthrefclk11_i => gth_qsouthrefclk11_i
      );

end odmb_inst;
