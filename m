Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14A9F1A9A94
	for <lists+linux-fpga@lfdr.de>; Wed, 15 Apr 2020 12:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408665AbgDOKco (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 15 Apr 2020 06:32:44 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:43489
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2408583AbgDOKZK (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 15 Apr 2020 06:25:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krd1CZzv2Kd7/yscMhz5bcjV5HDCPsONa9c7hvDHAHpozJqyovrVUFbglvpZ4NvI3vhbq4uOHLFDf5ES7uYhT6LONcwGp4oqpOzIO9RgESR3tGX3cUZs2RZN77ZyTS79JOb1hE6EluyMM3VOWBLfRG5zXlfPjRbeT0UZi39fqN55eiIFeCucFdBQNjTscsuWcLEwIzCyOrTQSYOjXqof608Y2OKl6hRugvY5HMvRYCaWLd0Tm48ul3rxRKcGrxmEJLLY204tQ/fAZMaNWxQ4k6bn0wnoTsUrY7KVE86PI1k/c9koB/GThFKFcKvtb5TBJVvhJhH1CChCGDzeGawrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixkfw4DV3l9ZzMixhU2bxIK8xqCuA2/DGCS5yAeFeYo=;
 b=SzMIW7hgeSpEhYdvPWWfW8TK1fO1W5Zdkaqlr1nu/99eNFKdv2GTvvEJ9Ecvddnno+IOy97bTrBlhINDwYiWULy0rW/OPiyNHfyIkeCbsrU3oJrw5m1oBo24fv8X3ouGy85KXOYkwXRsZx6/qxTi/yraZ30RVqkK7NNHHKbt+eM1HP0Ai24enn4inUVoGqmHkpiEEq7YZtHj59qUzf0jIazDhKQCO7CovjS/rK5LQou3CCEgpUc8iDYNXDwbKGGkcp9T2X4K9F9HiIprZdi6Dl4VNvY+08fR/dgtlMkEJXy/bAam0eWnc9cqg6lUNwm2gcOjc5UtHV6PkmdZSLP80g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.60.83) smtp.rcpttodomain=gmail.com smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ixkfw4DV3l9ZzMixhU2bxIK8xqCuA2/DGCS5yAeFeYo=;
 b=prSZA1vIyCBUwr5Hu8YjJ3lmazRjK8RYkFl/kc5eDWcbL9GQ7n1uNwK5/zklKDkVQm7TdedirjeHp88Vtvx4KZ/Sy24sF0tMZHa108UXtH5oPEPPBYKY15NTiz5dkquMbcnL3Nvs9zn2kxo19D9m3II1DEN4QeQcHj6pWF9DQS8=
Received: from CY4PR01CA0019.prod.exchangelabs.com (2603:10b6:903:1f::29) by
 SN6PR02MB4702.namprd02.prod.outlook.com (2603:10b6:805:9c::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2900.26; Wed, 15 Apr 2020 10:25:03 +0000
Received: from CY1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:903:1f:cafe::40) by CY4PR01CA0019.outlook.office365.com
 (2603:10b6:903:1f::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Wed, 15 Apr 2020 10:25:03 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT064.mail.protection.outlook.com (10.152.74.64) with Microsoft SMTP
 Server id 15.20.2900.15 via Frontend Transport; Wed, 15 Apr 2020 10:25:02
 +0000
Received: from [149.199.38.66] (port=57913 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1jOfDP-0002oq-Or; Wed, 15 Apr 2020 03:24:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1jOfE6-0000Qx-Hq; Wed, 15 Apr 2020 03:25:02 -0700
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id 03FAP0s6018322;
        Wed, 15 Apr 2020 03:25:00 -0700
Received: from [10.140.6.6] (helo=xhdappanad40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1jOfE3-0000Kb-Sa; Wed, 15 Apr 2020 03:25:00 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     mdf@kernel.org, michal.simek@xilinx.com,
        linux-fpga@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, chinnikishore369@gmail.com
Cc:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [PATCH 2/2] fpga: zynq: Add AFI config driver
Date:   Wed, 15 Apr 2020 15:54:50 +0530
Message-Id: <1586946290-7280-2-git-send-email-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
References: <1586946290-7280-1-git-send-email-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapsmtpgw01;PTR:unknown-60-83.xilinx.com;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(136003)(346002)(39860400002)(396003)(46966005)(7696005)(2906002)(356005)(70586007)(8936002)(26005)(6666004)(186003)(107886003)(81166007)(336012)(70206006)(47076004)(426003)(9786002)(82740400003)(478600001)(36756003)(5660300002)(4326008)(316002)(8676002)(81156014)(2616005)(42866002);DIR:OUT;SFP:1101;
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34a721e-d94d-4095-5f79-08d7e1274251
X-MS-TrafficTypeDiagnostic: SN6PR02MB4702:
X-Microsoft-Antispam-PRVS: <SN6PR02MB470263D84D7A1519E5B239E3C2DB0@SN6PR02MB4702.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:93;
X-Forefront-PRVS: 0374433C81
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BqvbgxK7Kmv9pqzFPSaeTF76/DkgZfXCI8t9QkmynRHlPVXK4e8Fa2/wOBtogfbS6OmKpNpc8u7/8bBC0p3va7Aq1JPCQij0pWsDZVbBAqoOSkrGl7sWiV5rD3he8t+TAJDwRKcXmHKrvkmevZcBdlKg4each3u0BGVtT38Tc5Wz1CDbaxz4l+yVKRdkQL2zl/VpADxafB8CqR8xfKfQ0vEDLQTL95FBmcnY/vAtbk3mcXCkyiOTMufqkqgVqTIZ95RDTKF89ySiVCgJmb9gMYfaWosC1u4fQq6SalDyetk6c19AB3RNr3lBlcAHuEu+KPSMqR//YkwCqzlQW0OnHu8nyaQJ9zAT66wh4lGwn7/QWHzbHjMhU++Vd0rcVdjJDHoMaZXGiGfAyTzPtDQ0/mVjS1gUbYj6dX+772gbzmm0r2iQoZVZq+uKdY1mv4Lh+K0MT7dZ2N86LORh4VbqDhP4MfuTQ/vejAzYmPyE5FQUAK4uqQnDKFV9w0a7+1mXJudGkzEMAVlmZbxuGmQmLrjbXXYmmjDp0Zt35iuc4Vs=
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 10:25:02.8717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c34a721e-d94d-4095-5f79-08d7e1274251
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4702
Sender: linux-fpga-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch Adds AFI config driver. This is useful for
the PS to PL configuration for the fpga manager On zynq
platform.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/Kconfig    |  8 +++++
 drivers/fpga/Makefile   |  1 +
 drivers/fpga/zynq-afi.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/fpga/zynq-afi.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 474f304e..60982a0 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -214,4 +214,12 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+config FPGA_MGR_ZYNQ_AFI_FPGA
+	bool "Xilinx AFI FPGA"
+	depends on FPGA_MGR_ZYNQ_FPGA
+	help
+	  Zynq AFI driver support for writing to the AFI registers
+	  for configuring the PS_PL interface. For some of the bitstream
+	  or designs to work the PS to PL interfaces need to be configured
+	  like the data bus-width etc.
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 312b937..d115e29 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -26,6 +26,7 @@ obj-$(CONFIG_FPGA_BRIDGE)		+= fpga-bridge.o
 obj-$(CONFIG_SOCFPGA_FPGA_BRIDGE)	+= altera-hps2fpga.o altera-fpga2sdram.o
 obj-$(CONFIG_ALTERA_FREEZE_BRIDGE)	+= altera-freeze-bridge.o
 obj-$(CONFIG_XILINX_PR_DECOUPLER)	+= xilinx-pr-decoupler.o
+obj-$(CONFIG_FPGA_MGR_ZYNQ_AFI_FPGA)	+= zynq-afi.o
 
 # High Level Interfaces
 obj-$(CONFIG_FPGA_REGION)		+= fpga-region.o
diff --git a/drivers/fpga/zynq-afi.c b/drivers/fpga/zynq-afi.c
new file mode 100644
index 0000000..7ce0d08
--- /dev/null
+++ b/drivers/fpga/zynq-afi.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx FPGA AFI driver.
+ * Copyright (c) 2018 Xilinx Inc.
+ */
+
+#include <linux/err.h>
+#include <linux/io.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+
+/* Registers and special values for doing register-based operations */
+#define AFI_RDCHAN_CTRL_OFFSET	0x00
+#define AFI_WRCHAN_CTRL_OFFSET	0x14
+
+#define AFI_BUSWIDTH_MASK	0x01
+
+/**
+ * struct afi_fpga - AFI register description
+ * @membase:	pointer to register struct
+ * @afi_width:	AFI bus width to be written
+ */
+struct zynq_afi_fpga {
+	void __iomem	*membase;
+	u32		afi_width;
+};
+
+static int zynq_afi_fpga_probe(struct platform_device *pdev)
+{
+	struct zynq_afi_fpga *afi_fpga;
+	struct resource *res;
+	u32 reg_val;
+	u32 val;
+
+	afi_fpga = devm_kzalloc(&pdev->dev, sizeof(*afi_fpga), GFP_KERNEL);
+	if (!afi_fpga)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	afi_fpga->membase = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(afi_fpga->membase))
+		return PTR_ERR(afi_fpga->membase);
+
+	val = device_property_read_u32(&pdev->dev, "xlnx,afi-width",
+				       &afi_fpga->afi_width);
+	if (val) {
+		dev_err(&pdev->dev, "Fail to get the afi bus width\n");
+		return -EINVAL;
+	}
+
+	reg_val = readl(afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_RDCHAN_CTRL_OFFSET);
+	reg_val = readl(afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+	reg_val &= ~AFI_BUSWIDTH_MASK;
+	writel(reg_val | afi_fpga->afi_width,
+	       afi_fpga->membase + AFI_WRCHAN_CTRL_OFFSET);
+
+	return 0;
+}
+
+static const struct of_device_id zynq_afi_fpga_ids[] = {
+	{ .compatible = "xlnx,zynq-afi-fpga" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, zynq_afi_fpga_ids);
+
+static struct platform_driver zynq_afi_fpga_driver = {
+	.driver = {
+		.name = "zynq-afi-fpga",
+		.of_match_table = zynq_afi_fpga_ids,
+	},
+	.probe = zynq_afi_fpga_probe,
+};
+module_platform_driver(zynq_afi_fpga_driver);
+
+MODULE_DESCRIPTION("ZYNQ FPGA AFI module");
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

