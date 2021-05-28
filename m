Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E095393AB0
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235955AbhE1AzQ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:55:16 -0400
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:63502
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235715AbhE1AzN (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:55:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zrowo1v2nBbdbyxQYBr4pRywDgXM8eygTiZ0NIWvOaN8JkmgVhCvqdAjcH9isr9NgxoPrWb8FkGVHIWqZFDrN8yFWk1pLOq8RPZvQiyq+ZKkulQyRJ13zrxkDPaBzJl+2G+vtEDa83a0XFXF4Sh45gv2uHdMYiPrmK8eVRkkH6pRGFdXLTgMk9NRS97NimKY5KxpTvCFhGtypAw0Vv3ZfQqexCcC5rb2vwDi3pKOfnoh0IpMhe9k4wgYhC5MIr9Nd3ruI7y3ohyEdnettOkIcWdOv4XG6OphEGBlT7XOUyZsSF78Vu4FjZ8CDw8jsp9htUA/gpHse/mnQwqCK9B+Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JoWcB9ecJXtm6aRhS9uteevhdJzM0K+CTcccaF41ak=;
 b=acWULoOoqtOPKsCLYJgMVhROYNaXTdR/zQOHL1q5VkuqZaymuPnETD506g+1PykjLH4mpeEe/lYliyf2hMyRzuGAhiDO50ZZ/TcAyebbDQcZvMdBb3VSrqS7R2w8/kIZ39ySVF1DmEtGy04sCf2NaUMQqsYLp2mswt9jQZvWCzwIPwe8lbMeTx+vlI/x2wMUaxz8XHEasAJoEN8VQ3irMQKNM7L5Ckz2QltBZiMIElQRohTIrcWhK0kiMGyag5IuUjCk1IZPoBUKGuM05TblIcukyISYzdsmUxYaCwzPhBjF0KsSoN4gEi7zhd21/YK6L9tYyI98Abav2QXyfoCc3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4JoWcB9ecJXtm6aRhS9uteevhdJzM0K+CTcccaF41ak=;
 b=FhAdBtqdVjg2mYXeW0lr+n9eKBrTg3gvdRuk22PVKScSyEo1Hvwzu1ydNdVhIw+3FyCwCZnBgTZc4jdxUQtF69mktZXUiG4k4oONEbV7weXfu4a03TnAeZee6aMeAjK32T76iQ+3HmbMotLBdclxg5Lv228hI+1SFQP/KEDOFVk=
Received: from BN1PR12CA0026.namprd12.prod.outlook.com (2603:10b6:408:e1::31)
 by MN2PR02MB6912.namprd02.prod.outlook.com (2603:10b6:208:1f4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 00:53:37 +0000
Received: from BN1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e1:cafe::6f) by BN1PR12CA0026.outlook.office365.com
 (2603:10b6:408:e1::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.21 via Frontend
 Transport; Fri, 28 May 2021 00:53:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT006.mail.protection.outlook.com (10.13.2.125) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:53:37 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:53:32 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:53:32 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34040 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQkm-0007LG-8r; Thu, 27 May 2021 17:53:32 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 472676032B3; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 17/20] fpga: xrt: clock frequency counter driver
Date:   Thu, 27 May 2021 17:49:56 -0700
Message-ID: <20210528004959.61354-18-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07bedd56-4d6f-41b9-9fb9-08d921730731
X-MS-TrafficTypeDiagnostic: MN2PR02MB6912:
X-Microsoft-Antispam-PRVS: <MN2PR02MB6912C9B22ED017A546404BDDA1229@MN2PR02MB6912.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Dq+ZvEzRprNokx6ekLWkCmpQ9Jg9H3pinyNJPDXm8Cy0x4lrjEHdZf8yzqBeohDALZX8CEz1nDszqbZyGHmTV1zlYd3+Y8wUbHYmuSnpe1Ct9ZCIp+0KdaRmy1InYHi+sxicRN2uUwElatNkwCgCu+mHT9qJtCHCzBzqthDstURSMMv9bEqRlYzIk3YqVfts/55PW5OFWP0Juf0CtEgAfB9Klg7BnD5qZbODkhjr/Ro1nAMDHiFnz08Wyi4Y+zWdwHTpC+ODt694vFCKeWaQG1fW7aKjeMqp5FOOesBFbYu/Jkx+WYQ562tZW9oz3SYmeUpWECwYAPGRijlHFk8zblrpOl+slt7yFvJ5oPQb01LV1Eh1MCLJ8UBQdkFT0XfFMxydegb8GIBOCWsaqleWy1CdJCoSdh+YQXZxUZ+n1Jdo9+pPXxnPXeQuvEiYwliUMHxyOZSTQvelvJemUwxDiyhnZkCkn7dM0gFl26lQgSa2N+lxvncytxh7KklU3Vvr977A/ekWLUf9uQolfE1MYBWq6XW7imCk2sCcApwYt7cyxRwXZzjpsuyfgV7C3qfHELE8CJyqIi35XSN0B9xqMUWIEooc/usqMCmxBht/B1YyLX+2cTS8nV0lPNruTaRI7rYdDyOovLJ+8kiDsCG/oLpwkoZS/2A6aaehrykV4HI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(39850400004)(376002)(396003)(136003)(46966006)(36840700001)(4326008)(6666004)(6266002)(47076005)(26005)(36860700001)(36756003)(1076003)(107886003)(6916009)(186003)(82740400003)(82310400003)(7636003)(2906002)(8936002)(5660300002)(316002)(356005)(478600001)(42186006)(70206006)(2616005)(54906003)(8676002)(336012)(83380400001)(70586007)(426003)(44832011);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:53:37.3874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bedd56-4d6f-41b9-9fb9-08d921730731
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT006.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB6912
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
Reviewed-by: Tom Rix <trix@redhat.com>
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

