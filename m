Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C6439B80A
	for <lists+linux-fpga@lfdr.de>; Fri,  4 Jun 2021 13:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbhFDLgH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 4 Jun 2021 07:36:07 -0400
Received: from mail-co1nam11on2070.outbound.protection.outlook.com ([40.107.220.70]:24865
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229962AbhFDLgH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 4 Jun 2021 07:36:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDJl9c3h2PiwCaP6ukgZ6RinwkcJGkZp4hJ+m0qYrpUWmTiRLEN8lR05BkpXN/ympHz437HiG/MMaBJCbOyVXrGDIsjxux0lXUnpc45skO0fQJG4A8a04202+ySWyf8cfQ8+fZCPPpwGpFGI6Hzn4ZoHJTSkIdxCChE/iqTFptT/e5AItQEPzOsz13H/rQMKgd3O34o8XRnhAjqdLzqG+LB03Si2MJtWdJFj9nlZR/UNa/ZszwS7Onyad9M5JLEJpI+Go6Z1EGrCL2zAzIR75ganPx0Gxn9YA6CCtOmb1FmOQGbty5K+RRK7vGHZbz34T8/rrEghGwdlhv3Meu3D5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwKQiieLq1nb+uf0fI3SX4vQyLxuNz9QpSD6NVb0lQM=;
 b=C+qB8eROmhH454ZZEet8mq7QlNkhwJQp15JMZTzYPE0f9KeP0qTDSt1gkVH/X1BWRovAfQ/Z3fMFjdONtVhJlDSyvRwJ2STz1bMW1NyLsOq6pfxtnJ7bqbIbDvUdZccMgYbBJlqORghZGj0+mInX6EWNc08wlWeSUWZY/mrpXCXe3nD5cOzFniThpPG98PvWu2EJT1elqomHXXlT1EcjQCCEj1jDKd+rDHNI8R4sp9gUYKH3r2D8fN5K7IqyCVz70157FI91F/4idZ/X1ku8ARvPvco4DYSo+QdemWr0Ag/YQBLoNw7dkGr77oNC+0M+VjyYQbEHgxXFpzjStTT1iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwKQiieLq1nb+uf0fI3SX4vQyLxuNz9QpSD6NVb0lQM=;
 b=duGKXb8VaPqalha6b+4I4Nbh3s+I/KAVFdwyAgupLLGh6yGOGEbwkA9O286skOenmKMSkh6gqW9CTVC0rhqgjpXJQ2rjB0vCP6YxfJWRe2TqStU9Sr7KKu0q3uMnbuwrLLMrZGVw5tomo9DexFcNxaYnr8mLisF4emNfkrtXkQ4=
Received: from SA9PR13CA0083.namprd13.prod.outlook.com (2603:10b6:806:23::28)
 by DM5PR0201MB3528.namprd02.prod.outlook.com (2603:10b6:4:7e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.27; Fri, 4 Jun
 2021 11:34:19 +0000
Received: from SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::42) by SA9PR13CA0083.outlook.office365.com
 (2603:10b6:806:23::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.9 via Frontend
 Transport; Fri, 4 Jun 2021 11:34:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0017.mail.protection.outlook.com (10.97.4.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4195.18 via Frontend Transport; Fri, 4 Jun 2021 11:34:19 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 4 Jun 2021 04:34:06 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 4 Jun 2021 04:34:06 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=49944 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lp85U-0005PI-U7; Fri, 04 Jun 2021 04:34:05 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <gregkh@linuxfoundation.org>,
        <amit.sunil.dhamne@xilinx.com>, <tejas.patel@xilinx.com>,
        <zou_wei@huawei.com>, <lakshmi.sai.krishna.potthuri@xilinx.com>,
        <ravi.patel@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <git@xilinx.com>, <chinnikishore369@gmail.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v7 4/4] fpga: versal-fpga: Add versal fpga manager driver
Date:   Fri, 4 Jun 2021 17:03:32 +0530
Message-ID: <20210604113332.1394-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210604113332.1394-1-nava.manne@xilinx.com>
References: <20210604113332.1394-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9729091-51eb-4181-fa83-08d9274cb14b
X-MS-TrafficTypeDiagnostic: DM5PR0201MB3528:
X-Microsoft-Antispam-PRVS: <DM5PR0201MB352814A3324757FC9EC85BCBC23B9@DM5PR0201MB3528.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C4GyyK1x8uaqoNxjt5pvY9VgTPtfTOnsc0dKLftWizXMcBO8cuPND6cgW61o1qmpmFrMBcLqnnvioV3TiP74urpVKiX9gwlu/MqVP3G1O8t+SyFjfwaJsisQ82cJ0/Qh1A0aaVTsetvNzvGoXFEPbwlvdW/taP0E9XzU1SLhgLM26dJBHMmOv2Kz2MJ67aQoZ4rIXtbqErfMSdMkIYdWeZTNAQCD7hJtSz9wx1x3E/NAsrkSxLd32WDmxvSrK5ixVn3AWWmZfwvoKojQZIGGZtYlPR4Em8o8Jc/LPFDn3mT6vf7fTeteQQeQeutw1OsLRcWGrxJJowH4z+gDZTIprQUaZUER4/rgwRBOJX44f8teYrGA6XHlA1SEv0Ne3K4aK1OIpeMDBqdtJP7cfsHYH0G/4AYwhni8WhqAgcY5Lxg0aOihF1bd9EJ02L+DLniq5IyxBTyyiD/z11I98w1epAschkcDc3iskDvuSzg/wuF+VItxQCkL5Bo4T1cqO7fw/LoHzfxaHQxKAa3CTwTlVtgDKceLoJFxQmVAKxmxIx8FFk86YoaZZMZpxztuSboBRc7Ja/O++juNGIuN+rCFCqxA52KCy8zWsdNemMWQhlNNn73homdS8FjYa1nDYQr/hattEd6KMNRdo2XOxUb/6HRnBZtXXWeGJW33rJXd8RkmNPo5vcw2HAaeNKw0mLyUyXOUYjgP48GmimZ9WiOHFjJ0hSTm9i6N8pZ8YoH3PfY0fvFQS40qnwaxvatmbw0M
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36840700001)(46966006)(426003)(36860700001)(2616005)(83380400001)(5660300002)(110136005)(921005)(2906002)(4326008)(26005)(336012)(70206006)(36756003)(356005)(82740400003)(70586007)(1076003)(316002)(82310400003)(8936002)(36906005)(478600001)(7696005)(8676002)(107886003)(47076005)(7636003)(7416002)(186003)(6666004)(9786002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2021 11:34:19.4390
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9729091-51eb-4181-fa83-08d9274cb14b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0201MB3528
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add support for Xilinx Versal FPGA manager.

PDI source type can be DDR, OCM, QSPI flash etc..
But driver allocates memory always from DDR, Since driver supports only
DDR source type.

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
Reviewed-by: Moritz Fischer <mdf@kernel.org>
---
Changes for v2:
              -Updated the Fpga Mgr registrations call's
               to 5.11
              -Fixed some minor coding issues as suggested by
               Moritz.

Changes for v3:
              -Rewritten the Versal fpga Kconfig contents.

Changes for v4:
              -Rebased the changes on linux-next.
               No functional changes.

Changes for v5:
              -None.

Changes for v6:
              -None.

Changes for v7:
              -Updated driver to remove unwated priv struct dependency.

 drivers/fpga/Kconfig       |  9 ++++
 drivers/fpga/Makefile      |  1 +
 drivers/fpga/versal-fpga.c | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/fpga/versal-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 33e15058d0dc..92c20b92357a 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -234,4 +234,13 @@ config FPGA_MGR_ZYNQMP_FPGA
 	  to configure the programmable logic(PL) through PS
 	  on ZynqMP SoC.
 
+config FPGA_MGR_VERSAL_FPGA
+	tristate "Xilinx Versal FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  Select this option to enable FPGA manager driver support for
+	  Xilinx Versal SoC. This driver uses the firmware interface to
+	  configure the programmable logic(PL).
+
+	  To compile this as a module, choose M here.
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 18dc9885883a..0bff783d1b61 100644
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
index 000000000000..1bd312a31b23
--- /dev/null
+++ b/drivers/fpga/versal-fpga.c
@@ -0,0 +1,96 @@
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
+	dma_addr_t dma_addr = 0;
+	char *kbuf;
+	int ret;
+
+	kbuf = dma_alloc_coherent(mgr->dev.parent, size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
+	dma_free_coherent(mgr->dev.parent, size, kbuf, dma_addr);
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
+	struct fpga_manager *mgr;
+	int ret;
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (ret < 0) {
+		dev_err(dev, "no usable DMA configuration\n");
+		return ret;
+	}
+
+	mgr = devm_fpga_mgr_create(dev, "Xilinx Versal FPGA Manager",
+				   &versal_fpga_ops, NULL);
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
2.17.1

