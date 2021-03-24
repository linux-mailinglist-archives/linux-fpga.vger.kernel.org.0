Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B162234711F
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:37:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235425AbhCXFgf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:35 -0400
Received: from mail-bn7nam10on2067.outbound.protection.outlook.com ([40.107.92.67]:54048
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235384AbhCXFgP (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:36:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7leXaE6dDEvoz35dhYNf8gyhltBnB0U8/XeDcZYvsEVK5Top6u3AvhDFEyrk4NDCD+CyTCP7pdvEd0cmLJSsKyqMxg5lcuui8pHwmu/GBIPKLTBKEjX94M72KJwOgHGlpk3+oFtgNPdpl23otXcNvuxupyyziFFHvPnRdDMEGsWcreAj2SRcwStu0+dRNrDoOZsran11XnnTsHG6iwv+Nht1k3cYLM14n8PR68HqR5+ZSOF4dxbjcN48Za81DXJioYd2rsJnr/DM/GwZIu5JRacNlF1GQm+rmt+TOXoLj2Q4quqR3/fdkDZt5gPnkDyeEblzqLVFh88/VQKUQFNlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFs1DgjJ1rWAX5buzhQU/q+oc9wU60jE4oTon4ZSEZs=;
 b=C3eh83ZLeGRr75yjECPe2KS5SfRED/QLUSsVokVaK76kUiLWGqT1x/5qxJA+UFkL2GIkymU5LfKU9iCTPXKomogGyXaM95Oj7B7tjK3HXrIL2yC0P8kr/K1/Q1IW+KzigWclMVWhnKSxQxOTPfEnJdDo0RRQWUtrvuyO37OTpcTJnCVOuD3mOZj4uACxzRX9bO2TknVkOLJZZtcGKxVqhQigVn0Z3MZK358kniTTYdibKoBSmn32Msol0yg51jfZWfRvhKSj2PAm5mo+eC/1mP5kimn27HsdDdsFO1eibRVEmr8zOXcBzEa8qrsx9ZJH9O9EP8OL4EN0kkKWbHNhOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LFs1DgjJ1rWAX5buzhQU/q+oc9wU60jE4oTon4ZSEZs=;
 b=KvKa+YJ3GpLnP6A+kLnXegjieJNN3g4qFgZWqPtYc5gGrkl3Ql7if3kmdxRjpqoB6fYPziX+ofWdJppWLvGF0LAWkVq3IbJhpsRaJF43IN9UE+eW78PclVvdR0CwtiJMAap7bpHYaPBhQjuQV5NE009j85Cqgi638+AATT/YkTc=
Received: from SN4PR0401CA0031.namprd04.prod.outlook.com
 (2603:10b6:803:2a::17) by BL0PR02MB6546.namprd02.prod.outlook.com
 (2603:10b6:208:1cc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.23; Wed, 24 Mar
 2021 05:36:13 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:803:2a:cafe::4c) by SN4PR0401CA0031.outlook.office365.com
 (2603:10b6:803:2a::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:36:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:36:13 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:35:59 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:35:59 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51056 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwBS-0006Er-UF; Tue, 23 Mar 2021 22:35:58 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 2C67E600132; Tue, 23 Mar 2021 22:29:57 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 18/20] fpga: xrt: DDR calibration platform driver
Date:   Tue, 23 Mar 2021 22:29:45 -0700
Message-ID: <20210324052947.27889-19-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db1a0881-a47a-43d5-2754-08d8ee86bccb
X-MS-TrafficTypeDiagnostic: BL0PR02MB6546:
X-Microsoft-Antispam-PRVS: <BL0PR02MB6546E69BDC64C00C0A39850AA1639@BL0PR02MB6546.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:311;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0anDwwQCxrU9dJ9Qufv+ILADasuJnuw2UfxMgTeWe4VE3ixcMadNRjXyMGl0Mhj7rA3hMliPS3tBOp3Jfzhh2eP4gZFjnE0Ze7Nh/y6935l/NdF5BWKCHNn1ZXOL6jJtkNYW9VAF5EMZV2J9CO4hLZ3yasPMjbeGo9l4SdQz3vC9KtanCBWuYPrK/t9R8Pcnicp5nFbjawEQMuX6S/KDgY0AKT1gYwrPss/JObE7xG5OQxMQbsEIsypNdEmCz8NSQf2xFNhp6HdiZ2rMBhAcbGpIZmzv11ynZaU2T29CSjhhMFteVB+m4Xb3P/fgzc9ffxs2+Sr0My/kWUNTWGuHiYE0bzawImZ16AjIXsSwHrFDSV8bGLIULLq+HqNY9l67VAiXXC4ZsazRfTC+HFUGuqKsw45zJcx/Susy4i5wKcfYx3OIsOehUobc/GeyC5lP5dKtx0GuAu6duLFT0j35lmL7Yvh+8ew6dZLYiJZjkX5+dEFpUow8Bmpohs8VfJZRHUosd2fcKuYe7PHh+NFo+W9KP+Vh0DlNtSfDk7riqI+m9dq1+iUxnAfCuIOvo0yGKNNNnYG5LeHoWJBcAVgF3yl4cS3Lqukha6uv1YJcLOLn6ATb2RdFpuig++TJS1a22hzdjD1v07+/CPmPc9Bin//nLVeqkAoDUoweMzVQnM=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(346002)(376002)(39860400002)(136003)(46966006)(36840700001)(5660300002)(1076003)(426003)(82740400003)(7636003)(4326008)(336012)(36756003)(2616005)(6266002)(44832011)(107886003)(47076005)(83380400001)(6916009)(70206006)(54906003)(42186006)(36860700001)(478600001)(316002)(2906002)(26005)(82310400003)(356005)(36906005)(186003)(70586007)(8936002)(8676002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:36:13.2584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db1a0881-a47a-43d5-2754-08d8ee86bccb
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB6546
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add DDR calibration driver. DDR calibration is a hardware function
discovered by walking firmware metadata. A platform device node will
be created for it. Hardware provides DDR calibration status through
this function.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 .../fpga/xrt/include/xleaf/ddr_calibration.h  |  28 +++
 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c  | 226 ++++++++++++++++++
 2 files changed, 254 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/ddr_calibration.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ddr_calibration.c

diff --git a/drivers/fpga/xrt/include/xleaf/ddr_calibration.h b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
new file mode 100644
index 000000000000..878740c26ca2
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/ddr_calibration.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#ifndef _XRT_DDR_CALIBRATION_H_
+#define _XRT_DDR_CALIBRATION_H_
+
+#include "xleaf.h"
+#include <linux/xrt/xclbin.h>
+
+/*
+ * Memory calibration driver leaf calls.
+ */
+enum xrt_calib_results {
+	XRT_CALIB_UNKNOWN = 0,
+	XRT_CALIB_SUCCEEDED,
+	XRT_CALIB_FAILED,
+};
+
+enum xrt_calib_leaf_cmd {
+	XRT_CALIB_RESULT = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+#endif	/* _XRT_DDR_CALIBRATION_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
new file mode 100644
index 000000000000..5a9fa82946cb
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ddr_calibration.c
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
+#include <linux/regmap.h>
+#include "xclbin-helper.h"
+#include "metadata.h"
+#include "xleaf/ddr_calibration.h"
+
+#define XRT_CALIB	"xrt_calib"
+
+#define XRT_CALIB_STATUS_REG		0
+#define XRT_CALIB_READ_RETRIES		20
+#define XRT_CALIB_READ_INTERVAL		500 /* ms */
+
+static const struct regmap_config calib_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
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
+	struct regmap		*regmap;
+	struct mutex		lock; /* calibration dev lock */
+	struct list_head	cache_list;
+	u32			cache_num;
+	enum xrt_calib_results	result;
+};
+
+static void __calib_cache_clean_nolock(struct calib *calib)
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
+	__calib_cache_clean_nolock(calib);
+	mutex_unlock(&calib->lock);
+}
+
+static int calib_calibration(struct calib *calib)
+{
+	u32 times = XRT_CALIB_READ_RETRIES;
+	u32 status;
+	int ret;
+
+	while (times != 0) {
+		ret = regmap_read(calib->regmap, XRT_CALIB_STATUS_REG, &status);
+		if (ret) {
+			xrt_err(calib->pdev, "failed to read status reg %d", ret);
+			return ret;
+		}
+
+		if (status & BIT(0))
+			break;
+		msleep(XRT_CALIB_READ_INTERVAL);
+		times--;
+	}
+
+	if (!times) {
+		xrt_err(calib->pdev,
+			"MIG calibration timeout after bitstream download");
+		return -ETIMEDOUT;
+	}
+
+	xrt_info(calib->pdev, "took %dms", (XRT_CALIB_READ_RETRIES - times) *
+		 XRT_CALIB_READ_INTERVAL);
+	return 0;
+}
+
+static void xrt_calib_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct calib *calib = platform_get_drvdata(pdev);
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	enum xrt_subdev_id id;
+	int ret;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+
+	switch (e) {
+	case XRT_EVENT_POST_CREATION:
+		if (id == XRT_SUBDEV_UCS) {
+			ret = calib_calibration(calib);
+			if (ret)
+				calib->result = XRT_CALIB_FAILED;
+			else
+				calib->result = XRT_CALIB_SUCCEEDED;
+		}
+		break;
+	default:
+		xrt_dbg(pdev, "ignored event %d", e);
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
+	return 0;
+}
+
+static int xrt_calib_probe(struct platform_device *pdev)
+{
+	void __iomem *base = NULL;
+	struct resource *res;
+	struct calib *calib;
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
+	if (!res) {
+		err = -EINVAL;
+		goto failed;
+	}
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base)) {
+		err = PTR_ERR(base);
+		goto failed;
+	}
+
+	calib->regmap = devm_regmap_init_mmio(&pdev->dev, base, &calib_regmap_config);
+	if (IS_ERR(calib->regmap)) {
+		xrt_err(pdev, "Map iomem failed");
+		err = PTR_ERR(calib->regmap);
+		goto failed;
+	}
+
+	mutex_init(&calib->lock);
+	INIT_LIST_HEAD(&calib->cache_list);
+
+	return 0;
+
+failed:
+	return err;
+}
+
+static int
+xrt_calib_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
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
+		.xsd_leaf_call = xrt_calib_leaf_call,
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
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_CALIB, calib);
-- 
2.27.0

