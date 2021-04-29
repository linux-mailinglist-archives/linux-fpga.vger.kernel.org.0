Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57B136EC08
	for <lists+linux-fpga@lfdr.de>; Thu, 29 Apr 2021 16:07:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240471AbhD2OHx (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 29 Apr 2021 10:07:53 -0400
Received: from mail-mw2nam10on2075.outbound.protection.outlook.com ([40.107.94.75]:6828
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240427AbhD2OHw (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 29 Apr 2021 10:07:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O/6z4gG/ocwCUSQy/6BizQeZOj1iTQHF0i/F+Fb6SCsXq+hlMBK2I9yLVW6dNthp2qx7XQJAiKtcEprUvJxrTDNBftruKUvNn6RJ/r7XYVq7xma686rKs/9Cz9SOA9xEB37L5d4GYnr4ObprDcgv1qjGC/0hitOZ2JoaI0UYPc4EoY96NTMOr7c63O2wKRFk5NPQTA8yViAzb+IehqZJc93Eu9nLlZf90MMlPCMJbsYOVA6DcRf/N8OCJY/9cc0/ODe66GaJcizEPdOsLFopxMLqLQ4YdQf4HNxlakSHkkeANi3xdKQYFt9vvEBm2VihgaKeqgNtWXLlZ61J8wNZQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK/W8ClThT2KQ4y8WmSuevdQQbvCAxLy3mUuZHRgYPE=;
 b=LwixIiZpUYDO6AqclRQz6BKMKbaDJ4MrNom0/FQ2edplOaWf4w9I76/XO+f/KxEaPUXiHpBX089B3hD93vGLsKX0jq6zJzPbAbqCKXHMFH4a901f3I+4vShvDqCKmKWl1OMYhx8N4Y8HYM1AjLK7Afgp66MIascitYoWvnfZiIOhmzaIxoBDNZySLRK1z0te45w7I4fHJtBxYmQ0HurNO/rAr3ceTp6MKbZtvDH0KXunwZir8LqyH52U3sN9UuREB5HdY3P6ul06UW5WrtgAr/dYayJFj5c1OJfMcun7GsfaxkWjGo3YOfdvtMLiLy0mp3gsSStT7cedbkA52NZT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kK/W8ClThT2KQ4y8WmSuevdQQbvCAxLy3mUuZHRgYPE=;
 b=IHBejnvCX7sIckbKgAbC4/Ex6aPkUKZLsUSH2BYmdkatVJT5xVnbczWoZ1+ojokNo5Ld5ggABkDrU6Fh3UppO37Y5wHkjALFAPZcDa+9uAZd9EpkF8N4JkoG2o1K4lzBi5TEM3KxH1Gor69btj25u1CidMWvZaaj6JFqGxqIjKg=
Received: from BL1PR13CA0123.namprd13.prod.outlook.com (2603:10b6:208:2bb::8)
 by DM6PR02MB4939.namprd02.prod.outlook.com (2603:10b6:5:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 14:07:04 +0000
Received: from BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:2bb:cafe::12) by BL1PR13CA0123.outlook.office365.com
 (2603:10b6:208:2bb::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.8 via Frontend
 Transport; Thu, 29 Apr 2021 14:07:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT018.mail.protection.outlook.com (10.152.77.170) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Thu, 29 Apr 2021 14:07:03 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 29 Apr 2021 07:04:39 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 29 Apr 2021 07:04:39 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 mdf@kernel.org,
 trix@redhat.com,
 gregkh@linuxfoundation.org,
 arnd@arndb.de,
 zou_wei@huawei.com,
 iwamatsu@nigauri.org,
 linus.walleij@linaro.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 chinnikishore369@gmail.com
Received: from [10.140.6.60] (port=60740 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1lc7HS-0004zS-0O; Thu, 29 Apr 2021 07:04:38 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <michal.simek@xilinx.com>, <mdf@kernel.org>,
        <trix@redhat.com>, <nava.manne@xilinx.com>,
        <gregkh@linuxfoundation.org>, <arnd@arndb.de>,
        <rajan.vaja@xilinx.com>, <amit.sunil.dhamne@xilinx.com>,
        <manish.narani@xilinx.com>, <zou_wei@huawei.com>,
        <lakshmi.sai.krishna.potthuri@xilinx.com>, <iwamatsu@nigauri.org>,
        <wendy.liang@xilinx.com>, <linus.walleij@linaro.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>, <git@xilinx.com>
CC:     Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Subject: [PATCH v4 4/4] fpga: versal-fpga: Add versal fpga manager driver
Date:   Thu, 29 Apr 2021 19:34:08 +0530
Message-ID: <20210429140408.23194-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429140408.23194-1-nava.manne@xilinx.com>
References: <20210429140408.23194-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82a60b18-d3d2-4238-be40-08d90b1810dc
X-MS-TrafficTypeDiagnostic: DM6PR02MB4939:
X-Microsoft-Antispam-PRVS: <DM6PR02MB49394250E6DCFC2D3A2E5435C25F9@DM6PR02MB4939.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: awuDfaIJcWA1IiVHQbnTPSjbwzxmr8q6LsCPn4UW5C3lwx6NO9Vu7C42i1ZHhUN/6BkNIgO3cXmPstas4AmWHUO1llVylhfJL84E2W6LE0J1/xd/T8kPeeo/z9KioLvVG6oii06Z+jhiRee5qLt268TPBAn4SF1mvHG50jD1bOUeBbMQYcNowEIorEVFZvz8OytCLlbnb9wP9NrMD/xowjMYDbaRvv02mQ0Y1Y/L0RXqlPyp6NaB+Ce9INqXmE4LLQ2dUfuMATiWCN4nuQSz/2Ckp6cYQ16yxa8GnDrSljJwXPmg6RoIAhXBmdFdgt+WWNW/9nxyLn0kL/YCWlyaDaKNo6hqXxDtHelspU7uDv/mj4NFoM1/eR1z23PIGfGj/JY6pO43R1NszfqeLklit0gZAy8/yN/PsaQLc25wM8M07dY0YmnfErgGTaJYc10wUHMWTsS0iMWwlRbhHAuIMWVA7Kz1G0yigzWr5h6YztvqhTC5H76oBzWpxIAoDGd7J1qpv8INoG+95d4tc4ii5MALmAzaALI/8hkcDBcDoWjJ+KGwHpcV+RxouyqwILLHUHlBphmaav4wKKHcYcpWaxX20I9b/Gadh7d9+DiqkK7w8LLoFMxAZEyDP87GOLhgXHVvonGU08jOP4AiDRtVpMRIVP8SN5eTGVYI/Z616Fpa4K31MdoQwU21rk/gWHI75atz/6dbQWSwkN3C9n678yriM5zbrMPWDUF0XWYZ+gk4RMPN/MW1igZUes/cMQNR
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(376002)(39860400002)(36840700001)(46966006)(70586007)(36756003)(8936002)(82740400003)(70206006)(8676002)(5660300002)(2906002)(7696005)(83380400001)(356005)(6666004)(107886003)(186003)(47076005)(9786002)(110136005)(36906005)(478600001)(2616005)(36860700001)(921005)(336012)(82310400003)(316002)(4326008)(1076003)(7636003)(426003)(6636002)(7416002)(26005)(102446001)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 14:07:03.8269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82a60b18-d3d2-4238-be40-08d90b1810dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4939
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
Changes for v3:
                -Rewritten the Versal fpga Kconfig contents.
Changes for v4:
                -Rebased the changes on linux-next.
                 No functional changes.

 drivers/fpga/Kconfig       |   9 +++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/versal-fpga.c | 117 +++++++++++++++++++++++++++++++++++++
 3 files changed, 127 insertions(+)
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
index 000000000000..5744e44f981d
--- /dev/null
+++ b/drivers/fpga/versal-fpga.c
@@ -0,0 +1,117 @@
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
+	ret = zynqmp_pm_load_pdi(PDI_SRC_DDR, dma_addr);
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
2.17.1

