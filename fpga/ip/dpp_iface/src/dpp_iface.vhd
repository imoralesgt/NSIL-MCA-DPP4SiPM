library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dpp_iface is
    port (
        -- AXI Lite Domain (Fast Clock)
        s_axi_aclk      : in  std_logic;
        s_axi_aresetn   : in  std_logic;
        s_axi_awaddr    : in  std_logic_vector(31 downto 0);
        s_axi_awvalid   : in  std_logic;
        s_axi_awready   : out std_logic;
        s_axi_wdata     : in  std_logic_vector(31 downto 0);
        s_axi_wvalid    : in  std_logic;
        s_axi_wready    : out std_logic;
        s_axi_bresp     : out std_logic_vector(1 downto 0);
        s_axi_bvalid    : out std_logic;
        s_axi_bready    : in  std_logic;
        s_axi_araddr    : in  std_logic_vector(31 downto 0);
        s_axi_arvalid   : in  std_logic;
        s_axi_arready   : out std_logic;
        s_axi_rdata     : out std_logic_vector(31 downto 0);
        s_axi_rresp     : out std_logic_vector(1 downto 0);
        s_axi_rvalid    : out std_logic;
        s_axi_rready    : in  std_logic;

        -- DPP Domain (Slow Clock)
        clk_dpp         : in  std_logic;

        -- Output Ports (Hardware Port N = Internal Register N-1)
        reg_out_1,  reg_out_2,  reg_out_3,  reg_out_4,  reg_out_5,  reg_out_6,  reg_out_7, 
        reg_out_8,  reg_out_9,  reg_out_10, reg_out_11, reg_out_12, reg_out_13, reg_out_14, 
        reg_out_15, reg_out_16, reg_out_17, reg_out_18, reg_out_19, reg_out_20, reg_out_21, 
        reg_out_22, reg_out_23, reg_out_24, reg_out_25, reg_out_26, reg_out_27, reg_out_28, 
        reg_out_29, reg_out_30, reg_out_31, reg_out_32, reg_out_33, reg_out_34, reg_out_35, 
        reg_out_36, reg_out_37, reg_out_38, reg_out_39, reg_out_40, reg_out_41, reg_out_42, 
        reg_out_43, reg_out_44, reg_out_45, reg_out_46, reg_out_47,
        reg_out_52, reg_out_53, reg_out_54, reg_out_55, reg_out_56, reg_out_57, reg_out_58, 
        reg_out_59, reg_out_60, reg_out_61, reg_out_62, reg_out_63, reg_out_64 : out std_logic_vector(31 downto 0);
        
        -- Input Ports (Port 48 maps to internal index 47)
        reg_in_48, reg_in_49, reg_in_50, reg_in_51 : in std_logic_vector(31 downto 0)
    );
end entity;

architecture rtl of dpp_iface is
    -- Attribute for Vivado Synchronizer placement
    attribute ASYNC_REG : string;

    -- Internal Storage (0-63 logic for 6-bit efficiency)
    type t_reg_storage is array (0 to 63) of std_logic_vector(31 downto 0);
    signal dpp_regs : t_reg_storage := (others => (others => '0'));

    -- CDC Chains (3-stage for toggle detection)
    signal axi_req_toggle, ack_toggle_dpp : std_logic := '0';
    signal ack_sync_axi, req_sync_dpp      : std_logic_vector(2 downto 0) := "000";
    attribute ASYNC_REG of ack_sync_axi, req_sync_dpp : signal is "TRUE";

    -- Handshake Buffers
    signal addr_axi : integer range 0 to 63;
    signal wdata_dpp, rdata_dpp : std_logic_vector(31 downto 0);
    signal write_dpp : std_logic;

    -- AXI Internal Mirror Signals
    signal awready_i, wready_i, bvalid_i, arready_i, rvalid_i : std_logic := '0';

