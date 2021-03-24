Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4679834711C
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235288AbhCXFge (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:34 -0400
Received: from mail-dm6nam10on2077.outbound.protection.outlook.com ([40.107.93.77]:16796
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235372AbhCXFgF (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:36:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PVetYBunGGn0he6VJoKZko5q/nycEhX0+A4fRchzgXwaz30PYK+f8oPD4YJ0KVUI64xr16Rocd80XiIbGxvPbUBHudNnyHggD4N4HJB/u4b0fjTandW7TP7Ke83vBxER5ayrYwvGxDsPNr1t9/D0HQ5I03NKuNV5+Rh5PlklwaLnMW4wBj5GFbiPnAzj/i7uql11RVDgIQlGPok5zPS9vp5eFkOzIvWq0+Z+ZyFoN6k+prINkf3P2trfvgSSQ7fDVW9+FmaijElo++gb69lrYrJxiTc+BD7mA621O60tOm07cYCOxdetSacdYwknLE3LsmIrGR+VN3/6bcdBi/eYjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgiCpQQGQijbPNH+7QGlmrY5TEOSACG81/9zHOoH4ck=;
 b=OT1PEb+x8XLLY5RQRIExaCcmiOwaFGSAUK62ZM1k2PfbalyTFgtZi6UgvtddC4f3RarbBeQr8g5UEN/CSogY0txMe5ahHIUfivWk8iMc+p0A8zI/CWJwdnTB60VVMktYNk24Vd3FZiDM0IBRrhu0LYlFF099mXUEXMaso4llrdcc316w1IZENLflVT8aLNwmlW2Imw2TT73mwILa8s0Kivch8Lr0s+LHybtMcbR/SUORz9A0al9WK+WP8Ca7XBVt2yPsfC5KmXMC4W1h6SbUnmPFqi+a9PZNpF576m7aUpKyRNYQGKn0Y+rc8tY+eARANc1rv6pNDh8SmprwHxCYDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgiCpQQGQijbPNH+7QGlmrY5TEOSACG81/9zHOoH4ck=;
 b=AVBsk5YDj/75PxJNoHbvw/mToNkZyVAbHbD93rjT4NUI6SYCZwqUkqBQZuTw46/nDakn9q4I2s/0NdE11f5+DGgOou6E5F2pCdjYCfy+0WDUMkomD1HFZoKDXxThI3IyXfZYqnr2KTppOj9FE6V8va6TOSO5o8WfXfAFP5+QrJM=
Received: from SN6PR05CA0019.namprd05.prod.outlook.com (2603:10b6:805:de::32)
 by MW4PR02MB7378.namprd02.prod.outlook.com (2603:10b6:303:75::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:36:03 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:de:cafe::5) by SN6PR05CA0019.outlook.office365.com
 (2603:10b6:805:de::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.10 via Frontend
 Transport; Wed, 24 Mar 2021 05:36:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:36:02 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:35:46 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:35:46 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51054 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwBG-0006E8-Sk; Tue, 23 Mar 2021 22:35:46 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 0D2E9600130; Tue, 23 Mar 2021 22:29:57 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 17/20] fpga: xrt: clock frequency counter platform driver
Date:   Tue, 23 Mar 2021 22:29:44 -0700
Message-ID: <20210324052947.27889-18-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e97b36d2-102e-4410-f311-08d8ee86b667
X-MS-TrafficTypeDiagnostic: MW4PR02MB7378:
X-Microsoft-Antispam-PRVS: <MW4PR02MB7378BF1B5B2491F6C92288E1A1639@MW4PR02MB7378.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xfCzoW7fmP+kPLyj0icSQFidUJ8n8ddgI9Wynx9ahNjdNqxWmqj484pk9++CXMlSgpfYdCsH+igyGYMQmzDW6PWJYksl6ZrVQvGplyNub4YEmpAohdzAYydsc7b1gMkIaV4MEktgdBgeYEqr2ME912PulU9/YX8HTit7D4gTWjU0h9nXBllGyYmO5sHIDtF7JiR0TZSSAYZ2bnFyTsI8bdyT69fvEYlIXniF7ulPXt3ukScz3/vX3mDshWoKzVCYmvPqt8iRmkaMQc5Zlp6xZE8+zrL0qb+TcZQXyMDtWOCuendci25aZBv3AHIbn6Hn9Hkof4E9CN5GFdrdMzR48DqzeYqgw5UiL/JAoRQAoy0YwxVxZ/19qGdK4cgROyR1LLdD8VGa0RRtogOvEtoxz2b3UFRQdbDoZMOLUij6Xqzf4vjiMH0vWAW+7C5NfiL2RI478zyR7tTW07DL/EebVvOHCfxFMTG366lc4qmnrSHtrYCP7oyUn9rJDmqUW1gUOSYoopRd9slnyEr90i1kFnXUGwYQs1iHZNjhpyi7DnIpT7FkTqmfJpgF4He2OzF8lA0s9E4kGg+MWRV/KV+8eUQRgSUqkJoqu96gByXNIOJ1Lvo1w9AzlQdmdEnKvNm7/J1QoUOidJKlT64PUxqA4v8ZUFACDKG7vYLDhYNl/zM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(36906005)(316002)(5660300002)(54906003)(36860700001)(4326008)(82740400003)(2906002)(42186006)(6266002)(1076003)(107886003)(478600001)(6666004)(7636003)(36756003)(336012)(356005)(70206006)(82310400003)(6916009)(44832011)(426003)(8936002)(8676002)(26005)(83380400001)(70586007)(186003)(2616005)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:36:02.5399
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e97b36d2-102e-4410-f311-08d8ee86b667
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR02MB7378
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add clock frequency counter driver. Clock frequency counter is
a hardware function discovered by walking xclbin metadata. A platform
device node will be created for it. Other part of driver can read the
actual clock frequency through clock frequency counter driver.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/clkfreq.h |  21 ++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 240 +++++++++++++++++++++++
 2 files changed, 261 insertions(+)
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
index 000000000000..49473adde3fd
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
@@ -0,0 +1,240 @@
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
+#include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/clkfreq.h"
+
+#define CLKFREQ_ERR(clkfreq, fmt, arg...)   \
+	xrt_err((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_WARN(clkfreq, fmt, arg...)  \
+	xrt_warn((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_INFO(clkfreq, fmt, arg...)  \
+	xrt_info((clkfreq)->pdev, fmt "\n", ##arg)
+#define CLKFREQ_DBG(clkfreq, fmt, arg...)   \
+	xrt_dbg((clkfreq)->pdev, fmt "\n", ##arg)
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
+static const struct regmap_config clkfreq_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+struct clkfreq {
+	struct platform_device	*pdev;
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
+	struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
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
+xrt_clkfreq_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clkfreq *clkfreq;
+	int ret = 0;
+
+	clkfreq = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_CLKFREQ_READ:
+		ret = clkfreq_read(clkfreq, arg);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int clkfreq_remove(struct platform_device *pdev)
+{
+	sysfs_remove_group(&pdev->dev.kobj, &clkfreq_attr_group);
+
+	return 0;
+}
+
+static int clkfreq_probe(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int ret;
+
+	clkfreq = devm_kzalloc(&pdev->dev, sizeof(*clkfreq), GFP_KERNEL);
+	if (!clkfreq)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, clkfreq);
+	clkfreq->pdev = pdev;
+	mutex_init(&clkfreq->clkfreq_lock);
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res) {
+		ret = -EINVAL;
+		goto failed;
+	}
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		ret = PTR_ERR(base);
+		goto failed;
+	}
+
+	clkfreq->regmap = devm_regmap_init_mmio(&pdev->dev, base, &clkfreq_regmap_config);
+	if (IS_ERR(clkfreq->regmap)) {
+		CLKFREQ_ERR(clkfreq, "regmap %pR failed", res);
+		ret = PTR_ERR(clkfreq->regmap);
+		goto failed;
+	}
+	clkfreq->clkfreq_ep_name = res->name;
+
+	ret = sysfs_create_group(&pdev->dev.kobj, &clkfreq_attr_group);
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
+static struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = XRT_MD_REGMAP_CLKFREQ },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_clkfreq_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xrt_clkfreq_leaf_call,
+	},
+};
+
+static const struct platform_device_id xrt_clkfreq_table[] = {
+	{ XRT_CLKFREQ, (kernel_ulong_t)&xrt_clkfreq_data },
+	{ },
+};
+
+static struct platform_driver xrt_clkfreq_driver = {
+	.driver = {
+		.name = XRT_CLKFREQ,
+	},
+	.probe = clkfreq_probe,
+	.remove = clkfreq_remove,
+	.id_table = xrt_clkfreq_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_CLKFREQ, clkfreq);
-- 
2.27.0

