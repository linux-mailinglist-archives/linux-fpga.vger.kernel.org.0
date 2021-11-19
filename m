Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C01634578BC
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236139AbhKSW3F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:29:05 -0500
Received: from mail-dm6nam12on2065.outbound.protection.outlook.com ([40.107.243.65]:20472
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236006AbhKSW3A (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:29:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gv4iPE1cKXmsApq5ZfYOqHuVQ37phcRuYWCGg4THW9jIKm5WAf32fXaHLFDA6/S2wExtWRY+EQv2GmaT4+oHYd2Qso+KmF1fXRlPcrDPtWmCssToQ8jnC8TcXjzK5D9pSrEm0V0Fu4ZxvE2izxb4s3YuwnjsMBb+jRCvjkDGOcY1q/alY9MviQh2dLYCMGkV0DeRxafI73YYeey0BQzuB0EB4Q7fuAg323UOn3VX7fQquJ/rU4e9AjQFrLP2y/w3tz2R4SMmY9d26NZsELmL55koDOnPXuXhCI/WRSULzGvnC5bjiS2evNbGwQMz+rgKJSzdWPo9qUg1hD2A7OGYBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=P0HyUtm7yxXQEWNtMkiEjJ/e56SvOeOlY9EzAqQlKJopQxTgq4mrzJYgm6i/bvfiFH4YAaAfGuSyHEvsg8H6S25DUn5rg7BPiIKs/SKn4HRvP98BpiaVWFga5Zde3YNZd1aoYNZw63xO2iteamMLXG8xhAzCKsuEUIISP1SOZSi8/isa7pMTzFfzLs5U80x+4NlcejFTBzO/qi/48iKJhqVl5Zlzysw45jajXE4J8RZxZCtXEl8GfKEQ/reNbuCQMyClVQNMc3HFhcF7zJiRpziZPzTJK5LP3qtj7PXTCO7WhzgD1qULv520EDdQpdOuIdOH1mGRNlnIRf+Rsf7Tng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLUPyaD2WNOJF2FSI+3UYA5mUG/m0S9MTFkcQnHq1JQ=;
 b=e8I97U6oCBZFXoX2iLlPsSv6buuwY8nCvfKRpm5KQPPioclESous8zmOVPvK1BCTs0cvqyCni6LPMhFhSyMktgUnJC633xDwnWmgbb47kwjUUbT+0eFac4FKuqNbDP9moj82st0c9tNy94KDAGqEZiClu23pDs862rIVEbbClT8=
Received: from DM6PR07CA0051.namprd07.prod.outlook.com (2603:10b6:5:74::28) by
 BN7PR02MB5347.namprd02.prod.outlook.com (2603:10b6:408:25::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.22; Fri, 19 Nov 2021 22:25:55 +0000
Received: from DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:74:cafe::7b) by DM6PR07CA0051.outlook.office365.com
 (2603:10b6:5:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Fri, 19 Nov 2021 22:25:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT029.mail.protection.outlook.com (10.13.4.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:25:55 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:25:51 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:25:51 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38946 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCKN-000Aik-1z; Fri, 19 Nov 2021 14:25:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 68775600150; Fri, 19 Nov 2021 14:24:15 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 8/9] fpga: xrt: xrt group device driver
Date:   Fri, 19 Nov 2021 14:24:11 -0800
Message-ID: <20211119222412.1092763-9-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2c12089-0f75-42f5-1e73-08d9abab8daa
X-MS-TrafficTypeDiagnostic: BN7PR02MB5347:
X-Microsoft-Antispam-PRVS: <BN7PR02MB534785F8C6E02A573DA8CD85A19C9@BN7PR02MB5347.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:199;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vsjgjzu2Ih3UlFBm/wDsy3MHqsYoV++wYtS3WUp/IMCpL8K2dsFLm7ShD/UUHXSgpN841L59pZpr0XJ+DoCE/WARa/ymsePdQ265mBFbDFbfDU+HX4+YFfH/3mtOx6okxyimYCVbOqmxV918BDcnjRgiVGkyJAt63yn5JFkXnBpW/jv3Ddpviydq+245ZePD8brcSF+oLgdXm8yh909FA/PdwCATcIkw28F4nmJYMhmdXBbChwvae4pzqdl062UGhwjhSSHsgMSKsafFn+OAFEz9bnflHi/k9L/LCbOfDd2XUVL7k4DNSaN8LWWMya5yVEfkeUDFol7Ohm56lkF04SltO4DzeYymWy1GrzlSYxwnGIM+7BG4Q4sB1xPKR/ffPgRuZwHV0IJKKpsPWIVC7U9wXh9VTsXZKab1OOrKg/s6PBjRJ+woJPD/y0603KAN4fRWqU/rG5bluyIpoo/cKKISP5MWaQpZFiIRhQR4uj7ojsPlcgxh2YidaTQja44bBrobR0tQGqpedsstgoeKqPc7MfubzmIJmKn2/4oNXmNY2mKZBlLdzhvuXyVfwHsg1nbxuNhwx6olL2aesHJbLif8fGwM/eYjhXTRObEAgFSqOZLwWCU2wZomNO4xuPLuyN68Yt3DYHd3FOGlDJ1sX0CMDPN9gqsJ/tXThvzn53yQ3JB/VuSjY6M9QuzHN1YRsuk3vLlAe2bF9RRdCBHWKg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(2616005)(1076003)(6266002)(8676002)(70206006)(6666004)(426003)(82310400003)(70586007)(186003)(7636003)(8936002)(107886003)(54906003)(36906005)(316002)(5660300002)(508600001)(356005)(47076005)(26005)(42186006)(6916009)(336012)(44832011)(2906002)(36860700001)(4326008)(36756003)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:25:55.3219
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2c12089-0f75-42f5-1e73-08d9abab8daa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5347
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

