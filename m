Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6608331E6BB
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhBRHK2 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 02:10:28 -0500
Received: from mail-mw2nam12on2049.outbound.protection.outlook.com ([40.107.244.49]:54913
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231169AbhBRHGc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 02:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CLk5XP/XjtF9eUUcihwrjcEnAZcjzf0oTru/b5zUutCKLxdz2LTVeOPuHLGw/xqYbNHSBiPnPWEG6spn4KzOTbziUttcjxiYYVAJzTXQbIN7kgGmV7xrC91TZ+xwOqNr/HNFuGdfU1wkuerPkDXnoPcn6QB6bwhHJXRokc3vyyx1XJOpnMPhIeuNjUl8cn1PemHIuv/V5lWjioMaxmdg91YtYs5HC/Gh8y9E3UlUAvhIRhpYPpCc4Y3KhzNvMORg05a3LlPspsYUFn2OiM5YeVaqvmEesDaaCLVRFPFYoeSP7wTy6YZi++VVr4xPqup9QsqZAaaAkVKb06jvFN9heg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53y9HeTzKac5kwas2KBGgX1qiCpxLRxwPL99SGa/fHA=;
 b=k1JKlf5n72My1fOmZCPB2uRQIDkR/hWvGFrAjhwETeI9WUYWsCakbY33RIdS7pnylz0JpuyQB6ty7F48QiskyTB3lQdu/y9PLecYIIRCZbNpHVkb8yxjTlHow0ovPO50gIYN6NtWA5+KAOxeTogQSxFU97FR3YX10vrOg7x5CyuZ9dau2YNJ51bBo/R8Qrcvm5k/sHAg8QenZUpvqvzPsBQi+vb0qU/EukcVRa3fYKGf6ltKrtCpgSSoqC2+1fnKSbMJa+9NnNJRCOVyUT+mlSRj5Vr4/iqGTezQ7lD1KPclG7W4zSLqfyWU4wl/7raBwcckpgyDxfOZVTTtCzgwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53y9HeTzKac5kwas2KBGgX1qiCpxLRxwPL99SGa/fHA=;
 b=dNBxTR5OPfzS4UOUaapEwJPEsW0vAlJF6lPGlGxpWLjNS41SfxNIoMGcUmzokX8tmfnlW0Lz3qoQ/OJ+7cHxDJDWJcADo8cVUhA5veBQjKMRuiiPyDC9w3Ol9+9hXppBICh52yQwZJN6Ius/cdme+M+G8JvtWmMyNLjDfJ5EIHE=
Received: from BLAPR03CA0058.namprd03.prod.outlook.com (2603:10b6:208:32d::33)
 by MN2PR02MB7039.namprd02.prod.outlook.com (2603:10b6:208:209::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 06:45:08 +0000
Received: from BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32d:cafe::62) by BLAPR03CA0058.outlook.office365.com
 (2603:10b6:208:32d::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:45:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT061.mail.protection.outlook.com (10.152.77.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:45:08 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:45:04 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:45:04 -0800
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
Received: from [172.19.72.212] (port=40182 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd3f-0001sR-Uv; Wed, 17 Feb 2021 22:45:03 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 49344600128; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 11/18] fpga: xrt: UCS platform driver
Date:   Wed, 17 Feb 2021 22:40:12 -0800
Message-ID: <20210218064019.29189-12-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eeeff88-51bb-4b93-0447-08d8d3d8bb9b
X-MS-TrafficTypeDiagnostic: MN2PR02MB7039:
X-Microsoft-Antispam-PRVS: <MN2PR02MB70396F39B0F6EBF3FA4FEC21A1859@MN2PR02MB7039.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8VfxClfIUO1a9de77Yf2jCm3KfhFQSNVHZnUhsmUbmqa+lVD12zlTLeNctE5LN1AWxlTiObvaERcFJJEjE6y2TT1bwXB1CuojHOd+gN76TXZZWeSc6m7nXlRcn3BaM3M++S1kHUtvXsHhFOPJogebsXQ66ubpZtfuxOoYOlw0LbJb5jeTS3A377OHjOuyKHsZQx+hlzvMMJTBgQGZOKH9xv1EsaxZGBJppHymPjOvqWK6y7pG+y5d7lhRxIaTx2wKzKG4l7oLYGQ2xkRxk/wG87PA0f6yKIZGkB9A94Dbis8shloiZs2VcET4sYCZqhMXdWIQ2rlfIi6eDGdVCZO9ShrjTIt9OW7z/X+l4qz+qx2wHO6GPqGsoH7eNUOnGjcZXKqwSxdW5TsjYBmZakxp1VmHZSix6IkSSEDWuvp0oU8vejv9RvFl9KQJyaDpOKl9xJ8o2eOciAebPvee25Wi96EoKAnVrT76pntU2fj5ahSqHY7iDElxQBfCepV53eb/vUON1kUiOOA2R48fDytekXOodptaL4MpOnSRHOqArz//jgaQEk+fdDOqMr3tUSuWubsXz5Za1jU5YYqfxy3w86OoyS+MQvYCp3jA13tQbQ9oZg/uM4v8Hd07zT7XaCjwuGyfp83K00S4fxylbEPVbQVOKUR0MILlqlDKZ78rk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(8676002)(82740400003)(83380400001)(8936002)(5660300002)(42186006)(54906003)(36906005)(336012)(6666004)(36860700001)(47076005)(2906002)(426003)(82310400003)(70206006)(70586007)(478600001)(6916009)(44832011)(26005)(1076003)(316002)(4326008)(356005)(186003)(7636003)(107886003)(2616005)(6266002)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:45:08.5391
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eeeff88-51bb-4b93-0447-08d8d3d8bb9b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7039
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add UCS driver. UCS is a hardware function discovered by walking xclbin
metadata. A platform device node will be created for it.
UCS enables/disables the dynamic region clocks.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/ucs.h |  24 +++
 drivers/fpga/xrt/lib/xleaf/ucs.c     | 235 +++++++++++++++++++++++++++
 2 files changed, 259 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/ucs.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c

diff --git a/drivers/fpga/xrt/include/xleaf/ucs.h b/drivers/fpga/xrt/include/xleaf/ucs.h
new file mode 100644
index 000000000000..a5ef0e100e12
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/ucs.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT UCS Leaf Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_UCS_H_
+#define _XRT_UCS_H_
+
+#include "xleaf.h"
+
+/*
+ * UCS driver IOCTL calls.
+ */
+enum xrt_ucs_ioctl_cmd {
+	XRT_UCS_CHECK = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_UCS_ENABLE,
+};
+
+#endif	/* _XRT_UCS_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
new file mode 100644
index 000000000000..ae762c8fddbb
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
@@ -0,0 +1,235 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA UCS Driver
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *      Lizhi Hou<Lizhi.Hou@xilinx.com>
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/ucs.h"
+#include "xleaf/clock.h"
+
+#define UCS_ERR(ucs, fmt, arg...)   \
+	xrt_err((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_WARN(ucs, fmt, arg...)  \
+	xrt_warn((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_INFO(ucs, fmt, arg...)  \
+	xrt_info((ucs)->pdev, fmt "\n", ##arg)
+#define UCS_DBG(ucs, fmt, arg...)   \
+	xrt_dbg((ucs)->pdev, fmt "\n", ##arg)
+
+#define XRT_UCS		"xrt_ucs"
+
+#define CHANNEL1_OFFSET			0
+#define CHANNEL2_OFFSET			8
+
+#define CLK_MAX_VALUE			6400
+
+struct ucs_control_status_ch1 {
+	unsigned int shutdown_clocks_latched:1;
+	unsigned int reserved1:15;
+	unsigned int clock_throttling_average:14;
+	unsigned int reserved2:2;
+};
+
+struct xrt_ucs {
+	struct platform_device	*pdev;
+	void __iomem		*ucs_base;
+	struct mutex		ucs_lock; /* ucs dev lock */
+};
+
+static inline u32 reg_rd(struct xrt_ucs *ucs, u32 offset)
+{
+	return ioread32(ucs->ucs_base + offset);
+}
+
+static inline void reg_wr(struct xrt_ucs *ucs, u32 val, u32 offset)
+{
+	iowrite32(val, ucs->ucs_base + offset);
+}
+
+static void xrt_ucs_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct platform_device	*leaf;
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
+	int instance = evt->xe_subdev.xevt_subdev_instance;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		xrt_dbg(pdev, "ignored event %d", e);
+		return;
+	}
+
+	if (id != XRT_SUBDEV_CLOCK)
+		return;
+
+	leaf = xleaf_get_leaf_by_id(pdev, XRT_SUBDEV_CLOCK, instance);
+	if (!leaf) {
+		xrt_err(pdev, "does not get clock subdev");
+		return;
+	}
+
+	xleaf_ioctl(leaf, XRT_CLOCK_VERIFY, NULL);
+	xleaf_put_leaf(pdev, leaf);
+}
+
+static void ucs_check(struct xrt_ucs *ucs, bool *latched)
+{
+	struct ucs_control_status_ch1 *ucs_status_ch1;
+	u32 status;
+
+	mutex_lock(&ucs->ucs_lock);
+	status = reg_rd(ucs, CHANNEL1_OFFSET);
+	ucs_status_ch1 = (struct ucs_control_status_ch1 *)&status;
+	if (ucs_status_ch1->shutdown_clocks_latched) {
+		UCS_ERR(ucs,
+			"Critical temperature or power event, kernel clocks have been stopped.");
+		UCS_ERR(ucs,
+			"run 'xbutil valiate -q' to continue. See AR 73398 for more details.");
+		/* explicitly indicate reset should be latched */
+		*latched = true;
+	} else if (ucs_status_ch1->clock_throttling_average >
+	    CLK_MAX_VALUE) {
+		UCS_ERR(ucs, "kernel clocks %d exceeds expected maximum value %d.",
+			ucs_status_ch1->clock_throttling_average,
+			CLK_MAX_VALUE);
+	} else if (ucs_status_ch1->clock_throttling_average) {
+		UCS_ERR(ucs, "kernel clocks throttled at %d%%.",
+			(ucs_status_ch1->clock_throttling_average /
+			 (CLK_MAX_VALUE / 100)));
+	}
+	mutex_unlock(&ucs->ucs_lock);
+}
+
+static void ucs_enable(struct xrt_ucs *ucs)
+{
+	reg_wr(ucs, 1, CHANNEL2_OFFSET);
+}
+
+static int
+xrt_ucs_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_ucs		*ucs;
+	int			ret = 0;
+
+	ucs = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_ucs_event_cb(pdev, arg);
+		break;
+	case XRT_UCS_CHECK: {
+		ucs_check(ucs, (bool *)arg);
+		break;
+	}
+	case XRT_UCS_ENABLE:
+		ucs_enable(ucs);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int ucs_remove(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs;
+
+	ucs = platform_get_drvdata(pdev);
+	if (!ucs) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	if (ucs->ucs_base)
+		iounmap(ucs->ucs_base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, ucs);
+
+	return 0;
+}
+
+static int ucs_probe(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs = NULL;
+	struct resource *res;
+	int ret;
+
+	ucs = devm_kzalloc(&pdev->dev, sizeof(*ucs), GFP_KERNEL);
+	if (!ucs)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, ucs);
+	ucs->pdev = pdev;
+	mutex_init(&ucs->ucs_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	ucs->ucs_base = ioremap(res->start, res->end - res->start + 1);
+	if (!ucs->ucs_base) {
+		UCS_ERR(ucs, "map base %pR failed", res);
+		ret = -EFAULT;
+		goto failed;
+	}
+	ucs_enable(ucs);
+
+	return 0;
+
+failed:
+	ucs_remove(pdev);
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_ucs_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_ucs_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_ucs_leaf_ioctl,
+	},
+};
+
+static const struct platform_device_id xrt_ucs_table[] = {
+	{ XRT_UCS, (kernel_ulong_t)&xrt_ucs_data },
+	{ },
+};
+
+static struct platform_driver xrt_ucs_driver = {
+	.driver = {
+		.name = XRT_UCS,
+	},
+	.probe = ucs_probe,
+	.remove = ucs_remove,
+	.id_table = xrt_ucs_table,
+};
+
+void ucs_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_UCS, &xrt_ucs_driver, xrt_ucs_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_UCS);
+}
-- 
2.18.4

