Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92F931851F
	for <lists+linux-fpga@lfdr.de>; Thu, 11 Feb 2021 07:15:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbhBKGNq (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 11 Feb 2021 01:13:46 -0500
Received: from mail-mw2nam08on2084.outbound.protection.outlook.com ([40.107.101.84]:46337
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229647AbhBKGNc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 11 Feb 2021 01:13:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYPYQBiIHoubG+NHWwdPFk/Qru2GPJ3jo8zy5U+yeFLGLFf1M2aDNUUqJm+9V1vBfMx3ABAvMMAZAm300zFepsBZ5zRO1VCemV6+vN7tMFT7AB5JobKyaJAp2BOvQFcGfkCwuqkFsVnc+KwD7EFyhnIfYH2nDHibsPQkPbLlx4lnkHykRXwRiQYIws3OqTi79khLZQUuvl2HsUIcRyltAzexWRqpmqckIaqTScPnNlpRKX5iwniMXAKTqsHHCkx68nngKUmr7/dVttv6ScQxIyabHWPySkssG+BjgWsX0olkj+OOuxTM7zcMbgkIr6bTKOy6yqsa505vott4JQVTAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik4pWMb4GFig+FNyXkvL9oal+1yV+0Q8GN5LPuQzAMI=;
 b=WCcc2ZwAOnenkmxlkLb/9LcVyzN1vLw1x9rLQclo/ZkagpPTkf1jsC8vrdjY6OCFED/hiX8lS6zOn6ZToX28aTr3w4RfmUUciBI/NII4q9+HNoUPLhPALN8tANglnEOtrcQ9d+6+e62kQqQqxCI/P/6wKPt1qeh9JvDnXeKh8j1ijxLY31Qt92tYmgOrm+BeG3+C89Ijqaeu37XGqUhtibPTYfMYo4t1b4ikK+gZYW/rQ8n3Z4eZPNNESiStK4Dx394LNFbT39zfbhslyo5C6DrtQTfsNfWnBLKAjXFVgm6Q6s5b4DWoAFKvmX+JdJ7pDebm8o3aBwkJcfmYQb1lIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ik4pWMb4GFig+FNyXkvL9oal+1yV+0Q8GN5LPuQzAMI=;
 b=U/IPikFQ/1vhD/AscL0Z6Wu2m4K9fttqZDp6k04iZAw85byBozzMhTRM/+ziQ2B72ivfgEWyUGyZ/n22dkr3a2Lm1ttVYHntxBrStPgqUfZAf2WG+xJcgv1kA0PavquA/JTZSSf4VvoxtBStqKwAf1Y+TDpZrNj9l2o4Ez1iLQQ=
Received: from SA0PR11CA0205.namprd11.prod.outlook.com (2603:10b6:806:1bc::30)
 by SN6PR02MB4783.namprd02.prod.outlook.com (2603:10b6:805:9e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Thu, 11 Feb
 2021 06:12:39 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::46) by SA0PR11CA0205.outlook.office365.com
 (2603:10b6:806:1bc::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend
 Transport; Thu, 11 Feb 2021 06:12:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3846.25 via Frontend Transport; Thu, 11 Feb 2021 06:12:39 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 10 Feb 2021 22:12:21 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 10 Feb 2021 22:12:21 -0800
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
Received: from [10.140.6.60] (port=34116 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lA5DA-0001Jy-KZ; Wed, 10 Feb 2021 22:12:21 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
CC:     <git@xilinx.com>, Nava kishore Manne <nava.manne@xilinx.com>,
        "Appana Durga Kedareswara rao" <appana.durga.rao@xilinx.com>
Subject: [PATCH v2 3/3] fpga: versal-fpga: Add versal fpga manager driver
Date:   Thu, 11 Feb 2021 11:35:32 +0530
Message-ID: <20210211060532.23662-4-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210211060532.23662-1-nava.manne@xilinx.com>
References: <20210211060532.23662-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d60ddf97-78b6-4a3e-e8bf-08d8ce54091e
X-MS-TrafficTypeDiagnostic: SN6PR02MB4783:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4783D44CE2D43329D46D65B1C28C9@SN6PR02MB4783.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jDtKGh+54FAxBNY29ynvH10Cqtuca0kdFCTxPGLhMMpTXqwqSdd4DMivqXNHDgzaKDmApcHYYgLVY5FpwFpjOPL/wTdiM8E8dg/zUwAuijYqvV9+FwY3vkJsTHcGdcW4N4IOnFXQaKCmE24hh0J3mA18t1JmTFCZOhw1drB9GxiJcAXUxpLcyCtB0iV2PkgwHNJ3OTF5AOFhApkKDkMwRlBmENsNekEZ7FswRgvcJiCmuSp2f07sP6PwWqRnHwjKFq7UCxUJg9WNtCUy4r538QEYlEQAlOaWn3dVrQamZokL9mQb2jit87yjl16caUYPY6kjtPkGI36KTesWtgtfizrMbYW0G/4f1Nwzexc1v0dRjw4jiG/ML3BOonMM73km1KeMsT7/Az936GBdLKV+ZTgCVA7kCOIPFDzErcRwuLFXtbHo9PhEw2sLAjn2tsYSlajm/wVhtNnLIUGMjU5NVmDA6mwT5FhiKrQk08tqEcxjPYsdBLKboEig24rFNZ9Nxj/91vaZGekQL/f3Z+FSp8QXTaktlMU0pmvA99UTxb+Wg3zEyWQSbVgawgmsHj+eFYTHd8d+sWXHwzWvDLpG4iL/bw4X+bAjxJhBkr+F/VLR0S6E0McZyZIDYM2BkVViuDN9qMwkNteiQ+NSvljNasf3PAE1s9q1ra/3juCjZpI6QhsVO6/vLZQ9W8WMFeQ/no/dzubfQ4DxpgpPPxasBA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(46966006)(36840700001)(36906005)(83380400001)(8936002)(336012)(47076005)(9786002)(26005)(36756003)(82310400003)(478600001)(107886003)(110136005)(186003)(8676002)(1076003)(36860700001)(54906003)(426003)(6666004)(70206006)(356005)(70586007)(5660300002)(7696005)(2616005)(316002)(4326008)(7636003)(2906002)(82740400003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2021 06:12:39.7700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d60ddf97-78b6-4a3e-e8bf-08d8ce54091e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4783
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for Xilinx Versal FPGA manager.

PDI source type can be DDR, OCM, QSPI flash etc..
But driver allocates memory always from DDR, Since driver supports only
DDR source type.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Updated the Fpga Mgr registrations call's
                 to 5.11
                -Fixed some minor coding issues as suggested by
                 Moritz.

 drivers/fpga/Kconfig       |   8 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/versal-fpga.c | 120 +++++++++++++++++++++++++++++++++++++
 3 files changed, 129 insertions(+)
 create mode 100644 drivers/fpga/versal-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index bf85b9a65ec2..dcd2ed5a7956 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -223,4 +223,12 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+config FPGA_MGR_VERSAL_FPGA
+        tristate "Xilinx Versal FPGA"
+        depends on ARCH_ZYNQMP || COMPILE_TEST
+        help
+          Select this option to enable FPGA manager driver support for
+          Xilinx Versal SOC. This driver uses the versal soc firmware
+          interface to load programmable logic(PL) images
+          on versal soc.
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index d8e21dfc6778..40c9adb6a644 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_FPGA_MGR_TS73XX)		+= ts73xx-fpga.o
 obj-$(CONFIG_FPGA_MGR_XILINX_SPI)	+= xilinx-spi.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
+obj-$(CONFIG_FPGA_MGR_VERSAL_FPGA)      += versal-fpga.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE)         += altera-pr-ip-core.o
 obj-$(CONFIG_ALTERA_PR_IP_CORE_PLAT)    += altera-pr-ip-core-plat.o
 
diff --git a/drivers/fpga/versal-fpga.c b/drivers/fpga/versal-fpga.c
new file mode 100644
index 000000000000..22d0bfb7b1e6
--- /dev/null
+++ b/drivers/fpga/versal-fpga.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2021 Xilinx, Inc.
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xlnx-zynqmp.h>
+
+/* Constant Definitions */
+#define PDI_SOURCE_TYPE	0xF
+
+/**
+ * struct versal_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ */
+struct versal_fpga_priv {
+	struct device *dev;
+};
+
+static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	return 0;
+}
+
+static int versal_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	struct versal_fpga_priv *priv;
+	dma_addr_t dma_addr = 0;
+	char *kbuf;
+	int ret;
+
+	priv = mgr->priv;
+
+	kbuf = dma_alloc_coherent(priv->dev, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	ret = zynqmp_pm_load_pdi(PDI_SOURCE_TYPE, dma_addr);
+
+	dma_free_coherent(priv->dev, size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int versal_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states versal_fpga_ops_state(struct fpga_manager *mgr)
+{
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops versal_fpga_ops = {
+	.state = versal_fpga_ops_state,
+	.write_init = versal_fpga_ops_write_init,
+	.write = versal_fpga_ops_write,
+	.write_complete = versal_fpga_ops_write_complete,
+};
+
+static int versal_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct versal_fpga_priv *priv;
+	struct fpga_manager *mgr;
+	int ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration\n");
+		return ret;
+	}
+
+	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
+				   &versal_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	return devm_fpga_mgr_register(dev, mgr);
+}
+
+static const struct of_device_id versal_fpga_of_match[] = {
+	{ .compatible = "xlnx,versal-fpga", },
+	{},
+};
+MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
+
+static struct platform_driver versal_fpga_driver = {
+	.probe = versal_fpga_probe,
+	.driver = {
+		.name = "versal_fpga_manager",
+		.of_match_table = of_match_ptr(versal_fpga_of_match),
+	},
+};
+module_platform_driver(versal_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_AUTHOR("Appana Durga Kedareswara rao <appanad.durga.rao@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Versal FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