begin
    -- Physical Port Mapping
    reg_out_1  <= dpp_regs(0);  reg_out_2  <= dpp_regs(1);  reg_out_3  <= dpp_regs(2);
    reg_out_4  <= dpp_regs(3);  reg_out_5  <= dpp_regs(4);  reg_out_6  <= dpp_regs(5);
    reg_out_7  <= dpp_regs(6);  reg_out_8  <= dpp_regs(7);  reg_out_9  <= dpp_regs(8);
    reg_out_10 <= dpp_regs(9);  reg_out_11 <= dpp_regs(10); reg_out_12 <= dpp_regs(11);
    reg_out_13 <= dpp_regs(12); reg_out_14 <= dpp_regs(13); reg_out_15 <= dpp_regs(14);
    reg_out_16 <= dpp_regs(15); reg_out_17 <= dpp_regs(16); reg_out_18 <= dpp_regs(17);
    reg_out_19 <= dpp_regs(18); reg_out_20 <= dpp_regs(19); reg_out_21 <= dpp_regs(20);
    reg_out_22 <= dpp_regs(21); reg_out_23 <= dpp_regs(22); reg_out_24 <= dpp_regs(23);
    reg_out_25 <= dpp_regs(24); reg_out_26 <= dpp_regs(25); reg_out_27 <= dpp_regs(26);
    reg_out_28 <= dpp_regs(27); reg_out_29 <= dpp_regs(28); reg_out_30 <= dpp_regs(29);
    reg_out_31 <= dpp_regs(30); reg_out_32 <= dpp_regs(31); reg_out_33 <= dpp_regs(32);
    reg_out_34 <= dpp_regs(33); reg_out_35 <= dpp_regs(34); reg_out_36 <= dpp_regs(35);
    reg_out_37 <= dpp_regs(36); reg_out_38 <= dpp_regs(37); reg_out_39 <= dpp_regs(38);
    reg_out_40 <= dpp_regs(39); reg_out_41 <= dpp_regs(40); reg_out_42 <= dpp_regs(41);
    reg_out_43 <= dpp_regs(42); reg_out_44 <= dpp_regs(43); reg_out_45 <= dpp_regs(44);
    reg_out_46 <= dpp_regs(45); reg_out_47 <= dpp_regs(46);
    
    reg_out_52 <= dpp_regs(51); reg_out_53 <= dpp_regs(52); reg_out_54 <= dpp_regs(53);
    reg_out_55 <= dpp_regs(54); reg_out_56 <= dpp_regs(55); reg_out_57 <= dpp_regs(56);
    reg_out_58 <= dpp_regs(57); reg_out_59 <= dpp_regs(58); reg_out_60 <= dpp_regs(59);
    reg_out_61 <= dpp_regs(60); reg_out_62 <= dpp_regs(61); reg_out_63 <= dpp_regs(62);
    reg_out_64 <= dpp_regs(63);

    -- Drive AXI Outputs
    s_axi_awready <= awready_i; s_axi_wready <= wready_i; s_axi_bvalid <= bvalid_i;
    s_axi_arready <= arready_i; s_axi_rvalid <= rvalid_i;
    s_axi_bresp <= "00"; s_axi_rresp <= "00";

    -- CDC Synchronizers
    process(s_axi_aclk) begin
        if rising_edge(s_axi_aclk) then ack_sync_axi <= ack_sync_axi(1 downto 0) & ack_toggle_dpp; end if;
    end process;

    process(clk_dpp) begin
        if rising_edge(clk_dpp) then req_sync_dpp <= req_sync_dpp(1 downto 0) & axi_req_toggle; end if;
    end process;

    -- AXI Interface Logic
    process(s_axi_aclk) begin
        if rising_edge(s_axi_aclk) then
            if s_axi_aresetn = '0' then
                awready_i <= '0'; wready_i <= '0'; bvalid_i <= '0'; arready_i <= '1'; rvalid_i <= '0';
                axi_req_toggle <= '0';
            else
                -- Write Handshake
                if (s_axi_awvalid = '1' and s_axi_wvalid = '1' and awready_i = '0') then
                    addr_axi    <= to_integer(unsigned(s_axi_awaddr(7 downto 2)));
                    wdata_dpp   <= s_axi_wdata; 
                    write_dpp   <= '1'; 
                    axi_req_toggle <= not axi_req_toggle;
                    awready_i   <= '1'; wready_i <= '1';
                elsif (ack_sync_axi(2) /= ack_sync_axi(1) and write_dpp = '1') then
                    awready_i <= '0'; wready_i <= '0'; bvalid_i <= '1';
                end if;
                if bvalid_i = '1' and s_axi_bready = '1' then bvalid_i <= '0'; end if;

                -- Read Handshake
                if (s_axi_arvalid = '1' and arready_i = '1') then
                    addr_axi  <= to_integer(unsigned(s_axi_araddr(7 downto 2)));
                    write_dpp <= '0'; 
                    axi_req_toggle <= not axi_req_toggle; 
                    arready_i <= '0';
                elsif (ack_sync_axi(2) /= ack_sync_axi(1) and write_dpp = '0') then
                    s_axi_rdata <= rdata_dpp; rvalid_i <= '1';
                end if;
                if rvalid_i = '1' and s_axi_rready = '1' then rvalid_i <= '0'; arready_i <= '1'; end if;
            end if;
        end if;
    end process;

    -- DPP Side Logic (CDC Execution)
    process(clk_dpp) begin
        if rising_edge(clk_dpp) then
            if (req_sync_dpp(2) /= req_sync_dpp(1)) then
                if write_dpp = '1' then
                    -- CPU Write (Allow only outside read-only range)
                    if (addr_axi <= 46) or (addr_axi >= 51) then
                        dpp_regs(addr_axi) <= wdata_dpp;
                    end if;
                else
                    -- CPU Read
                    case addr_axi is
                        when 47 => rdata_dpp <= reg_in_48; 
                        when 48 => rdata_dpp <= reg_in_49;
                        when 49 => rdata_dpp <= reg_in_50; 
                        when 50 => rdata_dpp <= reg_in_51;
                        when others => rdata_dpp <= dpp_regs(addr_axi);
                    end case;
                end if;
                ack_toggle_dpp <= not ack_toggle_dpp;
            end if;
        end if;
    end process;
end architecture;