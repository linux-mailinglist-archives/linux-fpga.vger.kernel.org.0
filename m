Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE8031E68F
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230352AbhBRG4L (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:56:11 -0500
Received: from mail-mw2nam10on2052.outbound.protection.outlook.com ([40.107.94.52]:50144
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230467AbhBRGss (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhivEzbpItUqYImjbzsP0lGd4y1u4oYi6sWhk1xpQLeEcIdG9uiEwPNCOrWzLR3SdHlyjjiTvI9WmmjynMS5FPxCVIAFV2U0lLdfOjsvYgiEpPSZXYZtKVmauq3cd4cRg7V6m0fYhtfLq7x+rrq23QtXMaVWKYsLeXVHFODgIKQltEHUcit6nYHvkOJpx9M4Q6bmtHRER1s2x/Q5MtDge26c3TJ0v1qimS5e6y/3HxwNSDtJY3BBqc7+R2WpYViGckUkGABiC0LVp7Ni6ERSkUnrOb87CVK00LFXPIZAZWTrUArU08STKnjMm8G+JiGChexbGUAoo3m1Lp2fwmqGow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFmxObRlu7vI6/d49+grAeWEWeE2gFP+5ov7xRE3fJI=;
 b=WMuI148a5+SEifnFLvtHQX+yFXDtOVhuCvIVxDHsp8sjpfPUy5jAwHoXBm+FCz2RduysjdGArhxqpGo35wzwGGLUUlyx1CrN2YnkI7tWpAKfm3TEUCrxX4yqOKcTGldxDBPHRcaUPbM5jX3faZV6H/9QPx3lJxV7rOym7xWCicK4dxpnPabU/Cul7ZAbzl4dnXuxd42N649ElCsM9jZ5y8CL/M0YLhc1z1ISI7pzWf+H2YXZlYOhEhprsRFWAr/OFAgsxAjmn/GRHBQhOXzXwf03A3Mw0xFs9Rl1JndngRQqvQhVN93imbi53u9sZ0cat5tEorSkr53o7+ATV2eoeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FFmxObRlu7vI6/d49+grAeWEWeE2gFP+5ov7xRE3fJI=;
 b=r6+4Sxn0m5kGBALjF1FEoWYh6SxUqm3jDAZDsYD8zntFmuzHjVN+zzJb55vHEmYxWwMr9xsrK956G4H+aJW+VzVkDNljb7cQAd2QrtMLer9EPQYNbbbajd5NuFylDM6mQSAdE/YUyQEW+PTMvXU29ecyRZosR/l7xQ4SZ8pMfhE=
Received: from DM5PR18CA0050.namprd18.prod.outlook.com (2603:10b6:3:22::12) by
 BYAPR02MB4485.namprd02.prod.outlook.com (2603:10b6:a03:58::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.31; Thu, 18 Feb 2021 06:46:19 +0000
Received: from CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:22:cafe::c0) by DM5PR18CA0050.outlook.office365.com
 (2603:10b6:3:22::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:46:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT052.mail.protection.outlook.com (10.152.74.123) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:46:18 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:46:04 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:46:04 -0800
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
Received: from [172.19.72.212] (port=40192 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd4e-0002FY-5r; Wed, 17 Feb 2021 22:46:04 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id A44BC60012C; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 16/18] fpga: xrt: DDR calibration platform driver
Date:   Wed, 17 Feb 2021 22:40:17 -0800
Message-ID: <20210218064019.29189-17-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 420085f0-4c52-4d37-73b3-08d8d3d8e564
X-MS-TrafficTypeDiagnostic: BYAPR02MB4485:
X-Microsoft-Antispam-PRVS: <BYAPR02MB44851A360173BE5BB6C894E1A1859@BYAPR02MB4485.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:534;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DxDsA9LQvhzhD4QE+dND72WDmFrSiGHAQgTrWsEc7XWhrz8KkDnZ0wiJp0gMNWPRaiBLonhilF1p3V6ZDN79yGfklWAnWWyMQc52LDYPQzdRoC0nB3tZ0Nwgys4MCspHyThamHbwDTC7AhQd6oe4k0P8plpSr3MpTQ3qSqO4DvG3d2TWmq4aCWKw8STTrIRbowjLQUu9ZsswjUJ1FPRpR2Wg+/VsW96VULlj2miu+QpYN+At8vTs34NEa3EI2eXiAJVmLOr7dysf8CotV4qM3aVdAG9wLEYvpOxKGJYUzR6nDnFSUYS1Lox6HILBX+OSWm7xOFbM4nOgrtFGmFuZz2/QUHhOKAYr9uEOPpfbrM5MqlmTTnSJuL37YmKhGEU1fO1MVUKMwkbHIDfSx49+89Q0TQiOMlYGFlPNNJm73ywvSVbbwG5dNtZJJ/n5g0dL8Vkd7b+aelSX48iTdMTlPmz6R2iYRS8VmSVI26E/cm3EUKOQLVObS1pDb8Ms4TMMfIWOYx1XuzTMlXDpO5PK1OSLs4fox9LA8Myv4IFdE7+nV3SCnVHn0bjuqMO9ztOcyt3B/nyLT+fesARwxB6uHaf60UdI+GxsQja7X5fvtYb5I1o1b7/H2TvtxjNEGySOLfhPUBu1CkQmGEu51tTMbJZFSJVvkRGoz2AV/2YAdk4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(136003)(396003)(36840700001)(46966006)(44832011)(82310400003)(47076005)(1076003)(426003)(83380400001)(5660300002)(6666004)(2616005)(6266002)(70206006)(316002)(36860700001)(36756003)(107886003)(36906005)(6916009)(336012)(70586007)(42186006)(7636003)(26005)(54906003)(186003)(478600001)(4326008)(356005)(8676002)(8936002)(82740400003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:46:18.7247
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 420085f0-4c52-4d37-73b3-08d8d3d8e564
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4485
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add DDR calibration driver. DDR calibration is a hardware function
discovered by walking firmware metadata. A platform device node will
be created for it. Hardware provides DDR calibration status through
this function.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/calib.h |  30 ++++
 drivers/fpga/xrt/lib/xleaf/calib.c     | 226 +++++++++++++++++++++++++
 2 files changed, 256 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/calib.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/calib.c

diff --git a/drivers/fpga/xrt/include/xleaf/calib.h b/drivers/fpga/xrt/include/xleaf/calib.h
new file mode 100644
index 000000000000..f8aba4594c58
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/calib.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT DDR Calibration Leaf Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_CALIB_H_
+#define _XRT_CALIB_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver IOCTL calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_ioctl_cmd {
+	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_CALIB_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/calib.c b/drivers/fpga/xrt/lib/xleaf/calib.c
new file mode 100644
index 000000000000..fbb813636e76
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/calib.c
@@ -0,0 +1,226 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA memory calibration driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * memory calibration
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+#include <linux/delay.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf/calib.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+struct calib_cache {
+	struct list_head	link;
+	const char		*ep_name;
+	char			*data;
+	u32			data_size;
+};
+
+struct calib {
+	struct platform_device	*pdev;
+	void			*calib_base;
+	struct mutex		lock; /* calibration dev lock */
+	struct list_head	cache_list;
+	u32			cache_num;
+	enum xrt_calib_results	result;
+};
+
+#define CALIB_DONE(calib)			\
+	(ioread32((calib)->calib_base) & BIT(0))
+
+static void calib_cache_clean_nolock(struct calib *calib)
+{
+	struct calib_cache *cache, *temp;
+
+	list_for_each_entry_safe(cache, temp, &calib->cache_list, link) {
+		vfree(cache->data);
+		list_del(&cache->link);
+		vfree(cache);
+	}
+	calib->cache_num = 0;
+}
+
+static void calib_cache_clean(struct calib *calib)
+{
+	mutex_lock(&calib->lock);
+	calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_srsr(struct calib *calib, struct platform_device *srsr_leaf)
+{
+	return -EOPNOTSUPP;
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	int i;
+
+	for (i = 0; i < 20; i++) {
+		if (CALIB_DONE(calib))
+			break;
+		msleep(500);
+	}
+
+	if (i == 20) {
+		xrt_err(calib->pdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->pdev, "took %dms", i * 500);
+	return 0;
+}
+
+static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+		struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
+	int instance = evt->xe_subdev.xevt_subdev_instance;
+	struct platform_device *leaf;
+	int ret;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION: {
+		if (id == XRT_SUBDEV_SRSR) {
+			leaf = xleaf_get_leaf_by_id(pdev,
+						    XRT_SUBDEV_SRSR,
+						    instance);
+			if (!leaf) {
+				xrt_err(pdev, "does not get SRSR subdev");
+				return;
+			}
+			ret = calib_srsr(calib, leaf);
+			xleaf_put_leaf(pdev, leaf);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		} else if (id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			calib->result =
+				ret ? XRT_CALIB_FAILED : XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	}
+	default:
+		break;
+	}
+}
+
+static int xrt_calib_remove(struct platform_device *pdev)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+
+	calib_cache_clean(calib);
+
+	if (calib->calib_base)
+		iounmap(calib->calib_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, calib);
+
+	return 0;
+}
+
+static int xrt_calib_probe(struct platform_device *pdev)
+{
+	struct calib *calib;
+	struct resource *res;
+	int err = 0;
+
+	calib = devm_kzalloc(&pdev->dev, sizeof(*calib), GFP_KERNEL);
+	if (!calib)
+		return -ENOMEM;
+
+	calib->pdev = pdev;
+	platform_set_drvdata(pdev, calib);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		goto failed;
+
+	calib->calib_base = ioremap(res->start, res->end - res->start + 1);
+	if (!calib->calib_base) {
+		err = -EIO;
+		xrt_err(pdev, "Map iomem failed");
+		goto failed;
+	}
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	xrt_calib_remove(pdev);
+	return err;
+}
+
+static int
+xrt_calib_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_calib_event_cb(pdev, arg);
+		break;
+	case XRT_CALIB_RESULT: {
+		enum xrt_calib_results *r = (enum xrt_calib_results *)arg;
+		*r = calib->result;
+		break;
+	}
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		ret = -EINVAL;
+	}
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_calib_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_DDR_CALIB },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_calib_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_calib_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_calib_table[] = {
+	{ XRT_CALIB, (kernel_ulong_t)&xrt_calib_data },
+	{ },
+};
+
+static struct platform_driver xrt_calib_driver = {
+	.driver = {
+		.name = XRT_CALIB,
+	},
+	.probe = xrt_calib_probe,
+	.remove = xrt_calib_remove,
+	.id_table = xrt_calib_table,
+};
+
+void calib_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_CALIB, &xrt_calib_driver, xrt_calib_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_CALIB);
+}
-- 
2.18.4

