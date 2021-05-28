Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3E3393AA6
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:53:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235854AbhE1Ayf (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:54:35 -0400
Received: from mail-mw2nam08on2042.outbound.protection.outlook.com ([40.107.101.42]:27872
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234371AbhE1Aye (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:54:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHKOF/jjnnRa+fmwGSB3wyBHMYvjKh7OnaslzhuRna/6soUCZSDkYLPtPjJ5F8iMEy006JB5iwmk3peMHECAsfAyuc/p1LH2mpMC3RnRzaUWQTlBzqEjoZG5cEvyBX0w/bi/14PW4zp1f2pdAOjiLWxnLe7nKj6zKVNvAlt3HVtawqVlDoHypqFC3D7oleMBzTLqDVkasyoVFSssgoYSEGH77HE3YsfDkC4jJYA/Kdy1QxwRX9AkqbHWY2dtE6+2UXWxH5iYOFaah70NRFcFJ1yMOLqHKUWTAQ+x8LL4pHM+y8C6igBnMboVfhs6480+HWV/S46DwIeJuVeAPSQsaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IHbA1KOlRqIRGKR42QJm/+BxfptGvC2i/9JPgkwKnU=;
 b=f4X8ySvCw+Qkr9wOA/fyvUD7AWZT0Y4y/PsZ0cQDFMU5xOX16nNKQwO4JVVA/5iYGJC2gHIzclQulCjGixvV19RIM+4syje4/HtuytKkEzkWfzNluIBPiawtbHGwBusGZNZg1SZGh2LdBpdSyi8CZ3tOT2uHK1j3p2ljeM84SJ1wsj1uF7jO4/joabeQ7ibMmT23ncis7ZwX4Gr3oQGBryupa+5KXKloguLqATdKAHnsvKIS3idM8NTVuy7hc6yTVITwzUSaEER+kelm32WNH4d8GS3DC4PUV8SXsa67D4UD4nUzVHpY3h4Vct1VuYUwutd0BZLJEhZ3Y60tfc88yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IHbA1KOlRqIRGKR42QJm/+BxfptGvC2i/9JPgkwKnU=;
 b=lcEe1X7jH+Kb61SzRR/Df2/d23B1kJyTIqMUjyDEo/uj/gqmDoWJo08Wh4m/VoGsRrHxLuQGaDSHpQ7V/XjD9XRdFh4WeSKOqY+lfpKkXqiTW9aW2R5V4YCHFtZ2UguYGrjRZot2FCExULgf5XCq8Mtj4kBD8sqlXu3rd2x5GSk=
Received: from SN6PR04CA0079.namprd04.prod.outlook.com (2603:10b6:805:f2::20)
 by DM6PR02MB6396.namprd02.prod.outlook.com (2603:10b6:5:1fc::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.22; Fri, 28 May
 2021 00:52:57 +0000
Received: from SN1NAM02FT0056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:f2:cafe::80) by SN6PR04CA0079.outlook.office365.com
 (2603:10b6:805:f2::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:52:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0056.mail.protection.outlook.com (10.97.4.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:52:56 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:52:44 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:52:44 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34032 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQk0-0007Ia-2p; Thu, 27 May 2021 17:52:44 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id E9EF66032AF; Thu, 27 May 2021 17:50:06 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem driver
Date:   Thu, 27 May 2021 17:49:52 -0700
Message-ID: <20210528004959.61354-14-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6fb282-7c51-4c26-3302-08d92172ef13
X-MS-TrafficTypeDiagnostic: DM6PR02MB6396:
X-Microsoft-Antispam-PRVS: <DM6PR02MB63964A518E373A09E3C9692CA1229@DM6PR02MB6396.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A8GNMFdjbQL0KMZD7n8ZJXXjR38rd0+xVm4SnVf+HzkpWfvfS6szRORAzXj3jJzCj+pBZWQ6PijHcw6D1HtghPig1yq/BfauUbmaTmQpRgmGJe49LSeKD6oDRbjhDsmKhhLPmWTzeZEGaoLZ2EZipAwr0oRCuDBLdsuulKqs9yYsmtP0IlK0FEBaOEJmHCByafbrhLE7/KbYHIbrWFJdoOaRT+EBfa6J0sWZ0vxG8BluTX+7ySLQ2NdoXL+b31bi64HmQTchP/u8cDH2vSJwFrbgkES0HwGKWUTF6vuxMsxuXLhJveyGYc6MGrYJ0NQYmZUPu9Dq157mGLzc7pmJRxA/0T2hbrlcsN/PQ5OQqLhG9JT3ssuGDYxUO4EeQPxwEwcvkrBqdY+Qnb1Mi3sSPaikLaosX2hcYW3YdU7yuvOdQTJSC7dC3jpUxLXnRmrwii/zj13fiLc6glRAi9JznutL9lSh2M4zCjzIXWRAW+Aqc8bduHmYcKZDJTbv+MfZFcD1MLV18u9tC5+4av3b/q9oo+mOkY4V2XKLizYBNMhss93uP9E6yz43DAfM5RmQHNuU1m7bC/YIhgNte5gk96JZgPV1ToP3Cry863m7oL/GQGAvOW8h/eJs2BhUB1ceWy5uCcTuK7BFCE+udeYveU6/w46WEfVXT0Id/0yWR3U=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(136003)(376002)(396003)(346002)(39850400004)(36840700001)(46966006)(54906003)(36860700001)(82310400003)(83380400001)(7636003)(316002)(42186006)(8936002)(82740400003)(6266002)(107886003)(8676002)(6666004)(4326008)(6916009)(478600001)(186003)(47076005)(44832011)(2616005)(2906002)(336012)(26005)(36756003)(426003)(356005)(70206006)(70586007)(5660300002)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:52:56.9827
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6fb282-7c51-4c26-3302-08d92172ef13
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6396
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

