Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD20F2F97EC
	for <lists+linux-fpga@lfdr.de>; Mon, 18 Jan 2021 03:50:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731100AbhARCuQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sun, 17 Jan 2021 21:50:16 -0500
Received: from mail-eopbgr690058.outbound.protection.outlook.com ([40.107.69.58]:22915
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731090AbhARCuP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sun, 17 Jan 2021 21:50:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEbBKBFF8eHLYVyFkWnCaw0/utzPDae7KBq5NGjNkbrxxcvs/rnI0p/hZ4M3iVouLw4iww804lh2IAHQAnutftxovTbd+WplEy9b1woEJ+EcEfaJEjDK+lE2aX78RmbIMGVsJ+kuyooKuocjxcD5hSd4417sTQc0RWNTrShCc4xbq+0xXWU38x2N1xBKkBhOUSkHVE0/BtuufqDMceCge9d8Z/0TazJDybJKeHl/NLm5yz0KMSnNtR8iKVCDfkx5AhdXcGDaeI4625c1X3t0oItc8GgnrCpZMzUM5PnLsD/h6FsHBpWu9JmwuI6UWmvLbk3rct3O1W5fc8L37Eub3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCIb88vO48StOorvK6QkzxZeLdC5Yi/tifLX3M7hAhw=;
 b=m1/OwfI6dJNB4RTxz59L4taqyfpYp3oQwXwSL8YuXtpbW0TZ/TtPiqHcDwApWMri2TwKj/hls/dTL2NBTmTrCz/lkSjxObEvGc0AP9BQW6X1FMGvEMVSAqS6t/fK5ITyZ64FFrg4eELThRL4domMBNP6Vp3j6yG+T49aBnnPMVMplWUsXOFAcrNxGHGj2esOtaoml1XULGX+Pkw/Czdlc4d0AlCnhjSwJaY00Z71n5ky3/rFb3Qe4rYX8srlnCM0LNEmmQslj8JbeUqoFOhUgOehDHrdcKPukqVXyLyW1N4PYQJA8pf+OtNRYLoNs2nGidh9vNuYEUZ9j6mijK3LFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCIb88vO48StOorvK6QkzxZeLdC5Yi/tifLX3M7hAhw=;
 b=mgH9DGjNLhblcFhvDY2oHL7DiLZqXFNzxJjGDW2GSOKHA/U6hm8dQ1utgZfdQebCbFVAXpAceHxF3t80vAad408kAskU+8nWi5TBVYFpB4SZjaD6yHdJ1E+0FL9fNCjkhjob29CWmHk8UC+Me6bCJ0DQn3Z/i2SopQnlooe6VZE=
Received: from SN4PR0501CA0153.namprd05.prod.outlook.com
 (2603:10b6:803:2c::31) by DM6PR02MB4522.namprd02.prod.outlook.com
 (2603:10b6:5:24::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3763.12; Mon, 18 Jan
 2021 02:49:27 +0000
Received: from SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2c:cafe::29) by SN4PR0501CA0153.outlook.office365.com
 (2603:10b6:803:2c::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.6 via Frontend
 Transport; Mon, 18 Jan 2021 02:49:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT029.mail.protection.outlook.com (10.152.72.110) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3763.12 via Frontend Transport; Mon, 18 Jan 2021 02:49:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Sun, 17 Jan 2021 18:49:25 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Sun, 17 Jan 2021 18:49:25 -0800
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
Received: from [10.140.6.60] (port=39926 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1l1Kbc-0001PD-P4; Sun, 17 Jan 2021 18:49:25 -0800
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <mdf@kernel.org>, <trix@redhat.com>, <robh+dt@kernel.org>,
        <michal.simek@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@xilinx.com>, <chinnikishore369@gmail.com>,
        Nava kishore Manne <nava.manne@xilinx.com>,
        Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH 3/3] fpga: versal-fpga: Add versal fpga manager driver
Date:   Mon, 18 Jan 2021 08:13:18 +0530
Message-ID: <20210118024318.9530-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20210118024318.9530-1-nava.manne@xilinx.com>
References: <20210118024318.9530-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 514a065c-4f02-463e-b94b-08d8bb5babc1
X-MS-TrafficTypeDiagnostic: DM6PR02MB4522:
X-Microsoft-Antispam-PRVS: <DM6PR02MB45228B32680A75F7327A4174C2A40@DM6PR02MB4522.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8EJqeTbbr61G/5fmcGRxXBYWkmzOgq8pI0la95YeDbi1AO/BmwsfRKaxrKvnhJGOW8zmlbtzLTLkXjjTBoBdY9QWiTOZIUYq/N1qoq+eU908MXtXh4961bQcSWicB0pwEzIcFRYtbD4QapC4XzaMhdT1g25iC1W/KHsw/LkTYhRb3XKf2lCcAXiV0tq1CI1lV5QGT6BkmFjDqBxgzi4XnXRKhlaQ9VLlDCvI2VLqPbRtmPU0H1S2fWMmnSJ+DZDQ3heYVnoejLA4KkDT9hEieRCib1+hPb6DLWnhTbz2KEf0Kb0pi7q7r1vN5Ohp3Dyqlchj1dv/SqM0jX7+DaM8zqRx9lCSHS0dyYjrXCAbtpNSS8/OIDdHMsSIEOJbm8kCVpxLBlxMmFzesQm8QIo3LbnrKULDhiNXhgCuH9hj1MM+kdv/6UJyW6vLTaV7Lsxd8ckwCoT39mCqaimD+GU/xL6gkmbqFtRn6p41kq03fyi9raRCIHHoycbqZNOILVKOSXu/VgFNPpkRZYgm7luONQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39850400004)(376002)(46966006)(82740400003)(36906005)(6666004)(8676002)(110136005)(1076003)(82310400003)(7696005)(36756003)(54906003)(478600001)(70586007)(7636003)(70206006)(316002)(4326008)(26005)(356005)(336012)(2906002)(107886003)(5660300002)(8936002)(2616005)(426003)(47076005)(9786002)(186003)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2021 02:49:27.0143
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 514a065c-4f02-463e-b94b-08d8bb5babc1
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4522
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

This patch adds driver for versal fpga manager.

PDI source type can be DDR, OCM, QSPI flash etc..
But driver allocates memory always from DDR, Since driver supports only
DDR source type.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/Kconfig       |   8 ++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/versal-fpga.c | 149 +++++++++++++++++++++++++++++++++++++
 3 files changed, 158 insertions(+)
 create mode 100644 drivers/fpga/versal-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 5645226ca3ce..9f779c3a6739 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -216,4 +216,12 @@ config FPGA_MGR_ZYNQMP_FPGA
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
index 000000000000..2a42aa78b182
--- /dev/null
+++ b/drivers/fpga/versal-fpga.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2021 Xilinx, Inc.
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
+ * @flags:	flags which is used to identify the PL Image type
+ */
+struct versal_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int versal_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct versal_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
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
+	return FPGA_MGR_STATE_OPERATING;
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
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration");
+		return ret;
+	}
+
+	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
+				   &versal_fpga_ops, priv);
+	if (!mgr)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, mgr);
+
+	err = fpga_mgr_register(mgr);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		fpga_mgr_free(mgr);
+		return err;
+	}
+
+	return 0;
+}
+
+static int versal_fpga_remove(struct platform_device *pdev)
+{
+	struct fpga_manager *mgr = platform_get_drvdata(pdev);
+
+	fpga_mgr_unregister(mgr);
+	fpga_mgr_free(mgr);
+
+	return 0;
+}
+
+static const struct of_device_id versal_fpga_of_match[] = {
+	{ .compatible = "xlnx,versal-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, versal_fpga_of_match);
+
+static struct platform_driver versal_fpga_driver = {
+	.probe = versal_fpga_probe,
+	.remove = versal_fpga_remove,
+	.driver = {
+		.name = "versal_fpga_manager",
+		.of_match_table = of_match_ptr(versal_fpga_of_match),
+	},
+};
+
+module_platform_driver(versal_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <nava.manne@xilinx.com>");
+MODULE_AUTHOR("Appana Durga Kedareswara rao <appanad.durga.rao@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Versal FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

