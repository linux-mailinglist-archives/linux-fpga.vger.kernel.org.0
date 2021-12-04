Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9A48468177
	for <lists+linux-fpga@lfdr.de>; Sat,  4 Dec 2021 01:41:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383889AbhLDAov (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Fri, 3 Dec 2021 19:44:51 -0500
Received: from mail-mw2nam10on2074.outbound.protection.outlook.com ([40.107.94.74]:19799
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1354301AbhLDAou (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Fri, 3 Dec 2021 19:44:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MqNnEFPo6NN8P+fLgHhTL/I+EDhQLbqmfLLAJazNSB3PvgXcbprtUkRIuLweAR5iaXFSWgN80J9kg9ts2rzGznIvITacDxoa3uo8z9JbFgxMeVJAxrBYPw/Hn0FRbiW0LeP0jG2HWgwFMFTHS328liHO+FU1lnVAYbnxQI20ik4rk3F5zdi/NGwCmxdQ1wOP/A6d9U5ncID1XpvpOISqcdCNFtbx+TOXMMb8EWR0gcARoPthCow2k5NFA74IwepTbJes8VY/OTUTtMkoMbRetA/HvG1wYM3b77j7MpDzyqaSWlC0dNZs4kNRGT2A7F56BYWKFcDwpRoS1h6bCmVqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZaBKcT7UEF2+ztUlkTt5Ky/G32yoV8gCsFoHGuUqp/Q=;
 b=EMrDk/W6RUC1XB8v8FpCf9MdpFZrxFQM+JDxPcuNoZNuJ3ZRXUQJZhLsTe1uCyNt9HbNcJ9C2Z4kMSD9ePOb8wY4ykjTh+m8SlYSb2az0MHZUiT3opE3DiDzJPCyQtxhfWKL3XcTSfJit4obXJPJZ9e9Fkjd9y7P6XZUekpZVrQl/t3rEiwJ2WS181MdN4TQEt0okhCd2GFd0CW4N7MpRz4Bcgqf12SbW8cwGRokvuKvt2KmMggfMEBaAWVFucmn0qkyOIR7emd94ee67HWU4J2e4EA9CPPOYqXXFIhaAAHmmVqhnsezjQ8TH8wO/wSXyhGt9tbmi3iBuGSobuwjgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=infradead.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZaBKcT7UEF2+ztUlkTt5Ky/G32yoV8gCsFoHGuUqp/Q=;
 b=DlPsGEqPKe+knm3RMcZRawrQ1lfl7SRsAjD0wkKAYcImkoeRhyh5sLYIbgRJvEi7+IPizCd2gEZDLUMXCnxHU56rWgyy+3VjTMuTf64HwPzSetMLfDkxNytzXN/pB0qa860iq7v6RZS8woHHDDYXRvOjXWl8it10Y+TkTtNolzM=
Received: from BN9PR03CA0624.namprd03.prod.outlook.com (2603:10b6:408:106::29)
 by BL0PR02MB4419.namprd02.prod.outlook.com (2603:10b6:208:44::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Sat, 4 Dec
 2021 00:41:23 +0000
Received: from BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::5d) by BN9PR03CA0624.outlook.office365.com
 (2603:10b6:408:106::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16 via Frontend
 Transport; Sat, 4 Dec 2021 00:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT012.mail.protection.outlook.com (10.13.2.130) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4755.13 via Frontend Transport; Sat, 4 Dec 2021 00:41:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 3 Dec 2021 16:41:15 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 3 Dec 2021 16:41:15 -0800
Envelope-to: dwmw2@infradead.org,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.93] (port=55520 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mtJ75-000B0A-3l; Fri, 03 Dec 2021 16:41:15 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 8FC1F600851; Fri,  3 Dec 2021 16:40:02 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, <dwmw2@infradead.org>,
        Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo Infrastructure 6/8] fpga: xrt: lib-xrt xroot APIs
Date:   Fri, 3 Dec 2021 16:39:55 -0800
Message-ID: <20211204003957.1448567-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
References: <20211204003957.1448567-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8cb5bc-e8cc-4c21-19f7-08d9b6becbd5
X-MS-TrafficTypeDiagnostic: BL0PR02MB4419:
X-Microsoft-Antispam-PRVS: <BL0PR02MB4419BAC05FD0E3CA7EC20FA9A16B9@BL0PR02MB4419.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:81;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dpMQi8g+oIbtmRjweKbjxK+6eTnOlqk7loGNgMQfe5WDmZeSrisrxabyPFB2p6bU2bTONLQV/ETGhsG6dTwlLo16wz29nzftuwsmq4b8qudsi6agiROtPDcv000CFyEtdPjMDSE0L/2xbR1MGK7V0hnbVB+Z7ITdlNKonCAzOmbCnlpojT1+QSF2EoG7pN2IYjltlGUIvFPDiz8gqs1GmrLDgQXwJ0rtxY+jgQ0Y5lTai9P9GOcwzRIUdsSBB/pt5CFB/XMoqmL/U9mbwQmlpXlIK1zIOIkmdzfosBSrxOHVd+YL+M6+tvFVycLXEwxaiA9g3+/wYm9OF60GsGZsf673cb2CcnpczHboJ8CNzeV+c9/3Tl+yZxXW8vvs/kfpqQxYKimAQ3YFl3DGUPD6+DNdHzjs9ID00p1JgmvW9CwAGR15tdb9xuXR1kyB4yVU4jNdzwpFA3LCkzs7OFSwLAAriw2hLs+zaGjxTjpK7+4q3+TeAtvL8HPgFXi80CNJTIrt55p0mwF20yck7kjGEtjzz27QDLCoy0hgD3SA9UjKbJdxtkTpBKIV+f1hDvtWWfEbnts1EUBMsHCDhZksrzi2lOJNuWEDYjmKaxu0AWZ9NxnwLUPJ4Qv2qR4qDdHyn25ugY/DDQEVgY0XYmSRkhSKW9upGUALy7XU08RlRAXkTMb41YZIipcK0b/WZVW+D2YmaJByZKmFIa7jYuy9Rg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(46966006)(36840700001)(47076005)(54906003)(70586007)(8936002)(70206006)(316002)(2906002)(4326008)(7636003)(36860700001)(6666004)(8676002)(6916009)(5660300002)(336012)(26005)(42186006)(186003)(2616005)(6266002)(107886003)(1076003)(508600001)(426003)(36756003)(356005)(44832011)(82310400004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2021 00:41:22.8011
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8cb5bc-e8cc-4c21-19f7-08d9b6becbd5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT012.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4419
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
 drivers/fpga/xrt/lib/xroot.c     | 223 +++++++++++++++++++++++++++++++
 3 files changed, 254 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xroot.h
 create mode 100644 drivers/fpga/xrt/lib/xroot.c

diff --git a/drivers/fpga/xrt/include/xroot.h b/drivers/fpga/xrt/include/xroot.h
new file mode 100644
index 000000000000..b87acbf702c8
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
+int xroot_create_group(void *xr, void *dtb, u32 len);
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
index 000000000000..d82934a5c35b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xroot.c
@@ -0,0 +1,223 @@
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
+#define XROOT_FDT_ALIGN		8
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
+	void *fdt;
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
+	kfree(grp->fdt);
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
+int xroot_create_group(void *root, void *dtb, u32 len)
+{
+	struct device_node *dn, *bus, *grp_dn;
+	struct xroot *xr = root;
+	struct xroot_group *grp;
+	void *dtb_aligned;
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
+	grp->fdt = kmalloc(len + XROOT_FDT_ALIGN, GFP_KERNEL);
+	if (!grp->fdt) {
+		ret = -ENOMEM;
+		goto failed;
+	}
+	dtb_aligned = PTR_ALIGN(grp->fdt, XROOT_FDT_ALIGN);
+	memcpy(dtb_aligned, dtb, len);
+
+	grp->dn_mem = of_fdt_unflatten_tree(dtb_aligned, NULL, &grp_dn);
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

