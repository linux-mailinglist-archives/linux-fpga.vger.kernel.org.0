Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E898336CD97
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239060AbhD0VCT (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:02:19 -0400
Received: from mail-co1nam11on2080.outbound.protection.outlook.com ([40.107.220.80]:15840
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239023AbhD0VCP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:02:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozt0lFx1wEr4Kh+ELXoaHwmSi1cwWrJrlCYNwBil7j24m+jfDqUnnfMWN7Sd82wLWVhZS/+AINBKWmuNjD/poe92iIpMh13JWO6y8NqIYLz2RCqorjUzEn3TZYMjY7qz7Qr3wQIny+XZ+Hzyo9yjhpnFBoJ6jlsGMGgbewgSBpc+epLWisWBtnP2IAfaHcpHlhYZb8Ood0RBym8lYbZk8egxeXeDLyNte/SueNKvYKDqLIblAoxLq43suuUQAR/S46JFkkZ+i/qr/3YBITE6ZeVq8P1+uNuzEhvLLTUEG+UeIYT3m6DcUnkTx3DzVNO/OL7+jbE8hoGJEYaxsa5/tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSOARqsstBFnyVcZXEjE3sGtzRq428dBMWblPDNR04Y=;
 b=O+IpJFfoG4wxwjR//cwBYRsNOdPs1Cc/w2UiUwT1gLNrGayxPlbK9eaX+CZdbp9oFXllIvrssg8XP8Lns71QczmJn6RQqGjr1hU0XBtKhiISUKX6qLFOj6VSlOPuYF9xa/ZZTV8tb00EV2IrtYcD8KYY1lzADY6ATspGu8xnfiJOeI/JSEc0CsZlEBb+LBQxqBNMNezkz/LsvzywbtZ6qeI+l/PyJdh7nyyNBoVMgBMrOG1RdTl0U7joDMYwTZINyn7YvILa6IYN5v50yej1XLHlP2tK4j1jM/DMOtPD/4Cw2lBB6mlojmC7pftek9Zejit2OI1SbBVsJUn6wky0EA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSOARqsstBFnyVcZXEjE3sGtzRq428dBMWblPDNR04Y=;
 b=KbXLnToDKGNraPBnZn4Ode03+8guhyRgZf6fMR7a1g00rESGfTh76kUx9SIP0/40+WBhiJuuQwDwy8qp84haHSqekk7xAlgakQkTH7a891VpwnhQ952pioeAslErnH+oLGbqynmqcDP2rS7bdhxjPssxChzHW+5Ip3XFz6tGUNU=
Received: from SA0PR11CA0198.namprd11.prod.outlook.com (2603:10b6:806:1bc::23)
 by SN4PR0201MB3616.namprd02.prod.outlook.com (2603:10b6:803:4e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Tue, 27 Apr
 2021 21:01:30 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::1c) by SA0PR11CA0198.outlook.office365.com
 (2603:10b6:806:1bc::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 21:01:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:01:30 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:01:15 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:01:15 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52030 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUpX-0000HC-4y; Tue, 27 Apr 2021 14:01:15 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 737A2600133; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 17/20] fpga: xrt: clock frequency counter driver
Date:   Tue, 27 Apr 2021 13:54:28 -0700
Message-ID: <20210427205431.23896-18-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b9d2ea1-7857-46a3-71ae-08d909bfa169
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3616:
X-Microsoft-Antispam-PRVS: <SN4PR0201MB36169960ECAEA4E9C16C1509A1419@SN4PR0201MB3616.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iw8usMMDujSPYvsZRw9RMS+BmnPYzxhDQqACv+1aCfFGYliKUhS5GBwEuwCBU9pMkxJOhxUr7d14tgo8xnnLa8PJRk/SYMEQDUwxj6KX2O8TH+zvqslVuGHPvXCJiBYXyeD0E18CFUQndcf5BvAJeTbqcsEMshR+fxxE+ZcWqrVA/S5LlREn6Lrd/087xAUzViaMCjAWK/Pf7A9xDYerEq9gsRCdQuxFtif3nFPpvTJKYU7iu7Z9TRwSxVA7GmetkNVRPeiapCCL3vgjLNq/t/c0isbDHI++6bYMUS10zNkwtkRKakZysKxGv4FuP+g2kk5z/yGdswB+EIcSR/qqMHVA16vmJ1B+uWOB+3y4NIJfGxb+qtMrGIyQmU4dpMzf6+SKf5Mk0hY3yofEp4BuGoHYFnP8Dszm6Zggne/ixLQ3jv7DmtlzARKKV7au/SgHOCwggD2fyWqzRxhH/i8Xdt7T+yK2jGJlV77CfPONkwS2Mh04OBunEnrvuhc+EWgPacLoX/6hy9IQ88w5xcqLHbYuDYAsorl0LPyTg3efd6n5/cywdSnRLxr+2qfI+5HotXf721XjDVuQvQFE7uxKr+HkDP/KtahudIHsZNyUhahxsdTTUSoBcqKDk8XA1fXkx0MHG4n4BaSNQdFoxn9u3jD9UupI/GFXdgojN2MZJXI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(136003)(376002)(39850400004)(36840700001)(46966006)(26005)(6266002)(186003)(316002)(54906003)(42186006)(336012)(5660300002)(1076003)(2616005)(2906002)(8676002)(356005)(7636003)(82310400003)(36756003)(82740400003)(83380400001)(44832011)(8936002)(426003)(107886003)(70206006)(4326008)(70586007)(6916009)(478600001)(6666004)(47076005)(36906005)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:01:30.0281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9d2ea1-7857-46a3-71ae-08d909bfa169
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3616
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add clock frequency counter driver. Clock frequency counter is
a hardware function discovered by walking xclbin metadata. A xrt
device node will be created for it. Other part of driver can read the
actual clock frequency through clock frequency counter driver.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/clkfreq.h |  21 +++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 223 +++++++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c

diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h b/drivers/fpga/xrt/include/xleaf/clkfreq.h
new file mode 100644
index 000000000000..005441d5df78
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_CLKFREQ_H_
+#define _XRT_CLKFREQ_H_
+
+#include "xleaf.h"
+
+/*
+ * CLKFREQ driver leaf calls.
+ */
+enum xrt_clkfreq_leaf_cmd {
+	XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_CLKFREQ_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/clkfreq.c b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
new file mode 100644
index 000000000000..3d1f11152375
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA Clock Frequency Counter Driver
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
+#include "xleaf/clkfreq.h"
+
+#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
+	xrt_err((clkfreq)->xdev, fmt "\n", ##arg)
+#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
+	xrt_warn((clkfreq)->xdev, fmt "\n", ##arg)
+#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
+	xrt_info((clkfreq)->xdev, fmt "\n", ##arg)
+#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
+	xrt_dbg((clkfreq)->xdev, fmt "\n", ##arg)
+
+#define XRT_CLKFREQ		"xrt_clkfreq"
+
+#define XRT_CLKFREQ_CONTROL_STATUS_MASK		0xffff
+
+#define XRT_CLKFREQ_CONTROL_START	0x1
+#define XRT_CLKFREQ_CONTROL_DONE	0x2
+#define XRT_CLKFREQ_V5_CLK0_ENABLED	0x10000
+
+#define XRT_CLKFREQ_CONTROL_REG		0
+#define XRT_CLKFREQ_COUNT_REG		0x8
+#define XRT_CLKFREQ_V5_COUNT_REG	0x10
+
+#define XRT_CLKFREQ_READ_RETRIES	10
+
+XRT_DEFINE_REGMAP_CONFIG(clkfreq_regmap_config);
+
+struct clkfreq {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	const char		*clkfreq_ep_name;
+	struct mutex		clkfreq_lock; /* clock counter dev lock */
+};
+
+static int clkfreq_read(struct clkfreq *clkfreq, u32 *freq)
+{
+	int times = XRT_CLKFREQ_READ_RETRIES;
+	u32 status;
+	int ret;
+
+	*freq = 0;
+	mutex_lock(&clkfreq->clkfreq_lock);
+	ret = regmap_write(clkfreq->regmap, XRT_CLKFREQ_CONTROL_REG, XRT_CLKFREQ_CONTROL_START);
+	if (ret) {
+		CLKFREQ_INFO(clkfreq, "write start to control reg failed %d", ret);
+		goto failed;
+	}
+	while (times != 0) {
+		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_CONTROL_REG, &status);
+		if (ret) {
+			CLKFREQ_INFO(clkfreq, "read control reg failed %d", ret);
+			goto failed;
+		}
+		if ((status & XRT_CLKFREQ_CONTROL_STATUS_MASK) == XRT_CLKFREQ_CONTROL_DONE)
+			break;
+		mdelay(1);
+		times--;
+	};
+
+	if (!times) {
+		ret = -ETIMEDOUT;
+		goto failed;
+	}
+
+	if (status & XRT_CLKFREQ_V5_CLK0_ENABLED)
+		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_V5_COUNT_REG, freq);
+	else
+		ret = regmap_read(clkfreq->regmap, XRT_CLKFREQ_COUNT_REG, freq);
+	if (ret) {
+		CLKFREQ_INFO(clkfreq, "read count failed %d", ret);
+		goto failed;
+	}
+
+	mutex_unlock(&clkfreq->clkfreq_lock);
+
+	return 0;
+
+failed:
+	mutex_unlock(&clkfreq->clkfreq_lock);
+
+	return ret;
+}
+
+static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct clkfreq *clkfreq = xrt_get_drvdata(to_xrt_dev(dev));
+	ssize_t count;
+	u32 freq;
+
+	if (clkfreq_read(clkfreq, &freq))
+		return -EINVAL;
+
+	count = snprintf(buf, 64, "%u\n", freq);
+
+	return count;
+}
+static DEVICE_ATTR_RO(freq);
+
+static struct attribute *clkfreq_attrs[] = {
+	&dev_attr_freq.attr,
+	NULL,
+};
+
+static struct attribute_group clkfreq_attr_group = {
+	.attrs = clkfreq_attrs,
+};
+
+static int
+xrt_clkfreq_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct clkfreq *clkfreq;
+	int ret = 0;
+
+	clkfreq = xrt_get_drvdata(xdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_CLKFREQ_READ:
+		ret = clkfreq_read(clkfreq, arg);
+		break;
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static void clkfreq_remove(struct xrt_device *xdev)
+{
+	sysfs_remove_group(&xdev->dev.kobj, &clkfreq_attr_group);
+}
+
+static int clkfreq_probe(struct xrt_device *xdev)
+{
+	struct clkfreq *clkfreq = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int ret;
+
+	clkfreq = devm_kzalloc(&xdev->dev, sizeof(*clkfreq), GFP_KERNEL);
+	if (!clkfreq)
+		return -ENOMEM;
+
+	xrt_set_drvdata(xdev, clkfreq);
+	clkfreq->xdev = xdev;
+	mutex_init(&clkfreq->clkfreq_lock);
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto failed;
+	}
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto failed;
+	}
+
+	clkfreq->regmap = devm_regmap_init_mmio(&xdev->dev, base, &clkfreq_regmap_config);
+	if (IS_ERR(clkfreq->regmap)) {
+		CLKFREQ_ERR(clkfreq, "regmap %pR failed", res);
+		ret = PTR_ERR(clkfreq->regmap);
+		goto failed;
+	}
+	clkfreq->clkfreq_ep_name = res->name;
+
+	ret = sysfs_create_group(&xdev->dev.kobj, &clkfreq_attr_group);
+	if (ret) {
+		CLKFREQ_ERR(clkfreq, "create clkfreq attrs failed: %d", ret);
+		goto failed;
+	}
+
+	CLKFREQ_INFO(clkfreq, "successfully initialized clkfreq subdev");
+
+	return 0;
+
+failed:
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_clkfreq_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .compat = XRT_MD_COMPAT_CLKFREQ },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_clkfreq_driver = {
+	.driver = {
+		.name = XRT_CLKFREQ,
+	},
+	.subdev_id = XRT_SUBDEV_CLKFREQ,
+	.endpoints = xrt_clkfreq_endpoints,
+	.probe = clkfreq_probe,
+	.remove = clkfreq_remove,
+	.leaf_call = xrt_clkfreq_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(clkfreq);
-- 
2.27.0

