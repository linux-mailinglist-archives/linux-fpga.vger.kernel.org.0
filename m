Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345203B4F56
	for <lists+linux-fpga@lfdr.de>; Sat, 26 Jun 2021 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhFZP4H (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Sat, 26 Jun 2021 11:56:07 -0400
Received: from mail-dm6nam12on2073.outbound.protection.outlook.com ([40.107.243.73]:28865
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230304AbhFZP4E (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Sat, 26 Jun 2021 11:56:04 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HKAyofezbHGp+gOJ7gS5Jb0uWf7kZRNZipz83kLd3zSn06OUbdylH377cP0CKa7cuMaDSnbHU+2K4pXmsY6m9cO3uTczZUi5me8GQZnTyif2xi4R9sXcmcxaiqKE2qRYAQFAM2q5vMVZS3eaXVdSQXGPX2MmcYpG9nVNUe7/hSinnvBhz8eCTT2+jpnbo6GugNmIfgqlWCGvhgIvdl+NdTpYO4R3t2OxxtJvzlTCtwN4hnMOl07ad4+VKg26PL+JeHQPoJ/cno4NUGVX5Lqz78CNqF+ZEeP6lB18lLt6stc1/7DLx2OXseyWaubzzsCsuWUVLstCV7CqP2CiwYR8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsIIlFV3AYsirKSZxrdVP7c4qNov2kLLqxUR7az5lfg=;
 b=j+ZWQcOpXAfbSVh+EhoXcbeHAo/ENCnrXF4xBZQdZ4yXHnGIfZsR91F71j/LwG+o2vuZNCCoEge8JUr8fbRWHAS2LGqgXRQ16gMyL5TdT+YPutyjoV+/k2YQZkZtlFOh9jtQ8+aDSAjbkCuvDxTHw5+JpGEQbLsIfDKxpIldtjsx6m/8C28QbdoQFD4+GEUaD6k03ynL7SaNWOaGINoQa97E0w8xp7HfsyatJacc9Jvb0VDIinEh06WoxBqvtyZpHdxdm6IXe36IB7tVxzM8BAfpNQLq1G2FW6e9zmMfyDOChTPunsm5Ley2MHqxkPVF8PNCl7zsiwby+6XRYgYaMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fsIIlFV3AYsirKSZxrdVP7c4qNov2kLLqxUR7az5lfg=;
 b=RUkp7qK46LYB5HOSH9sxCwF1nLLQ+HiP114l3UhvN1WcRl8paqfzCjXqoEe9m9xVNXs8O0B+vFc18XADJQPc7eWYSRBJiWoTyXnDKotFfEhd5bq3J5aXVwaztBO5Z17kooJ9IFbz+uz1p+hQR+7yf1uD7tSoJ5J4smkzgIb0CI0=
Received: from DM3PR12CA0106.namprd12.prod.outlook.com (2603:10b6:0:55::26) by
 BYAPR02MB5415.namprd02.prod.outlook.com (2603:10b6:a03:a0::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.23; Sat, 26 Jun 2021 15:53:36 +0000
Received: from DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
 (2603:10b6:0:55:cafe::6c) by DM3PR12CA0106.outlook.office365.com
 (2603:10b6:0:55::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend
 Transport; Sat, 26 Jun 2021 15:53:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT034.mail.protection.outlook.com (10.13.4.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4264.18 via Frontend Transport; Sat, 26 Jun 2021 15:53:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 26 Jun 2021 08:53:27 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Sat, 26 Jun 2021 08:53:27 -0700
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
Received: from [10.140.6.60] (port=59432 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lxAcU-0000uY-UD; Sat, 26 Jun 2021 08:53:23 -0700
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
Subject: [PATCH v8 5/5] fpga: versal-fpga: Add versal fpga manager driver
Date:   Sat, 26 Jun 2021 21:22:48 +0530
Message-ID: <20210626155248.5004-6-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210626155248.5004-1-nava.manne@xilinx.com>
References: <20210626155248.5004-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c74ca8c0-a14e-4ff6-a4ca-08d938ba8ee2
X-MS-TrafficTypeDiagnostic: BYAPR02MB5415:
X-Microsoft-Antispam-PRVS: <BYAPR02MB5415F7435DA95FD51858C164C2059@BYAPR02MB5415.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iEoGTuO6b8bzNU3ZIidhUqqsP1rWkgNH+mzImV4xvaNZ/rzrG+NTH4sg2WpUwNI7dhRpEQrxgjO2aTSfpWqg0ANXx2kWCTgeQWt7YBCdEFbZ60nQO2KND6RTHInRq/Jm/ohDoRh3FagEiqeErcehMGBysjaOKvibMZbfUqJ4wp/S84IAUhZW1Y47uWq2ZnLOUAjf460W69616VG+/rDOZubD0Zud/at/Y2Bu7mjcB6sPbC7H/x+bMwYeDisNxl/18FBBRaI2SBRTEEZ87/jl3TGoeqNK5hKJQlr2Bmy0AurJCV+vqfdHvjwq1mJ6+1clD/K77FbSjjgAHBhmOX5MWkGyn9mpafgRth7lSSKMw2nuroqiIPeGfXGuOK230TBEh/MJb+oZK2+7szWKq6KOi8idvZv9wNmnY06IBPBIuN3+GhpsfjPOXj+dwZhlZMImyH+q5iJjcJaPLLo6/dBgeSTsA6N+gVe7rOKO1Tqj0moZ/d+ro3fZZaFWTrQ9n720RHuc0c94NOT9xHr+9yagW2tlzxPPOiMLJ6Zsn324/tmaEhvwEnqyGu1fUbftjwXoaKiRHwpBlIwLk7ODZLtZdxZjAsLM9i4n3mJI8EF9a95FIBvmjWR6bLUiYmQGVTaP/2KGOy2IS/L+OUPCIR1qMhdBYJ+C2Y984MyIxe50f1FNrujZYRbcVSTlk78fejc13hPXfzrFhG4/dEu8qIYU6g9zMOKWIu0ZdozG8b7Q2DEGui/ia+7Z+88T9vrbsKsO7UTLxRwzRhoWJKAT6ZYU/DcO/trok/rGWB0nAKgtMN0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39850400004)(396003)(136003)(346002)(36840700001)(46966006)(4326008)(921005)(7416002)(426003)(8936002)(9786002)(36860700001)(336012)(2906002)(356005)(47076005)(82740400003)(7636003)(478600001)(83380400001)(7696005)(26005)(6666004)(186003)(8676002)(36906005)(82310400003)(36756003)(2616005)(5660300002)(110136005)(1076003)(70586007)(70206006)(107886003)(316002)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2021 15:53:36.1016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c74ca8c0-a14e-4ff6-a4ca-08d938ba8ee2
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT034.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5415
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

Changes for v8:
              -None.

 drivers/fpga/Kconfig       |  9 ++++
 drivers/fpga/Makefile      |  1 +
 drivers/fpga/versal-fpga.c | 96 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 106 insertions(+)
 create mode 100644 drivers/fpga/versal-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 8cd454ee20c0..16793bfc2bb4 100644
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

