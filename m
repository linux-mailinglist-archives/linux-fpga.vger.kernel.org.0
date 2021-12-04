Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C07246817C
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383892AbhLDApV (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:45:21 -0500
Received: from mail-dm6nam11on2083.outbound.protection.outlook.com ([40.107.223.83]:30816
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345008AbhLDApU (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:45:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPvH3SzJKzJ0DBNfsl5f4Rm0t8C1x7GZroOwjB1LcaP8fmSZpLMBaUQlCO38Zxmp+6db8mUdMrG5sqa8XGc0UnJHijLJdDdCQ5DyXafPCS+qD3lxjAyG8qj5E+77rLQdQprNK2wP++vhKs+mw0A2WxN5vj7lCPDHljjV0oODHBsliFqqpj5EQHD3IMYp+INc+tQjlZ2p7m6KiyJ86LeoW1D4m0Q+tqzoLuWJSWE4Qf3ZJx3pey3nsGOwW3J9w0QtsS0FdtKAcAWOWLQK+8Whwb1MiM99sdjoG3GnXErBWgZ36Y+w8g83rzu6o27rVcRoVCapQzn+n2KF9wE3LGsH/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=b1ZYGFS2ecog4Sgc/tCWi0Sxw6BZ7ACYuhQVFuqjmgO8fsb8GNvST/rQ6pauv0wzq9fuNm6OK7ZWW06BiyX1mom+lanQuAGATgPA61itRlZY8IBpAM2BG1CJ5H2jwkyDJdDeFeIh+nRr+iIILcN/wEguc9UZ7rnqxET4D0iy26K6T6a6ybl+TtxVA2XKQQWPxo1EX8hN8itT5geJ7LomoaoI7wypSET3N6IjwbixLLzyR5s9FWxxAQc9mujaHj/qV28ReCnaes/P0ojfuFhBrRVDGgNY66tIsdTfBW4WaqB8tndqkV+4K5jWG6uo2ZBb0I6Ng6CTIJ5VC0JgxJAahg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=dQtXZXv0XSc3WTu6rx6OQ+OOvTEE+w+T0RvE3QWk8ZGCsbMeW4OVbk70UpKeBA0QEIKpCEC1RzcoFyGdGv64FAoGnmrsdmxXCWmGIfZ0gOGmQ9DA/nPRce5BPSuGiac2iWvyee6aQ2JR2UAs5+U+9sco0DyokxKlS2r5d3J+StQ=
Received: from BN6PR2001CA0032.namprd20.prod.outlook.com
 (2603:10b6:405:16::18) by CY4PR02MB2629.namprd02.prod.outlook.com
 (2603:10b6:903:73::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14; Sat, 4 Dec
 2021 00:41:53 +0000
Received: from BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::ff) by BN6PR2001CA0032.outlook.office365.com
 (2603:10b6:405:16::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11 via Frontend
 Transport; Sat, 4 Dec 2021 00:41:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT026.mail.protection.outlook.com (10.13.2.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:41:52 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:41:39 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:41:39 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55524 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ7T-000DiB-6m; Fri, 03 Dec 2021 16:41:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id BD783600854; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 7/8] fpga: xrt: xrt group device driver
Date:   Fri, 3 Dec 2021 16:39:56 -0800
Message-ID: <20211204003957.1448567-8-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 06d79ee8-a9bf-471b-47b8-08d9b6bedda6
X-MS-TrafficTypeDiagnostic: CY4PR02MB2629:
X-Microsoft-Antispam-PRVS: <CY4PR02MB2629E861F1B13730B515BEAFA16B9@CY4PR02MB2629.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nsHsgD/LVIj3m9fPSoGbv9M0gLWUZLtxI5M/P5gUPD3GH0g6EiBe/MD+GZ0j+FTSOvG7V6bRFNZOwQBEPtlU9yt8lC6qDDMW5OHoq9GmwjW5RE52TZkV8y+nIhremzF0OBLPAV14H6j9dJ6EFj6rNIs/wyO+WOpa0u0iDGkKwPfWVKWm+uBtsZKE6EqvkixmVfF3VVLiz2Jqvy+rH/oAbpeAY7B4tLywLVuc1gEMV8QJwFGNZHtJ7U5Ld7L4ZIQ2GHw8UKeRm6PvEs64OA8X3Bc+H7rtorB/P+ZlqVqZsFh2wNOhHnnVANl3x4Oenw5IjIURlTjLlK3WHVtg62PWR89xXzYYhE8IzDQpVfuzhaIrj1AwL1qP7NQb3Ve2nU/qzHC2J9oWVnTRVhnWg1tVZpvG5oQJ+8qOo46syJo+R4pB+KWy9rLhIBymnRTAv6/kAiarlH/o8zDoDPv7l09HLPspLrdLSmafOW2W7hqPKNfJAFsSwAluuljcctYrktC0eaFVeGc1HXtRzFEV61SfP7tTov4b8ENIgCZALshVYT+jHdpt2YYH7lwc7kNE3gi7F4FKndCSHFvUbjkpeZ7NP5bfeZHpzdLypjCcAypa7dOeL5hAAwW6QsG4INTcVkITQZGYvVY0VSI6dxXs9kdhu1JrtFk+5FaTofGHURiDkHmcRUnn+HVy3c5OWD/fEuBfZJRaaOw4R0fudwmKB7xhRQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(70206006)(42186006)(70586007)(6266002)(26005)(5660300002)(82310400004)(107886003)(508600001)(4326008)(186003)(336012)(2616005)(44832011)(426003)(54906003)(36860700001)(6916009)(83380400001)(36756003)(356005)(8676002)(6666004)(47076005)(7636003)(316002)(2906002)(1076003)(8936002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:41:52.7089
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d79ee8-a9bf-471b-47b8-08d9b6bedda6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT026.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2629
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

group driver that manages life cycle of a bunch of leaf driver instances.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/Makefile  |  1 +
 drivers/fpga/xrt/lib/group.c   | 94 ++++++++++++++++++++++++++++++++++
 drivers/fpga/xrt/lib/lib-drv.c | 18 ++++++-
 drivers/fpga/xrt/lib/lib-drv.h | 13 +++++
 4 files changed, 125 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fpga/xrt/lib/group.c

diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
index fd2af2cbd1da..abf7d5341a69 100644
--- a/drivers/fpga/xrt/lib/Makefile
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
 xrt-lib-objs :=			\
 	lib-drv.o		\
 	xroot.o			\
+	group.o			\
 	xrt-bus.dtb.o
 
 ccflags-y := -I$(FULL_XRT_PATH)/include
diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
new file mode 100644
index 000000000000..feafc45ddb52
--- /dev/null
+++ b/drivers/fpga/xrt/lib/group.c
@@ -0,0 +1,94 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Group Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include <linux/kmod.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/xrt/xdevice.h>
+#include "lib-drv.h"
+#include "xroot.h"
+
+#define XRT_GRP "xrt_group"
+
+struct xgroup_leaf {
+	struct list_head node;
+	struct xrt_device *leaf_dev;
+};
+
+struct xgroup {
+	struct xrt_device *xdev;
+	struct list_head leaves;
+};
+
+static int xrt_grp_probe(struct xrt_device *xdev)
+{
+	struct xgroup_leaf *leaf;
+	struct xgroup *xg = NULL;
+	struct device_node *dn;
+
+	dev_info(&xdev->dev, "probing\n");
+
+	xg = devm_kzalloc(&xdev->dev, sizeof(*xg), GFP_KERNEL);
+	if (!xg)
+		return -ENOMEM;
+
+	xg->xdev = xdev;
+	INIT_LIST_HEAD(&xg->leaves);
+	xrt_set_drvdata(xdev, xg);
+
+	for_each_child_of_node(xdev->dev.of_node, dn) {
+		leaf = kmalloc(sizeof(*leaf), GFP_KERNEL);
+		if (!leaf)
+			break;
+
+		leaf->leaf_dev = xrt_device_register(&xdev->dev, dn, NULL, 0, NULL, 0);
+		if (!leaf->leaf_dev) {
+			kfree(leaf);
+			continue;
+		}
+		list_add(&leaf->node, &xg->leaves);
+	}
+
+	return 0;
+}
+
+static void xrt_grp_remove(struct xrt_device *xdev)
+{
+	struct xgroup *xg = xrt_get_drvdata(xdev);
+	struct xgroup_leaf *leaf, *tmp;
+
+	list_for_each_entry_safe(leaf, tmp, &xg->leaves, node) {
+		list_del(&leaf->node);
+		xrt_device_unregister(leaf->leaf_dev);
+		kfree(leaf);
+	}
+}
+
+static int xrt_grp_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	return 0;
+}
+
+static const struct of_device_id group_match[] = {
+	{ .compatible = "xlnx,xrt-group" },
+	{ }
+};
+
+static struct xrt_driver xrt_group_driver = {
+	.driver	= {
+		.name = XRT_GRP,
+		.of_match_table = group_match,
+	},
+	.probe = xrt_grp_probe,
+	.remove = xrt_grp_remove,
+	.leaf_call = xrt_grp_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(group);
diff --git a/drivers/fpga/xrt/lib/lib-drv.c b/drivers/fpga/xrt/lib/lib-drv.c
index 3ad02a7c2aac..c9c654f692d4 100644
--- a/drivers/fpga/xrt/lib/lib-drv.c
+++ b/drivers/fpga/xrt/lib/lib-drv.c
@@ -200,9 +200,17 @@ xrt_device_register(struct device *parent, struct device_node *dn,
 	return NULL;
 }
 
+/*
+ * Leaf driver's module init/fini callbacks. This is not a open infrastructure for dynamic
+ * plugging in drivers. All drivers should be statically added.
+ */
+static void (*leaf_init_fini_cbs[])(bool) = {
+	group_leaf_init_fini,
+};
+
 static __init int xrt_lib_init(void)
 {
-	int ret;
+	int ret, i;
 
 	ret = of_overlay_fdt_apply(__dtb_xrt_bus_begin,
 				   __dtb_xrt_bus_end - __dtb_xrt_bus_begin,
@@ -216,11 +224,19 @@ static __init int xrt_lib_init(void)
 		return ret;
 	}
 
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](true);
+
 	return 0;
 }
 
 static __exit void xrt_lib_fini(void)
 {
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(leaf_init_fini_cbs); i++)
+		leaf_init_fini_cbs[i](false);
+
 	bus_unregister(&xrt_bus_type);
 	of_overlay_remove(&xrt_bus_ovcs_id);
 }
diff --git a/drivers/fpga/xrt/lib/lib-drv.h b/drivers/fpga/xrt/lib/lib-drv.h
index 4bf8a32c7ec5..02d9b3731351 100644
--- a/drivers/fpga/xrt/lib/lib-drv.h
+++ b/drivers/fpga/xrt/lib/lib-drv.h
@@ -9,6 +9,19 @@
 #ifndef _LIB_DRV_H_
 #define _LIB_DRV_H_
 
+/* Module's init/fini routines for leaf driver in xrt-lib module */
+#define XRT_LEAF_INIT_FINI_FUNC(name)					\
+void name##_leaf_init_fini(bool init)					\
+{									\
+	if (init)							\
+		xrt_register_driver(&xrt_##name##_driver);		\
+	else								\
+		xrt_unregister_driver(&xrt_##name##_driver);		\
+}
+
+/* Module's init/fini routines for leaf driver in xrt-lib module */
+void group_leaf_init_fini(bool init);
+
 extern u8 __dtb_xrt_bus_begin[];
 extern u8 __dtb_xrt_bus_end[];
 
-- 
2.27.0

