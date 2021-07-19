Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA2C3CF04A
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbhGSXMc (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:12:32 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:3009
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388232AbhGSUq5 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e2ajGfUnWt86g4aCTzn4juwTskswVPnAMAUIbPWgkEAzdMBYGQEE8W1lWr7MmEBwWvFAPV5QAxfm+V736bO9asMxE7K5xj2skRbTiabNbb7F3qgfFMsHhV8AjxaVjJu3nhwWoIGzU2+iFIoXpmlDAl3sfc91N8UGtkMUJn5v+7EWVIZ5jmbvzoazNta09zyRu4/rhFQ9gy5T3P7kZidGb2ynYhHJCF6Q2tlP2JOLxj/9yIeoicGEwBCXFE5QS5a418q28TvqGvKFZoJ/+rqd5yb6SajxnkqxEQnt970cMuU6R3eVneprhH62xEwVBGoTdhQluoRGw3YR+SeUHGObag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX0uLyI8DyDALmjDSx/DCq6ZEGpSQm1m8kEhGOkgTs=;
 b=Skg/BpETiH79Fuwg2/hSJQWCYjX4wNJDt0/6TD2TPpsOpuOAdUtj/EIOPXYY9ZStdCU0KtdBa8YIZ5+8cXlFwXRo4aSA3ra1xlQ0xht3MtcVVYM0YMe6jVoJNVAa7r9h25a0uS0Qb2OFy+DKmKGJdKmjqCgCvvZI4zD67SZC62qPyFhVGtbmLxAiK5B+QYbJ+1YvdmyQXK2ImU5qnUDqdRKcccncOhFhb9aBx90rz8VWtFYNAHX4HO6wr/+TS7OQi9/QEycqjGV/j+/QWdiGUR167z6mcLex/Fqhlaxd8soPwzfJkYIEaYPDuUXlBuMVnt4I5m9FS4u4XSf/zENfpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX0uLyI8DyDALmjDSx/DCq6ZEGpSQm1m8kEhGOkgTs=;
 b=h4jJ81ICyu2kLUAWu1RB5gc4FzAYRNTHG8TvfzrP46inyrOIA+Ze9FJyXQoe0hydYGbPJ0KHm0JZZunaO4+Dq4Z0+8MQxQNndaTtgdQ9bqHmLECklu6aG8WWTpBls72Lhd+8knYux+xgJcidEE5JeJZfjDmYXRotKXtrAdEkZBc=
Received: from DM5PR20CA0024.namprd20.prod.outlook.com (2603:10b6:3:93::34) by
 BN6PR02MB2482.namprd02.prod.outlook.com (2603:10b6:404:55::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.29; Mon, 19 Jul 2021 21:27:33 +0000
Received: from DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::3d) by DM5PR20CA0024.outlook.office365.com
 (2603:10b6:3:93::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 21:27:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT054.mail.protection.outlook.com (10.13.5.135) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:27:33 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:27:32 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:27:32 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=38274 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5anU-0004xG-4P; Mon, 19 Jul 2021 14:27:32 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 9CFBB6020BC; Mon, 19 Jul 2021 14:26:31 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V8 XRT Alveo 05/14] fpga: xrt: group driver
Date:   Mon, 19 Jul 2021 14:26:19 -0700
Message-ID: <20210719212628.134129-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719212628.134129-1-lizhi.hou@xilinx.com>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d686a084-fdc6-449a-1274-08d94afc056e
X-MS-TrafficTypeDiagnostic: BN6PR02MB2482:
X-Microsoft-Antispam-PRVS: <BN6PR02MB24825B2CB90EF4099484C9C3A1E19@BN6PR02MB2482.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lDFArRUDLVkS0PnGGc0rYqSMK/L7ydy3Yn0RPzuGKpfBvcTsCIVwJJQaIDCH8f3ChpkSImZKybSqE04u2mowU9Cw8e+ejq6GTwgpJJLp/DofQdcABlr5SzrzpzSQE3/DgvTBuPt4eXSXTq+gXoSoL2DRWxkqlicX2QjmR5Sauf2ygF0YhHTDJpZGWgojr/l//7tsEcLjY4tf//opvyjwqmKOhkJmryiDfv+TnGb0ercCNZbIVubUmPDZtvJN7OOoGXpuTUzEZ9gnm8z1WMJxuaqr/lbyEIZlggTHOp2QtG5EoBVLf/G7+CGVa/uKWQtwOS3NCZMU4nbqJGBVdCYvv/L+3zJzEG25Av3kqJtd3cy7D9iTpyVOr3euakwftN0h6sHpibBij5TLPFrJJKhyW04oVUNiOG7vGY9uKOVMfExeKEoyjhatTYR5n4bbGHrOlco3KJ4acU5gIzsOhBa2xA81mFCKQJ+j1EsSBUUbRLAYf3lgDH2HfrmO6iBm4evyyVHzX0flD5c+6wRb2KINPmj14XaoFQBsRIj5ccRZJahqYe9UU1fdxj5MWHAA7gSOkqvi0OzkEfCsL/eXHpzN9iy+3akunB4gGSzQ3uxilqk/8xMDbTCvsljuetzQb3YjHnLXbTQruVbeneHTTvdX+23k+CgXi12Oq7wWZbayS6DO7ksioZXOTvn+T6W4entPntYXgSSDo0qwRSoYPbHrKQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(6916009)(186003)(2906002)(1076003)(36906005)(6266002)(8676002)(107886003)(42186006)(54906003)(426003)(8936002)(508600001)(44832011)(4326008)(70586007)(5660300002)(2616005)(336012)(316002)(70206006)(26005)(6666004)(7636003)(36860700001)(36756003)(82310400003)(356005)(47076005)(83380400001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:27:33.2030
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d686a084-fdc6-449a-1274-08d94afc056e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT054.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2482
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

group driver that manages life cycle of a bunch of leaf driver instances
and bridges them with root.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/group.h |  25 +++
 drivers/fpga/xrt/lib/group.c     | 278 +++++++++++++++++++++++++++++++
 2 files changed, 303 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/group.h
 create mode 100644 drivers/fpga/xrt/lib/group.c

diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
new file mode 100644
index 000000000000..09e9d03f53fe
--- /dev/null
+++ b/drivers/fpga/xrt/include/group.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_GROUP_H_
+#define _XRT_GROUP_H_
+
+#include "xleaf.h"
+
+/*
+ * Group driver leaf calls.
+ */
+enum xrt_group_leaf_cmd {
+	XRT_GROUP_GET_LEAF = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_GROUP_PUT_LEAF,
+	XRT_GROUP_INIT_CHILDREN,
+	XRT_GROUP_FINI_CHILDREN,
+	XRT_GROUP_TRIGGER_EVENT,
+};
+
+#endif	/* _XRT_GROUP_H_ */
diff --git a/drivers/fpga/xrt/lib/group.c b/drivers/fpga/xrt/lib/group.c
new file mode 100644
index 000000000000..b45f05449e0b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/group.c
@@ -0,0 +1,278 @@
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
+#include <linux/mod_devicetable.h>
+#include "xleaf.h"
+#include "subdev_pool.h"
+#include "group.h"
+#include "metadata.h"
+#include "lib-drv.h"
+
+#define XRT_GRP "xrt_group"
+
+struct xrt_group {
+	struct xrt_device *xdev;
+	struct xrt_subdev_pool leaves;
+	bool leaves_created;
+	struct mutex lock; /* lock for group */
+};
+
+static int xrt_grp_root_cb(struct device *dev, void *parg,
+			   enum xrt_root_cmd cmd, void *arg)
+{
+	int rc;
+	struct xrt_device *xdev =
+		container_of(dev, struct xrt_device, dev);
+	struct xrt_group *xg = (struct xrt_group *)parg;
+
+	switch (cmd) {
+	case XRT_ROOT_GET_LEAF_HOLDERS: {
+		struct xrt_root_get_holders *holders =
+			(struct xrt_root_get_holders *)arg;
+		rc = xrt_subdev_pool_get_holders(&xg->leaves,
+						 holders->xpigh_xdev,
+						 holders->xpigh_holder_buf,
+						 holders->xpigh_holder_buf_len);
+		break;
+	}
+	default:
+		/* Forward parent call to root. */
+		rc = xrt_subdev_root_request(xdev, cmd, arg);
+		break;
+	}
+
+	return rc;
+}
+
+/*
+ * Cut subdev's dtb from group's dtb based on passed-in endpoint descriptor.
+ * Return the subdev's dtb through dtbp, if found.
+ */
+static int xrt_grp_cut_subdev_dtb(struct xrt_group *xg, struct xrt_dev_endpoints *eps,
+				  char *grp_dtb, char **dtbp)
+{
+	int ret, i, ep_count = 0;
+	char *dtb = NULL;
+
+	ret = xrt_md_create(DEV(xg->xdev), &dtb);
+	if (ret)
+		return ret;
+
+	for (i = 0; eps->xse_names[i].ep_name || eps->xse_names[i].compat; i++) {
+		const char *ep_name = eps->xse_names[i].ep_name;
+		const char *compat = eps->xse_names[i].compat;
+
+		if (!ep_name)
+			xrt_md_get_compatible_endpoint(DEV(xg->xdev), grp_dtb, compat, &ep_name);
+		if (!ep_name)
+			continue;
+
+		ret = xrt_md_copy_endpoint(DEV(xg->xdev), dtb, grp_dtb, ep_name, compat, NULL);
+		if (ret)
+			continue;
+		xrt_md_del_endpoint(DEV(xg->xdev), grp_dtb, ep_name, compat);
+		ep_count++;
+	}
+	/* Found enough endpoints, return the subdev's dtb. */
+	if (ep_count >= eps->xse_min_ep) {
+		*dtbp = dtb;
+		return 0;
+	}
+
+	/* Cleanup - Restore all endpoints that has been deleted, if any. */
+	if (ep_count > 0) {
+		xrt_md_copy_endpoint(DEV(xg->xdev), grp_dtb, dtb,
+				     XRT_MD_NODE_ENDPOINTS, NULL, NULL);
+	}
+	vfree(dtb);
+	*dtbp = NULL;
+	return 0;
+}
+
+static int xrt_grp_create_leaves(struct xrt_group *xg)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->xdev);
+	struct xrt_dev_endpoints *eps = NULL;
+	int ret = 0, failed = 0;
+	enum xrt_subdev_id did;
+	char *grp_dtb = NULL;
+	unsigned long mlen;
+
+	if (!pdata)
+		return -EINVAL;
+
+	mlen = xrt_md_size(DEV(xg->xdev), pdata->xsp_dtb);
+	if (mlen == XRT_MD_INVALID_LENGTH) {
+		xrt_err(xg->xdev, "invalid dtb, len %ld", mlen);
+		return -EINVAL;
+	}
+
+	mutex_lock(&xg->lock);
+
+	if (xg->leaves_created) {
+		/*
+		 * This is expected since caller does not keep track of the state of the group
+		 * and may, in some cases, still try to create leaves after it has already been
+		 * created. This special error code will let the caller know what is going on.
+		 */
+		mutex_unlock(&xg->lock);
+		return -EEXIST;
+	}
+
+	grp_dtb = vmalloc(mlen);
+	if (!grp_dtb) {
+		mutex_unlock(&xg->lock);
+		return -ENOMEM;
+	}
+
+	/* Create all leaves based on dtb. */
+	xrt_info(xg->xdev, "bringing up leaves...");
+	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
+	for (did = 0; did < XRT_SUBDEV_NUM; did++) {
+		eps = xrt_drv_get_endpoints(did);
+		while (eps && eps->xse_names) {
+			char *dtb = NULL;
+
+			ret = xrt_grp_cut_subdev_dtb(xg, eps, grp_dtb, &dtb);
+			if (ret) {
+				failed++;
+				xrt_err(xg->xdev, "failed to cut subdev dtb for drv %s: %d",
+					xrt_drv_name(did), ret);
+			}
+			if (!dtb) {
+				/*
+				 * No more dtb to cut or bad things happened for this instance,
+				 * switch to the next one.
+				 */
+				eps++;
+				continue;
+			}
+
+			/* Found a dtb for this instance, let's add it. */
+			ret = xrt_subdev_pool_add(&xg->leaves, did, xrt_grp_root_cb, xg, dtb);
+			if (ret < 0) {
+				/*
+				 * It is not a fatal error here. Some functionality is not usable
+				 * due to this missing device, but the error can be handled
+				 * when the functionality is used.
+				 */
+				failed++;
+				xrt_err(xg->xdev, "failed to add %s: %d", xrt_drv_name(did), ret);
+			}
+			vfree(dtb);
+			/* Continue searching for the same instance from grp_dtb. */
+		}
+	}
+
+	xg->leaves_created = true;
+	vfree(grp_dtb);
+	mutex_unlock(&xg->lock);
+	return failed == 0 ? 0 : -ECHILD;
+}
+
+static void xrt_grp_remove_leaves(struct xrt_group *xg)
+{
+	mutex_lock(&xg->lock);
+
+	if (!xg->leaves_created) {
+		mutex_unlock(&xg->lock);
+		return;
+	}
+
+	xrt_info(xg->xdev, "tearing down leaves...");
+	xrt_subdev_pool_fini(&xg->leaves);
+	xg->leaves_created = false;
+
+	mutex_unlock(&xg->lock);
+}
+
+static int xrt_grp_probe(struct xrt_device *xdev)
+{
+	struct xrt_group *xg;
+
+	xrt_info(xdev, "probing...");
+
+	xg = devm_kzalloc(&xdev->dev, sizeof(*xg), GFP_KERNEL);
+	if (!xg)
+		return -ENOMEM;
+
+	xg->xdev = xdev;
+	mutex_init(&xg->lock);
+	xrt_subdev_pool_init(DEV(xdev), &xg->leaves);
+	xrt_set_drvdata(xdev, xg);
+
+	return 0;
+}
+
+static void xrt_grp_remove(struct xrt_device *xdev)
+{
+	struct xrt_group *xg = xrt_get_drvdata(xdev);
+
+	xrt_info(xdev, "leaving...");
+	xrt_grp_remove_leaves(xg);
+}
+
+static int xrt_grp_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	int rc = 0;
+	struct xrt_group *xg = xrt_get_drvdata(xdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Simply forward to every child. */
+		xrt_subdev_pool_handle_event(&xg->leaves,
+					     (struct xrt_event *)arg);
+		break;
+	case XRT_GROUP_GET_LEAF: {
+		struct xrt_root_get_leaf *get_leaf =
+			(struct xrt_root_get_leaf *)arg;
+
+		rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
+					 get_leaf->xpigl_match_arg,
+					 DEV(get_leaf->xpigl_caller_xdev),
+					 &get_leaf->xpigl_tgt_xdev);
+		break;
+	}
+	case XRT_GROUP_PUT_LEAF: {
+		struct xrt_root_put_leaf *put_leaf =
+			(struct xrt_root_put_leaf *)arg;
+
+		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_tgt_xdev,
+					 DEV(put_leaf->xpipl_caller_xdev));
+		break;
+	}
+	case XRT_GROUP_INIT_CHILDREN:
+		rc = xrt_grp_create_leaves(xg);
+		break;
+	case XRT_GROUP_FINI_CHILDREN:
+		xrt_grp_remove_leaves(xg);
+		break;
+	case XRT_GROUP_TRIGGER_EVENT:
+		xrt_subdev_pool_trigger_event(&xg->leaves, (enum xrt_events)(uintptr_t)arg);
+		break;
+	default:
+		xrt_err(xdev, "unknown IOCTL cmd %d", cmd);
+		rc = -EINVAL;
+		break;
+	}
+	return rc;
+}
+
+static struct xrt_driver xrt_group_driver = {
+	.driver	= {
+		.name    = XRT_GRP,
+	},
+	.subdev_id = XRT_SUBDEV_GRP,
+	.probe = xrt_grp_probe,
+	.remove = xrt_grp_remove,
+	.leaf_call = xrt_grp_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(group);
-- 
2.27.0

