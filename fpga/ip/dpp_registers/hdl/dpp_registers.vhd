library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity dpp_registers is
	generic (
		-- Users to add parameters here

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 8
	);
	port (
		-- Users to add ports here
        r1_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r2_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r3_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r4_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r5_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r6_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r7_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r8_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r9_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r10_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r11_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r12_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r13_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r14_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r15_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r16_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r17_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r18_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r19_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r20_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r21_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r22_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r23_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r24_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r25_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r26_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r27_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r28_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r29_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r30_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r31_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r32_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r33_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r34_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r35_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r36_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r37_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r38_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r39_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r40_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r41_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r42_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r43_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r44_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r45_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r46_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r47_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r48_in : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r49_in : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r50_in : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r51_in : in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r52_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r53_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end dpp_registers;

architecture arch_imp of dpp_registers is

	-- component declaration
	component dpp_registers_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 8
		);
		port (
		r1_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r2_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r3_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r4_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r5_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r6_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r7_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r8_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r9_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

        r10_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r11_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r12_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r13_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r14_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r15_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r16_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r17_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r18_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r19_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

        r20_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r21_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r22_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r23_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r24_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r25_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r26_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r27_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r28_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r29_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

        r30_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r31_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r32_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r33_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r34_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r35_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r36_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r37_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r38_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r39_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

        r40_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r41_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r42_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r43_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r44_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r45_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r46_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r47_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);

        r48_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        r49_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        r50_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
        r51_in : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);  
        r52_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        r53_out : out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
        
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic
		);
	end component dpp_registers_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
dpp_registers_S00_AXI_inst : dpp_registers_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH
	)
	port map (
        r1_out => r1_out,
        r2_out => r2_out,
        r3_out => r3_out,
        r4_out => r4_out,
        r5_out => r5_out,
        r6_out => r6_out,
        r7_out => r7_out,
        r8_out => r8_out,
        r9_out => r9_out,                      
        r10_out => r10_out,
        r11_out => r11_out,
        r12_out => r12_out,
        r13_out => r13_out,
        r14_out => r14_out,
        r15_out => r15_out,
        r16_out => r16_out,
        r17_out => r17_out,
        r18_out => r18_out,
        r19_out => r19_out,                  
        r20_out => r20_out,
        r21_out => r21_out,
        r22_out => r22_out,
        r23_out => r23_out,
        r24_out => r24_out,
        r25_out => r25_out,
        r26_out => r26_out,
        r27_out => r27_out,
        r28_out => r28_out,
        r29_out => r29_out,                  
        r30_out => r30_out,
        r31_out => r31_out,
        r32_out => r32_out,
        r33_out => r33_out,
        r34_out => r34_out,
        r35_out => r35_out,
        r36_out => r36_out,
        r37_out => r37_out,
        r38_out => r38_out,
        r39_out => r39_out,               
        r40_out => r40_out,
        r41_out => r41_out,
        r42_out => r42_out,
        r43_out => r43_out,
        r44_out => r44_out,
        r45_out => r45_out,
        r46_out => r46_out,
        r47_out => r47_out,	
        r48_in => r48_in,
        r49_in => r49_in,
        r50_in => r50_in,
        r51_in => r51_in,
        r52_out => r52_out,	
        r53_out => r53_out,	
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
