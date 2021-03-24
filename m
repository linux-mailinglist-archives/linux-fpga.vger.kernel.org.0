Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FAA3470F7
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235296AbhCXFdy (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:33:54 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:38168
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232940AbhCXFdj (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:33:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ctc8u6PaVTAVKCrEWiVzsg+eehbmGMawG+1Ba0SIypRj63HgeElXmHtlxQw3I//OBHoDhqwsS7tBEO/gNC+f4YcHrcoYW6n3bJZO3LMp8r6MOudmoYbV9L9zD6ogHneidaiVQsihuuNd62uWsyxMqaxvkXtSChyVr52Dr0YtX7Eke5UxjfWlm1TmxBSj2xPlzNZx5RX6CTfyM8EOY1/5wPcUnD8y3UbwZs+JR+cYBl/TcfVl61X8ARinF4f6Ps152i/G+aO6qRULUxqkiqZNB7yFaU8UuvrJObuAeErnpaGHGHk0SQWYp8cw1OWEP3jdjqx/0jXIhw3RxWhzHRl1zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEP3mSXW5GR6m8sx0XDRg8FRFULliXnH5AB4lJXm7SM=;
 b=fLrxGum8LJKV+kqXMsokbgh/94DPJRjOtdlWb/kFHUOE/PdlOsBluIrNjf47rdespY0sDUv6S6faNCBiArnJrNIAIwCvFhrZQC+tuWsE1WPMPnsjqARxJu9Dj+FChzmbO40icS0/kFTVi4/nD4eFIQJDGQisTn8oUjyKOqvkNBL4bYjUrctaPeql2/cTrVBtItIh2WgA0pHTXaFToHtngd2ch/oghXYqXW6Enwf8msP4CqLjKQpdEy2uanv4GuO8m//8oonscDmnQxBBJcbMo++otuGDVkTBAf5OL10vrNCXhhX3SYTZDdeUEJXN9M75wqxmrXjvjeFqB2UZ5STEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YEP3mSXW5GR6m8sx0XDRg8FRFULliXnH5AB4lJXm7SM=;
 b=f6Hv98gDwfst5kI4xL9+Nr1liZPZI80c5RWnFCYHb/Rc38c24cuwIbLTQ1Tv4qa/k93pmogThZljdMJFjCGFEx84y2Josvi326uLSs7I0VDfaz39D7oqyI+eEFBSU54f9qezFCh91K7A4n0afwUOopR3phT0nHNFBp/ULYoX4JM=
Received: from SA9PR03CA0028.namprd03.prod.outlook.com (2603:10b6:806:20::33)
 by MN2PR02MB7056.namprd02.prod.outlook.com (2603:10b6:208:20c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:33:37 +0000
Received: from SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:20:cafe::f8) by SA9PR03CA0028.outlook.office365.com
 (2603:10b6:806:20::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT014.mail.protection.outlook.com (10.152.72.106) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:33:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:33:22 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:33:22 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51030 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw8w-0005tK-2c; Tue, 23 Mar 2021 22:33:22 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 071B0600125; Tue, 23 Mar 2021 22:29:55 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 05/20] fpga: xrt: group platform driver
Date:   Tue, 23 Mar 2021 22:29:32 -0700
Message-ID: <20210324052947.27889-6-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3aba5ef-8586-4ebd-3632-08d8ee86600b
X-MS-TrafficTypeDiagnostic: MN2PR02MB7056:
X-Microsoft-Antispam-PRVS: <MN2PR02MB705606E2E449B123A7081322A1639@MN2PR02MB7056.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:64;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UTyDCAACUdz9A3+Xk563/hSoUMH4IFuWoDgxdSisBlQi2/+OAQfRjEwA4j/YaWHRo/ihC92aUntRDzKpK67+Vj+K4XofLWWlPtfOjnt9sqdl8tVk/5cEJpRIWDUWHYwKaY5i+MB5rKJw3hmwXpyr+bSM+Wnu9xU2CfT++U67sHaxq136bch4HSf8s0f/zDroo8FwJUQ/szdap0LNEll8Zdk1sqMT4C9tfOnqnBNCH97M8zf+VI8ejuX4qw5Zps/qEesx5q+dkj/rOb8WLjspHsmUF6qwKbvt1j2aAap7Tn9Fi1AwBbnCH034/ADHCzpUK1V9QAzoVvzJhc2kMYU+JAEtiXLnPYe8VeZUcDExsArXP/S48aiW7ZVjzIBWE7q7is59G9/EJbmOiqHMWiVgAG2K0mypzRBxoPKn+uDLJJzR8/biQR21fL1D/ipCnsWwcywWUSULBNiJgOET1pCXc0ndxGPZZyA3/cSepd0GeUyA1EzUTFFqsBVwvPbRY0D2ltkeTOgaHIm/4432Hu71FRNp/mPYpFZJtGSIThBU0q6IIIAoF055UGg5QlYVrZGHdWCCV1DnvUZKPTKuRVpM4qpYNxQ6kAePVMONZKnud/Ltv9fnrJ5MdloDNm7fXbM8VIVwrFLt6NXl8FYB6D4ilRGujuabCU4zMK4RiO0KbBw=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(36840700001)(46966006)(36756003)(478600001)(426003)(6666004)(336012)(107886003)(47076005)(70586007)(6916009)(1076003)(54906003)(82740400003)(36860700001)(2616005)(356005)(83380400001)(82310400003)(44832011)(186003)(7636003)(8936002)(316002)(4326008)(5660300002)(6266002)(26005)(8676002)(36906005)(70206006)(2906002)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:33:37.6481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3aba5ef-8586-4ebd-3632-08d8ee86600b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT014.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7056
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

group driver that manages life cycle of a bunch of leaf driver instances
and bridges them with root.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/group.h |  25 +++
 drivers/fpga/xrt/lib/group.c     | 286 +++++++++++++++++++++++++++++++
 2 files changed, 311 insertions(+)
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
index 000000000000..7b8716569641
--- /dev/null
+++ b/drivers/fpga/xrt/lib/group.c
@@ -0,0 +1,286 @@
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
+#include <linux/platform_device.h>
+#include "xleaf.h"
+#include "subdev_pool.h"
+#include "group.h"
+#include "metadata.h"
+#include "lib-drv.h"
+
+#define XRT_GRP "xrt_group"
+
+struct xrt_group {
+	struct platform_device *pdev;
+	struct xrt_subdev_pool leaves;
+	bool leaves_created;
+	struct mutex lock; /* lock for group */
+};
+
+static int xrt_grp_root_cb(struct device *dev, void *parg,
+			   enum xrt_root_cmd cmd, void *arg)
+{
+	int rc;
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct xrt_group *xg = (struct xrt_group *)parg;
+
+	switch (cmd) {
+	case XRT_ROOT_GET_LEAF_HOLDERS: {
+		struct xrt_root_get_holders *holders =
+			(struct xrt_root_get_holders *)arg;
+		rc = xrt_subdev_pool_get_holders(&xg->leaves,
+						 holders->xpigh_pdev,
+						 holders->xpigh_holder_buf,
+						 holders->xpigh_holder_buf_len);
+		break;
+	}
+	default:
+		/* Forward parent call to root. */
+		rc = xrt_subdev_root_request(pdev, cmd, arg);
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
+static int xrt_grp_cut_subdev_dtb(struct xrt_group *xg, struct xrt_subdev_endpoints *eps,
+				  char *grp_dtb, char **dtbp)
+{
+	int ret, i, ep_count = 0;
+	char *dtb = NULL;
+
+	ret = xrt_md_create(DEV(xg->pdev), &dtb);
+	if (ret)
+		return ret;
+
+	for (i = 0; eps->xse_names[i].ep_name || eps->xse_names[i].regmap_name; i++) {
+		const char *ep_name = eps->xse_names[i].ep_name;
+		const char *reg_name = eps->xse_names[i].regmap_name;
+
+		if (!ep_name)
+			xrt_md_get_compatible_endpoint(DEV(xg->pdev), grp_dtb, reg_name, &ep_name);
+		if (!ep_name)
+			continue;
+
+		ret = xrt_md_copy_endpoint(DEV(xg->pdev), dtb, grp_dtb, ep_name, reg_name, NULL);
+		if (ret)
+			continue;
+		xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name, reg_name);
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
+		xrt_md_copy_endpoint(DEV(xg->pdev), grp_dtb, dtb,
+				     XRT_MD_NODE_ENDPOINTS, NULL, NULL);
+	}
+	vfree(dtb);
+	*dtbp = NULL;
+	return 0;
+}
+
+static int xrt_grp_create_leaves(struct xrt_group *xg)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
+	struct xrt_subdev_endpoints *eps = NULL;
+	int ret = 0, failed = 0;
+	enum xrt_subdev_id did;
+	char *grp_dtb = NULL;
+	unsigned long mlen;
+
+	if (!pdata)
+		return -EINVAL;
+
+	mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
+	if (mlen == XRT_MD_INVALID_LENGTH) {
+		xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
+		return -EINVAL;
+	}
+
+	mutex_lock(&xg->lock);
+
+	if (xg->leaves_created) {
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
+	xrt_info(xg->pdev, "bringing up leaves...");
+	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
+	for (did = 0; did < XRT_SUBDEV_NUM; did++) {
+		eps = xrt_drv_get_endpoints(did);
+		while (eps && eps->xse_names) {
+			char *dtb = NULL;
+
+			ret = xrt_grp_cut_subdev_dtb(xg, eps, grp_dtb, &dtb);
+			if (ret) {
+				failed++;
+				xrt_err(xg->pdev, "failed to cut subdev dtb for drv %s: %d",
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
+				failed++;
+				xrt_err(xg->pdev, "failed to add %s: %d", xrt_drv_name(did), ret);
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
+	xrt_info(xg->pdev, "tearing down leaves...");
+	xrt_subdev_pool_fini(&xg->leaves);
+	xg->leaves_created = false;
+
+	mutex_unlock(&xg->lock);
+}
+
+static int xrt_grp_probe(struct platform_device *pdev)
+{
+	struct xrt_group *xg;
+
+	xrt_info(pdev, "probing...");
+
+	xg = devm_kzalloc(&pdev->dev, sizeof(*xg), GFP_KERNEL);
+	if (!xg)
+		return -ENOMEM;
+
+	xg->pdev = pdev;
+	mutex_init(&xg->lock);
+	xrt_subdev_pool_init(DEV(pdev), &xg->leaves);
+	platform_set_drvdata(pdev, xg);
+
+	return 0;
+}
+
+static int xrt_grp_remove(struct platform_device *pdev)
+{
+	struct xrt_group *xg = platform_get_drvdata(pdev);
+
+	xrt_info(pdev, "leaving...");
+	xrt_grp_remove_leaves(xg);
+	return 0;
+}
+
+static int xrt_grp_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	int rc = 0;
+	struct xrt_group *xg = platform_get_drvdata(pdev);
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
+					 DEV(get_leaf->xpigl_caller_pdev),
+					 &get_leaf->xpigl_tgt_pdev);
+		break;
+	}
+	case XRT_GROUP_PUT_LEAF: {
+		struct xrt_root_put_leaf *put_leaf =
+			(struct xrt_root_put_leaf *)arg;
+
+		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_tgt_pdev,
+					 DEV(put_leaf->xpipl_caller_pdev));
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
+		xrt_err(pdev, "unknown IOCTL cmd %d", cmd);
+		rc = -EINVAL;
+		break;
+	}
+	return rc;
+}
+
+static struct xrt_subdev_drvdata xrt_grp_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xrt_grp_leaf_call,
+	},
+};
+
+static const struct platform_device_id xrt_grp_id_table[] = {
+	{ XRT_GRP, (kernel_ulong_t)&xrt_grp_data },
+	{ },
+};
+
+static struct platform_driver xrt_group_driver = {
+	.driver	= {
+		.name    = XRT_GRP,
+	},
+	.probe   = xrt_grp_probe,
+	.remove  = xrt_grp_remove,
+	.id_table = xrt_grp_id_table,
+};
+
+void group_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_GRP, &xrt_group_driver, NULL);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_GRP);
+}
-- 
2.27.0

