Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D97B0468179
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:41:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354301AbhLDApI (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:45:08 -0500
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:51905
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345008AbhLDApH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:45:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XwQMmR3J3RgRRr/fC2IThyNl03fzim/3brqpR3qutSqRtqcrZy+0Vp+cHXcvMpNHKDzOQs0A+nw4ZfbNGhJHAkQKy7/L4MIAKiW1bHfq5EwD51wH4+1qTl5wX9IGQQwW95wrS7uuJMQMFZ3zhUyUju64bcx16Xf6jSd6kfp+djbkMc35UU5/adxcwm0rMDZUGKMYCYAdIPl3C7vOJIE3Is2DhnBxpT2HtHYkKj6sV0l+EXmBCUDd/onmojksM6IqirFk3KmIH++ljmj83y0fxW40MJNzkNLwIwEU/8AybzrATYpXFwVj9nfVeUNBSF0dxpmw+2dZo7WJg17/ijw/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yb6YaclkZmg3XIllqgcdWPmBWIeAUwqsjxftzV+VG1I=;
 b=oLGhLoLHRpWpahbQkdZTtVoMXNuxfc55nFyP5fIgR7wT5LCbfwOo8Thvlm3sNaIvEYninb01+8w6y02LPhbvB2N3/UkxX9D0zLxexWjmWBbwnDCr0sRpgCI+kGc88hcUePBGLFq7ZRtyU2Aimmye4KwtWbPBlMMAO2cSVwBaLlAvLORbDuh1qJAQX3uAFicrs/fWdBWmf7orOyI8faiVIscgcZHwyGa+LjMBZ74+gr046V9UMm1SfThaXvE+bR0eu2YkoaqyLCr5APMaqacZgI6j2TUs073oJV5b82yI8IJFGdxPdvVnK44B6+xunG0HPntMCMqq+LstAubjlhnqaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yb6YaclkZmg3XIllqgcdWPmBWIeAUwqsjxftzV+VG1I=;
 b=F7JaKtZQqeWJQqQCK0+msgirX/Fk4hDxD/mZj7PrCJIibwVtN+D7BTGzURLBP/KuRswLJJRXGQwMoLMCC+AoQhhJo6BycJvCXE49WQ/h8/2JJRldDQSsg7WtHDx2H5KPUyhJOSJgFVbLQvwDrsvgxm+w9Jrox77DPl05TC6agYk=
Received: from BN6PR2001CA0014.namprd20.prod.outlook.com
 (2603:10b6:404:b4::24) by SJ0PR02MB8735.namprd02.prod.outlook.com
 (2603:10b6:a03:3e0::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Sat, 4 Dec
 2021 00:41:39 +0000
Received: from BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:404:b4:cafe::d4) by BN6PR2001CA0014.outlook.office365.com
 (2603:10b6:404:b4::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Sat, 4 Dec 2021 00:41:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT050.mail.protection.outlook.com (10.13.2.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:41:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:41:27 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:41:27 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55522 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ7H-000DhS-5C; Fri, 03 Dec 2021 16:41:27 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id A6724600852; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 8/8] fpga: xrt: management physical function driver
Date:   Fri, 3 Dec 2021 16:39:57 -0800
Message-ID: <20211204003957.1448567-9-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b78192d9-10b9-427b-05b9-08d9b6bed569
X-MS-TrafficTypeDiagnostic: SJ0PR02MB8735:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB8735CC0975DECB5FD6D79CB9A16B9@SJ0PR02MB8735.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:85;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZFrPwipG9pLmdbkkH5s3aFKtu7O0dODdoAUf+gBrZsk32n8xvGDIngXUkwN8cwv1jE9vRnC4n08nyhVFxg52/suxpsF1PZfLzrGgzD6tm/TcDf+42XHbkZRVPUs0zyENLoU2coxj7SIi7SjKr+iG6MfRWJ+lNJWjaqrR8aDck5ksSvA7594ejtv28FlXSYIzdUbrcS68ZaQPs+27QM4ne0P6e0t9LmwmghkadFuMuWnJC0jy/1thiaO0AeRtAppwv3avOgkXztEpXoeDqlFQQg5oKfPj+g68njwzZb7WfQollFp/RWWXu+WWXobDsF+vO8lTaLraw03IsNBEIrKRG+P2KZhuU+lj84Xqv0t040h3qFAMQt2d20zY9h6lUkg6F3UKLnY6NXFfeqRori2USNu4iLFSSDZq4b205pPXHMuFBe6VAr+VaUi0p81Nz/YfrvOfMCQVATLlnzrySHLc9iaf+nErQHXc3AjjWefxsJlRA2go9+bjuw1m4VreNyCFq9d/7YviBUeeExwxW7fv9VsqH96Zblk1oRAKS0g1UKZ0m5im3kGOOZeB2kHgSWmuUMyd3cCNM624IYGqRlz81ibT/VvC7wZYgm+8nB0h9OIi8hj9GlJytYprolfoyPDdccSNd0y4Edm17eOkqbOAXM8H5u+1sga/iCm0TX2znc5eFhOb5d1mZFnpIr31meW+WNSLa+HyjHUU7IHC57ndIg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(26005)(336012)(54906003)(426003)(44832011)(356005)(36756003)(36860700001)(186003)(2906002)(8676002)(8936002)(6666004)(6266002)(83380400001)(70206006)(2616005)(1076003)(107886003)(7636003)(70586007)(316002)(42186006)(47076005)(508600001)(6916009)(4326008)(82310400004)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:41:38.8700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b78192d9-10b9-427b-05b9-08d9b6bed569
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB8735
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The PCIE device driver which attaches to management function on Alveo
devices. It instantiates one or more group drivers which, in turn,
instantiate xrt drivers. The instantiation of group and xrt drivers is
completely dtb driven. A test dtb is used for this patchset.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/Makefile             |   1 +
 drivers/fpga/xrt/Kconfig          |   1 +
 drivers/fpga/xrt/mgmt/Kconfig     |  14 +++
 drivers/fpga/xrt/mgmt/Makefile    |  16 +++
 drivers/fpga/xrt/mgmt/dt-test.dts |  11 ++
 drivers/fpga/xrt/mgmt/dt-test.h   |  15 +++
 drivers/fpga/xrt/mgmt/xmgmt-drv.c | 167 ++++++++++++++++++++++++++++++
 7 files changed, 225 insertions(+)
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
index 000000000000..fd2d47fed0c5
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/Makefile
@@ -0,0 +1,16 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2021 Xilinx, Inc. All rights reserved.
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
index 000000000000..90fd1a1813d6
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.dts
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0
+/dts-v1/;
+
+/ {
+	compatible = "xlnx,xrt-group";
+	#address-cells = <3>;
+	#size-cells = <2>;
+	ep_fpga_configuration_00@0,0,1e88000 {
+		reg = <0 0 0x1e88000 0 0x8000>;
+	};
+};
diff --git a/drivers/fpga/xrt/mgmt/dt-test.h b/drivers/fpga/xrt/mgmt/dt-test.h
new file mode 100644
index 000000000000..25a8b86c381b
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/dt-test.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
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
index 000000000000..fb00ddc861f2
--- /dev/null
+++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
@@ -0,0 +1,167 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo Management Function Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
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
+#include "xroot.h"
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
+	void *root;
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
+	struct xroot_range ranges[PCI_NUM_RESOURCES];
+	struct xroot_info xr_info = { 0 };
+	struct device *dev = &pdev->dev;
+	int ret, i, idx = 0;
+	struct xmgmt *xm;
+	__be64 tmp;
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
+			ranges[idx].child_addr[0] = cpu_to_be32(i);
+			tmp = cpu_to_be64(pci_resource_start(pdev, i));
+			memcpy(ranges[idx].parent_addr, &tmp, sizeof(tmp));
+			tmp = cpu_to_be64(pci_resource_len(pdev, i));
+			memcpy(ranges[idx].child_size, &tmp, sizeof(tmp));
+			idx++;
+		}
+	}
+	xr_info.num_range = idx;
+	xr_info.ranges = ranges;
+	xr_info.addr = XMGMT_DEV_ID(pdev);
+	ret = xroot_probe(&pdev->dev, &xr_info, &xm->root);
+	if (ret)
+		goto failed;
+
+	ret = xroot_create_group(xm->root, __dtb_dt_test_begin,
+				 (u32)(__dtb_dt_test_end - __dtb_dt_test_begin));
+	if (ret) {
+		xmgmt_err(xm, "failed to create root group: %d", ret);
+		goto failed;
+	}
+
+	xmgmt_info(xm, "%s started successfully", XMGMT_MODULE_NAME);
+	return 0;
+
+failed:
+	if (xm->root)
+		xroot_remove(xm->root);
+	pci_set_drvdata(pdev, NULL);
+	return ret;
+}
+
+static void xmgmt_remove(struct pci_dev *pdev)
+{
+	struct xmgmt *xm = pci_get_drvdata(pdev);
+
+	xroot_remove(xm->root);
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

