Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 027DB4578B4
	for <lists+linux-fpga@lfdr.de>; Fri, 19 Nov 2021 23:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhKSW2u (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 19 Nov 2021 17:28:50 -0500
Received: from mail-bn8nam11on2060.outbound.protection.outlook.com ([40.107.236.60]:57281
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235824AbhKSW2r (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 19 Nov 2021 17:28:47 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inlXoMCtbvFpf2zADWawS1DI12TOpzsJBs/QYLsaYvtl6EN6wp39iPf2efLmWhdazAiPAEmjM9pDXs5DYjlL8wmje4ag3z3GfLfMkwEyK0hhRMlP/FmHs3wwV+lpyFED/y0P9/FnSpdp+FcBzocjDB7o1sYJc/H7Y7MVbgDZ2gplNWGU5er0RhoI76lS8/nrXT3Oq1CnNAQOgyRLfCodrfv7bFJegtcpYHr0K5JiBu599dXFN076JyVvsXQCkQKXDr3MQdX4PojV36rJIXJ5i3BRP2mY5y7XmEZDrSypcvBiFMXKtphHOLdec3yJuJ5kCg+nGMNmCgQeyzdL21+BVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSUAgszNk8jNWzaSQkn0mEGh7RDfYQh4C6ZuMbWeU4c=;
 b=KignzY5L1Vqidw/0AhDl029vouCTwBrOHlWjqUx4wisyZAmctq/a/+wRTs1RAS6py9lA37CSEYqccdgN6Ew2x+yeW08BgsBdwP16wZ+6mpDmRHj3R6h2YghFk+Il4ihOO/b5JYOEYGB3s5AlgZrFbcjFdKt5zpFXCIFEl6PSq2rHVloaWPBfGn+nq1HTzsNT+cMK0BJPVEJ/CSRdQFni03e7cE2vXvLeHbUB3b4g4n7BQedFsHpvmzxmLRwHgyEZpPHdwY7jVI2FZaCys3qZN8k7C28vR0FXSUWLOqDH3i5r5xb9lUFX5VgtVLCKWZ4HQK2LkJVgZ1EB9SnypZYvuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSUAgszNk8jNWzaSQkn0mEGh7RDfYQh4C6ZuMbWeU4c=;
 b=j0KiXbsfcrONwWaRdkr1485niMGqDt2VGDRbMYSc/0fmNObs6YpQN+RO0AkkfNeGGa03OgRv6nyx3wPZ6csen94wtKBapZFbWQyJuLmizlub8iAOWHIV0OClNOTqswoDqZh3yoTMS9/KME2dePhvm9eLfio2LywRQfuQz3RIny8=
Received: from DM5PR21CA0039.namprd21.prod.outlook.com (2603:10b6:3:ed::25) by
 BN7PR02MB5283.namprd02.prod.outlook.com (2603:10b6:408:30::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4690.27; Fri, 19 Nov 2021 22:25:42 +0000
Received: from DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:ed:cafe::8f) by DM5PR21CA0039.outlook.office365.com
 (2603:10b6:3:ed::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.13 via Frontend
 Transport; Fri, 19 Nov 2021 22:25:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT060.mail.protection.outlook.com (10.13.4.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Fri, 19 Nov 2021 22:25:42 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 19 Nov 2021 14:25:39 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 19 Nov 2021 14:25:39 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=38944 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1moCKB-0001QY-0M; Fri, 19 Nov 2021 14:25:39 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 53C3B60014E; Fri, 19 Nov 2021 14:24:15 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V2 XRT Alveo Infrastructure 7/9] fpga: xrt: lib-xrt xroot APIs
Date:   Fri, 19 Nov 2021 14:24:10 -0800
Message-ID: <20211119222412.1092763-8-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
References: <20211119222412.1092763-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23c55147-b12b-41b4-64b1-08d9abab85d9
X-MS-TrafficTypeDiagnostic: BN7PR02MB5283:
X-Microsoft-Antispam-PRVS: <BN7PR02MB5283CF079F5536C8D9FACFF7A19C9@BN7PR02MB5283.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5pTntAnVN+O9e9zgdYdifrYrI6eG/nk6zeT0NopWrUV+OAOJrv4V0VYgmgeq52tDtFbe6tsl3dlTDW97Gezkqr+BKpXJyHN1GQGMLd1sGJvQkLZgAgStoe1HVJWSgTWllhU4BBUJParkElChHXZvX3NuuTbFccqh8LlQSQtPAQ12qf90BgMFi/IHARB6jyTUQ5yIaBYZgFrPrVnP5PnlhtxOI9W6Jej5u/nv9o4/IcA59+gtUQAZjyqApxJ5rKjMwSBdrl9piHB0XH/ylAeE1UNKp3Hr3yB/OAjfO3MzNlGwuXCyqLlklrW8aDX1eVDr/YT/dLL3A30BKktRjP6RoNBkTujIZO0cTJ5wMfFSZkjtaUdGDOZaNcYGWE7FdMxveYtxyZQ6e7sy+wr8gkFbuqyMQ7F7jHEAX7x5shp+zbmT6+RYTExpKTou53HiTNsBBhJRo3oQOwlQSu7q9eHr1eXyqLFsM71ZmAikr/CIS09x7R7zC/bQWgNnPP/tAiFpwZizOYVaYeBHFkh5zhLy4891CxikJzo1T58bOMbr8wmXKqYWcLgoQER8yKsgJi4ZDeQoBAzLalmlNwBnc4rdKn0KgTNsslTsIah47kxJeHtQBe6BldVRLoeizwChK3uBmUS3E/09G2M7p3XsSf41kFDf0V4DptW1EkKyVaT6434VyS4ua1QhW4a65IAo+hnIWzNPM2zLn0hEV/JW1QmIBw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(36840700001)(46966006)(6666004)(6266002)(47076005)(8676002)(2616005)(426003)(36860700001)(7636003)(336012)(5660300002)(36756003)(44832011)(6916009)(70586007)(356005)(42186006)(508600001)(8936002)(70206006)(36906005)(1076003)(107886003)(316002)(186003)(26005)(54906003)(2906002)(4326008)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2021 22:25:42.2090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c55147-b12b-41b4-64b1-08d9abab85d9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT060.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5283
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

lib-xrt infrastructure code to create xrt group device.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xroot.h |  30 +++++
 drivers/fpga/xrt/lib/Makefile    |   1 +
 drivers/fpga/xrt/lib/xroot.c     | 210 +++++++++++++++++++++++++++++++
 3 files changed, 241 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/xroot.c

diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
new file mode 100644
index 000000000000..6ea1b64b3ae3
--- /dev/null
+++ b/drivers/fpga/xrt/include/xroot.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_ROOT_H_
+#define _XRT_ROOT_H_
+
+struct xroot_range {
+	__be32 child_addr[3];
+	__be32 parent_addr[2];
+	__be32 child_size[2];
+};
+
+struct xroot_info {
+	u32 addr;
+	int num_range;
+	struct xroot_range *ranges;
+};
+
+int xroot_probe(struct device *dev, struct xroot_info *info, void **root);
+void xroot_remove(void *root);
+
+int xroot_create_group(void *xr, void *dtb);
+void xroot_destroy_group(void *xr, u32 grp_id);
+
+#endif	/* _XRT_ROOT_H_ */
diff --git a/drivers/fpga/xrt/lib/Makefile b/drivers/fpga/xrt/lib/Makefile
index f67bb19ef20a..fd2af2cbd1da 100644
--- a/drivers/fpga/xrt/lib/Makefile
+++ b/drivers/fpga/xrt/lib/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_FPGA_XRT_LIB) += xrt-lib.o
 
 xrt-lib-objs :=			\
 	lib-drv.o		\
+	xroot.o			\
 	xrt-bus.dtb.o
 
 ccflags-y := -I$(FULL_XRT_PATH)/include
diff --git a/drivers/fpga/xrt/lib/xroot.c b/drivers/fpga/xrt/lib/xroot.c
new file mode 100644
index 000000000000..34489a0cc10b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xroot.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Root Functions
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ *	Lizhi Hou <lizhih@xilinx.com>
+ */
+
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/xrt/xdevice.h>
+#include "xroot.h"
+
+#define xroot_err(xr, fmt, args...) dev_err((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_warn(xr, fmt, args...) dev_warn((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_info(xr, fmt, args...) dev_info((xr)->dev, "%s: " fmt, __func__, ##args)
+#define xroot_dbg(xr, fmt, args...) dev_dbg((xr)->dev, "%s: " fmt, __func__, ##args)
+
+struct xroot {
+	struct device *dev;
+	struct list_head groups;
+	u32 addr;
+	struct xroot_range *ranges;
+	int num_range;
+	struct ida grp_ida;
+};
+
+struct xroot_group {
+	struct list_head node;
+	struct xroot *xr;
+	struct xrt_device *grp_dev;
+	struct property ranges;
+	struct of_changeset chgset;
+	bool chgset_applied;
+	void *dn_mem;
+	char *name;
+	int id;
+};
+
+#define XRT_GROUP	"xrt-group"
+#define MAX_GRP_NAME_LEN	64
+
+static void xroot_cleanup_group(struct xroot_group *grp)
+{
+	if (grp->grp_dev)
+		xrt_device_unregister(grp->grp_dev);
+	if (grp->chgset_applied)
+		of_changeset_revert(&grp->chgset);
+	of_changeset_destroy(&grp->chgset);
+
+	if (grp->id >= 0)
+		ida_free(&grp->xr->grp_ida, grp->id);
+	kfree(grp->dn_mem);
+	kfree(grp->name);
+}
+
+void xroot_destroy_group(void *root, u32 grp_id)
+{
+	struct xroot *xr = root;
+	struct xroot_group *grp;
+
+	list_for_each_entry(grp, &xr->groups, node) {
+		if (grp->id == grp_id)
+			break;
+	}
+	if (list_entry_is_head(grp, &xr->groups, node))
+		return;
+
+	list_del(&grp->node);
+
+	xroot_cleanup_group(grp);
+	kfree(grp);
+}
+EXPORT_SYMBOL_GPL(xroot_destroy_group);
+
+/*
+ * Create XRT group device.
+ *
+ * Unflatten the device tree blob attached to the group and
+ * overlay the device nodes under /xrt-bus. Then create group device
+ * and link it to device node.
+ */
+int xroot_create_group(void *root, void *dtb)
+{
+	struct device_node *dn, *bus, *grp_dn;
+	struct xroot *xr = root;
+	struct xroot_group *grp;
+	int ret;
+
+	grp = kzalloc(sizeof(*grp), GFP_KERNEL);
+	if (!grp)
+		return -ENOMEM;
+
+	bus = of_find_node_by_path("/xrt-bus");
+	if (!bus) {
+		kfree(grp);
+		return -EINVAL;
+	}
+	grp->xr = xr;
+	of_changeset_init(&grp->chgset);
+
+	ret = ida_alloc(&xr->grp_ida, GFP_KERNEL);
+	if (ret < 0)
+		goto failed;
+
+	grp->id = ret;
+
+	grp->name = kzalloc(MAX_GRP_NAME_LEN, GFP_KERNEL);
+	if (!grp->name) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+	snprintf(grp->name, MAX_GRP_NAME_LEN, "%s@%x,%x", XRT_GROUP, xr->addr, grp->id);
+
+	grp->dn_mem = of_fdt_unflatten_tree(dtb, NULL, &grp_dn);
+	if (!grp->dn_mem) {
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	of_node_get(grp_dn);
+	grp_dn->full_name = grp->name;
+	grp_dn->parent = bus;
+	for (dn = grp_dn; dn; dn = of_find_all_nodes(dn))
+		of_changeset_attach_node(&grp->chgset, dn);
+
+	grp->ranges.name = "ranges";
+	grp->ranges.length = xr->num_range * sizeof(*xr->ranges);
+	grp->ranges.value = xr->ranges;
+	ret = of_changeset_add_property(&grp->chgset, grp_dn, &grp->ranges);
+	if (ret)
+		goto failed;
+
+	ret = of_changeset_apply(&grp->chgset);
+	if (ret)
+		goto failed;
+	grp->chgset_applied = true;
+
+	of_node_put(bus);
+	bus = NULL;
+
+	grp->grp_dev = xrt_device_register(xr->dev, grp_dn, NULL, 0, NULL, 0);
+	if (!grp->grp_dev) {
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	if (device_attach(&grp->grp_dev->dev) != 1) {
+		ret = -EFAULT;
+		xroot_err(xr, "failed to attach");
+		goto failed;
+	}
+
+	list_add(&grp->node, &xr->groups);
+
+	return grp->id;
+
+failed:
+	if (bus)
+		of_node_put(bus);
+	xroot_cleanup_group(grp);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xroot_create_group);
+
+int xroot_probe(struct device *dev, struct xroot_info *info, void **root)
+{
+	struct xroot *xr = NULL;
+
+	dev_info(dev, "%s: probing...", __func__);
+
+	xr = devm_kzalloc(dev, sizeof(*xr), GFP_KERNEL);
+	if (!xr)
+		return -ENOMEM;
+
+	xr->dev = dev;
+	INIT_LIST_HEAD(&xr->groups);
+
+	xr->addr = info->addr;
+	xr->num_range = info->num_range;
+	xr->ranges = devm_kzalloc(dev, sizeof(*info->ranges) * info->num_range, GFP_KERNEL);
+	if (!xr->ranges)
+		return -ENOMEM;
+
+	memcpy(&xr->ranges, info->ranges, sizeof(*info->ranges) * info->num_range);
+	ida_init(&xr->grp_ida);
+
+	*root = xr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xroot_probe);
+
+void xroot_remove(void *root)
+{
+	struct xroot *xr = (struct xroot *)root;
+	struct xroot_group *grp, *tmp;
+
+	xroot_info(xr, "leaving...");
+	list_for_each_entry_safe(grp, tmp, &xr->groups, node) {
+		list_del(&grp->node);
+		xroot_cleanup_group(grp);
+		kfree(grp);
+	}
+}
+EXPORT_SYMBOL_GPL(xroot_remove);
-- 
2.27.0

