Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D67C393A90
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhE1AxE (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:53:04 -0400
Received: from mail-bn1nam07on2052.outbound.protection.outlook.com ([40.107.212.52]:56309
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235612AbhE1AxD (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:53:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XA+xA6LAk1KBGqJ809jOVcSiOnoE7NrgwGak0Pww5OWdhZ7R0/rhphKxR/LEUYIM0aZKAYmMD7+KjwxQ7NElg4A/N0UlkYEhoRtw0+HL6yc+CcmlPiyQFCrO3jM65NcRl9qRmCTYlEVZ7H0gdBUbHahdGjfL6FRn5z5F4Y2y0YUWynt+TDfh0olVasgb12S9Ta4zu5dF2Rd/OF6TX1ZI5yJRKHR/S41QZiGgDB4Ka/I8KlnJeZVF3WB8H9wJzX37i31IRnKwMXosBKm+S2HrR6CQkcIbO73TVagYV5Z5ResVtKxBICR1xjj5D73T7+AN/VNHnTKl48ESnfZdPGaD2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX0uLyI8DyDALmjDSx/DCq6ZEGpSQm1m8kEhGOkgTs=;
 b=CcVUBNSWzwITMSgMNcY8qCIMAhN3jjP3tBfPdvIKHywV5W89o+H7TAbxoycY3Qijn2UW7Ptjf0DnFznsyoUt4/92zmykZ+WvxhQNfrotMALsGcer0zjPUR2UkksqcJSemreRQqhiUzt+fdi/PuWN4alqetKlWI5qIhrJhqpm97po8aC/aT+wYZovcyE/6qpJEj8ubilSN12gv2TyIdZm812HowvBJYSn8V3T49reReXmnRLVHuiLOTUBYGsZUkqey96GqFdYwkbXH88/W9Hw4LJNnTZ6Y/jq8XWTEeKTp89rKC53vI3qU34m1QMIk9nuZjRPSb3peDiNJxpH+85h+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PCX0uLyI8DyDALmjDSx/DCq6ZEGpSQm1m8kEhGOkgTs=;
 b=Sl/+2mNPcrpIN3Rwof1eNtlXenWadP2jOomwxuveOz14HPWjqpVUT30zxtz33l6Zxq8vHXC0rL7l2VCD1Kr9WbUDapRYLto8jx4XCXBrnVGq1SkjDjlvY2Xxjl+tUFUfMMKjsxE1W9ao4By9ofy1diZS6bYoxfny+gGbc2UuVUo=
Received: from BN9PR03CA0680.namprd03.prod.outlook.com (2603:10b6:408:10e::25)
 by BN6PR02MB3138.namprd02.prod.outlook.com (2603:10b6:405:63::39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 00:51:27 +0000
Received: from BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:10e:cafe::f3) by BN9PR03CA0680.outlook.office365.com
 (2603:10b6:408:10e::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22 via Frontend
 Transport; Fri, 28 May 2021 00:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT005.mail.protection.outlook.com (10.13.2.124) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:51:26 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:51:07 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:51:07 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34014 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQiR-0007D1-Mn; Thu, 27 May 2021 17:51:07 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 40EE16032A7; Thu, 27 May 2021 17:50:06 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 05/20] fpga: xrt: group driver
Date:   Thu, 27 May 2021 17:49:44 -0700
Message-ID: <20210528004959.61354-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0c99296d-48b6-477e-f470-08d92172b967
X-MS-TrafficTypeDiagnostic: BN6PR02MB3138:
X-Microsoft-Antispam-PRVS: <BN6PR02MB31386D854DA46BEC863DB3B4A1229@BN6PR02MB3138.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HARDT8PWihS65vQ9nUQB3B4l1+BbRxDLnrvGfH67ViahHY2OesEV1YxyOU14z9H1CafLEke+fWhqdrtTB898D2Uhlipq7Gu5SzVytYcOW0h/0DwK1e95ekZVtX2Mg7cJUbke2pyd2laNuqovuYlF+EVDnBsJsUhV68nGdiuHCb3RFwzHH3KEpqaaB8y5x3OPpki2cOzBC3kGNCCzSdltZhG6qQH7u1PBJFjYhGQgQiYKXKav4KLv6zNe/x6uTS5NijqTo2ko33NRaBSmOCs0kpKYsHrgxBx1ElXbEnivbS3DSwf41X9AsJn5FarPQmvME+p1Cf3/tnu6uwc2t+qb+ahBEMoBmIxM4KmSy74jzDnCzjELW4YJ2Zor/fM1r0hVtKW3U+AvhmUN6qdCNDBgIkJAom9zYWKRzYI/ovyVqg3vIJ+E5gi/Ngg8p4EjrmEpMvAkT78gt7G5KftP893rwaONy/Lq7fHCSHhkjHduZiHaiXbGUVMANAGz3/8LDzuEECuSJMiVb2+ZjHv+RgTnnzEzF7Q5JQqIQzTQ1Qzl8yEfo0zmyzWaC9UrSNfwON/CjpUP+0bFiEB2IFGDSjKysVDwgyQujkRjCHuHS5czLWqXRdvDwK9w06DJGsFvT5VYgsfUuUga5vxoN/K3vfETMaS9V/zSmrf6njt0nonkvNk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39850400004)(46966006)(36840700001)(26005)(44832011)(83380400001)(186003)(47076005)(82740400003)(2906002)(8936002)(4326008)(8676002)(36860700001)(107886003)(6666004)(82310400003)(70206006)(42186006)(316002)(70586007)(1076003)(336012)(7636003)(6266002)(356005)(2616005)(6916009)(54906003)(426003)(36756003)(478600001)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:51:26.8752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c99296d-48b6-477e-f470-08d92172b967
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT005.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3138
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

