Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94A59F245
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Aug 2022 05:58:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234630AbiHXD4k (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 23 Aug 2022 23:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234619AbiHXD4c (ORCPT
        <rfc822;linux-fpga@vger.kernel.org>); Tue, 23 Aug 2022 23:56:32 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4095F46;
        Tue, 23 Aug 2022 20:56:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PT72xCOOWCvOaJBxtnPD9wI+qqWQ2/H2YDkgStrZ/09L0Xyvs+tJaIgIl42eyanCwloGur90jlhDPd98EAFjoVDKEE+QRg7TnyrisOh6gMiUCmKd8RFMF1foB6OZuw816F9TslBEYsO3TB2EiOJzWZWYtO0rtF7VbR/LoyFSPgJtedVteUfZvS2Vrcyuv5S0EXMDoX3cPfTC8N0wOUcXYz3Wh/o+OTnEqUdZj8hwAQ+dpa+v558grTn5gcmH+z4P9HW+PnpUFrtN8slFzGuO5dLjGpUxboDOuSBbMAVxJ0Ai2m3U7UBUwxAGTMtFp3Fj9QHB+InR8kGRenP4Pk/pZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50krMVAoNvmdYZe8/b0rI1i7TXmLbiF8l14QS1W0N20=;
 b=Zqawkf61f4c9+/UaU1iHGBEqkZIaS8WprOA40m9StOGwpKOf3No9C9dcbQ2RzoWeiM0XQbKrxamLBQ4tW8lioVa3qcrrzdYw8/QUve7SGU/PmS9xxa85gciAWQ5V0B+okmPLhFWxX9cRJMOe33HUc7npo2OlHzB5PdIkGu5uZlO5DeNcrEnyiWsVU/rf1ypkBf+rlWkLhohLpIul46MhQn11gBbLRp3rjlab3bNJdpeQ7weZPsG+amtGVEz6HAqo6ieg10yaKEhuykTTybxrQoE94+C4KMB7L7+/i2PgqR+rHc/58WGPkOxv911R8NOfFLe8p4Ni5/3VyaT12XcVtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50krMVAoNvmdYZe8/b0rI1i7TXmLbiF8l14QS1W0N20=;
 b=H2MsFuIuiy33tWYF5eVGLSssBu3xSVPLRt0Lt0ivLZMa7MWLm39RqrYF+a7kbQ6P5NBvjTr62eOCRSc+K9AFF6rTWGv9ib5O5lpFGOog6wkvVchdQxyAGbuigNZKMIrgizXTi/+TdeHqB4lkx03fdeXkVOBytJHOfhrTd1a0PPg=
Received: from MW4PR03CA0323.namprd03.prod.outlook.com (2603:10b6:303:dd::28)
 by BN8PR12MB2929.namprd12.prod.outlook.com (2603:10b6:408:9c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 03:56:07 +0000
Received: from CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::44) by MW4PR03CA0323.outlook.office365.com
 (2603:10b6:303:dd::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14 via Frontend
 Transport; Wed, 24 Aug 2022 03:56:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT036.mail.protection.outlook.com (10.13.174.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 03:56:06 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:56:03 -0500
From:   Nava kishore Manne <nava.kishore.manne@amd.com>
To:     <git@amd.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <nava.kishore.manne@amd.com>, <mdf@kernel.org>, <hao.wu@intel.com>,
        <yilun.xu@intel.com>, <trix@redhat.com>, <p.zabel@pengutronix.de>,
        <gregkh@linuxfoundation.org>, <ronak.jain@xilinx.com>,
        <rajan.vaja@xilinx.com>, <abhyuday.godhasara@xilinx.com>,
        <piyush.mehta@xilinx.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <harsha.harsha@xilinx.com>, <linus.walleij@linaro.org>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>
Subject: [PATCH 4/4] fpga: zynqmp: Add afi config driver
Date:   Wed, 24 Aug 2022 09:25:42 +0530
Message-ID: <20220824035542.706433-5-nava.kishore.manne@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220824035542.706433-1-nava.kishore.manne@amd.com>
References: <20220824035542.706433-1-nava.kishore.manne@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38fdf123-9646-47d4-599c-08da8584929f
X-MS-TrafficTypeDiagnostic: BN8PR12MB2929:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jME4pI3QLUwMZHI9b2B9ToZWjI1gBt4aIMHJ45qOBPlUJ8xAXiAAct06AVfD4Ba/cCQ1KLpVKpy4PEKmTIBx9et1LU3AHz+r+KRLp1vEMPfzqPakT02BfyRUFFmnyDSdLdUEsPLIqSfI+ahHWWHKQ7FPBh8h9Lm1e9rdMl4v5FZhn1k0WtaUd07JgYuhoj7Sm4TElHKFPFAB1+PsEDd6VAFhXU7BmUQDPXasbVKULeVhZwd5ybo6cp465M1WslqTnMjjyfLEiW0vWu4efsGt5OCAKDju7jVb3yeRSNHYgy7AIiClhVgn2aELwb7fCJH6h90S+cZVOBrrJj6f1qQAWvlKAGSBgWmTRd8+q9cJxvwoA7znIehkQDSV2G0okXRDZSHFgZlN2Ibk85REW5xDCIm461eGgBJ66WBY56PJMJ8r2X55JM3YxjsfnZ6+ITqnkXC0+ZQTCWCLw86EEF+CmBYBF8CgPrkw66Pggg60yqWDG93cQDbtlHPWV/kN5FBOKI3xtm8EdT9eKqIO4dppxp6eDWSjIo3tvRYFV/oKmmE7M94a5PRjm64UbJcb0Dn8+V7Bgquj9t+Wf3SAHUEWCSz5RglsxwvwKHhDNGr+vO59sswgz7nYPjKPw9Isb/wTDBLDWZ2MC6U4r61VU+14UC2inbaGGkEo6IbBbj9gsXznauY1dovYcMzPSkxLFtu1kM7qo/qUCY5VtksM0ZeGRtqbDFgmp6CBZ8p7pIIpCeNGbnhaAXV5DVH1F9NwKz0m0P+uku9PQjYuDF9aDoJPdKYLoEeTthP8GImEoxDPUsitIGZyiBZ5UI7ItYXTtDJUsx93RFkHnoe08ekq/Mv4pQIn8vL+NF2wXuEMZfY4PDFYth8LEQgy0bYTyUk8CCq9
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966006)(36840700001)(40470700004)(6666004)(81166007)(82740400003)(478600001)(40480700001)(356005)(921005)(2906002)(82310400005)(16526019)(103116003)(5660300002)(2616005)(7416002)(70586007)(316002)(26005)(8676002)(70206006)(41300700001)(83380400001)(186003)(1076003)(36756003)(336012)(86362001)(8936002)(40460700003)(36860700001)(110136005)(426003)(47076005)(2101003)(83996005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 03:56:06.6565
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fdf123-9646-47d4-599c-08da8584929f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2929
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add zynqmp AXI FIFO interface(AFI) config driver. This is useful for the
configuration of the PS-PL interface on Zynq US+ MPSoC platform.

Signed-off-by: Nava kishore Manne <nava.kishore.manne@amd.com>
---
 MAINTAINERS               |   6 ++
 drivers/fpga/Kconfig      |  13 +++
 drivers/fpga/Makefile     |   1 +
 drivers/fpga/zynqmp-afi.c | 211 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 231 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-afi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 20ffac651214..957e753e6406 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8032,6 +8032,12 @@ F:	Documentation/fpga/
 F:	drivers/fpga/
 F:	include/linux/fpga/
 
+FPGA ZYNQMP PS-PL BRIDGE DRIVER
+M:	Nava kishore Manne <nava.kishore.manne@amd.com>
+S:	Supported
+F:	Documentation/devicetree/bindings/fpga/xlnx,zynqmp-afi-fpga.yaml
+F:	drivers/fpga/zynqmp-afi.c
+
 INTEL MAX10 BMC SECURE UPDATES
 M:	Russ Weight <russell.h.weight@intel.com>
 L:	linux-fpga@vger.kernel.org
diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 6c416955da53..c08794d30fb5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -130,6 +130,19 @@ config XILINX_PR_DECOUPLER
 	  reconfiguration, preventing the system deadlock that can
 	  occur if AXI transactions are interrupted by DFX.
 
+config ZYNQMP_AFI
+	tristate "Xilinx ZYNQMP AFI support"
+	depends on FPGA_BRIDGE
+	help
+	  Say Y to enable drivers to handle the PS-PL clocks configurations
+	  and PS-PL Bus-width. Xilinx Zynq US+ MPSoC connect the PS to the
+	  programmable logic (PL) through the AXI port. This AXI port helps
+	  to establish the data path between the PS and PL.
+	  In-order to establish the proper communication path between PS and PL,
+	  the AXI port data path should be configured with the proper Bus-width
+	  values and it will also handles the PS-PL reset signals to reset the
+	  PL domain.
+
 config FPGA_REGION
 	tristate "FPGA Region"
 	depends on FPGA_BRIDGE
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 42ae8b58abce..94cfe60972db 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -31,6 +31,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
 obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
+obj-$(CONFIG_ZYNQMP_AFI)		+= zynqmp-afi.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
diff --git a/drivers/fpga/zynqmp-afi.c b/drivers/fpga/zynqmp-afi.c
new file mode 100644
index 000000000000..bc975d304039
--- /dev/null
+++ b/drivers/fpga/zynqmp-afi.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Xilinx, Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+#include <linux/fpga/fpga-bridge.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/reset.h>
+#include <linux/slab.h>
+
+/* Registers and special values for doing register-based operations */
+#define AFI_RDCHAN_CTRL_OFFSET	0x00
+#define AFI_WRCHAN_CTRL_OFFSET	0x14
+#define AFI_BUSWIDTH_MASK	BIT(0)
+
+/**
+ * struct zynqmp_afi - AFI register description.
+ * @dev: device that owns this.
+ * @of_node: Device Tree overlay.
+ * @resets: Pointer to the reset control for ps-pl resets.
+ */
+struct zynqmp_afi {
+	struct device *dev;
+	struct device_node *of_node;
+	struct reset_control *resets;
+};
+
+/**
+ * struct zynqmp_afi_configreg - AFI configuration registers info.
+ * @reg:	Name of the AFI configuration register.
+ * @id:		Register index value.
+ */
+struct zynqmp_afi_configreg {
+	char *reg;
+	u32 id;
+};
+
+static struct zynqmp_afi_configreg afi_cfgreg[] = {
+	{.reg = "xlnx,afi-fm0-rd-bus-width",	.id = AFIFM0_RDCTRL},
+	{.reg = "xlnx,afi-fm1-rd-bus-width",	.id = AFIFM1_RDCTRL},
+	{.reg = "xlnx,afi-fm2-rd-bus-width",	.id = AFIFM2_RDCTRL},
+	{.reg = "xlnx,afi-fm3-rd-bus-width",	.id = AFIFM3_RDCTRL},
+	{.reg = "xlnx,afi-fm4-rd-bus-width",	.id = AFIFM4_RDCTRL},
+	{.reg = "xlnx,afi-fm5-rd-bus-width",	.id = AFIFM5_RDCTRL},
+	{.reg = "xlnx,afi-fm6-rd-bus-width",	.id = AFIFM6_RDCTRL},
+	{.reg = "xlnx,afi-fm0-wr-bus-width",	.id = AFIFM0_WRCTRL},
+	{.reg = "xlnx,afi-fm1-wr-bus-width",	.id = AFIFM1_WRCTRL},
+	{.reg = "xlnx,afi-fm2-wr-bus-width",	.id = AFIFM2_WRCTRL},
+	{.reg = "xlnx,afi-fm3-wr-bus-width",	.id = AFIFM3_WRCTRL},
+	{.reg = "xlnx,afi-fm4-wr-bus-width",	.id = AFIFM4_WRCTRL},
+	{.reg = "xlnx,afi-fm5-wr-bus-width",	.id = AFIFM5_WRCTRL},
+	{.reg = "xlnx,afi-fm6-wr-bus-width",	.id = AFIFM6_WRCTRL},
+	{.reg = "xlnx,afi-fs-ss0-bus-width",	.id = AFIFS},
+	{.reg = "xlnx,afi-fs-ss2-bus-width",	.id = AFIFS_SS2},
+	{}
+};
+
+static int zynqmp_afi_config(struct zynqmp_afi *afi_data)
+{
+	struct zynqmp_afi_configreg *cfgptr = afi_cfgreg;
+	struct device_node *np = afi_data->of_node;
+	u32 afi_ss0_val, afi_ss1_val, bus_width;
+	int ret;
+
+	while (cfgptr->reg) {
+		ret = of_property_read_u32(np, cfgptr->reg, &bus_width);
+		if (!ret) {
+			if (cfgptr->id == AFIFS_SS2) {
+				if (bus_width == 32)
+					ret = zynqmp_pm_afi(AFIFS_SS2,
+							    AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL);
+				else if (bus_width == 64)
+					ret = zynqmp_pm_afi(AFIFS_SS2,
+							    AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL);
+				else if (bus_width == 128)
+					ret = zynqmp_pm_afi(AFIFS_SS2,
+							    AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL);
+				else
+					return -EINVAL;
+			} else if (cfgptr->id == AFIFS) {
+				if (bus_width == 32)
+					afi_ss0_val = AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
+				else if (bus_width == 64)
+					afi_ss0_val = AFIFS_SS0_SS2_BUS_WIDTH_64_CONFIG_VAL;
+				else if (bus_width == 128)
+					afi_ss0_val = AFIFS_SS0_SS2_BUS_WIDTH_128_CONFIG_VAL;
+				else
+					return -EINVAL;
+
+				ret = of_property_read_u32(np, "xlnx,afi-fs-ss1-bus-width",
+							   &bus_width);
+				if (!ret) {
+					if (bus_width == 32)
+						afi_ss1_val = AFIFS_SS_BUS_WIDTH_32_CONFIG_VAL;
+					else if (bus_width == 64)
+						afi_ss1_val = AFIFS_SS1_BUS_WIDTH_64_CONFIG_VAL;
+					else if (bus_width == 128)
+						afi_ss1_val = AFIFS_SS1_BUS_WIDTH_128_CONFIG_VAL;
+					else
+						return -EINVAL;
+
+					ret = zynqmp_pm_afi(AFIFS, afi_ss1_val | afi_ss0_val);
+				}
+			} else {
+				if (bus_width == 32)
+					ret = zynqmp_pm_afi(cfgptr->id,
+							    AFIFM_BUS_WIDTH_32_CONFIG_VAL);
+				else if (bus_width == 64)
+					ret = zynqmp_pm_afi(cfgptr->id,
+							    AFIFM_BUS_WIDTH_64_CONFIG_VAL);
+				else if (bus_width == 128)
+					ret = zynqmp_pm_afi(cfgptr->id,
+							    AFIFM_BUS_WIDTH_128_CONFIG_VAL);
+				else
+					return -EINVAL;
+			}
+		}
+		cfgptr++;
+	}
+
+	return 0;
+}
+
+static int zynqmp_afi_enable_set(struct fpga_bridge *bridge, bool enable)
+{
+	struct device_node *overlay = bridge->info->overlay;
+	struct zynqmp_afi *priv = bridge->priv;
+	int ret = 0;
+
+	if (enable) {
+		reset_control_reset(priv->resets);
+		return 0;
+	}
+
+	of_node_get(overlay);
+	priv->of_node =
+	of_find_node_with_property(overlay,
+				   "xlnx,afi-fm0-rd-bus-width");
+	if (priv->of_node)
+		ret = zynqmp_afi_config(priv);
+	of_node_put(priv->of_node);
+
+	return ret;
+}
+
+static const struct fpga_bridge_ops zynqmp_afi_br_ops = {
+	.enable_set = zynqmp_afi_enable_set,
+};
+
+static const struct of_device_id zynqmp_afi_of_match[] = {
+	{ .compatible =  "xlnx,zynqmp-afi-fpga" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zynqmp_afi_of_match);
+
+static int zynqmp_afi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_afi *priv;
+	struct fpga_bridge *br;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+
+	priv->resets = devm_reset_control_array_get_optional_exclusive(&pdev->dev);
+	if (IS_ERR(priv->resets))
+		return PTR_ERR(priv->resets);
+
+	br = fpga_bridge_register(dev, "Xilinx ZynqMP AFI",
+				  &zynqmp_afi_br_ops, priv);
+	if (IS_ERR(br)) {
+		dev_err(dev, "unable to register Xilinx ZynqMP AFI");
+		return PTR_ERR(br);
+	}
+
+	platform_set_drvdata(pdev, br);
+
+	return 0;
+}
+
+static int zynqmp_afi_remove(struct platform_device *pdev)
+{
+	struct fpga_bridge *bridge = platform_get_drvdata(pdev);
+
+	fpga_bridge_unregister(bridge);
+
+	return 0;
+}
+
+static struct platform_driver zynqmp_afi_driver = {
+	.probe = zynqmp_afi_probe,
+	.remove = zynqmp_afi_remove,
+	.driver = {
+		.name = "zynqmp_afi",
+		.of_match_table = of_match_ptr(zynqmp_afi_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_afi_driver);
+
+MODULE_DESCRIPTION("ZYNQMP FPGA AXI FIFO interface configuration module");
+MODULE_AUTHOR("Nava kishore Manne <nava.kishore.manne@amd.com>");
+MODULE_LICENSE("GPL");
-- 
2.25.1

