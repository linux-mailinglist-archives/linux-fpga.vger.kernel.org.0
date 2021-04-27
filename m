Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB56336CD83
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbhD0VBh (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:01:37 -0400
Received: from mail-co1nam11on2061.outbound.protection.outlook.com ([40.107.220.61]:18433
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237009AbhD0VBb (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ICwmShAlzVN3ZqFrZwJm3BACwS1VIWGjLSKVmmRbEJx6mYzQN5w3eLDpeB8GOCyRAB/GFeSClEQlplhS2fee3jEdyMK3BgZFeXnEMKmPk9S2gBtQ25zImwfupG578wpEgcyeSawRtcQbAjL2tZXuwpyUp+pSUXO8Afs32AczLF+CRdKvWmELKj+YLsW8PqHDVqnxsRY+d7eYqdLvQHU3haGu59lUyctdFtd0tU29ELV+1N2bDg82mELTaWI+ZBrHeeZKaDgI8SpZY10POycWGJbi+M6KAtOGeySZ9pTF/PEgDanwy8mStuQJz3MpMcsBRI2fpvgrx8zi9qxzmK/dyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqL0Xqvmd1CZgGiaQDpxp6XzQobHydQe/gzRd+h+AWU=;
 b=n+pmU7GIyYSN5vogFT6qbona1bh43tQLPkvV3ra1YoeEzs4SfExaYzJLpbnbMTPQJjL4EcteBP3bf+mk23FDfjXCraIexFPEEj5BMP/fNnFyWcdpLgnCb5xOypjktMv7/29w602epRNufd+jFe1dlkAxUNMYVI9TawtuS1y2LyaaDbemHjWVRJKrBKZmeRfc/4kl6NgoALMuGnKvs8/41BvCpHbdkYGh/eO7sP95D73oCblMnq2jmagKfYFtGAxGTH4fXy+3zHe59grM8pRQSCh6wzjejHWVxj/AGbVbfrfNVvb2aoiyIjXIGbTc5xfmqQ0i9lv0BQlkCAd9ocgWPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XqL0Xqvmd1CZgGiaQDpxp6XzQobHydQe/gzRd+h+AWU=;
 b=Y9gmYhz94eE2AE7FJyOOUae6tMtVhCvlDQuoCd9/aCaz/7JRqG55BvT39LSou4KTHv+SkZZ/ub7E4WNO3CtGHQ7aXI2iyYQzlvvNNssLBj1+aYcyQ3G/7kDKe9qi9GaMhUxibmO0nLOSXMk8Ouf2mA+wHnc5EYz/PUBVZEV31RA=
Received: from BLAPR03CA0098.namprd03.prod.outlook.com (2603:10b6:208:32a::13)
 by BN7PR02MB4178.namprd02.prod.outlook.com (2603:10b6:406:fc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 21:00:45 +0000
Received: from BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
 (2603:10b6:208:32a:cafe::4e) by BLAPR03CA0098.outlook.office365.com
 (2603:10b6:208:32a::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Tue, 27 Apr 2021 21:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT004.mail.protection.outlook.com (10.152.76.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:00:45 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:00:27 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:00:27 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52022 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUok-00025G-Sx; Tue, 27 Apr 2021 14:00:26 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 3223E60012F; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 13/20] fpga: xrt: User Clock Subsystem driver
Date:   Tue, 27 Apr 2021 13:54:24 -0700
Message-ID: <20210427205431.23896-14-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87902db9-1ef7-4839-7bd7-08d909bf86ef
X-MS-TrafficTypeDiagnostic: BN7PR02MB4178:
X-Microsoft-Antispam-PRVS: <BN7PR02MB4178CCDD590686D324C17FA9A1419@BN7PR02MB4178.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2399;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7vwbTSb6l83wtpYHPisnRpFwb2iCqIQN34UA8wCskI5ApQ7Z9t/kTzkTidQi6GrXkJLmI+IBxHxDGkdaMTx+48WIL6F2clj57emjsD0DQquqJWkl4ya2mJJNsO/uSsCEgiCLdoX7+L75Z0pZd8LDVBeTUe8uGSl2C3cmyANxRsWltM+aaxB2cPsVrPXKhLU91E1RgBaehTaYurXams9w8JMmlui2BXj0/UE7TXvWvKEViWF9kAqdEFPP/QtsISYIS2MAQHUUhBIW2BJz8hOnqu+qD1VxUkFERrxTeU4Dpt8wcqyXSEhweU1XaSj3oiiEwPGROEMVfNOntbP40DiwvlIBhU9K+/mrKpPMrd9NvaSGNwXQVpcCjQuvLEAwWsPxAjo+K2Y7nbFBQoz2S1uwEBjPPzh58NoTbvP4ZVOVAFS8NMDVq6RXd7s9FUYmKCKpda80qAh2OUOlLujhrZM2LZdZEAK57G0wgI5lukD2B4lN477LOUHWH6ZWfGKajm6afbtTAtNQ5UkxYh3rACPpt4nEI2sJTqKmDXGdCWY03YjwIHlBcE6YGRaSklrpnF0dfSsnAHr06Up4cSlFHEaoUvXhlmPSImoW1YONlt311RHtlJDEMrNf5cIFzPDkvEXihyLtHvgD5+tWksyvQITubSNx1Go+wdKzQSQzCjSn7AU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(346002)(136003)(396003)(36840700001)(46966006)(186003)(8676002)(42186006)(5660300002)(2906002)(336012)(36756003)(8936002)(44832011)(6266002)(478600001)(1076003)(7636003)(70206006)(316002)(6916009)(47076005)(26005)(70586007)(83380400001)(426003)(2616005)(4326008)(82740400003)(54906003)(107886003)(36906005)(36860700001)(6666004)(82310400003)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:00:45.5401
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87902db9-1ef7-4839-7bd7-08d909bf86ef
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT004.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB4178
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add User Clock Subsystem (UCS) driver. UCS is a hardware function
discovered by walking xclbin metadata. A xrt device node will be
created for it.  UCS enables/disables the dynamic region clocks.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
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

