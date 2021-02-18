Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9B531E6B7
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230492AbhBRHJt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 02:09:49 -0500
Received: from mail-eopbgr750080.outbound.protection.outlook.com ([40.107.75.80]:4595
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231168AbhBRHGc (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 02:06:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XU83QVmHw/+b5aZ5zbpws8Bhicna70TcbLCqCSkrQoKIthAnvckM0vbd15nW8hA+ZWHtpi9skbvZvQz0uQC7toWPVUbSqTtswf9TJSzS8hirLJoFuXRbHSe2Yce4/Tfw6xwZtT9rpZwwp5hh/pd2pjC6kVJ46hKL2nv5deltJ+u6KpvxeXQ9ErHsCpDiVm9OntE8hev03RbT+J9xezlOOXIFynaCaBFr9fZWLADJt8fz/A4Nw/cs0xLPZXwt6xMCjopiftzbsYDcUrSgpgiE9S/J/EfXtkmafhrPGek7R8fEeFp5EDnLEi61WGay0bhlNIWS9VHwVMKi9W5szexxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZbFw/MxoWUpkZPb7ssXG+bPJeJnI1EaYLGzo96kVag=;
 b=h7Dv0P40q1KIa32Pv62P+35unhYgwDBc+3Mu/XOnEPFTUbx1dKjS0JNlFwqkIhDtrcVs0hYL95inQ29gJGZuB/JIvNbyd9XwTxkWprAiDlqCAR0x8ObQDuRVy0Pp4GjVJHt8brLlax7Ho9w8yNU+bLtyyD/QARxf0gT8b7LfOq1PwB8fRrYmkSzeALCLdKORrKxA15UnER3B1lQSCYoYINSv4gmFODJUJZKGj+XhPBr4tA4Vr7WgZTiyqV1jwWgwPsM6t7bsAkkzs3d+ZZJSEsYdkdJW64UUpQyCz+K2KaoRiLM7bNUkSQ61udAcFsPzN7bLq86Feje8v89RgYbjmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ZbFw/MxoWUpkZPb7ssXG+bPJeJnI1EaYLGzo96kVag=;
 b=KhzzO5RaHET/boTRMY9RvrN9lU7BvxCFsAaYbLZMSWlfYaTlvhjcsDhTs2HjYZL+Q3y2xaV+haLEM10iY6AHVMl0hxpR5l50hOt04SV3SAk6yE8DyUc5ixRgNGlx1ztQl++mMugfRGkY4Y7mkxTKK5zgWT+XmBHvAkFLs9FGDeM=
Received: from MN2PR04CA0015.namprd04.prod.outlook.com (2603:10b6:208:d4::28)
 by BYAPR02MB4005.namprd02.prod.outlook.com (2603:10b6:a02:f8::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27; Thu, 18 Feb
 2021 06:45:53 +0000
Received: from BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:d4:cafe::bb) by MN2PR04CA0015.outlook.office365.com
 (2603:10b6:208:d4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:45:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT036.mail.protection.outlook.com (10.152.77.154) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:45:52 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:45:52 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:45:52 -0800
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
Received: from [172.19.72.212] (port=40190 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd4S-0000mR-48; Wed, 17 Feb 2021 22:45:52 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 96C4760012E; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 15/18] fpga: xrt: clock frequence counter platform driver
Date:   Wed, 17 Feb 2021 22:40:16 -0800
Message-ID: <20210218064019.29189-16-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2b0e9a2b-9231-4ccc-6c47-08d8d3d8d615
X-MS-TrafficTypeDiagnostic: BYAPR02MB4005:
X-Microsoft-Antispam-PRVS: <BYAPR02MB40052CCF6AFF13510D969433A1859@BYAPR02MB4005.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XY3aK/joJC42LeIRq8HI2gxzPxQyGyzQlEFP/XDdjxejd1gJBP+51NJVKZ/a4XcZ1puYUQ2eqRkeNTPBSkOzl+GiSamWMHoPbgEUPF3xJcFg3mYuh/KQbXqu75QLdz7g/BFZj3BKvKHiML+U0F1RLvQvWlVrx6L7GeafToK7VjsXDc0VDfXSqfSXKo5V6nWye3CqB80g2j3CUonHu2/lGRIYy20l0Vef/CgkqsKRhwoGSA2PLIkRHi4m2Cq8UKWTgIrzKlxl1kJASqj5jj2wjXEr3ZDtUOxb/cedX1WsWl+6YoriaTe4ljuW8nqk6hu78WGjk/R6Lyn1P2Bv06lUzagjYiRY9q2TxU/lrtYfUxo2Jt98cot4SWJP7TLFkFQlS9QdKj72qcmIy5XQivZtxYbk6Aon9nvhSkY4fnZVD+v3yPeXQAQHVdThfb7ozxGBWcNfF1EwpTvky6YgIPVzZ7NQ5Z/HpkBMMtjxeB6UeI5+WZC4aYn+zXLkx64iNNhGIEjP0xbOF+tU/rqozM0sutvdhV+ttfPhSREm3S//7U0ZeDfIYNazFrdcwcn/kwLbJBOw4WBbmzSSQsRuu0jKF6ALiWBqWURzxK+c0HcNjVrm9+wFNUa2V0ME3frextjFhWl3gIF26u1BDUJSivLmkn9aIHiU0C03tFiJ8m0jGY4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966006)(36840700001)(26005)(47076005)(186003)(2906002)(82310400003)(7636003)(70206006)(70586007)(6916009)(36756003)(83380400001)(36860700001)(107886003)(8676002)(4326008)(8936002)(6266002)(82740400003)(478600001)(356005)(36906005)(2616005)(6666004)(336012)(426003)(1076003)(54906003)(42186006)(316002)(5660300002)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:45:52.9620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0e9a2b-9231-4ccc-6c47-08d8d3d8d615
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT036.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4005
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add clock frequence counter driver. Clock frequence counter is
a hardware function discovered by walking xclbin metadata. A platform
device node will be created for it. Other part of driver can read the
actual clock frequence through clock frequence counter driver.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/clkfreq.h |  23 +++
 drivers/fpga/xrt/lib/xleaf/clkfreq.c     | 221 +++++++++++++++++++++++
 2 files changed, 244 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/clkfreq.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/clkfreq.c

diff --git a/drivers/fpga/xrt/include/xleaf/clkfreq.h b/drivers/fpga/xrt/include/xleaf/clkfreq.h
new file mode 100644
index 000000000000..29fc45e8a31b
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/clkfreq.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT Clock Counter Leaf Driver
+ *
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
+ * CLKFREQ driver IOCTL calls.
+ */
+enum xrt_clkfreq_ioctl_cmd {
+	XRT_CLKFREQ_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_CLKFREQ_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/clkfreq.c b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
new file mode 100644
index 000000000000..2482dd2cff47
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/clkfreq.c
@@ -0,0 +1,221 @@
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
+#define OCL_CLKWIZ_STATUS_MASK		0xffff
+
+#define OCL_CLKWIZ_STATUS_MEASURE_START	0x1
+#define OCL_CLKWIZ_STATUS_MEASURE_DONE	0x2
+#define OCL_CLK_FREQ_COUNTER_OFFSET	0x8
+#define OCL_CLK_FREQ_V5_COUNTER_OFFSET	0x10
+#define OCL_CLK_FREQ_V5_CLK0_ENABLED	0x10000
+
+struct clkfreq {
+	struct platform_device	*pdev;
+	void __iomem		*clkfreq_base;
+	const char		*clkfreq_ep_name;
+	struct mutex		clkfreq_lock; /* clock counter dev lock */
+};
+
+static inline u32 reg_rd(struct clkfreq *clkfreq, u32 offset)
+{
+	return ioread32(clkfreq->clkfreq_base + offset);
+}
+
+static inline void reg_wr(struct clkfreq *clkfreq, u32 val, u32 offset)
+{
+	iowrite32(val, clkfreq->clkfreq_base + offset);
+}
+
+static u32 clkfreq_read(struct clkfreq *clkfreq)
+{
+	u32 freq = 0, status;
+	int times = 10;
+
+	mutex_lock(&clkfreq->clkfreq_lock);
+	reg_wr(clkfreq, OCL_CLKWIZ_STATUS_MEASURE_START, 0);
+	while (times != 0) {
+		status = reg_rd(clkfreq, 0);
+		if ((status & OCL_CLKWIZ_STATUS_MASK) ==
+		    OCL_CLKWIZ_STATUS_MEASURE_DONE)
+			break;
+		mdelay(1);
+		times--;
+	};
+	if (times > 0) {
+		freq = (status & OCL_CLK_FREQ_V5_CLK0_ENABLED) ?
+			reg_rd(clkfreq, OCL_CLK_FREQ_V5_COUNTER_OFFSET) :
+			reg_rd(clkfreq, OCL_CLK_FREQ_COUNTER_OFFSET);
+	}
+	mutex_unlock(&clkfreq->clkfreq_lock);
+
+	return freq;
+}
+
+static ssize_t freq_show(struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct clkfreq *clkfreq = platform_get_drvdata(to_platform_device(dev));
+	u32 freq;
+	ssize_t count;
+
+	freq = clkfreq_read(clkfreq);
+	count = snprintf(buf, 64, "%d\n", freq);
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
+xrt_clkfreq_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct clkfreq		*clkfreq;
+	int			ret = 0;
+
+	clkfreq = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_CLKFREQ_READ: {
+		*(u32 *)arg = clkfreq_read(clkfreq);
+		break;
+	}
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
+	struct clkfreq *clkfreq;
+
+	clkfreq = platform_get_drvdata(pdev);
+	if (!clkfreq) {
+		xrt_err(pdev, "driver data is NULL");
+		return -EINVAL;
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, clkfreq);
+
+	CLKFREQ_INFO(clkfreq, "successfully removed clkfreq subdev");
+	return 0;
+}
+
+static int clkfreq_probe(struct platform_device *pdev)
+{
+	struct clkfreq *clkfreq = NULL;
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
+	clkfreq->clkfreq_base = ioremap(res->start, res->end - res->start + 1);
+	if (!clkfreq->clkfreq_base) {
+		CLKFREQ_ERR(clkfreq, "map base %pR failed", res);
+		ret = -EFAULT;
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
+	clkfreq_remove(pdev);
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_clkfreq_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .regmap_name = "freq_cnt" },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_clkfreq_data = {
+	.xsd_dev_ops = {
+		.xsd_ioctl = xrt_clkfreq_leaf_ioctl,
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
+void clkfreq_leaf_init_fini(bool init)
+{
+	if (init) {
+		xleaf_register_driver(XRT_SUBDEV_CLKFREQ,
+				      &xrt_clkfreq_driver, xrt_clkfreq_endpoints);
+	} else {
+		xleaf_unregister_driver(XRT_SUBDEV_CLKFREQ);
+	}
+}
-- 
2.18.4

