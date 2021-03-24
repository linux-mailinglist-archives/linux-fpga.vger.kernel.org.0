Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5953B34711D
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235397AbhCXFgg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:36 -0400
Received: from mail-dm6nam08on2072.outbound.protection.outlook.com ([40.107.102.72]:26209
        "EHLO NAM04-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235254AbhCXFgY (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:36:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Te0PavZOOL4pr0u1a8eQ9Ht4EaI/yFWCKmvpuX/9x9/qCImKF3nxKI9H/J1lUtQddor1rdcET1uT73TJEKz4ICPA/VO02KCsuV6OBn0Z6jqpBydNvrKvSw7eXvfG6SKdQvbwLgfiQQ42u/hl5QftTJmqmy0mXvEGHKkqIjHHTAoxla1Fkxmr26EYSj6cC7mhZVtTmmc3WzaDK+RFEbpGKU/BB6tx12Q/dGY0nLHNAJ8ee2gicLHS03TyZEWzvwiuctckMGmfoOSWrXFuKmmHsjzVieuT7vjlPMnqqOisaFBdjNdWxb7telM6vslcMAXTF/VEktBWgcyT0SFbEzKcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8WP/KkCLZxwVQkpfFcRZGd05Bh18d86s5fws/sL8o8=;
 b=F+oYRhmZtFCTTD9CUKR7lTx6sCV3ZcBY/C1tA2t8S4gyCUyY4EVcdtngt6Kmk9wmxbfULkt97Yie4IWHy0JSjYbEUFKkD+4XiH4EOxrrERUIKUOLLP1BgIc56LPzjJjG1Cxi8PVKnQ5RiOWes/Xc3Bw20V/3b/tid7wvqWf9CxoR1ihd+QW5XcpMu3fECwP1HbSXKgCJNYnwcBHJ+5+TdZZ4K6AQM0521GxvDGSi6zoFmsAv3QSWhEW7z0ujoYH5ZixZcU7tTkGHKUjPOB5LFYJplfSb0ECNiAUqGiJCJJAiB0xCPU1CLah28Ta0xLRE5H44EoJfp0wrTJQ9D80U5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v8WP/KkCLZxwVQkpfFcRZGd05Bh18d86s5fws/sL8o8=;
 b=IptPHZHBVoMgM7dik8Ycr6gHVz2dIHzeK2udl1y3UJXK0zNreQp5z5wVOC8t7Q7Pn9rkl9pHQztM2uSearw9s4ifBpSC57H9iIsXjrvlTJns1BFIfvd1t6vrDZsh9p0QBERNZnNF82imCR3dzbNQAWYSEmWxM/GQs5f0PRtL1mg=
Received: from DM5PR08CA0027.namprd08.prod.outlook.com (2603:10b6:4:60::16) by
 DM6PR02MB4457.namprd02.prod.outlook.com (2603:10b6:5:1f::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.23; Wed, 24 Mar 2021 05:36:22 +0000
Received: from DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::cb) by DM5PR08CA0027.outlook.office365.com
 (2603:10b6:4:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25 via Frontend
 Transport; Wed, 24 Mar 2021 05:36:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT061.mail.protection.outlook.com (10.13.4.230) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:36:22 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:36:11 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:36:11 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51058 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwBe-0006Gj-Vn; Tue, 23 Mar 2021 22:36:11 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 38E63600131; Tue, 23 Mar 2021 22:29:57 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 19/20] fpga: xrt: partition isolation platform driver
Date:   Tue, 23 Mar 2021 22:29:46 -0700
Message-ID: <20210324052947.27889-20-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b40adce-244b-4789-e78a-08d8ee86c228
X-MS-TrafficTypeDiagnostic: DM6PR02MB4457:
X-Microsoft-Antispam-PRVS: <DM6PR02MB44578CD81D405B4CABF14AB8A1639@DM6PR02MB4457.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NAygoAGrJ9t1tEXhWNq9ui/RxDHAN+bclttgZTaRnVBQdHX2MyzdSjwsErZB1YSuRzFGCnTnd7eboNisghH77dUcmsZzUMETzfZ56GfvSjD0ULwTjxvDzQK8qrR8EssI/D29myQf4k2Zv8ge+5h3fLiYwSamleKUruWrh/oIqAkLnzlXoVPOs/B477FotrWgE+oAn1XywygGgb0+KvNt+Fy6nZGFw7hQOB35wxi7CiRY26heBJc/94ZgNiB09m+iyTLMZcpZ1cXEdO+/Xdzyr/UvUS5EUlciHfYs/s/5En+fMyR3ttwoOXoURwmIYlSQ5aV4zDsFVrR25Xt8AUoZO0QL+dlf9DWmOvPyrcr2g9qCrERXRYHNomSesGbD3cxGaIF3LF9aSMDclEXbi+QxCbyHSV3m/gKYvdIyonqtflIrjE0n7MmbXzu6qsjzYlvdOV2IBCpNft30afuiFdqcMUxwb1VzmvwW2UF3dYXLBfuDIbXKOuJZixsE80hnJjPk9dNFj/mRWF49rmu3aOrkwsVEwWpma63Y7DJUeDb+1+gSnOf8y1wis8XZVkHfvtbA6w6y+6Dcmi7C8ZdD1OuZXbz3imlYPVlbhpyYY8m3UhDvx9RJcttn8Mhzc9I47kEZ++vbw4Tq5VP8YcgB/OaOjJLySyC9gvZekg0ic7meS7Q=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(39860400002)(376002)(36840700001)(46966006)(6266002)(6666004)(44832011)(478600001)(36906005)(8936002)(1076003)(2616005)(36860700001)(8676002)(107886003)(2906002)(426003)(6916009)(5660300002)(54906003)(336012)(70206006)(47076005)(82310400003)(316002)(36756003)(42186006)(186003)(83380400001)(26005)(356005)(82740400003)(4326008)(7636003)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:36:22.2524
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b40adce-244b-4789-e78a-08d8ee86c228
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT061.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4457
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add partition isolation platform driver. partition isolation is
a hardware function discovered by walking firmware metadata.
A platform device node will be created for it. Partition isolation
function isolate the different fpga regions

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/axigate.h |  23 ++
 drivers/fpga/xrt/lib/xleaf/axigate.c     | 342 +++++++++++++++++++++++
 2 files changed, 365 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c

diff --git a/drivers/fpga/xrt/include/xleaf/axigate.h b/drivers/fpga/xrt/include/xleaf/axigate.h
new file mode 100644
index 000000000000..58f32c76dca1
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/axigate.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_AXIGATE_H_
+#define _XRT_AXIGATE_H_
+
+#include "xleaf.h"
+#include "metadata.h"
+
+/*
+ * AXIGATE driver leaf calls.
+ */
+enum xrt_axigate_leaf_cmd {
+	XRT_AXIGATE_CLOSE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_AXIGATE_OPEN,
+};
+
+#endif	/* _XRT_AXIGATE_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
new file mode 100644
index 000000000000..231bb0335278
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA AXI Gate Driver
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
+#include <linux/regmap.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/axigate.h"
+
+#define XRT_AXIGATE "xrt_axigate"
+
+#define XRT_AXIGATE_WRITE_REG		0
+#define XRT_AXIGATE_READ_REG		8
+
+#define XRT_AXIGATE_CTRL_CLOSE		0
+#define XRT_AXIGATE_CTRL_OPEN_BIT0	1
+#define XRT_AXIGATE_CTRL_OPEN_BIT1	2
+
+#define XRT_AXIGATE_INTERVAL		500 /* ns */
+
+struct xrt_axigate {
+	struct platform_device	*pdev;
+	struct regmap		*regmap;
+	struct mutex		gate_lock; /* gate dev lock */
+
+	void			*evt_hdl;
+	const char		*ep_name;
+
+	bool			gate_closed;
+};
+
+static const struct regmap_config axigate_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+/* the ep names are in the order of hardware layers */
+static const char * const xrt_axigate_epnames[] = {
+	XRT_MD_NODE_GATE_PLP, /* PLP: Provider Logic Partition */
+	XRT_MD_NODE_GATE_ULP  /* ULP: User Logic Partition */
+};
+
+static inline int close_gate(struct xrt_axigate *gate)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG, XRT_AXIGATE_CTRL_CLOSE);
+	if (ret) {
+		xrt_err(gate->pdev, "write gate failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	/*
+	 * Legacy hardware requires extra read work properly.
+	 * This is not on critical path, thus the extra read should not impact performance much.
+	 */
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->pdev, "read gate failed %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static inline int open_gate(struct xrt_axigate *gate)
+{
+	u32 val;
+	int ret;
+
+	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG, XRT_AXIGATE_CTRL_OPEN_BIT1);
+	if (ret) {
+		xrt_err(gate->pdev, "write 2 failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	/*
+	 * Legacy hardware requires extra read work properly.
+	 * This is not on critical path, thus the extra read should not impact performance much.
+	 */
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->pdev, "read 2 failed %d", ret);
+		return ret;
+	}
+	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG,
+			   XRT_AXIGATE_CTRL_OPEN_BIT0 | XRT_AXIGATE_CTRL_OPEN_BIT1);
+	if (ret) {
+		xrt_err(gate->pdev, "write 3 failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->pdev, "read 3 failed %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xrt_axigate_epname_idx(struct platform_device *pdev)
+{
+	struct resource	*res;
+	int ret, i;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(xrt_axigate_epnames); i++) {
+		ret = strncmp(xrt_axigate_epnames[i], res->name,
+			      strlen(xrt_axigate_epnames[i]) + 1);
+		if (!ret)
+			return i;
+	}
+
+	return -EINVAL;
+}
+
+static int xrt_axigate_close(struct platform_device *pdev)
+{
+	struct xrt_axigate *gate;
+	u32 status = 0;
+	int ret;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
+	if (ret) {
+		xrt_err(pdev, "read gate failed %d", ret);
+		goto failed;
+	}
+	if (status) {		/* gate is opened */
+		xleaf_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE, false);
+		ret = close_gate(gate);
+		if (ret)
+			goto failed;
+	}
+
+	gate->gate_closed = true;
+
+failed:
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "close gate %s", gate->ep_name);
+	return ret;
+}
+
+static int xrt_axigate_open(struct platform_device *pdev)
+{
+	struct xrt_axigate *gate;
+	u32 status;
+	int ret;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
+	if (ret) {
+		xrt_err(pdev, "read gate failed %d", ret);
+		goto failed;
+	}
+	if (!status) {		/* gate is closed */
+		ret = open_gate(gate);
+		if (ret)
+			goto failed;
+		xleaf_broadcast_event(pdev, XRT_EVENT_POST_GATE_OPEN, true);
+		/* xrt_axigate_open() could be called in event cb, thus
+		 * we can not wait for the completes
+		 */
+	}
+
+	gate->gate_closed = false;
+
+failed:
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "open gate %s", gate->ep_name);
+	return ret;
+}
+
+static void xrt_axigate_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct xrt_axigate *gate = platform_get_drvdata(pdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct platform_device *leaf;
+	enum xrt_subdev_id id;
+	struct resource	*res;
+	int instance;
+
+	if (e != XRT_EVENT_POST_CREATION)
+		return;
+
+	instance = evt->xe_subdev.xevt_subdev_instance;
+	id = evt->xe_subdev.xevt_subdev_id;
+	if (id != XRT_SUBDEV_AXIGATE)
+		return;
+
+	leaf = xleaf_get_leaf_by_id(pdev, id, instance);
+	if (!leaf)
+		return;
+
+	res = platform_get_resource(leaf, IORESOURCE_MEM, 0);
+	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
+		xleaf_put_leaf(pdev, leaf);
+		return;
+	}
+
+	/* higher level axigate instance created, make sure the gate is opened. */
+	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(pdev))
+		xrt_axigate_open(pdev);
+	else
+		xleaf_call(leaf, XRT_AXIGATE_OPEN, NULL);
+
+	xleaf_put_leaf(pdev, leaf);
+}
+
+static int
+xrt_axigate_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_axigate_event_cb(pdev, arg);
+		break;
+	case XRT_AXIGATE_CLOSE:
+		ret = xrt_axigate_close(pdev);
+		break;
+	case XRT_AXIGATE_OPEN:
+		ret = xrt_axigate_open(pdev);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_axigate_probe(struct platform_device *pdev)
+{
+	struct xrt_axigate *gate = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int ret;
+
+	gate = devm_kzalloc(&pdev->dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return -ENOMEM;
+
+	gate->pdev = pdev;
+	platform_set_drvdata(pdev, gate);
+
+	xrt_info(pdev, "probing...");
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty resource 0");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		xrt_err(pdev, "map base iomem failed");
+		ret = PTR_ERR(base);
+		goto failed;
+	}
+
+	gate->regmap = devm_regmap_init_mmio(&pdev->dev, base, &axigate_regmap_config);
+	if (IS_ERR(gate->regmap)) {
+		xrt_err(pdev, "regmap %pR failed", res);
+		ret = PTR_ERR(gate->regmap);
+		goto failed;
+	}
+	gate->ep_name = res->name;
+
+	mutex_init(&gate->gate_lock);
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GATE_ULP },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GATE_PLP },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_axigate_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xrt_axigate_leaf_call,
+	},
+};
+
+static const struct platform_device_id xrt_axigate_table[] = {
+	{ XRT_AXIGATE, (kernel_ulong_t)&xrt_axigate_data },
+	{ },
+};
+
+static struct platform_driver xrt_axigate_driver = {
+	.driver = {
+		.name = XRT_AXIGATE,
+	},
+	.probe = xrt_axigate_probe,
+	.id_table = xrt_axigate_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_AXIGATE, axigate);
-- 
2.27.0

