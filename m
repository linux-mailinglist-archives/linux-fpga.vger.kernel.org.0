Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4218531E67C
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 07:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230495AbhBRGrb (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:47:31 -0500
Received: from mail-dm6nam10on2043.outbound.protection.outlook.com ([40.107.93.43]:37248
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230309AbhBRGoq (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:44:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GozbvfFeqGg1TPf6bXLMuDaeQzhEzHYxYJJZOjyxgU0eSiqOR0ub7Q10iCgNQPMJmth4Tr2UL4rskmvMKBX9nq111qOgDWgCd6ByGOot14bZAywHqanKb8Dft8yI2OjXWYzvan9EhRK44GQjL/u7ULtMiv08QciCgYhTOCqzqwwqNrdSRYF+75wvkUXuqrkM97MkSIoL84QGD4TtUWPncXfOXFws3fez+3j0SK9V3xMwWvUXT2o2c66CcGlfWzc5i4RL+B/w3cJGgJCr0+DE2CjhnL1vAnv44vu2Dvpjbx0mGTdhW88tK0xRaT3DAa+WqkOwokJvWm1NkugxD+lWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1eeLtiY67HGWRYY/cXX0lXhpx1RCLFgYWKKgOYafUk=;
 b=QlROuKjUMfqiQA/Im2Dmyc5uI69ZvBCTCTOAMTDTdWe19+FvSxd15ds5hcL5u0KX0U4Snau6Tatp+Dt4L3U0KT7oPh3888ZjYPZq4tw7JIgHs6wHKx5Dc266C+M56DIx8SmVC3lAfLHXXHZ9ar08JN97TVSTfJY1NreqdMB4r2UK5d54fUqyOkfDVwgrE5Uq008ZV9MGj2P/F/Aih6NQdIbyOrBVIiul5J8tA9aQqhmcSxtRlskG6esYdciknAvNwAeYX0QGAvYePJ/yHMUhBSaBsvD/7sPSS9BgX3M8XAfrZmStmdCdcbMmWFM1KLEooMAsIG9izAVOo4mbKjydVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r1eeLtiY67HGWRYY/cXX0lXhpx1RCLFgYWKKgOYafUk=;
 b=tAwdQ6c0d1cqWm4j5V9NbR6DnL1BFZqUfaoBIWAsXrVHw/HUVoGhW76XE6JK0eaHkUVFiXIALS6gM0L3xOzk9QNAKc0fDwMu9IiKWenazN0BYgMZPDvv2k//U+HspN6hM2twotZKsX/IQ2SAk4PIZJjcej3+wpApVhylBpfsVJY=
Received: from BLAPR03CA0005.namprd03.prod.outlook.com (2603:10b6:208:32b::10)
 by DM6PR02MB5401.namprd02.prod.outlook.com (2603:10b6:5:31::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 06:43:52 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::38) by BLAPR03CA0005.outlook.office365.com
 (2603:10b6:208:32b::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:43:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT051.mail.protection.outlook.com (10.152.76.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:43:52 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:43:51 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:43:51 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40168 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd2V-0000YG-MB; Wed, 17 Feb 2021 22:43:51 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D01A460011F; Wed, 17 Feb 2021 22:41:05 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 05/18] fpga: xrt: group platform driver
Date:   Wed, 17 Feb 2021 22:40:06 -0800
Message-ID: <20210218064019.29189-6-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df4d4e4b-46ef-43c2-dfa5-08d8d3d88e44
X-MS-TrafficTypeDiagnostic: DM6PR02MB5401:
X-Microsoft-Antispam-PRVS: <DM6PR02MB5401C3428D1197AA2D81F523A1859@DM6PR02MB5401.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:13;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6fxIvi4jaEJyW3E1NbUqbidw5sfzAuLIQV3NsZ94asGs0541U9XxA/j2n/Z3TTcZM9kP7NtaCi4TFQ8im2nLW+k9JPJGi7kd7pmHdAYh4a4+9U1TYduMuRtO7XW7o2wsSzkcZZRQicT6uQV+sD56dYoqZycq2NZ7Q+g6KrIxck63pnWs3qp0ljNV12crhEFKVxi9pm+feU9XXfD5cePDiMyqKakIK/RXPoLdq1le32Gh2C/EUO4idzPZhCelD/7u0SuoC4LNisv56Vc9rijkPYN+rqURCrfio0uXW+ejHq8HOu3tJPi1VwkrXRZ76RD/YOhHwGL5gC0FadgPohOaTVotebme+zXcmmW83LmY+XHG/er4ScGsq+aUhkHm+6jLPLyJR6ZqduS7pKzeA4Ttr/ziBVDgBflSyZmSzj7ZYT2bnp2XLqEyVpcvtkolzWELbANPCd8nr0MekeqjHNizdc9W3EtGFdVKk3X+8YfHS58TbiPEsGaNkGFgG3oytzzwDqxaYmGDxEKZ7w8VSYOWm4rnoL+wH3kgoquH0u0CpYJxvixAgRZeSB5dvEO8PL9hjn/XRShFQXPVaHHgBsG0dsAWvifO5eZqGhYNuYpXWllzylTGxyhzeP+AefFUk8P9/jeHmixfn/3I6jomGpFnFYKUXC7/s5psR/NMlfM7Fxg=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(356005)(6266002)(4326008)(36860700001)(2906002)(478600001)(7636003)(47076005)(1076003)(107886003)(6916009)(5660300002)(36756003)(186003)(426003)(44832011)(70206006)(70586007)(8936002)(26005)(8676002)(82310400003)(336012)(2616005)(83380400001)(54906003)(42186006)(36906005)(82740400003)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:43:52.4790
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4d4e4b-46ef-43c2-dfa5-08d8d3d88e44
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5401
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

group driver that manages life cycle of a bunch of leaf driver instances
and bridges them with root.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/group.h |  27 ++++
 drivers/fpga/xrt/lib/group.c     | 265 +++++++++++++++++++++++++++++++
 2 files changed, 292 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/group.h
 create mode 100644 drivers/fpga/xrt/lib/group.c

diff --git a/drivers/fpga/xrt/include/group.h b/drivers/fpga/xrt/include/group.h
new file mode 100644
index 000000000000..1874cdd5120d
--- /dev/null
+++ b/drivers/fpga/xrt/include/group.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for Xilinx Runtime (XRT) driver
+ *
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
+ * Group driver IOCTL calls.
+ */
+enum xrt_group_ioctl_cmd {
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
index 000000000000..6ba56eea479b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/group.c
@@ -0,0 +1,265 @@
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
+#include "main.h"
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
+			   u32 cmd, void *arg)
+{
+	int rc;
+	struct platform_device *pdev =
+		container_of(dev, struct platform_device, dev);
+	struct xrt_group *xg = (struct xrt_group *)parg;
+
+	switch (cmd) {
+	case XRT_ROOT_GET_LEAF_HOLDERS: {
+		struct xrt_root_ioctl_get_holders *holders =
+			(struct xrt_root_ioctl_get_holders *)arg;
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
+static int xrt_grp_create_leaves(struct xrt_group *xg)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xg->pdev);
+	enum xrt_subdev_id did;
+	struct xrt_subdev_endpoints *eps = NULL;
+	int ep_count = 0, i, ret = 0, failed = 0;
+	unsigned long mlen;
+	char *dtb, *grp_dtb = NULL;
+	const char *ep_name;
+
+	mutex_lock(&xg->lock);
+
+	if (xg->leaves_created) {
+		mutex_unlock(&xg->lock);
+		return -EEXIST;
+	}
+
+	xrt_info(xg->pdev, "bringing up leaves...");
+
+	/* Create all leaves based on dtb. */
+	if (!pdata)
+		goto bail;
+
+	mlen = xrt_md_size(DEV(xg->pdev), pdata->xsp_dtb);
+	if (mlen == XRT_MD_INVALID_LENGTH) {
+		xrt_err(xg->pdev, "invalid dtb, len %ld", mlen);
+		goto bail;
+	}
+
+	grp_dtb = vmalloc(mlen);
+	if (!grp_dtb)
+		goto bail;
+
+	memcpy(grp_dtb, pdata->xsp_dtb, mlen);
+	for (did = 0; did < XRT_SUBDEV_NUM;) {
+		eps = eps ? eps + 1 : xrt_drv_get_endpoints(did);
+		if (!eps || !eps->xse_names) {
+			did++;
+			eps = NULL;
+			continue;
+		}
+		ret = xrt_md_create(DEV(xg->pdev), &dtb);
+		if (ret) {
+			xrt_err(xg->pdev, "create md failed, drv %s",
+				xrt_drv_name(did));
+			failed++;
+			continue;
+		}
+		for (i = 0; eps->xse_names[i].ep_name ||
+		     eps->xse_names[i].regmap_name; i++) {
+			ep_name = (char *)eps->xse_names[i].ep_name;
+			if (!ep_name) {
+				xrt_md_get_compatible_endpoint(DEV(xg->pdev),
+							       grp_dtb,
+							       eps->xse_names[i].regmap_name,
+							       &ep_name);
+			}
+			if (!ep_name)
+				continue;
+
+			ret = xrt_md_copy_endpoint(DEV(xg->pdev),
+						   dtb, grp_dtb, ep_name,
+						   (char *)eps->xse_names[i].regmap_name,
+						   NULL);
+			if (ret)
+				continue;
+			xrt_md_del_endpoint(DEV(xg->pdev), grp_dtb, ep_name,
+					    (char *)eps->xse_names[i].regmap_name);
+			ep_count++;
+		}
+		if (ep_count >= eps->xse_min_ep) {
+			ret = xrt_subdev_pool_add(&xg->leaves, did,
+						  xrt_grp_root_cb, xg, dtb);
+			eps = NULL;
+			if (ret < 0) {
+				failed++;
+				xrt_err(xg->pdev, "failed to create %s: %d",
+					xrt_drv_name(did), ret);
+			}
+		} else if (ep_count > 0) {
+			xrt_md_copy_all_endpoints(DEV(xg->pdev), grp_dtb, dtb);
+		}
+		vfree(dtb);
+		ep_count = 0;
+	}
+
+	xg->leaves_created = true;
+
+bail:
+	vfree(grp_dtb);
+	mutex_unlock(&xg->lock);
+
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
+static int xrt_grp_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
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
+		struct xrt_root_ioctl_get_leaf *get_leaf =
+			(struct xrt_root_ioctl_get_leaf *)arg;
+
+		rc = xrt_subdev_pool_get(&xg->leaves, get_leaf->xpigl_match_cb,
+					 get_leaf->xpigl_match_arg,
+					 DEV(get_leaf->xpigl_pdev),
+					 &get_leaf->xpigl_leaf);
+		break;
+	}
+	case XRT_GROUP_PUT_LEAF: {
+		struct xrt_root_ioctl_put_leaf *put_leaf =
+			(struct xrt_root_ioctl_put_leaf *)arg;
+
+		rc = xrt_subdev_pool_put(&xg->leaves, put_leaf->xpipl_leaf,
+					 DEV(put_leaf->xpipl_pdev));
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
+		.xsd_ioctl = xrt_grp_ioctl,
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
2.18.4

