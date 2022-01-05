Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0504B485BDC
	for <lists+linux-fpga@lfdr.de>; Wed,  5 Jan 2022 23:52:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245218AbiAEWwC (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 5 Jan 2022 17:52:02 -0500
Received: from mail-co1nam11on2050.outbound.protection.outlook.com ([40.107.220.50]:43851
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S245178AbiAEWvD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 5 Jan 2022 17:51:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd3sdm1gAAnefeCvVSe50qvc5+3BXXkVBtEgHerhcwzZ4mEdpzCOBreBiINEcODdrpGW53nuFAK6ZsHO6aSJLdFpV9WmhiA9Upz+SmTlmhxc4lOECusOISdbL9RdA2paRKEMtQ0jvB4G6a2Q/xK3JrUKICx21Blm8lg6wz/77a8w2LBpysk67yYAUX3GHOSayxlnGe+o3A2cFKr+rbDbQd5gR8QOP5AcR8PDLT7ET9DMcSjWPGiIkGPUj3LMX0/7zRpE98YPenqs1J12U4lhuRrM+mwU2Lrr3IQSt3TKoN58jFN+bmApDHjc0d+idnkiPOq73afJVQWByQAzPjKH8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sa4V/JxSV9doE4+XJwC4vcYV0b02IcNryo/K9fVitA=;
 b=DXrN9Kjm/W5jqv1/UrxoHBbZ58AxmQH3LSTjifWSCUmH/tf1S2uXhwZG5wlNLiYHrxkaYF/nrDyBVt5ls+y/n0iVJgOHKUtHEPCrX77UwJnCEF7mMqS1wBhANoFuqK5Nfq4ls+ttciUZT4eoL76me1BPanb+DXiVaP87AhTdoArFbg0KuD7Q/Wlh29yiUazJRl7A8GEQIW43GpgfQimfru1iFIeeGi8sMv/VcNXFM3k1SxM2vaHFhTQ23JExIKufAulUc8W4jXjNUz921CQgq/GmJ+Dq98ymhnNl5swljgKu2Vz8T2Z2YOK/NnW1OmnvHBkf2Ay5SPUfoj2EmMqRVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sa4V/JxSV9doE4+XJwC4vcYV0b02IcNryo/K9fVitA=;
 b=eNBvC+o9dK3IXXWkJs9qoZQ+T/YGHCMbidQUDZ20MrPArLWzyLEBA7EKkOZl1ERWGyY2ypeHyq4Sv7NbldmJzVW0gPaY4Hh97g/g2WwyO6bgI8UL1vcDKmuX2vl0T+0yPxJ6NF9cAKq/U1qdvnQgkqJj2w0CsyA1s+qH2mFz2wo=
Received: from DM5PR07CA0110.namprd07.prod.outlook.com (2603:10b6:4:ae::39) by
 DM6PR02MB6810.namprd02.prod.outlook.com (2603:10b6:5:214::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.7; Wed, 5 Jan 2022 22:51:01 +0000
Received: from DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::d8) by DM5PR07CA0110.outlook.office365.com
 (2603:10b6:4:ae::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14 via Frontend
 Transport; Wed, 5 Jan 2022 22:51:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT012.mail.protection.outlook.com (10.13.5.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4867.7 via Frontend Transport; Wed, 5 Jan 2022 22:51:00 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 5 Jan 2022 14:51:00 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 5 Jan 2022 14:51:00 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=56782 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1n5F7U-000B1h-8b; Wed, 05 Jan 2022 14:51:00 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id E412360018F; Wed,  5 Jan 2022 14:50:22 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo Infrastructure 4/5] fpga: xrt: xrt-lib common interfaces
Date:   Wed, 5 Jan 2022 14:50:12 -0800
Message-ID: <20220105225013.1567871-5-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
References: <20220105225013.1567871-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726a3ae5-dbd0-4eaf-c128-08d9d09dd886
X-MS-TrafficTypeDiagnostic: DM6PR02MB6810:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB6810B8998A3E4D04C10E1893A14B9@DM6PR02MB6810.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:499;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UPJATpf2450SGR8/Hufoq8ALard/IqbOGtXmWU1DikrCE0DBCSQWcSnRxVH5A1RSodNuFKwUjMg+mFBJL2RLkYPjn60qOwTFrSxfZWaba6m7fnrurlDTjf1iGnlcqauOTukvODxzaWGzgD17nYiSCKGBUkx0PMyP+OOsT9Ft25BnBtWrC9L2I6AjxI6iN5eoMurgpp7Fl+NINO+XvMgB9GSn0xwGKXCY7kC5pt//5ti3VIYQIi+TzMbl5dqAnBuCAcaDeFrujkYVWM+WzzGaaAGTzO5xGMFWnu1Z6GRpNx/R/cCXIrZxDybDzoe1Btoa8I011WgMTrIk8Sy2IbscBgeKLPlHZWcIdKUeTAnC2lx++iRMbCizma5YB8v2rhb3uNzGOgxKZQwX7t6v+MKk8IAu3xrzHRFd+4n4m4lKV/wFA1rL5A+m+Vn9P7Q5yhU9EfjBVzgch2sH/jttVggUR+uk5FZLt9BoU4rwaLaU+U/hGKr8Q1AEXWSNHZTD5skhm8FGCarxdRaWD7lXzecncl6qaleNWnhuRxr5qbaRZIhMV7vABTpl3IKypfmeQWUdfi8y8pS32XEwRAouL5F/NteACOdL4NfSNjuovNa5XPHjvNfzvRcnDX24/W/+C42PnoczwRsyXGXrGxPcSzmiy/m2oYYapvrMiwa3e8jrx3/vOyxZNfzKLtsZi5iLbKyDZ1zOftne8XdVwq4QabyzKg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(316002)(42186006)(4326008)(44832011)(70206006)(70586007)(5660300002)(6666004)(1076003)(8676002)(26005)(186003)(2906002)(54906003)(107886003)(6916009)(36756003)(2616005)(8936002)(7636003)(36860700001)(47076005)(356005)(426003)(336012)(82310400004)(6266002)(508600001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 22:51:00.9694
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a3ae5-dbd0-4eaf-c128-08d9d09dd886
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6810
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

The Alveo platform has to PCI fucntions. Each function has its own driver
attached. The common interfaces are created to support both drivers.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/Kconfig                  |   3 +
 drivers/fpga/Makefile                 |   3 +
 drivers/fpga/xrt/Kconfig              |   6 +
 drivers/fpga/xrt/include/xpartition.h |  28 ++++
 drivers/fpga/xrt/lib/Kconfig          |  17 +++
 drivers/fpga/xrt/lib/Makefile         |  15 +++
 drivers/fpga/xrt/lib/lib-drv.c        | 178 ++++++++++++++++++++++++++
 drivers/fpga/xrt/lib/lib-drv.h        |  15 +++
 8 files changed, 265 insertions(+)
 create mode 100644 drivers/fpga/xrt/Kconfig
 create mode 100644 drivers/fpga/xrt/include/xpartition.h
 create mode 100644 drivers/fpga/xrt/lib/Kconfig
 create mode 100644 drivers/fpga/xrt/lib/Makefile
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.c
 create mode 100644 drivers/fpga/xrt/lib/lib-drv.h

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 991b3f361ec9..93ae387c97c5 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
 	  configure the programmable logic(PL).
 
 	  To compile this as a module, choose M here.
+
+source "drivers/fpga/xrt/Kconfig"
+
 endif # FPGA
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 0bff783d1b61..5bd41cf4c7ec 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
 
 # Drivers for FPGAs which implement DFL
 obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
+
+# XRT drivers for Alveo
+obj-$(CONFIG_FPGA_XRT_LIB)		+= xrt/lib/
diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
new file mode 100644
index 000000000000..04c3bb5aaf4f
--- /dev/null
+++ b/drivers/fpga/xrt/Kconfig
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Xilinx Alveo FPGA device configuration
+#
+
+source "drivers/fpga/xrt/lib/Kconfig"
diff --git a/drivers/fpga/xrt/include/xpartition.h b/drivers/fpga/xrt/include/xpartition.h
new file mode 100644
index 000000000000..d72090ddfbee
--- /dev/null
+++ b/drivers/fpga/xrt/include/xpartition.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#ifndef _XRT_PARTITION_H_
+#define _XRT_PARTITION_H_
+
+struct xrt_partition_range {
+	u32 bar_idx;
+	u64 base;
+	u64 size;
+};
+
+struct xrt_partition_info {
+	int num_range;
+	struct xrt_partition_range *ranges;
+	void *fdt;
+	u32 fdt_len;
+};
+
+int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle);
+void xrt_partition_destroy(void *handle);
+
+#endif
diff --git a/drivers/fpga/xrt/lib/Kconfig b/drivers/fpga/xrt/lib/Kconfig
new file mode 100644
index 000000000000..73de1f50d5c6
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# XRT Alveo FPGA device configuration
+#
+
+config FPGA_XRT_LIB
+	tristate "XRT Alveo Driver Library"
+	depends on HWMON && PCI && HAS_IOMEM && OF
+	select REGMAP_MMIO
+	select OF_OVERLAY
+	help
+	  Select this option to enable Xilinx XRT Alveo driver library. This
+	  library is core infrastructure of XRT Alveo FPGA drivers which
+	  provides functions for working with device nodes, iteration and
+	  lookup of platform devices, common interfaces for platform devices,
+	  plumbing of function call and ioctls between platform devices and
+	  parent partitions.
diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
new file mode 100644
index 000000000000..698877c39657
--- /dev/null
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
+#
+# Authors: Sonal.Santan@xilinx.com
+#
+
+FULL_XRT_PATH=$(srctree)/$(src)/..
+
+obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
+
+xrt-lib-objs :=			\
+	lib-drv.o
+
+ccflags-y := -I$(FULL_XRT_PATH)/include
diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
new file mode 100644
index 000000000000..56334b2b9bec
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.c
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ *	Lizhi Hou <lizhi.hou@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
+#include "xpartition.h"
+#include "lib-drv.h"
+
+#define XRT_PARTITION_FDT_ALIGN		8
+#define XRT_PARTITION_NAME_LEN		64
+
+struct xrt_partition {
+	struct device *dev;
+	u32 id;
+	char name[XRT_PARTITION_NAME_LEN];
+	void *fdt;
+	struct property ranges;
+	struct of_changeset chgset;
+	bool chgset_applied;
+	void *dn_mem;
+};
+
+DEFINE_IDA(xrt_partition_id);
+
+static int xrt_partition_set_ranges(struct xrt_partition *xp, struct xrt_partition_range *ranges,
+				    int num_range)
+{
+	__be64 *prop;
+	u32 prop_len;
+	int i;
+
+	prop_len = num_range * (sizeof(u64) * 3);
+	prop = kzalloc(prop_len, GFP_KERNEL);
+	if (!prop)
+		return -ENOMEM;
+
+	xp->ranges.name = "ranges";
+	xp->ranges.length = prop_len;
+	xp->ranges.value = prop;
+
+	for (i = 0; i < num_range; i++) {
+		*prop = cpu_to_be64((u64)ranges[i].bar_idx << 60);
+		prop++;
+		*prop = cpu_to_be64(ranges[i].base);
+		prop++;
+		*prop = cpu_to_be64(ranges[i].size);
+		prop++;
+	}
+
+	return 0;
+}
+
+void xrt_partition_destroy(void *handle)
+{
+	struct xrt_partition *xp = handle;
+
+	if (xp->chgset_applied)
+		of_changeset_revert(&xp->chgset);
+	of_changeset_destroy(&xp->chgset);
+
+	ida_free(&xrt_partition_id, xp->id);
+	kfree(xp->dn_mem);
+	kfree(xp->fdt);
+	kfree(xp->ranges.value);
+	kfree(xp);
+}
+EXPORT_SYMBOL_GPL(xrt_partition_destroy);
+
+int xrt_partition_create(struct device *dev, struct xrt_partition_info *info, void **handle)
+{
+	struct device_node *parent_dn = NULL, *dn, *part_dn;
+	struct xrt_partition *xp = NULL;
+	void *fdt_aligned;
+	int ret;
+
+	xp = kzalloc(sizeof(*xp), GFP_KERNEL);
+	if (!xp)
+		return -ENOMEM;
+
+	ret = ida_alloc(&xrt_partition_id, GFP_KERNEL);
+	if (ret < 0) {
+		dev_err(dev, "alloc id failed, ret %d", ret);
+		kfree(xp);
+		return ret;
+	}
+	xp->id = ret;
+	of_changeset_init(&xp->chgset);
+
+	parent_dn = of_find_node_by_path("/");
+	if (!parent_dn) {
+		dev_err(dev, "did not find xrt node");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	xp->dev = dev;
+	snprintf(xp->name, XRT_PARTITION_NAME_LEN, "xrt-part@%x", xp->id);
+	ret = xrt_partition_set_ranges(xp, info->ranges, info->num_range);
+	if (ret)
+		goto failed;
+
+	xp->fdt = kmalloc(info->fdt_len + XRT_PARTITION_FDT_ALIGN, GFP_KERNEL);
+	if (!xp->fdt) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+	fdt_aligned = PTR_ALIGN(xp->fdt, XRT_PARTITION_FDT_ALIGN);
+	memcpy(fdt_aligned, info->fdt, info->fdt_len);
+
+	xp->dn_mem = of_fdt_unflatten_tree(fdt_aligned, NULL, &part_dn);
+	if (!xp->dn_mem) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	of_node_get(part_dn);
+	part_dn->full_name = xp->name;
+	part_dn->parent = parent_dn;
+	for (dn = part_dn; dn; dn = of_find_all_nodes(dn))
+		of_changeset_attach_node(&xp->chgset, dn);
+
+	ret = of_changeset_add_property(&xp->chgset, part_dn, &xp->ranges);
+	if (ret) {
+		dev_err(dev, "failed to add property, ret %d", ret);
+		goto failed;
+	}
+
+	ret = of_changeset_apply(&xp->chgset);
+	if (ret) {
+		dev_err(dev, "failed to apply changeset, ret %d", ret);
+		goto failed;
+	}
+	xp->chgset_applied = true;
+	of_node_put(parent_dn);
+
+	ret = of_platform_populate(part_dn, NULL, NULL, dev);
+	if (ret) {
+		dev_err(dev, "failed to populate devices, ret %d", ret);
+		goto failed;
+	}
+
+	*handle = xp;
+	return 0;
+
+failed:
+	if (parent_dn)
+		of_node_put(parent_dn);
+	xrt_partition_destroy(xp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xrt_partition_create);
+
+static __init int xrt_lib_init(void)
+{
+	return 0;
+}
+
+static __exit void xrt_lib_fini(void)
+{
+}
+
+module_init(xrt_lib_init);
+module_exit(xrt_lib_fini);
+
+MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx Alveo IP Lib driver");
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
new file mode 100644
index 000000000000..77ed5c399dcf
--- /dev/null
+++ b/drivers/fpga/xrt/lib/lib-drv.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2022 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _LIB_DRV_H_
+#define _LIB_DRV_H_
+
+extern u8 __dtb_xrt_begin[];
+extern u8 __dtb_xrt_end[];
+
+#endif	/* _LIB_DRV_H_ */
-- 
2.27.0

