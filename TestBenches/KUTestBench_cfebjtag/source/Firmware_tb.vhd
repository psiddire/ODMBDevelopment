library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library UNISIM;
use UNISIM.VComponents.all;

use work.Firmware_pkg.all;

entity Firmware_tb is
  PORT ( 
    -- 300 MHz clk_in
    CLK_IN_P : in std_logic;
    CLK_IN_N : in std_logic;
    -- 40 MHz clk out
    J36_USER_SMA_GPIO_P : out std_logic
  );      
end Firmware_tb;

architecture Behavioral of Firmware_tb is
  component clockManager is
  port (
    CLK_IN300  : in std_logic := '0';
    CLK_OUT40  : out std_logic := '0';
    CLK_OUT10  : out std_logic := '0';
    CLK_OUT80  : out std_logic := '0';
    CLK_OUT160 : out std_logic := '0'
  );
  end component;
  component ila is
  port (
    clk : in std_logic := '0';
    probe0 : in std_logic_vector(255 downto 0) := (others=> '0');
    probe1 : in std_logic_vector(4095 downto 0) := (others => '0')
  );
  end component;

  -- LUT constents
  constant bw_addr   : integer := 3;
  constant bw_input1 : integer := 16;
  constant bw_input2 : integer := 16;
  component lut_input1 is
  port (
    clka : in std_logic := '0';
    addra : in std_logic_vector(bw_addr-1 downto 0) := (others=> '0');
    douta : out std_logic_vector(bw_input1-1 downto 0) := (others => '0')
  );
  end component;
  component lut_input2 is
  port (
    clka : in std_logic := '0';
    addra : in std_logic_vector(bw_addr-1 downto 0) := (others=> '0');
    douta : out std_logic_vector(bw_input2-1 downto 0) := (others => '0')
  );
  end component;

  -- Clock signals
  signal clk_in_buf : std_logic := '0';
  signal sysclk : std_logic := '0';
  signal sysclkQuarter : std_logic := '0'; 
  signal sysclkDouble : std_logic := '0';
  signal sysclkQuad : std_logic := '0';
  signal intime_s: std_logic := '0';
  -- Constants
  constant bw_output : integer := 20;
  constant bw_fifo   : integer := 18;
  constant bw_count  : integer := 16;
  constant bw_wait   : integer := 9;
  constant nclksrun  : integer := 2048;
  -- Counters
  signal waitCounter  : unsigned(bw_wait-1 downto 0) := (others=> '0');
  signal inputCounter : unsigned(bw_count-1 downto 0) := (others=> '0');
  signal startCounter  : unsigned(bw_count-1 downto 0) := (others=> '0');

  -- Reset
  signal rst_global : std_logic := '0';

  -- Mimic input/output from/to the VME and discrete logic part
  signal vme_data_in      : std_logic_vector (15 downto 0) := (others => '0'); 
  signal dl_jtag_tck      : std_logic_vector (6 downto 0)  := (others => '0');
  signal dl_jtag_tms      : std_logic := '0';
  signal dl_jtag_tdi      : std_logic := '0';
  signal dl_jtag_tdo      : std_logic_vector (6 downto 0)  := (others => '0');
  signal dcfeb_initjtag   : std_logic := '0';

  -- ILA
  signal trig0 : std_logic_vector(255 downto 0) := (others=> '0');
  signal data  : std_logic_vector(4095 downto 0) := (others=> '0');
  -- LUT input
  signal lut_input_addr1_s : unsigned(bw_addr-1 downto 0) := (others=> '1');
  signal lut_input_addr2_s : unsigned(bw_addr-1 downto 0) := (others=> '1');
  signal lut_input1_dout_c : std_logic_vector(bw_input1-1 downto 0) := (others=> '0');
  signal lut_input2_dout_c : std_logic_vector(bw_input2-1 downto 0) := (others=> '0');

  signal input_dav : std_logic := '0';
  signal cmddev    : std_logic_vector(15 downto 0) := (others=> '0');
  signal nextcmd   : std_logic := '1';
  signal cack      : std_logic := 'H';
  signal cack_reg  : std_logic := 'H';

  -- Checker bit
  signal checker  : std_logic := '0';

