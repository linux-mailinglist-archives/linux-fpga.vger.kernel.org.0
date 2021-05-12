Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1AD37B3E5
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 04:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhELCBH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:01:07 -0400
Received: from mail-mw2nam08on2057.outbound.protection.outlook.com ([40.107.101.57]:12144
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229945AbhELCBG (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:01:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ae3EPqnox4MzlfDA1nfSgUsOLbKzoO6S4fmz21EFlXmcvM1ZOSy+tc8l4LRiaeXyIEXd2qtsSIk/Yu0cM8bzo9Ge2S0Mw26GMUti5auo5haWnXpLanj3c7B5CviYSes2t3q4MHOYoUCBv0XLRTZqWVhglF5ruixpdtgDT2j3sQM9ExPQhiRW+TaGM1WoF0+Zj0kt6ZMWjGteNFvqYMqFyKt3iZKK6brZeCc00aUTgU41QQgGSFXjgQt60GU+/qS3SFjZhMeu6ptwEgBPf59pNfrY0kYLkfMsX13V6ILKgtaIou9HnYN7ZmSmm8rqAJyouDoG60jKE/SY8CdrIGo0Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IHbA1KOlRqIRGKR42QJm/+BxfptGvC2i/9JPgkwKnU=;
 b=UQeWrhWuaQwXbaP0UKqnLtWE8vvf5A6HFhQmvu3AsrJ+qe/vLPa0unys/OYxBsSBT23z+tOWS5s7gwsqj4SDkWRiM9j0WWPznT7tSdfQmuBkRKQVXwL1Yb0RPfNC84S6PxRYb4qRAlt/11zvkSRdjxVPDWKOzedJ9HLCh5+xHjcvBF3R98Nw2ZHgsJyp5gAuXrBNJhWjRWPVqduiOPUp4KaTvJs2VzU4frZ4c7sbwlxewY6G/1PY7q5WogsVNauasqJXOkrBIrgCqO2o96PWRywnFtbUcCU/NtvzvUPecBz7oz+eeOyC9LgDQqnmx13LVFCI61uxJtJyCZm/LMX5pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IHbA1KOlRqIRGKR42QJm/+BxfptGvC2i/9JPgkwKnU=;
 b=qjjiNVJGmSCQbV9Eq9eXs+EYXK4+EVjwedzzZL6vVzsvz/M7t+hhkhAzyo8I9FHnwSU5jJs8MTQh/yhP4VoMaoEny/YyZrg7kszAi0Yg8yNg972e05GpG961i7gKM1R2qhYc9OTkVYZQY6E04/Bljk/V/io2tbHNNV7hu/SnyyM=
Received: from BN0PR03CA0025.namprd03.prod.outlook.com (2603:10b6:408:e6::30)
 by SJ0PR02MB7741.namprd02.prod.outlook.com (2603:10b6:a03:32c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.27; Wed, 12 May
 2021 01:59:57 +0000
Received: from BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::ed) by BN0PR03CA0025.outlook.office365.com
 (2603:10b6:408:e6::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4108.25 via Frontend
 Transport; Wed, 12 May 2021 01:59:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT027.mail.protection.outlook.com (10.13.2.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 01:59:57 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 18:59:55 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 18:59:55 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35738 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lgeAF-0005ck-GO; Tue, 11 May 2021 18:59:55 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id B065C600132; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem driver
Date:   Tue, 11 May 2021 18:53:32 -0700
Message-ID: <20210512015339.5649-14-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527fea28-302d-44ad-d74c-08d914e9a4a8
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7741:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7741000DBB006BA0170EEDDEA1529@SJ0PR02MB7741.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pKHvTf8Twrf+X0MP2HmERGHt9AUDEFPH6inmWLmjs4VfvDZxEHCSFVWXKYG9drDPvoXDuTIylKXU3FMAt+nWBsjFAmVd1ZOUF6rAo18LDmd+AjFd/K/b1c8cONjqNsc7aKLa/q/5/+nwqcImhqYa8TYiBKeIZNnxjXXekYw0FeiD7FrMuHlJ+Dn1VbAIpZBelzCVPV4y7flz20nqRUTL6K9lXx1tXKX9na2+3WUEY6MuFjSYJISVXleSxkeXHviyKNL9mkdylG0qFcj+aEUFG4/DWD5H/yF+J+ssuozfkCkEcNFuOTZrz6OWVL67JaR0UFrTFdOjJZ27rImHrL0SHeufWNZvgzPlSARibj3BStPV8cRIGhmZcl23LFIlAyUVvmJhV4sbJg0JgjLS5AG/+kop5nAu2j2I49VOG10M52WXdafY+TS9MUIZuyLl0NG9jSGj1ZcDvw/LHtt2Hz5/abDEktgQBf4H74QIuDmSQUWr+PuNgGaZ3yH4s/4cUv/fK02PvPggqktX6wGm9sCozLn8MJ+UQN54ly8fsDIogV8IXupMyTDaY2Fzo9yNtITPahpx4foxGvcvulIzagG39i7GLz09pIsCpgTgRicHtqTctx3TKfmLPdAZZxnn0Xv5obsE6YuDZK6WVu8rdUy1taYEo21Abz1oab3qH/1Fj4k=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39850400004)(136003)(46966006)(36840700001)(36906005)(70586007)(42186006)(316002)(478600001)(8676002)(26005)(7636003)(356005)(5660300002)(186003)(36756003)(82740400003)(70206006)(2616005)(83380400001)(54906003)(36860700001)(4326008)(426003)(82310400003)(336012)(47076005)(1076003)(6916009)(6266002)(44832011)(8936002)(107886003)(2906002)(6666004);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 01:59:57.0560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527fea28-302d-44ad-d74c-08d914e9a4a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT027.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7741
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add User Clock Subsystem (UCS) driver. UCS is a hardware function
discovered by walking xclbin metadata. A xrt device node will be
created for it.  UCS enables/disables the dynamic region clocks.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/lib/xleaf/ucs.c | 152 +++++++++++++++++++++++++++++++
 1 file changed, 152 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/xleaf/ucs.c

diff --git a/drivers/fpga/xrt/lib/xleaf/ucs.c b/drivers/fpga/xrt/lib/xleaf/ucs.c
new file mode 100644
index 000000000000..a7a96ddde44f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/ucs.c
@@ -0,0 +1,152 @@
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
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/regmap.h>
+#include <linux/io.h>
+#include "metadata.h"
+#include "xleaf.h"
+#include "xleaf/clock.h"
+
+#define UCS_ERR(ucs, fmt, arg...)   \
+	xrt_err((ucs)->xdev, fmt "\n", ##arg)
+#define UCS_WARN(ucs, fmt, arg...)  \
+	xrt_warn((ucs)->xdev, fmt "\n", ##arg)
+#define UCS_INFO(ucs, fmt, arg...)  \
+	xrt_info((ucs)->xdev, fmt "\n", ##arg)
+#define UCS_DBG(ucs, fmt, arg...)   \
+	xrt_dbg((ucs)->xdev, fmt "\n", ##arg)
+
+#define XRT_UCS		"xrt_ucs"
+
+#define XRT_UCS_CHANNEL1_REG			0
+#define XRT_UCS_CHANNEL2_REG			8
+
+#define CLK_MAX_VALUE			6400
+
+XRT_DEFINE_REGMAP_CONFIG(ucs_regmap_config);
+
+struct xrt_ucs {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap;
+	struct mutex		ucs_lock; /* ucs dev lock */
+};
+
+static void xrt_ucs_event_cb(struct xrt_device *xdev, void *arg)
+{
+	struct xrt_event *evt = (struct xrt_event *)arg;
+	enum xrt_events e = evt->xe_evt;
+	struct xrt_device *leaf;
+	enum xrt_subdev_id id;
+	int instance;
+
+	id = evt->xe_subdev.xevt_subdev_id;
+	instance = evt->xe_subdev.xevt_subdev_instance;
+
+	if (e != XRT_EVENT_POST_CREATION) {
+		xrt_dbg(xdev, "ignored event %d", e);
+		return;
+	}
+
+	if (id != XRT_SUBDEV_CLOCK)
+		return;
+
+	leaf = xleaf_get_leaf_by_id(xdev, XRT_SUBDEV_CLOCK, instance);
+	if (!leaf) {
+		xrt_err(xdev, "does not get clock subdev");
+		return;
+	}
+
+	xleaf_call(leaf, XRT_CLOCK_VERIFY, NULL);
+	xleaf_put_leaf(xdev, leaf);
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
+xrt_ucs_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		xrt_ucs_event_cb(xdev, arg);
+		break;
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int ucs_probe(struct xrt_device *xdev)
+{
+	struct xrt_ucs *ucs = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+
+	ucs = devm_kzalloc(&xdev->dev, sizeof(*ucs), GFP_KERNEL);
+	if (!ucs)
+		return -ENOMEM;
+
+	xrt_set_drvdata(xdev, ucs);
+	ucs->xdev = xdev;
+	mutex_init(&ucs->ucs_lock);
+
+	res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -EINVAL;
+
+	base = devm_ioremap_resource(&xdev->dev, res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ucs->regmap = devm_regmap_init_mmio(&xdev->dev, base, &ucs_regmap_config);
+	if (IS_ERR(ucs->regmap)) {
+		UCS_ERR(ucs, "map base %pR failed", res);
+		return PTR_ERR(ucs->regmap);
+	}
+	ucs_enable(ucs);
+
+	return 0;
+}
+
+static struct xrt_dev_endpoints xrt_ucs_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_UCS_CONTROL_STATUS },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{ 0 },
+};
+
+static struct xrt_driver xrt_ucs_driver = {
+	.driver = {
+		.name = XRT_UCS,
+	},
+	.subdev_id = XRT_SUBDEV_UCS,
+	.endpoints = xrt_ucs_endpoints,
+	.probe = ucs_probe,
+	.leaf_call = xrt_ucs_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(ucs);
-- 
2.27.0

