Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90FA44564CF
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Nov 2021 22:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231338AbhKRVIQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Nov 2021 16:08:16 -0500
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:50326
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234082AbhKRVIN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Nov 2021 16:08:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWCfRg6CjCO7Hgypm+2zbmTNqI4HaxSjNG8OF5Q5jy4WdL25M5je70cThj0NOd/pELX93kLIeiK2DSnmpWptgmE59Crz6POc8Fx92KGxIAzYwzxsqthATExl7KbDHTKeDWOZw9aJCzBRS4+T6Y5Hiz5U8TI37mQOjJhbGxceVq1tK9Ct/9HToT6hVtsHYeNxyz1GznOI56WFU86crf0JGN7x3n9lgPjaAZvYFbPzn9xFdkcizbQbR4p9zKBDZUe6E/DcBDsmBfIfr3fPcGZGBRKVneutMHfH+13dUHhgjTD5M/n8lVHPBrOvvdg9tKA4aW4o6g0c8HCUKvDB8V5ggg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tSUAgszNk8jNWzaSQkn0mEGh7RDfYQh4C6ZuMbWeU4c=;
 b=hu0o34cTF1G7sXflK93ufZJBJVmmluXVQ+gufHhkU+gf2AsIXua4URcZAn+PWiQuGbQdE+Q+OjCTIyyLHpzXzWWeo4/yVn5/VT9TRwCwu5taOd9DM0bKjtaqGpsnNnSXS+JQqCdTCn68JkwsqUvq/ez7wg+Zea/iPlf7c2r3LxclRoYL8buuyTSYvSSXYNqkXENGtJo2bReTyuo/CHYofHhDtqIu5klH5wi+tYoXaasqFEdiV2y7+tuNGUcmlW4kJJ7dh7vl5/9lbwcRDVkljq+q7Fiosc/VcD7GUb5ob+QfFrFm0MXy4A9rKHRSTNltWrr8SgvVl4u0PvlfPX0dYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tSUAgszNk8jNWzaSQkn0mEGh7RDfYQh4C6ZuMbWeU4c=;
 b=O6lEM2xqOaX/05mpvX7dc23J8UTLADM2uXG27z0MXWC0z0OhRvAEfjc5tMFYg3WT5kossZxhYqhGpWT+08vwUJ4MZb0XQE4OCBeXtNmed9V6JaGF7Wf1V1CIwSqyF7anyGA3vKemx/VYtcR2Hdf5iqDImIUJA8Ri6fUbJSFig1M=
Received: from SN4PR0701CA0033.namprd07.prod.outlook.com
 (2603:10b6:803:2d::27) by CO6PR02MB7537.namprd02.prod.outlook.com
 (2603:10b6:303:b3::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Thu, 18 Nov
 2021 21:05:10 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2d:cafe::bb) by SN4PR0701CA0033.outlook.office365.com
 (2603:10b6:803:2d::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19 via Frontend
 Transport; Thu, 18 Nov 2021 21:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4713.19 via Frontend Transport; Thu, 18 Nov 2021 21:05:10 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 18 Nov 2021 13:05:00 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 18 Nov 2021 13:05:00 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=37762 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mnoaa-0001bD-LX; Thu, 18 Nov 2021 13:05:00 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 29315600146; Thu, 18 Nov 2021 13:03:36 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V1 XRT Alveo Infrastructure 7/9] fpga: xrt: lib-xrt xroot APIs
Date:   Thu, 18 Nov 2021 13:03:21 -0800
Message-ID: <20211118210323.1070283-8-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
References: <20211118210323.1070283-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f7afaac-20bc-4921-04b9-08d9aad71b54
X-MS-TrafficTypeDiagnostic: CO6PR02MB7537:
X-Microsoft-Antispam-PRVS: <CO6PR02MB753783DBE5DAB7FC6FDAE3B5A19B9@CO6PR02MB7537.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s4duEB2XUMgCckN/k9SqwNphLy0k3GIVLzkoKevYTmZG+DE4gVWaiJiOzBLEw7cm7aPlrY1MIAKI/wJqgEIajLTLM03MnCEtJa2uCwxC4iKF2hVBVRzpxEyzFzbtxguzNhuLmqeK02okGjTqz0SuAIxgQ2VH2+BeqyBoJbB46jTJAf+kAgiUEVz7Ndyh3JR3UKsoYHDqu4+ynD00aJv5IhQfTqgFrdSuuUj3XDnrYc0soL0roIqU11fW5u7X5JjKGhpCR6JLKDwJVhQ3zG3vFpAre4BQZRDYfOcAp5/ImuAUvBSOxonNRjqblg6ke+Qt++6g0bgOkSj20+gGgIk7okbC2+wDxV8GG+G5nTsAw2PAUUI+XjzsyUT/OpGG5O3B50q7TFuEXpIL8dPx2if5plw+JVTbn+HrFRQHEads+nOrQR+the7/Cw/absM+1I6AMpuAqQL32RTEy4zHosSUyZAMxgmKivczK4YdMq9+fVNJBDIkr/p/BIuo/giPzZ4KY+2qUiiTyETYyheAvkKWy10+63XwlowSu9YWm6fPfq4j8OJe+Ajj9iMIF4OSGlBZlnp9aI+/WTdT3DTL2incdRLaqAIL7GsctZXLJvK0IZQtMtAD3g6pAlnHMkmID20SEFxYCwHTo3A4G0ZGqMStqcS40g5xa5Flngyhv5dXEhJcl9zMTcqObN1mNKte1RTjdp1NePutvLjT7cBMwj5ICQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(356005)(7636003)(6266002)(508600001)(426003)(6916009)(2906002)(47076005)(36756003)(54906003)(1076003)(186003)(70586007)(70206006)(42186006)(44832011)(82310400003)(8936002)(2616005)(316002)(336012)(107886003)(36906005)(5660300002)(8676002)(26005)(6666004)(4326008)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2021 21:05:10.2017
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f7afaac-20bc-4921-04b9-08d9aad71b54
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7537
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