begin

  input_clk_simulation_i : if in_simulation generate
    process
      constant clk_period_by_2 : time := 1.666 ns;
      begin
      while 1=1 loop
        clk_in_buf <= '0';
        wait for clk_period_by_2;
        clk_in_buf <= '1';
        wait for clk_period_by_2;
      end loop;
    end process;
  end generate input_clk_simulation_i;
  input_clk_synthesize_i : if in_synthesis generate
    ibufg_i : IBUFGDS
    port map (
               I => CLK_IN_P,
               IB => CLK_IN_N,
               O => clk_in_buf
             );
  end generate input_clk_synthesize_i;

  ClockManager_i : clockManager
  port map(
            CLK_IN300 => clk_in_buf,
            CLK_OUT40 => sysclk,
            CLK_OUT10 => sysclkQuarter,
            CLK_OUT80 => sysclkDouble,
            CLK_OUT160 => sysclkQuad
          );

  J36_USER_SMA_GPIO_P <= sysclk;

  i_ila : ila
  port map(
    clk => sysclkQuad,   -- to use the fastest clock here
    probe0 => trig0,
    probe1 => data
  );

  -- Input LUTs
  lut_input1_i: lut_input1
  port map(
            clka=> sysclkQuad,
            addra=> std_logic_vector(lut_input_addr1_s),
            douta=> lut_input1_dout_c
          );
  lut_input2_i: lut_input2
  port map(
            clka=> sysclkDouble,
            addra=> std_logic_vector(lut_input_addr2_s),
            douta=> lut_input2_dout_c
          );



  -- Test CFEBJTAG functionality
  -- cfebjtag is used to talk to DCFEBs through JTAG, but we don't have CFEBs
  -- communication now, so let's test the the code is giving proper behavior

  -- 0. First the block to generate counter
  startGenerator_i: process (sysclk) is
  begin

    if sysclk'event and sysclk='1' then
      startCounter <= startCounter + 1;
      -- Set the intime to 1 only after 7 clk cycles
      if startCounter = 0 then
        rst_global <= '1';
      elsif startCounter = 1 then
        rst_global <= '0';
        intime_s <= '0';
      elsif startCounter = 6 then
        dcfeb_initjtag <= '1';
      elsif startCounter = 7 then
        dcfeb_initjtag <= '0';
        intime_s <= '1';
      -- elsif startCounter >= (nclksrun+7) then
      --   intime_s <= '0';
      --   startCounter <= (others => '0');
      end if;
    end if;
  end process;

  waitGenerator_i: process (sysclk) is
  begin
    if intime_s = '0' then
      waitCounter <= (others => '0');
    else
      waitCounter <= waitCounter + 1;
      if waitCounter >= 320 then
        waitCounter <= (others => '0');
      end if;
    end if;
  end process;

  -- Read input from input1 and pass it to the fifo
  inputGenerator_i: process (sysclk) is
    variable init_input1: unsigned(bw_fifo-3 downto 0):= (others => '0');
    variable init_input2: unsigned(bw_fifo-3 downto 0):= (others => '1');
  begin

    if sysclk'event and sysclk='1' then
      if waitCounter = 0 and cack = '1' then
        nextcmd <= '1';
      else
        nextcmd <= '0';
      end if;
      if intime_s = '1' and nextcmd = '1' then
        inputCounter <= inputCounter + 1;
        -- Initalize lut_input_addr_s
        if inputCounter = 0 then
          lut_input_addr1_s <= to_unsigned(0,bw_addr);
          lut_input_addr2_s <= to_unsigned(0,bw_addr);
          cmddev <= std_logic_vector(init_input1);
          input_dav <= '0';
        else
          lut_input_addr1_s <= lut_input_addr1_s + 1;
          lut_input_addr2_s <= lut_input_addr2_s + 1;
          -- The output is PRNS { rnd |= 1; rnd ^= (rnd << (i % 11 + 1)); }
          cmddev <= lut_input1_dout_c;
          vme_data_in <= lut_input2_dout_c;
          input_dav <= '1';
        end if;
      elsif intime_s = '0' then
        inputCounter <= to_unsigned(0,bw_count);
        input_dav <= '0';
      elsif nextcmd = '0' then
        cmddev <= std_logic_vector(init_input1);
        input_dav <= '0';
      end if;
    end if;

  end process;

  -- vme_data_in(15) <= input_dav;


  -- 1. Test decoder and ILA
  --   - Signals involved:


  -- Firmware process
  firmware_i: entity work.Firmware
  port map(
    -- Clock
    CLK160         => sysclkQuad,
    CLK80          => sysclkDouble,
    CLK40          => sysclk,
    CLK10          => sysclkQuarter,
    RST            => rst_global,
    VME_DATA_IN    => vme_data_in,
    DL_JTAG_TCK    => dl_jtag_tck,
    DL_JTAG_TMS    => dl_jtag_tms,
    DL_JTAG_TDI    => dl_jtag_tdi,
    DL_JTAG_TDO    => dl_jtag_tdo,
    DCFEB_INITJTAG => dcfeb_initjtag,
    CMDDEV         => cmddev,
    CACK           => cack
    );

end Behavioral;
