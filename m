Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A824564D5
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:05:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232944AbhKRVIg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:08:36 -0500
Received: from mail-co1nam11on2049.outbound.protection.outlook.com ([40.107.220.49]:52321
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232591AbhKRVIg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:08:36 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp161UpHygB9QbN9zG1+qgK/o39PUgC9UfLrLwZOe0zNrxTHynn0MdZklTrGYJ6rGFIwIZcNNeBDv15uHZWONQfqPyIQk9X8s/aTA9nAHQCyIOnr22alnTHRjxJsGq9MNH6vOmAX7nBAWB6Q60XauyQYqY9SKM/ieCtVhw/6VFXcEDXgd4ayfTcLnySUpE9AvvxQCvUo4BP/knSBzV3NuN9XdIxwJqdB5zMl/thqWAmquvwzHyD3mGnv+7PLFJtrWkx/+dy3jcWxwly7cPPIS7Ej3NwDTjZGYdV7VGrBiJMpBcIPIHZj2MFvC0Z567swvGvo9plnFZNAj6CI8IjLZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=NvgIrd8owY50IBk0eQ9SCTszcpujxviu0wytc8R7ZqX/ZWKCfCS3lyY4FN22guLoNqzvMDrjc3sPLJA0bSMDibVW2PdC56R1pmLHtL8m/B43clGTYzfR7Hzc9pdMK9n0sZK7IoYz97On5RhHNz31bzF1ZSFIs1E7JUBrLKML+cybIhsmSCy8bw95wXxtLAPlRFsotRKyeMNj4lYg/26a1yxnOjH29RCB541WQevWBs3xgVQqjU0zqhfgnwSjOGVq2G1BWbCbBictcpmn06Y7/nEAXRNETvrIMWkXVWn9StAMtG9b7J5KgK4+V9JVTdvIJthAe/44jjCC+NsNwqO0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=DmBhSGcCPw1irZEzUI28ak4qIg3mGGowN/BcqnGZTPv3NVsq6GnHnqHbCpJ/EkH26Exen+3GaqtyQWZkvBa45FI+7TDrvco9LVgiUT9KQ0j9Fg53ZbuavrolQf0vuGZ9LoYO2kHhIY+b72FtIA9keHdikjBqRAms3jmOpg+ak5E=
Received: from BN6PR2001CA0041.namprd20.prod.outlook.com
 (2603:10b6:405:16::27) by CH2PR02MB7063.namprd02.prod.outlook.com
 (2603:10b6:610:83::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:05:32 +0000
Received: from BN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:16:cafe::e0) by BN6PR2001CA0041.outlook.office365.com
 (2603:10b6:405:16::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.22 via Frontend
 Transport; Thu, 18 Nov 2021 21:05:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT006.mail.protection.outlook.com (10.13.2.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4690.19 via Frontend Transport; Thu, 18 Nov 2021 21:05:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:05:12 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:05:12 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37764 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoam-0001ij-Ne; Thu, 18 Nov 2021 13:05:12 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 4418560014A; Thu, 18 Nov 2021 13:03:37 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 8/9] fpga: xrt: xrt group device driver
Date:   Thu, 18 Nov 2021 13:03:22 -0800
Message-ID: <20211118210323.1070283-9-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc3d58ae-36a9-4628-fd4e-08d9aad7287b
X-MS-TrafficTypeDiagnostic: CH2PR02MB7063:
X-Microsoft-Antispam-PRVS: <CH2PR02MB70634A537296A5239A36D387A19B9@CH2PR02MB7063.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ca5ppYfpbX9Cqw4Vh4fQMdhBXGgjUpc5KWTqLxlLFJPI/B8MIpe3qMa/4Ss0rKJP/lNRjMAygjgP8bPMHfZttzLz+m+Q3mV4z8wLb15ty6s5eGHHkE9RqD30ce0mArftjMAyyQ00/S0+/rtOex0YGhEmlESH7n7Mx+IMXAS4SzHeqo/E+syIGvVQ86icRIb5e2XZsBI+SCC9ur3mW+ET3hB7bB0RwHCJnsVtO8HXgHRCvzVqj376xXzZnM43js6//QLoIS1DsRac1yWVFLWwodKBFOHke+PUcQG/d1fkyp09M4xsFWtg6BkCQmixHszTZxJ0D6PRivqxWZ31o745eCz7fi3NDBLXnHr0L2Yq4Eus6A2aEEQagKQ0l6bc3EZOtBQxaRrws2r88O54OWhwt7peoWozZYZlWJwlKfQJ7RcbI92wWVzJXIhChScfx7d80dY07z/2ixEnjmzLVolMJ3ENewTCGXvRbxmepGdNEbqRO6zdzjCgjYjeG/aX8kDHsVjn6tWgnfxFPp4AktlYlLWE+Kw/5k26fEymBqbYHAWtTUgGFBNwDUUxwYewl+leQzJekoe++H+/0O+OSTY6rVEjvhOPG0FOhiq6zy/9T3jjXhdnF37DcqlbgkqIXaT3QiqQNVmW2dyLIa3uziUF0HPE7bBKznpCq/UEw2KE6hL6PPBYpPKE9rE6WthG+Hjm/NtLMux2VeE7OMVO/5qMZw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(47076005)(6666004)(54906003)(42186006)(4326008)(356005)(5660300002)(2906002)(83380400001)(36756003)(8676002)(7636003)(1076003)(70206006)(36906005)(70586007)(316002)(8936002)(6916009)(508600001)(26005)(426003)(44832011)(107886003)(6266002)(186003)(336012)(36860700001)(82310400003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:05:32.2131
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc3d58ae-36a9-4628-fd4e-08d9aad7287b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR02MB7063
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

