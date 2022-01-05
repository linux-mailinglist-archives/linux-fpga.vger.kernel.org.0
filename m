Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84016485BE3
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245284AbiAEWww (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:52:52 -0500
Received: from mail-co1nam11on2052.outbound.protection.outlook.com ([40.107.220.52]:46432
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245206AbiAEWva (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:51:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+zBwZtciuvkaBQZsS1kVj4bHd42kwGikxMTeXU4wgJ6+l4F8SRRp4xHmCeveubbAcOgFRmvOiWjvT//x8k8eZ0pPMOF4DswFLoF/z357iW43eD6DdTfVsfyt0oK5S30HVq1iKbAbtRr61wrFYSrjzXzr0qNxzGkjRWkPcaUV9sDsRuGzMuSCOdgp9yspmVgwW/4sAIjCKrFz059CuxZzEz0tBsNuEuJrZoe6TtDLOUdlmNhuJkmq5xVmf7JnaOyz9Ch1bMb6lIHhDqVhsLA1udOwsTpRCWShwJPMMrxlyG/b1zsufBVQw5jlaTdsCPg1qE0ygL8T1xpTtYWh8Maeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EtWztmF2Hi0Q+lTPG5beVTB3yz/S0tUVWX6IStq8bSo=;
 b=Fqso6V+5L/xO75rp6iw+FJnhphi0jdkqw58Eb0VyM8oXiCgyLMgvZ4pgsnL6LL90lEipt9xk3QHKr9h3zxbvfjuVBA38eZ5Y983nJv5+n8XMKPJHCMhQ5TkHhgkNsvx/B0PSWlWwIuI4BE+YIUesDG56jyYcuT+j/6Pj4Kz6mCC7zTuZM8RuIdlzO4cb5KQBTxizk371UCBQpli2LThpKUXTAHahQK8capnYMfRT7l7iNn7+ah896nGsqF6RchDWqqmc3pyu/2/0T6ap3M3HI9yO8b9G72fsC2nmVBtmww8+CAPhGPM/RfJAc+CeoifvjjhG35w05PijBvLxRlFo0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EtWztmF2Hi0Q+lTPG5beVTB3yz/S0tUVWX6IStq8bSo=;
 b=k0ZylsoHgE9SwMXygrKcbUUVf63cu6nPinorNfWXdJ5wGU5gApedEpwqmJ5PXxnneb8PW0etv3no5sEbEGZC2T5X0OOVm79XtxYHfVo7KUwEjFtx9Nj0vwNVgH0rY2rqIOKr2yn9V3irAsKuUmpF1//EvxLxmOuqs+V0zPj6Rqg=
Received: from BN9PR03CA0908.namprd03.prod.outlook.com (2603:10b6:408:107::13)
 by MWHPR02MB2861.namprd02.prod.outlook.com (2603:10b6:300:109::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Wed, 5 Jan
 2022 22:51:27 +0000
Received: from BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::74) by BN9PR03CA0908.outlook.office365.com
 (2603:10b6:408:107::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7 via Frontend
 Transport; Wed, 5 Jan 2022 22:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT033.mail.protection.outlook.com (10.13.3.186) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:51:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:51:24 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:51:24 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56786 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F7s-000GOz-BI; Wed, 05 Jan 2022 14:51:24 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 0B37D60017A; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo Infrastructure 5/5] fpga: xrt: management physical function driver
Date:   Wed, 5 Jan 2022 14:50:13 -0800
Message-ID: <20220105225013.1567871-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61e5eb32-7b57-4418-7998-08d9d09de7ec
X-MS-TrafficTypeDiagnostic: MWHPR02MB2861:EE_
X-Microsoft-Antispam-PRVS: <MWHPR02MB2861A11B0336C5258CD18B0FA14B9@MWHPR02MB2861.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:83;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HnMER1vO/SnOHVs5KQKj6uH6jgWehA4HVjsJRa+lmeCeM5qA2BK39/fFX7/z664ZR0JKwlWkuNWXwuoYAxTznpfglXAv/lCVC9eMRZYpEr28bQMSI1mIB61UFHk7EU4jbuNk89pybrK7EYfIYgUGNG/ksRFhhkL3SnolAk97gslnd+WRZWLjHj4i4noZa4w1/R0fdVBWOxmCaDG+LMzseTce9oY08mvjaiQQyYP64MhbY0FLkNuc3I+O/naDDR6kJa5phXzco6Vskj7PBEDD57N/ujeoOTP7ogoz32LEnR/gxfKcgZtgsmaE/YHvRFlVQ6+V5gyqvAIAyYNunR9MqDnTEh13x6IuRuj3hxOMpFqki1PVDpU3hihfRuXJr7yUVJ86Wglo6FdydpW/lUQ6UrN6kXHYSzGaI8Fp5e9jhgynFlh6+Nj5wgAS5QldWYQPKEXjrH2fBmwBiDAGHJaOEab/i/mmjYhRIr+J7jwPzcCYVWHEzggNXuiuINL/0UYvcSdoxPATxBLync66L/eJ631unuO3YgV+cDvbCrR/tikf8ESJ/oY4+QZc0P1OGg9ei8Y87kI+oK7PhFutnmq3CUFl65QPTBUdTBsC6jsBpZcHIU56GgctRXR793WvGpmdKdzAiSBvtGIN3iSN/lVQSjJAc9JV0aEWNHGMFS3XlijgflwrvtQd2BpXQrqWzxfo/+b5RYEeW9vjYSPF4faEDg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(36860700001)(54906003)(6666004)(508600001)(82310400004)(2906002)(6266002)(47076005)(336012)(186003)(107886003)(8676002)(26005)(4326008)(8936002)(44832011)(70586007)(426003)(2616005)(70206006)(1076003)(42186006)(83380400001)(6916009)(36756003)(7636003)(356005)(316002)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:51:26.7550
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5eb32-7b57-4418-7998-08d9d09de7ec
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2861
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The PCIE device driver which attaches to management function on Alveo
devices. It instantiates one or more partition. Each partition consists
a set of hardward endpoints. A flat device tree is associated with each
partition. The first version of this driver uses test version flat device
tree and call xrt lib API to unflatten it.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/Makefile             |   1 +
 drivers/fpga/xrt/Kconfig          |   1 +
 drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
 drivers/fpga/xrt/mgmt/Makefile    |  16 +++
 drivers/fpga/xrt/mgmt/dt-test.dts |  12 +++
 drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
 drivers/fpga/xrt/mgmt/xmgmt-drv.c | 158 ++++++++++++++++++++++++++++++
 7 files changed, 217 insertions(+)
 create mode 100644 drivers/fpga/xrt/mgmt/Kconfig
 create mode 100644 drivers/fpga/xrt/mgmt/Makefile
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.dts
 create mode 100644 drivers/fpga/xrt/mgmt/dt-test.h
 create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c

diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 5bd41cf4c7ec..544e2144878f 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -52,3 +52,4 @@ obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
 
 # XRT drivers for Alveo
 obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
+obj-$(CONFIG_FPGA_XRT_XMGMT)		+= xrt/mgmt/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
index 04c3bb5aaf4f..50422f77c6df 100644
--- a/drivers/fpga/xrt/Kconfig
+++ b/drivers/fpga/xrt/Kconfig
@@ -4,3 +4,4 @@
 #
 
 source "drivers/fpga/xrt/lib/Kconfig"
+source "drivers/fpga/xrt/mgmt/Kconfig"
diff --git a/drivers/fpga/xrt/mgmt/Kconfig b/drivers/fpga/xrt/mgmt/Kconfig
new file mode 100644
index 000000000000..a978747482be
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx XRT FPGA device configuration
+#
+
+config FPGA_XRT_XMGMT
+	tristate "Xilinx Alveo Management Driver"
+	depends on FPGA_XRT_LIB
+	select FPGA_BRIDGE
+	select FPGA_REGION
+	help
+	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
+	  This driver provides interfaces for userspace application to access
+	  Alveo FPGA device.
diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
new file mode 100644
index 000000000000..c5134bf71cca
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+
+obj-$(CONFIG_FPGA_XRT_LIB) += xrt-mgmt.o
+
+xrt-mgmt-objs :=		\
+	xmgmt-drv.o		\
+	dt-test.dtb.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include
diff --git a/drivers/fpga/xrt/mgmt/dt-test.dts b/drivers/fpga/xrt/mgmt/dt-test.dts
new file mode 100644
index 000000000000..68dbcb7fd79d
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.dts
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/ {
+	compatible = "xlnx,alveo-partition", "simple-bus";
+	#address-cells = <2>;
+	#size-cells = <2>;
+	pr_isolate_ulp@0,41000 {
+		compatible = "xlnx,alveo-pr-isolation";
+		reg = <0x0 0x41000 0x0 0x1000>;
+	};
+};
diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
new file mode 100644
index 000000000000..6ec4203afbd2
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#ifndef _DT_TEST_H_
+#define _DT_TEST_H_
+
+extern u8 __dtb_dt_test_begin[];
+extern u8 __dtb_dt_test_end[];
+
+#endif	/* _DT_TEST_H_ */
diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
new file mode 100644
index 000000000000..87abe5b86e0b
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ *	Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/aer.h>
+#include <linux/vmalloc.h>
+#include <linux/delay.h>
+#include "xpartition.h"
+#include "dt-test.h"
+
+#define XMGMT_MODULE_NAME	"xrt-mgmt"
+
+#define XMGMT_PDEV(xm)		((xm)->pdev)
+#define XMGMT_DEV(xm)		(&(XMGMT_PDEV(xm)->dev))
+#define xmgmt_err(xm, fmt, args...)	\
+	dev_err(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_warn(xm, fmt, args...)	\
+	dev_warn(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_info(xm, fmt, args...)	\
+	dev_info(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define xmgmt_dbg(xm, fmt, args...)	\
+	dev_dbg(XMGMT_DEV(xm), "%s: " fmt, __func__, ##args)
+#define XMGMT_DEV_ID(_pcidev)			\
+	({ typeof(_pcidev) (pcidev) = (_pcidev);	\
+	((pci_domain_nr((pcidev)->bus) << 16) |	\
+	PCI_DEVID((pcidev)->bus->number, (pcidev)->devfn)); })
+
+#define XRT_MAX_READRQ		512
+
+/* PCI Device IDs */
+#define PCI_DEVICE_ID_U50		0x5020
+static const struct pci_device_id xmgmt_pci_ids[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
+	{ 0, }
+};
+
+struct xmgmt {
+	struct pci_dev *pdev;
+	void *base_partition;
+
+	bool ready;
+};
+
+static int xmgmt_config_pci(struct xmgmt *xm)
+{
+	struct pci_dev *pdev = XMGMT_PDEV(xm);
+	int rc;
+
+	rc = pcim_enable_device(pdev);
+	if (rc < 0) {
+		xmgmt_err(xm, "failed to enable device: %d", rc);
+		return rc;
+	}
+
+	rc = pci_enable_pcie_error_reporting(pdev);
+	if (rc)
+		xmgmt_warn(xm, "failed to enable AER: %d", rc);
+
+	pci_set_master(pdev);
+
+	rc = pcie_get_readrq(pdev);
+	if (rc > XRT_MAX_READRQ)
+		pcie_set_readrq(pdev, XRT_MAX_READRQ);
+	return 0;
+}
+
+static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	struct xrt_partition_range ranges[PCI_NUM_RESOURCES];
+	struct xrt_partition_info xp_info = { 0 };
+	struct device *dev = &pdev->dev;
+	int ret, i, idx = 0;
+	struct xmgmt *xm;
+
+	xm = devm_kzalloc(dev, sizeof(*xm), GFP_KERNEL);
+	if (!xm)
+		return -ENOMEM;
+	xm->pdev = pdev;
+	pci_set_drvdata(pdev, xm);
+
+	ret = xmgmt_config_pci(xm);
+	if (ret)
+		goto failed;
+
+	for (i = 0; i < PCI_NUM_RESOURCES; i++) {
+		if (pci_resource_len(pdev, i) > 0) {
+			ranges[idx].bar_idx = i;
+			ranges[idx].base = pci_resource_start(pdev, i);
+			ranges[idx].size = pci_resource_len(pdev, i);
+			idx++;
+		}
+	}
+	xp_info.num_range = idx;
+	xp_info.ranges = ranges;
+	xp_info.fdt = __dtb_dt_test_begin;
+	xp_info.fdt_len = (u32)(__dtb_dt_test_end - __dtb_dt_test_begin);
+	ret = xrt_partition_create(&pdev->dev, &xp_info, &xm->base_partition);
+	if (ret)
+		goto failed;
+
+	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
+	return 0;
+
+failed:
+	if (xm->base_partition)
+		xrt_partition_destroy(xm->base_partition);
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void xmgmt_remove(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	xrt_partition_destroy(xm->base_partition);
+	pci_disable_pcie_error_reporting(xm->pdev);
+	xmgmt_info(xm, "%s cleaned up successfully", XMGMT_MODULE_NAME);
+}
+
+static struct pci_driver xmgmt_driver = {
+	.name = XMGMT_MODULE_NAME,
+	.id_table = xmgmt_pci_ids,
+	.probe = xmgmt_probe,
+	.remove = xmgmt_remove,
+};
+
+static int __init xmgmt_init(void)
+{
+	int res = 0;
+
+	res = pci_register_driver(&xmgmt_driver);
+	if (res)
+		return res;
+
+	return 0;
+}
+
+static __exit void xmgmt_exit(void)
+{
+	pci_unregister_driver(&xmgmt_driver);
+}
+
+module_init(xmgmt_init);
+module_exit(xmgmt_exit);
+
+MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo management function driver");
+MODULE_LICENSE("GPL v2");
-- 
2.27.0

