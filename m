Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C134393ABD
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:54:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbhE1Az7 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:55:59 -0400
Received: from mail-bn7nam10on2072.outbound.protection.outlook.com ([40.107.92.72]:14224
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235323AbhE1Az6 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:55:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ya6cxhFmWy/ZehWpt8L2jrhznoqfykGsWwfpx2/DHJEib+WYBAvntjXXtqEvKiTyApjHy5pTUxXNenHkj0bsMIdXnaoNGRMHdYjPfxxp+sSPITyit6EeUI/O5FqEMRKhzEV6WnDb9mWJ30n6n0KyGhsMk7rWOC2uESASQfplK1ja6Z+CQ04sDQ4ML2TevprIR4rCAMZXrqEWSkWPjZcl4PJRZkWVUkJ1RRUBQ3j1tfBiGTduI0RfRWSFyq1rEFyQpZoRMmXxr6M7xZFSRtgvkkxhddwR9AX9hC7ldR0kkN1Kt3v5vImgm8nm+xVR8VAD+CEnP0wvcfN4/3ZqQ39xHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgIysCMmPg/Q49sXbfndlmHRD4oFRC9Mz4qe72WFBAY=;
 b=RogjXyFLAjFXUq0j6AEnhf15bn2E+oJmyvKBgL66dJzMpqO8OADXv/akFTCsyvm7A0xfHgekeAp22G6qEyM1Mrqm05YNjkhpU7LN5zY+808XKJ1hOXqX3tGc/Ss/8lrH8g0bzS7sr93JXRwClZ/OJFqHrrHS/j2elsw/SuANAXuWgUIScpab6j1c3SN3uGPiKKi68twdyq4KVOwVToax1MvSGz3KHehLDt54GyojnUKPobWUvbFL20AdcTc7Cehx0lfDgxxMwwVexlMRiNv8fxB0VlHfuE0MMZqYyM4q7KLOH/Rj9vOdvGMvhlKafNAdEla5H3916b+60yZ+f51O2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HgIysCMmPg/Q49sXbfndlmHRD4oFRC9Mz4qe72WFBAY=;
 b=dQDHg7j1Z8obNJkjCoYRjH8XGeRILZsxjCrIz7HTC3falzk0cO2NC9f7gNUbuIH6bjv4fEB+JEYN6Jv5S+BCyIhUEzgmFaA1WLXFc/tQXa4jIGEvAud2SYT+l7/rPWQq3CGJq4HHseT0YxW3DPs2hEDaJQotCsZKGEA1B8m02VA=
Received: from SN4PR0801CA0016.namprd08.prod.outlook.com
 (2603:10b6:803:29::26) by DM8PR02MB8072.namprd02.prod.outlook.com
 (2603:10b6:8:19::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21; Fri, 28 May
 2021 00:54:20 +0000
Received: from SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:29:cafe::77) by SN4PR0801CA0016.outlook.office365.com
 (2603:10b6:803:29::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:54:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0032.mail.protection.outlook.com (10.97.5.58) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:54:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:53:56 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:53:56 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34044 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQlA-0007M9-BU; Thu, 27 May 2021 17:53:56 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 791996032B6; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 19/20] fpga: xrt: partition isolation driver
Date:   Thu, 27 May 2021 17:49:58 -0700
Message-ID: <20210528004959.61354-20-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32fa67ca-5540-4e3e-67fe-08d921732090
X-MS-TrafficTypeDiagnostic: DM8PR02MB8072:
X-Microsoft-Antispam-PRVS: <DM8PR02MB807241B653C88CC43A8690C8A1229@DM8PR02MB8072.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:245;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4m7MU1Vq3WQbPMSta5eOgs4dOhBjKxK1OgCbT6c7n+i2Ks+GcSGqSielOYWzF93gYhQRSQkzhr8WNZZ2Cx+kFl6M1sx2aSTElletjBzgR7ipZ329hHTZAJ/CWtdYkH0ropSxe74yN4iSpw0SDrVMf/KdQEE4j4A2JrrXzQ4EgODllOUe8Gmc/ZHNzc52uO2oHpZJaBVatBop/XJn3Z7uNl7l/Nqcj0xNgPv7fuSYM9pBzESicTLUuQ2TqCBn8nwWYfmBwisWJsHnIghdDMvJmkmYXfJWwZV4OV+jSdA1h8/LePCJ4J6p5aHkfYvAzz9jmZXw8MbXd5l478Iao3r5o5LdRo4eLLY81GtLCdTWmwHNZRmr9wOnG4fyFL5nLhPdVBI+vu1eMT7K0lxqElZ5hUACBNCZwywYr3oX7hL6cVlp1DZcagVbjj9g5I5YTljPy/3X6gJkZ0g8g/f8wTi/vYb55E5/DGPwP0pORBonslcrvauP1c1L4n/P2V38sphp5VILj0+pWP0B3gTsnDYUm6iGQXuru/NSDZaHgbXPlRWQ/DeUNng8Mb5jffK/Ut62PdBlaFUlF+/w4Tn8YW7WI5SDV1cT6qcxMtLtGhCrsN712DdTz4qpnSBCMJph8KIVj+Lw3oa3Qrw7spM01fznH/qH1/rjNmLJOTm0195h4Yc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(39840400004)(346002)(46966006)(36840700001)(6666004)(2906002)(44832011)(8676002)(426003)(2616005)(186003)(8936002)(336012)(36756003)(4326008)(107886003)(47076005)(6266002)(478600001)(26005)(36860700001)(6916009)(316002)(54906003)(42186006)(1076003)(82310400003)(70206006)(356005)(83380400001)(70586007)(7636003)(5660300002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:54:20.0126
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32fa67ca-5540-4e3e-67fe-08d921732090
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR02MB8072
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

