Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCA331848B
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 06:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229580AbhBKFTy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 00:19:54 -0500
Received: from mail-bn8nam12on2054.outbound.protection.outlook.com ([40.107.237.54]:56385
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229544AbhBKFTu (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 00:19:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKclnsJipKqWEjUl13y3uaPpwoL7G+dF3//J/PVIaF8Dzj2GFuWrTWXGSjeFIi/GigF5ojZi5sB6qzSImH3S0FO648udbIGPJlUi5zUFns81jy4LcqOn3+LRrJ2CRPUnNB8ZuSdseEy8306zriKPHX6OBQHBCi3JeYV3pZUOGAwxbEEo2jxa1J7c5myf7lTk11F/6wIeYFg5LK4eYtT5hyR3oMqlA1QFAQG31tyQDj/DUJ+D5sDVc3d6OpcIf87zCyoc23xeYUar1WIcOxTHAFKzHF/a4HZ+4vpTyRh+ebyWa4Y56AkBDY1WBOc5JFXuavn0rG/UmZ78dip3UDEkrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+gVoX9UOal0itc7XT89rnENLF2jWd5TCPiORmwunvw=;
 b=E9OeOOeWoajgOvSbS0w20KsiVlyvpS8Ht3wBRy1jML4bTiGI9Ge43uK+jwZOqnOkx2Aoi3bnESKrbzUyRMV0Lo8ZKMiOVCZZTzMgIV/azeGZ49szXKbpgT9ZhNZk7lQdfY2sDqAyVX4Bhm8H/SPpbnQSacJ87wzImyWXBnrReufxxSCm/uR00AUXp27UQc/cwFVOJVkCCiACvrbUrKtp2RdrNAihyLew5SC1BIfVVJyxOTZ2O9t6m1JM6SmOpeHYvmT0mKFeWOd0JSvnbregbGP5ewG59uGp+jQ8M1FFAiHF6NCd51HVHoi4SmPd2t1D8gppFUoBay7q8tRCK+MSMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+gVoX9UOal0itc7XT89rnENLF2jWd5TCPiORmwunvw=;
 b=Dw5dxJ68KuJd5jfQG8nN0Gc85V6gCEQYJevTLA48wth94IrimEqDTJbiwWfKn+ZZFtF7u+L1E9oBDNgEEuRC4fIvT2LA44vd6LZ1goB3lQAaJPFPzvfBfYUIQH7GryVO3DQvCvwHSsP3Sufe10FGt6QQY9XKScCQopr21yXGVAo=
Received: from SN4PR0401CA0008.namprd04.prod.outlook.com
 (2603:10b6:803:21::18) by SN6PR02MB5311.namprd02.prod.outlook.com
 (2603:10b6:805:6a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.20; Thu, 11 Feb
 2021 05:18:55 +0000
Received: from SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:21:cafe::3b) by SN4PR0401CA0008.outlook.office365.com
 (2603:10b6:803:21::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Thu, 11 Feb 2021 05:18:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT017.mail.protection.outlook.com (10.152.72.115) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 05:18:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 21:18:36 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 21:18:36 -0800
Envelope-to: git@xilinx.com,
 michal.simek@xilinx.com,
 mdf@kernel.org,
 trix@redhat.com,
 robh+dt@kernel.org,
 linux-fpga@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=49268 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA4N9-0000QK-48; Wed, 10 Feb 2021 21:18:35 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH v2 2/2] fpga: Add support for Xilinx DFX AXI Shutdown manager
Date:   Thu, 11 Feb 2021 10:41:48 +0530
Message-ID: <20210211051148.16722-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210211051148.16722-1-nava.manne@xilinx.com>
References: <20210211051148.16722-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3bc5f199-bbbd-4993-d68a-08d8ce4c8768
X-MS-TrafficTypeDiagnostic: SN6PR02MB5311:
X-Microsoft-Antispam-PRVS: <SN6PR02MB531188C9629B3ED6D3CF8AF5C28C9@SN6PR02MB5311.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tIkuIbWISWW/KxXhjoa2FiJ5HWCFp3ODhG0I/qqMx2NAIpV/tH1JcYg/BQITkoEKxvdH+Z5poqcG9K0jBfhArtD1YvLbMJ+o9QehkkYMTJqiTq/E6Qunm6TUQmY7xzlRMShirXWX89aw2XM+IWHGrSmjBk7mEPGtuUHzDxTVpCwZ1vGNyzVFvAEEXC21jzCV8vqlL0AhbuJj6FsCHNDcK04HfX+fdMvrRuKWvP//A9id8rGaf/Q7k/1Sv55oHTFd69wHotjvEkGzEAoTQMJ+EPHSz0L8qCb9knSDucQng+Xe/ZdmA1riyw0AFtRixO+mXVRq/mj45B5zpgeXc8WRCIdmHIODwcvj9wvwX6aLmpuYlO8Ifhu4miT/3XQ2hYuBFk2odb+DedDzFZsnwTMXwNlpZH5yp5SBRDeqVz4nPrS2AWXAoomoBzO24SB5gs7VqeB6Ckp2b7Ts8NdHgqqkhzEhfnuQ24So86uYNfBzOn98HeEK2noj+H3iwwYXzsbViANwWJ1E8qjiZIXRrOtyIu2mVYEVhuV9+gdGZHJvepXj/21+i4vzMee9SyOpuO/94LZZfuPCQkc/9Fsogoyc2kzWJNfCw2P+CILf9qI0rpEf4CFyp15WUMKR48oN14a9w/sRvWOlFKnCwuYHQLD6npGeazr/KFhV16vm4kRE65GanFppqNanY30mNbO+djK9b50bJaBBCK9yc2eIxG8SSw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(39860400002)(136003)(36840700001)(46966006)(6666004)(356005)(7636003)(4326008)(9786002)(107886003)(82310400003)(47076005)(186003)(336012)(1076003)(36906005)(5660300002)(36860700001)(2906002)(82740400003)(54906003)(7696005)(26005)(36756003)(83380400001)(8676002)(110136005)(8936002)(426003)(70586007)(316002)(478600001)(70206006)(2616005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 05:18:55.6756
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bc5f199-bbbd-4993-d68a-08d8ce4c8768
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5311
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds support for Xilinx Dynamic Function eXchange(DFX) AXI
shutdown manager IP. It can be used to safely handling the AXI traffic
on a Reconfigurable Partition when it is undergoing dynamic reconfiguration
and there by preventing system deadlock that may occur if AXI transactions
are interrupted during reconfiguration.

PR-Decoupler and AXI shutdown manager are completely different IPs.
But both the IP registers are compatible and also both belong to the
same sub-system (fpga-bridge).So using same driver for both IP's.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Fixed some minor coding issues as suggested by
                 Tom Rix.

 drivers/fpga/Kconfig               |  9 +++++++-
 drivers/fpga/xilinx-pr-decoupler.c | 37 ++++++++++++++++++++++++++----
 2 files changed, 40 insertions(+), 6 deletions(-)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5645226ca3ce..bf85b9a65ec2 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -118,10 +118,17 @@ config XILINX_PR_DECOUPLER
 	depends on FPGA_BRIDGE
 	depends on HAS_IOMEM
 	help
-	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler.
+	  Say Y to enable drivers for Xilinx LogiCORE PR Decoupler
+	  or Xilinx Dynamic Function eXchnage AIX Shutdown Manager.
 	  The PR Decoupler exists in the FPGA fabric to isolate one
 	  region of the FPGA from the busses while that region is
 	  being reprogrammed during partial reconfig.
+	  The Dynamic Function eXchange AXI shutdown manager prevents
+	  AXI traffic from passing through the bridge. The controller
+	  safely handles AXI4MM and AXI4-Lite interfaces on a
+	  Reconfigurable Partition when it is undergoing dynamic
+	  reconfiguration, preventing the system deadlock that can
+	  occur if AXI transactions are interrupted by DFX.
 
 config FPGA_REGION
 	tristate "FPGA Region"
diff --git a/drivers/fpga/xilinx-pr-decoupler.c b/drivers/fpga/xilinx-pr-decoupler.c
index 7d69af230567..78a6f5324193 100644
--- a/drivers/fpga/xilinx-pr-decoupler.c
+++ b/drivers/fpga/xilinx-pr-decoupler.c
@@ -1,7 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
  * Copyright (c) 2017, National Instruments Corp.
- * Copyright (c) 2017, Xilix Inc
+ * Copyright (c) 2017, Xilinx Inc
  *
  * FPGA Bridge Driver for the Xilinx LogiCORE Partial Reconfiguration
  * Decoupler IP Core.
@@ -18,7 +18,12 @@
 #define CTRL_CMD_COUPLE		0
 #define CTRL_OFFSET		0
 
+struct xlnx_config_data {
+	const char *name;
+};
+
 struct xlnx_pr_decoupler_data {
+	const struct xlnx_config_data *ipconfig;
 	void __iomem *io_base;
 	struct clk *clk;
 };
@@ -76,15 +81,28 @@ static const struct fpga_bridge_ops xlnx_pr_decoupler_br_ops = {
 	.enable_show = xlnx_pr_decoupler_enable_show,
 };
 
+static const struct xlnx_config_data decoupler_config = {
+	.name = "Xilinx PR Decoupler",
+};
+
+static const struct xlnx_config_data shutdown_config = {
+	.name = "Xilinx DFX AXI Shutdown Manager",
+};
+
 static const struct of_device_id xlnx_pr_decoupler_of_match[] = {
-	{ .compatible = "xlnx,pr-decoupler-1.00", },
-	{ .compatible = "xlnx,pr-decoupler", },
+	{ .compatible = "xlnx,pr-decoupler-1.00", .data = &decoupler_config },
+	{ .compatible = "xlnx,pr-decoupler", .data = &decoupler_config },
+	{ .compatible = "xlnx,dfx-axi-shutdown-manager-1.00",
+					.data = &shutdown_config },
+	{ .compatible = "xlnx,dfx-axi-shutdown-manager",
+					.data = &shutdown_config },
 	{},
 };
 MODULE_DEVICE_TABLE(of, xlnx_pr_decoupler_of_match);
 
 static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 {
+	struct device_node *np = pdev->dev.of_node;
 	struct xlnx_pr_decoupler_data *priv;
 	struct fpga_bridge *br;
 	int err;
@@ -94,6 +112,14 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
+	if (np) {
+		const struct of_device_id *match;
+
+		match = of_match_node(xlnx_pr_decoupler_of_match, np);
+		if (match && match->data)
+			priv->ipconfig = match->data;
+	}
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	priv->io_base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(priv->io_base))
@@ -114,7 +140,7 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	clk_disable(priv->clk);
 
-	br = devm_fpga_bridge_create(&pdev->dev, "Xilinx PR Decoupler",
+	br = devm_fpga_bridge_create(&pdev->dev, priv->ipconfig->name,
 				     &xlnx_pr_decoupler_br_ops, priv);
 	if (!br) {
 		err = -ENOMEM;
@@ -125,7 +151,8 @@ static int xlnx_pr_decoupler_probe(struct platform_device *pdev)
 
 	err = fpga_bridge_register(br);
 	if (err) {
-		dev_err(&pdev->dev, "unable to register Xilinx PR Decoupler");
+		dev_err(&pdev->dev, "unable to register %s",
+			priv->ipconfig->name);
 		goto err_clk;
 	}
 
-- 
2.18.0

