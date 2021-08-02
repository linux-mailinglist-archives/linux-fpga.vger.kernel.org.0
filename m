Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDA3D3DDD38
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232725AbhHBQIf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:08:35 -0400
Received: from mail-bn8nam11on2058.outbound.protection.outlook.com ([40.107.236.58]:33184
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232709AbhHBQId (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:08:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e5k9tVR2aouU3SkhYgLuEoCvFsFvPIZe79fQFUvbCdDA1mF2S4G1iyOPKS1L4+4+btLdXpoXUV59UtzI6/VgnH9egwmFIfblCEesWvaJeuI1zIn7PyMxVOD6xB5kcQMvCLzVfBAkKBfOJ5ZHbshsqHfLESCTe7FntrKIFcQHyFTY5DzQTf5hPyIqPcPqY993m3LzZ9Z61Pu6GV9Bj1StoNxdZzsaUeXH8m5Vo/8e0GbPJaWdMSehkLmjxSIlQ6uL5jAWRLU3P5EmpNnGYtG1Sr76R7FBfaA2mgXCjIqOqZx/r/1EbxD4wyckGzSApyPaW6ZJcT91YpXwuie6RnIN8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgIysCMmPg/Q49sXbfndlmHRD4oFRC9Mz4qe72WFBAY=;
 b=Nt9XxMLSEcKK18xD8w5rDh5QP/LeXh6XjBF1uW3LnzgTrIULBiCyzIWoTP/a2LK68gPynR8E8e9kcKHpFz4qTuAab2keR17TpKKs04cOc6y2k6IL90IIe9FNxh/61YN55mbKcWfNmyeilItHN0mXUea6knS4OVf2kxr2q83BVUCttQqxnEKQ6/SNgcRafAOxbYOg/DAUDSasQJqpfr9Yw0m7tzzbBPFetLiI46pHfxLuemuHCjpd3eej5kK5KP5imFkMcsxztJdSNFPZ80XdfApZDV1gnATUxZjy/3TZvjcYFPzQ6OeThxefyzjh9mFpRs/BAho9LYaLkze3lywizw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgIysCMmPg/Q49sXbfndlmHRD4oFRC9Mz4qe72WFBAY=;
 b=AqvaLwkeK+0RJXoHtEvSndjv8idlUP+ss0YZv6Lzto3tKE+Lokb4qZRt8kOCrZU+ssGaQk4BmzutOEqGGhQh+akgy7Gu1R+0Er1WFhc/n0fLEQafv+0XuHDYpcE4nYrcHPvrpnTvWnoktbYXf3XHmttSWCYet05IC3HinPn62m4=
Received: from DM6PR04CA0001.namprd04.prod.outlook.com (2603:10b6:5:334::6) by
 CO1PR02MB8505.namprd02.prod.outlook.com (2603:10b6:303:158::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.25; Mon, 2 Aug
 2021 16:08:20 +0000
Received: from DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:334:cafe::50) by DM6PR04CA0001.outlook.office365.com
 (2603:10b6:5:334::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.20 via Frontend
 Transport; Mon, 2 Aug 2021 16:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT008.mail.protection.outlook.com (10.13.5.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:08:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:08:18 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:08:18 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49076 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaUE-0004NQ-La; Mon, 02 Aug 2021 09:08:18 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 2FE3E601B3A; Mon,  2 Aug 2021 09:05:30 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 13/14] fpga: xrt: partition isolation driver
Date:   Mon, 2 Aug 2021 09:05:20 -0700
Message-ID: <20210802160521.331031-14-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bb04b0ed-b165-461b-bca3-08d955cfbf64
X-MS-TrafficTypeDiagnostic: CO1PR02MB8505:
X-Microsoft-Antispam-PRVS: <CO1PR02MB850536404EC40A7FF0822A24A1EF9@CO1PR02MB8505.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cLxTlKSNyL/GbCIoS43JbJcfIfnKg7rRsnZv7Cza6v/VQWoZEOlqLGoH9FXkSDgZgs+lvQk2dySc34elfeA0wffTiyQAVl3qlN2GfgzFIatXS+wJFVKFg9Ms05d3069V3AARJS0bOC2SqM7JuzrVlF6JYuOXFa+QnL3L+7gfafBDdO3jlNTBifLV24kIYc4hvzyFUhEdE9hUspOl4Wi7etJ7jrD2mrtIuU1TvExHwAT+Kmlwmw0jPe5vuTPWk6jB0Nvz1GV3Aq/u7dDilSMY9K9+fNmWGbxJPqQuKKpOAvai9pntBxKZKR4m+od8OElhPcHRI595qWrbACiCrGwO4uYpvtITZlT9yXQ/qw4+mKpkZT3WNxVoZIH2R1Xgb0r/6LIj3cbp+QPrz8hJQWVgLLNe6igfxd5C44bOHilKIAxvHnQ3QoqmvN1F2OiX12vnu6Y+uPJPfKg94ZW2b83Sb9qSBTEa6xWF12ataMJutKRkYdV6/O6wBVgh0F3xXvQgVXaGVi33st1FqdKgyZKw57Zxncu3pRPwakVddkhP/PH0T1mOxDJAirnytcN6Nd8b8UukKUJAUuA1fHyMoa31lySLxRcSZPEtzci88OqaqEKkdHqgLTRrcXKfsNT5yng/VAg4h6k78gR/lWudjYmPLRd2P6wMSh+FMPeYq8B8DjVeGHXk6fyZ1xA+Dd1k6qcAT9tEe/wOTf+dk3K70BHhzw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(6916009)(2616005)(336012)(508600001)(7636003)(44832011)(26005)(186003)(82310400003)(8676002)(5660300002)(426003)(83380400001)(70586007)(70206006)(2906002)(316002)(36906005)(54906003)(42186006)(6266002)(107886003)(4326008)(1076003)(47076005)(36860700001)(356005)(8936002)(36756003)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:08:20.6357
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb04b0ed-b165-461b-bca3-08d955cfbf64
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT008.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8505
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add partition isolation xrt driver. partition isolation is
a hardware function discovered by walking firmware metadata.
A xrt device node will be created for it. Partition isolation
function isolate the different fpga regions

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/include/xleaf/axigate.h |  23 ++
 drivers/fpga/xrt/lib/xleaf/axigate.c     | 325 +++++++++++++++++++++++
 2 files changed, 348 insertions(+)
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
index 000000000000..493707b782e4
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
@@ -0,0 +1,325 @@
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
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		gate_lock; /* gate dev lock */
+	void			*evt_hdl;
+	const char		*ep_name;
+	bool			gate_closed;
+};
+
+XRT_DEFINE_REGMAP_CONFIG(axigate_regmap_config);
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
+		xrt_err(gate->xdev, "write gate failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	/*
+	 * Legacy hardware requires extra read work properly.
+	 * This is not on critical path, thus the extra read should not impact performance much.
+	 */
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->xdev, "read gate failed %d", ret);
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
+		xrt_err(gate->xdev, "write 2 failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	/*
+	 * Legacy hardware requires extra read work properly.
+	 * This is not on critical path, thus the extra read should not impact performance much.
+	 */
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->xdev, "read 2 failed %d", ret);
+		return ret;
+	}
+	ret = regmap_write(gate->regmap, XRT_AXIGATE_WRITE_REG,
+			   XRT_AXIGATE_CTRL_OPEN_BIT0 | XRT_AXIGATE_CTRL_OPEN_BIT1);
+	if (ret) {
+		xrt_err(gate->xdev, "write 3 failed %d", ret);
+		return ret;
+	}
+	ndelay(XRT_AXIGATE_INTERVAL);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &val);
+	if (ret) {
+		xrt_err(gate->xdev, "read 3 failed %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int xrt_axigate_epname_idx(struct xrt_device *xdev)
+{
+	struct resource	*res;
+	int ret, i;
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(xdev, "Empty Resource!");
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
+static int xrt_axigate_close(struct xrt_device *xdev)
+{
+	struct xrt_axigate *gate;
+	u32 status = 0;
+	int ret;
+
+	gate = xrt_get_drvdata(xdev);
+
+	mutex_lock(&gate->gate_lock);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
+	if (ret) {
+		xrt_err(xdev, "read gate failed %d", ret);
+		goto failed;
+	}
+	if (status) {		/* gate is opened */
+		xleaf_broadcast_event(xdev, XRT_EVENT_PRE_GATE_CLOSE, false);
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
+	xrt_info(xdev, "close gate %s", gate->ep_name);
+	return ret;
+}
+
+static int xrt_axigate_open(struct xrt_device *xdev)
+{
+	struct xrt_axigate *gate;
+	u32 status;
+	int ret;
+
+	gate = xrt_get_drvdata(xdev);
+
+	mutex_lock(&gate->gate_lock);
+	ret = regmap_read(gate->regmap, XRT_AXIGATE_READ_REG, &status);
+	if (ret) {
+		xrt_err(xdev, "read gate failed %d", ret);
+		goto failed;
+	}
+	if (!status) {		/* gate is closed */
+		ret = open_gate(gate);
+		if (ret)
+			goto failed;
+		xleaf_broadcast_event(xdev, XRT_EVENT_POST_GATE_OPEN, true);
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
+	xrt_info(xdev, "open gate %s", gate->ep_name);
+	return ret;
+}
+
+static void xrt_axigate_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct xrt_axigate *gate = xrt_get_drvdata(xdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct xrt_device *leaf;
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
+	leaf = xleaf_get_leaf_by_id(xdev, id, instance);
+	if (!leaf)
+		return;
+
+	res = xrt_get_resource(leaf, IORESOURCE_MEM, 0);
+	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
+		xleaf_put_leaf(xdev, leaf);
+		return;
+	}
+
+	/* higher level axigate instance created, make sure the gate is opened. */
+	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(xdev))
+		xrt_axigate_open(xdev);
+	else
+		xleaf_call(leaf, XRT_AXIGATE_OPEN, NULL);
+
+	xleaf_put_leaf(xdev, leaf);
+}
+
+static int
+xrt_axigate_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	int ret = 0;
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_axigate_event_cb(xdev, arg);
+		break;
+	case XRT_AXIGATE_CLOSE:
+		ret = xrt_axigate_close(xdev);
+		break;
+	case XRT_AXIGATE_OPEN:
+		ret = xrt_axigate_open(xdev);
+		break;
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_axigate_probe(struct xrt_device *xdev)
+{
+	struct xrt_axigate *gate = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int ret;
+
+	gate = devm_kzalloc(&xdev->dev, sizeof(*gate), GFP_KERNEL);
+	if (!gate)
+		return -ENOMEM;
+
+	gate->xdev = xdev;
+	xrt_set_drvdata(xdev, gate);
+
+	xrt_info(xdev, "probing...");
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(xdev, "Empty resource 0");
+		ret = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base)) {
+		xrt_err(xdev, "map base iomem failed");
+		ret = PTR_ERR(base);
+		goto failed;
+	}
+
+	gate->regmap = devm_regmap_init_mmio(&xdev->dev, base, &axigate_regmap_config);
+	if (IS_ERR(gate->regmap)) {
+		xrt_err(xdev, "regmap %pR failed", res);
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
+static struct xrt_dev_endpoints xrt_axigate_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GATE_ULP },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GATE_PLP },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_axigate_driver = {
+	.driver = {
+		.name = XRT_AXIGATE,
+	},
+	.subdev_id = XRT_SUBDEV_AXIGATE,
+	.endpoints = xrt_axigate_endpoints,
+	.probe = xrt_axigate_probe,
+	.leaf_call = xrt_axigate_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(axigate);
-- 
2.27.0

