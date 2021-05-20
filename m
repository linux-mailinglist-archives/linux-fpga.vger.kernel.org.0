Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD9F389F8F
	for <lists+linux-fpga@lfdr.de>; Thu, 20 May 2021 10:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhETIMp (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 20 May 2021 04:12:45 -0400
Received: from mail-bn8nam11on2068.outbound.protection.outlook.com ([40.107.236.68]:13537
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231204AbhETIMo (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 20 May 2021 04:12:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KvQc9yOtt599wyBS+mp/w3EUfnwORc93bGJG4x087vxEzn5fofzAeBC0daUq9TPw+YAuKBrVwVlHpjpK/8nbmvNLqTsVZ2ivONLi/GBdZY+UOJjDOVDcQCo9Cm76JpCvzW5ynZ4wqKZBXKXjyU8+pu9DUXwxP3X4MALrBrjMRL7v1Clp8aJc17Z+mGMJQwDHJcDEecLVfRCup4RHUgOPisp7YJ/Fe2SMIoNaHMV9Es5K8KGHad0d7zSU8N1DqgVF2EwpnNzvRaJtbN6HXHTK62rczF8yRg4XtRoFpAG2JpgbYkITvswMb4xo/Uj8g5uT+s6Ump7GBClRfPZQlItOGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGmf7Hjv4PEWUEIi/BvW4WUXmx19aOWf7foHEJ/I7m4=;
 b=BxRR+njM+LJsfSaHw1Dsc4QuzUaH2+uVgc8nTxZL/t/sNB1cVcoh+e1EyG/E++20bSWyn7wNZKd1SECzwM+Es7twf0vQPnzdZ8n03016K9O2Jl1d/oVErgwDdRBSrojOAYEmX/eB6JYI5/4aNwtsGAGBQvEe0rARUdG9rdqd3NYAMXOo4iutjP/ryf6nExMGbERc0bD2Lebwb+RklB4RILRsO0MWw/2TsA4vHEB3by/oZTjxixRBCIzXX/0wbCj5gsgJnbFiHQYKxNQN2l76vu2eEAHWethg7sXdTz5BdotV0DJGRDUzsUzDBJmo/8KpAKmm7hrJf5jb3LI/JXnSXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGmf7Hjv4PEWUEIi/BvW4WUXmx19aOWf7foHEJ/I7m4=;
 b=Wi9ajSU6Ch4AxuY8eknTlZGDgYnDRaEWUwRHPva9gxJi3sw/zqcDlxoSrYjDM86RGjw/6jdniIrzCCWQUUJpT1B0Go/eQkdG90tUPGm//pyJAQIS8AaIIA8tvABnQ844S41CnYDr80NavciZpOo1pcuxe5jLumAN3zE6ur2COaM=
Received: from SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33)
 by CH2PR02MB6120.namprd02.prod.outlook.com (2603:10b6:610:8::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.29; Thu, 20 May
 2021 08:11:21 +0000
Received: from SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::ca) by SN6PR05CA0020.outlook.office365.com
 (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.12 via Frontend
 Transport; Thu, 20 May 2021 08:11:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0042.mail.protection.outlook.com (10.97.4.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.27 via Frontend Transport; Thu, 20 May 2021 08:11:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 20 May 2021 01:10:25 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 20 May 2021 01:10:25 -0700
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
Received: from [10.140.6.60] (port=42624 helo=xhdnavam40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <nava.manne@xilinx.com>)
        id 1ljdlA-0007IV-61; Thu, 20 May 2021 01:10:24 -0700
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
Subject: [PATCH v6 4/4] fpga: versal-fpga: Add versal fpga manager driver
Date:   Thu, 20 May 2021 13:39:54 +0530
Message-ID: <20210520080954.1393-5-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210520080954.1393-1-nava.manne@xilinx.com>
References: <20210520080954.1393-1-nava.manne@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe37197-b989-4eb4-e948-08d91b66da2d
X-MS-TrafficTypeDiagnostic: CH2PR02MB6120:
X-Microsoft-Antispam-PRVS: <CH2PR02MB6120E7848E783C555204E4C1C22A9@CH2PR02MB6120.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0jVl8kPXBTKnAjmxEgBjI/P01rtfLgvxTirzsDEuEhknU4VHZdO0t18PEaxxDpY3Ixw/uJf4JYl0nzMr8gu7Es5p7vH6NP1TssgX96WjEPIsLZkn2jHYFF6eIIwRGIG48MrVIQdaxuz7V4qf8oS/12H/4iqM0pEnjC/6UBrLV4q3RwviRgqmpDWTYArnDDkf0Q/X2AnmFLSlfqExpLl/QMQQ2WgB9rAooy9CcdusRrt0UUv7BiUcUwFmqh1XJqjhqytNif1iY+tQ3W6ESMQpp5j2wuCR8+RyCSSD3mNS0MdwpOQBv7x2N7nMksLECHe/FnJCS8cdbyCwXxAaI/BDt5fiVyfXR7/18rxOzfW6NlfzKtTzk4pF5y9VYblTJa7LuyPO1ghiM5OfacPoZZVAnm2+QUN+2hTVNn2pXxU53IL+CjExLwX9H/Bgyjw7nhptx4GLQDbJLsPOdxBwimxBu6TVvLHbSm0b0Lkrh83odUpL6DCDl31Mfw/j+usty2/lA0/lk3+UcYC/jcezeWdnMUGKJkx5Fx2WqY6CnfBX3QSnyLHqJRnqWc1L893zbRQvQtV7ZIi9jY1QS6akHooKQGEtcPC42fWsNGE3vrm9jQOiWoL1xYtv2F0rwMsA4zXIyTlJEVOvWCkCsiWPrVogaZfQHhOAzaF5ABDrr11JUthsgAMkCbZ58n0/sQFiiDaMADT4FRjypWOJKsFkz34nIjCt4LCLYkhRUw4Jk4KnEmTLcRt+hp1Qo3H9WJ9fg4H
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(346002)(39850400004)(376002)(396003)(36840700001)(46966006)(186003)(82740400003)(8936002)(8676002)(83380400001)(26005)(356005)(336012)(7636003)(82310400003)(1076003)(921005)(9786002)(47076005)(7696005)(4326008)(6666004)(36756003)(36860700001)(426003)(110136005)(5660300002)(36906005)(7416002)(2906002)(2616005)(70206006)(107886003)(316002)(70586007)(478600001)(102446001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2021 08:11:20.9912
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe37197-b989-4eb4-e948-08d91b66da2d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0042.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB6120
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

