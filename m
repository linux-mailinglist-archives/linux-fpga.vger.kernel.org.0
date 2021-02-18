Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4931E695
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:01:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbhBRG5f (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:57:35 -0500
Received: from mail-eopbgr680071.outbound.protection.outlook.com ([40.107.68.71]:47331
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230376AbhBRGst (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:48:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmRba4WXLmtfaB9MLARLLiZIbnm2W0Jf4GZlZIbKKTwx731xE+UD6FxyKwA+0cxOuoZ5T07M+76EJ61nC39C0XxkWZsT3UZltcfaZzHGNxMKdKfLmDkv8n8tr/m4sLAj1egewNRgfz9d/kw9c3VMxZlAXS2HjGQsk62hhUOWLgn8ufFVTq9WLjDEGHmqZg6HHmFAhC5BOmwb3OAT/LysVdBhL6eBVoCyxzfsTOZjLOiImS+TT0a8oTIjll6Czmjnfvi0wO8tqyzIfTVCvKuLe/8Tsa2O6LcF2t3xGJqlQQj+w0RKhnXAi2yAsqopE1bywFp+oxnTr6uRWDMGp1hajQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS+kwM2jYFa0sj3mAEDegEwPhrDqPotu6ZopZYPZn/o=;
 b=HlQ2n/PUZOWDAKhWyxNIeVlRShT/sklfpdMxyiifDSts5N1Ejc5Vu2egSnBO8FQWjpa6M/FA2hKHhELuDlTnnyWcpjmU/A7TXu2a5CPonzn6uVgo6YYl+tihq3SrQhKdvHOs7v+QNCnE9NlyhNcNiJ32z5f8jxUWtD4k5LjYRkTYPm2oDjTGZlLjzEP2FlwXhzC/EtWFHcNp+T2VAj2H47uIZhgZYLdgWeJpyRY8FOOYRNiO2cPzEbbiPEA0N7Ily6J1v3SQLxDCRP2ehHxUhGk8iM17VKLMVlXryEv4Pms7dVQeuHtJSR734t473AwduOT4XEWHk7D8QMFsDjPY5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bS+kwM2jYFa0sj3mAEDegEwPhrDqPotu6ZopZYPZn/o=;
 b=Lj/PfXujiQvqRt6T6ErwCaobJoS9g2H7HY7z51z4xTuqj0QUZavRQodJd+KRhmvXqt9de2+d/5szYS+NmEuykZaGFzE3XAM3q3+eshzBnDM2lts2zaziaKDzJQK4mnF/acNMSZa20EyMbsyySmvxny4yupwhzOtJSz7PUPh+f2A=
Received: from BLAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:32b::23)
 by PH0PR02MB7653.namprd02.prod.outlook.com (2603:10b6:510:5e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.27; Thu, 18 Feb
 2021 06:46:17 +0000
Received: from BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32b:cafe::e0) by BLAPR03CA0018.outlook.office365.com
 (2603:10b6:208:32b::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:46:17 +0000
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
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:46:16 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:46:16 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:46:16 -0800
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
Received: from [172.19.72.212] (port=40194 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd4q-0002Jq-74; Wed, 17 Feb 2021 22:46:16 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id B7A8360012F; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 17/18] fpga: xrt: partition isolation platform driver
Date:   Wed, 17 Feb 2021 22:40:18 -0800
Message-ID: <20210218064019.29189-18-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6c562c0b-db39-4a24-9cc7-08d8d3d8e44e
X-MS-TrafficTypeDiagnostic: PH0PR02MB7653:
X-Microsoft-Antispam-PRVS: <PH0PR02MB76530F0CA4066D20D96C4D28A1859@PH0PR02MB7653.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N5p9o5uUydxOyPqz5Una7sA5ghWoA9JU8KTBgK/Lyy84rxD4tZA1WQjPD9YDQkpnvUQCXHawZ1dggcQ4Fcdaby6VKdSyrpCud851+kSq0S9+VLCKh4H8n7loN/m0x+RHSmw1jW5ua+WpKAETtm4UwL4TUB59SXL2j5a+wdSjbphoMzJakLjGcHUDAxrDi3pKqmXFCN6i1+qf82m1d1u7NiiyHchhyWPFcgp1jbJFlgdo5rwcCMLHwNqmanQVIG3JLmQcEa8hxw3HGMNIUxa5oS5Jw/mOsNV8Pa0aLoPLQQLjF5KcuXm/eMYPBXecuN9Q9x4kNcHpf+uTaEvmoKQFoVCADTF3jduFLGlZlhdqHFU8w2yK07GWA9gpHFO6VOyZsG5wEzdPHvXcVaSL/bNXLNFgDGz1+PopU1tR0nIqZv+cWbJ+Z/feoyRq+RelNJgdiF/jyTYRsK2T5vE8oALjEfvVg6UTkq9Z0OMKSNPrEznpWqu5Si2Trzmd2gAiBGEQT/Kz3gw9dAnEXiMGUEcgp4KdmTUVNRIXSX25quI2OcsYVu+zavF+3B+5twFm8+prB4eT5oluOZXB4lYVYQ/tPc/x07oVxc/IALfv13w9WzIahlLJoarLU6eXaCuOaE06KVNDyIPDUimiXrPxyxDwgjxmmLFmb+C0WfmrmK6gbBA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(136003)(376002)(396003)(46966006)(36840700001)(2616005)(426003)(8936002)(1076003)(36906005)(6916009)(36756003)(83380400001)(82310400003)(4326008)(36860700001)(186003)(6666004)(336012)(47076005)(8676002)(82740400003)(478600001)(5660300002)(26005)(44832011)(70586007)(356005)(42186006)(107886003)(6266002)(7636003)(70206006)(54906003)(2906002)(316002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:46:16.8259
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c562c0b-db39-4a24-9cc7-08d8d3d8e44e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7653
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add partition isolation platform driver. partition isolation is
a hardware function discovered by walking firmware metadata.
A platform device node will be created for it. Partition isolation
function isolate the different fpga regions

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/axigate.h |  25 ++
 drivers/fpga/xrt/lib/xleaf/axigate.c     | 298 +++++++++++++++++++++++
 2 files changed, 323 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/axigate.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/axigate.c

diff --git a/drivers/fpga/xrt/include/xleaf/axigate.h b/drivers/fpga/xrt/include/xleaf/axigate.h
new file mode 100644
index 000000000000..2cef71e13b30
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/axigate.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT Axigate Leaf Driver
+ *
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
+ * AXIGATE driver IOCTL calls.
+ */
+enum xrt_axigate_ioctl_cmd {
+	XRT_AXIGATE_FREEZE = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_AXIGATE_FREE,
+};
+
+#endif	/* _XRT_AXIGATE_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/axigate.c b/drivers/fpga/xrt/lib/xleaf/axigate.c
new file mode 100644
index 000000000000..382969f9925f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/axigate.c
@@ -0,0 +1,298 @@
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
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/axigate.h"
+
+#define XRT_AXIGATE "xrt_axigate"
+
+struct axigate_regs {
+	u32		iag_wr;
+	u32		iag_rvsd;
+	u32		iag_rd;
+} __packed;
+
+struct xrt_axigate {
+	struct platform_device	*pdev;
+	void			*base;
+	struct mutex		gate_lock; /* gate dev lock */
+
+	void			*evt_hdl;
+	const char		*ep_name;
+
+	bool			gate_freezed;
+};
+
+/* the ep names are in the order of hardware layers */
+static const char * const xrt_axigate_epnames[] = {
+	XRT_MD_NODE_GATE_PLP,
+	XRT_MD_NODE_GATE_ULP,
+	NULL
+};
+
+#define reg_rd(g, r)						\
+	ioread32((void *)(g)->base + offsetof(struct axigate_regs, r))
+#define reg_wr(g, v, r)						\
+	iowrite32(v, (void *)(g)->base + offsetof(struct axigate_regs, r))
+
+static inline void freeze_gate(struct xrt_axigate *gate)
+{
+	reg_wr(gate, 0, iag_wr);
+	ndelay(500);
+	reg_rd(gate, iag_rd);
+}
+
+static inline void free_gate(struct xrt_axigate *gate)
+{
+	reg_wr(gate, 0x2, iag_wr);
+	ndelay(500);
+	(void)reg_rd(gate, iag_rd);
+	reg_wr(gate, 0x3, iag_wr);
+	ndelay(500);
+	reg_rd(gate, iag_rd);
+}
+
+static int xrt_axigate_epname_idx(struct platform_device *pdev)
+{
+	int			i;
+	int			ret;
+	struct resource		*res;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		xrt_err(pdev, "Empty Resource!");
+		return -EINVAL;
+	}
+
+	for (i = 0; xrt_axigate_epnames[i]; i++) {
+		ret = strncmp(xrt_axigate_epnames[i], res->name,
+			      strlen(xrt_axigate_epnames[i]) + 1);
+		if (!ret)
+			break;
+	}
+
+	ret = (xrt_axigate_epnames[i]) ? i : -EINVAL;
+	return ret;
+}
+
+static void xrt_axigate_freeze(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze = 0;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (freeze) {		/* gate is opened */
+		xleaf_broadcast_event(pdev, XRT_EVENT_PRE_GATE_CLOSE, false);
+		freeze_gate(gate);
+	}
+
+	gate->gate_freezed = true;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "freeze gate %s", gate->ep_name);
+}
+
+static void xrt_axigate_free(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	u32			freeze;
+
+	gate = platform_get_drvdata(pdev);
+
+	mutex_lock(&gate->gate_lock);
+	freeze = reg_rd(gate, iag_rd);
+	if (!freeze) {		/* gate is closed */
+		free_gate(gate);
+		xleaf_broadcast_event(pdev, XRT_EVENT_POST_GATE_OPEN, true);
+		/* xrt_axigate_free() could be called in event cb, thus
+		 * we can not wait for the completes
+		 */
+	}
+
+	gate->gate_freezed = false;
+	mutex_unlock(&gate->gate_lock);
+
+	xrt_info(pdev, "free gate %s", gate->ep_name);
+}
+
+static void xrt_axigate_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct platform_device *leaf;
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id = evt->xe_subdev.xevt_subdev_id;
+	int instance = evt->xe_subdev.xevt_subdev_instance;
+	struct xrt_axigate *gate = platform_get_drvdata(pdev);
+	struct resource	*res;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		break;
+	default:
+		return;
+	}
+
+	if (id != XRT_SUBDEV_AXIGATE)
+		return;
+
+	leaf = xleaf_get_leaf_by_id(pdev, id, instance);
+	if (!leaf)
+		return;
+
+	res = platform_get_resource(leaf, IORESOURCE_MEM, 0);
+	if (!res || !strncmp(res->name, gate->ep_name, strlen(res->name) + 1)) {
+		(void)xleaf_put_leaf(pdev, leaf);
+		return;
+	}
+
+	/*
+	 * higher level axigate instance created,
+	 * make sure the gate is openned. This covers 1RP flow which
+	 * has plp gate as well.
+	 */
+	if (xrt_axigate_epname_idx(leaf) > xrt_axigate_epname_idx(pdev))
+		xrt_axigate_free(pdev);
+	else
+		xleaf_ioctl(leaf, XRT_AXIGATE_FREE, NULL);
+
+	(void)xleaf_put_leaf(pdev, leaf);
+}
+
+static int
+xrt_axigate_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_axigate_event_cb(pdev, arg);
+		break;
+	case XRT_AXIGATE_FREEZE:
+		xrt_axigate_freeze(pdev);
+		break;
+	case XRT_AXIGATE_FREE:
+		xrt_axigate_free(pdev);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int xrt_axigate_remove(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+
+	gate = platform_get_drvdata(pdev);
+
+	if (gate->base)
+		iounmap(gate->base);
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, gate);
+
+	return 0;
+}
+
+static int xrt_axigate_probe(struct platform_device *pdev)
+{
+	struct xrt_axigate	*gate;
+	struct resource		*res;
+	int			ret;
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
+	gate->base = ioremap(res->start, res->end - res->start + 1);
+	if (!gate->base) {
+		xrt_err(pdev, "map base iomem failed");
+		ret = -EFAULT;
+		goto failed;
+	}
+
+	gate->ep_name = res->name;
+
+	mutex_init(&gate->gate_lock);
+
+	return 0;
+
+failed:
+	xrt_axigate_remove(pdev);
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_axigate_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_ulp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = "ep_pr_isolate_plp_00" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_axigate_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_axigate_leaf_ioctl,
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
+	.remove = xrt_axigate_remove,
+	.id_table = xrt_axigate_table,
+};
+
+void axigate_leaf_init_fini(bool init)
+{
+	if (init) {
+		xleaf_register_driver(XRT_SUBDEV_AXIGATE,
+				      &xrt_axigate_driver, xrt_axigate_endpoints);
+	} else {
+		xleaf_unregister_driver(XRT_SUBDEV_AXIGATE);
+	}
+}
-- 
2.18.4

