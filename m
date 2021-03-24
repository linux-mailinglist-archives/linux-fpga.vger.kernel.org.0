Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A930347110
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:36:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235357AbhCXFgB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:01 -0400
Received: from mail-dm6nam10on2045.outbound.protection.outlook.com ([40.107.93.45]:28096
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235344AbhCXFfb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:35:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q6fshFMw19K5hRyETnN6E9vJUuXR1y5+0t0qbLgKTi1uyObONiUxw/SgZFYDeOC94eme824Uqub1qkJ23HC8uGvv00/ZjK8ffGod4h4+dDGwRIB203Szjl5gJwrePeoo4nCvJO2RANb1nbyIP0AvQuUzKZoor7XM+xyGLmyY5bZ7B13gtlmlzSmXvLuwqHTomRBMtErkVLaIO1iIRtyeUZf7f7IO6jnsVSBdQSfWIBCniqWI4iuInu1tfxdH9x41zmS3R/DP94spMbUATiRn637msjiwNDE1zjH2mqldOnyMU5iYXs86rRDjcyI8s7ZNdFamMysSFn72fEQDWsdcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa/ifs7RwLwrTS6piSpFxNNtn8YrHxiOq2jtm3/Ibbo=;
 b=i2ULAQzzTole0puzhpocUM0B1gUuCojth/3WSbz7o5BpJVtTCceUVgj4Xa/MW9b7+X00x/PqR3J6EL3cmsHhu9RiS0KkaekWjC0i4vq+PIkL8xR7fnYPtY4OVbN24CAcJC5dFKRl2XXy3ppEoSU/M2XMMsjJ4yR5bn+BqR2DP7ATP6dTjpJyzfjZafnsjhEJjdagyVQU0hdbg0DYeMHa7/iL4N6KXMVqd4GXfqWx8zlGZAbiT4KgCG/r6N+vU1cF/PHtbOXc8WN9qhj534bfwkNHbeycfq/8cuT69MRGFeqvpJe794PpDwDhlc3DlScPH+0+lXjaoO5XIaX6V5d1cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aa/ifs7RwLwrTS6piSpFxNNtn8YrHxiOq2jtm3/Ibbo=;
 b=qlE5WyTTBcKdMHo7F7bSoNwniGpFjdsgaDXufrggb0tmwgrBebIwfgeSJ0Jzw5CUXFYvuaPxzA6Uzr33jhk04wtouBWvJ5sZHKXJm0zJZjUMgwhLoqLL++a7Myc5YJY0OxoygU7pKZKxczTup6c29CGreHDi2CNT+T2LPUbMIkE=
Received: from DM5PR06CA0092.namprd06.prod.outlook.com (2603:10b6:3:4::30) by
 BN6PR02MB3283.namprd02.prod.outlook.com (2603:10b6:405:64::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3955.18; Wed, 24 Mar 2021 05:35:27 +0000
Received: from DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
 (2603:10b6:3:4:cafe::f7) by DM5PR06CA0092.outlook.office365.com
 (2603:10b6:3:4::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18 via Frontend
 Transport; Wed, 24 Mar 2021 05:35:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT024.mail.protection.outlook.com (10.13.5.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3955.24 via Frontend Transport; Wed, 24 Mar 2021 05:35:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:34:58 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:34:58 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51046 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwAU-0004aW-MU; Tue, 23 Mar 2021 22:34:58 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id A391C60012C; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem platform driver
Date:   Tue, 23 Mar 2021 22:29:40 -0700
Message-ID: <20210324052947.27889-14-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a9704ce8-da6c-4107-e8ed-08d8ee86a196
X-MS-TrafficTypeDiagnostic: BN6PR02MB3283:
X-Microsoft-Antispam-PRVS: <BN6PR02MB3283EDD34C7EDE60A4EF3BC1A1639@BN6PR02MB3283.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vuym4QwCsze0irgM5gNWYx8jROyZrJfU51qTSyoe4ifF/Xilo7VSfcKAInbkxK8R8+hR3pGykHTGulHT2ejE4NBANJoWyTV9B7KhSSoHDB46rmFHVwRUUZN0Qa2Hj+OB2CYVawQuJM0N+s4wBR4+ehQ4I1daxwTGZfaDjZhXCtz2TRXpYWTUgqPFM0YRmajAQF2wh1SW2FWrk82bK8neSYpUdKDiPD2bafDD7MTgxeP2AzcWXvjQp/2OanDKbRkUUya00JSWbAd9AHfrdK43EF1yfz+fRqK5AHs2KvfVBVzWe3DPsTqj+jhKX3sh3isE0mnlPfKXVFuOsDGS61ATPRqjIzPywPHoJhw5ja63/LKw018t84/BWuqQaVCes4mtRb8BJ/SWBKW9BhE85PoRp38OOi+lEn+4BphdAkgH8AWcsC5qyQfdnWTBdhNrGVNGP0wzNgOe/xOO74prvBJRo4RUBzXqaSqbIILrSbHmwENJhSwwxn6eCKw3noyG/qSS1J3itJm/Q2RsWPT9uRBZwDpYjsDwI8O3DidC7a7Y1MYRzGQQwL4YPL3Iyem3zb2hc7WHh/5CiustOGtJI0UV3BMW6MmrCBr+IrxblDMD+VKprV6DFrjRxZGIIx6ATeA80tb+KMqmeNZAZs0wBvN4H7+/LWPXypj4tHknMcpglOI=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(136003)(346002)(396003)(39850400004)(46966006)(36840700001)(6266002)(83380400001)(6666004)(54906003)(107886003)(42186006)(186003)(70206006)(336012)(36906005)(356005)(47076005)(26005)(7636003)(5660300002)(82310400003)(1076003)(70586007)(8936002)(316002)(36756003)(478600001)(4326008)(82740400003)(2906002)(2616005)(8676002)(6916009)(44832011)(426003)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:35:27.6065
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9704ce8-da6c-4107-e8ed-08d8ee86a196
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT024.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB3283
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add User Clock Subsystem (UCS) driver. UCS is a hardware function
discovered by walking xclbin metadata. A platform device node will be
created for it.  UCS enables/disables the dynamic region clocks.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/xleaf/ucs.c | 167 +++++++++++++++++++++++++++++++
 1 file changed, 167 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c

diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
new file mode 100644
index 000000000000..d91ee229e7cb
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
@@ -0,0 +1,167 @@
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
+#include <linux/regmap.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
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
+#define XRT_UCS_CHANNEL1_REG			0
+#define XRT_UCS_CHANNEL2_REG			8
+
+#define CLK_MAX_VALUE			6400
+
+static const struct regmap_config ucs_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+	.max_register = 0x1000,
+};
+
+struct xrt_ucs {
+	struct platform_device	*pdev;
+	struct regmap		*regmap;
+	struct mutex		ucs_lock; /* ucs dev lock */
+};
+
+static void xrt_ucs_event_cb(struct platform_device *pdev, void *arg)
+{
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct platform_device *leaf;
+	enum xrt_subdev_id id;
+	int instance;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+	instance = evt->xe_subdev.xevt_subdev_instance;
+
+	if (e != XRT_EVENT_POST_CREATION) {
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
+	xleaf_call(leaf, XRT_CLOCK_VERIFY, NULL);
+	xleaf_put_leaf(pdev, leaf);
+}
+
+static int ucs_enable(struct xrt_ucs *ucs)
+{
+	int ret;
+
+	mutex_lock(&ucs->ucs_lock);
+	ret = regmap_write(ucs->regmap, XRT_UCS_CHANNEL2_REG, 1);
+	mutex_unlock(&ucs->ucs_lock);
+
+	return ret;
+}
+
+static int
+xrt_ucs_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_ucs_event_cb(pdev, arg);
+		break;
+	default:
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ucs_probe(struct platform_device *pdev)
+{
+	struct xrt_ucs *ucs = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
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
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ucs->regmap = devm_regmap_init_mmio(&pdev->dev, base, &ucs_regmap_config);
+	if (IS_ERR(ucs->regmap)) {
+		UCS_ERR(ucs, "map base %pR failed", res);
+		return PTR_ERR(ucs->regmap);
+	}
+	ucs_enable(ucs);
+
+	return 0;
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
+		.xsd_leaf_call = xrt_ucs_leaf_call,
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
+	.id_table = xrt_ucs_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_UCS, ucs);
-- 
2.27.0

