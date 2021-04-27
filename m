Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8D736CD92
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 23:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239128AbhD0VCB (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:02:01 -0400
Received: from mail-mw2nam10on2081.outbound.protection.outlook.com ([40.107.94.81]:23265
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239328AbhD0VB7 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:01:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcxGXS/I5cvCMTOIslN/rgfflboylBkvyijQOEZiWW6kH21FVaxxo1Pzazlx2X50Jtul3Z9sZH2zWDmXi5Dg5mXp67r5Wg4O/zuDM4Y2TTE/gOMNk25XMoQI9xk4G1lRPCxDFK6VQCqo5nzTsOKYYvPE+xAx5jIiHzSqVu2EyuiZupaiFdAhwdXveFUk2Y0w/UIIRHmX8YRzjEb5nMi/fLM+MeCanZlMcXWM481kpl9RQnIIV9F4ILW+Z6fUx9qmJxqfTSVn30DnTG5H7/PmKVYsqBFdJATMyGYW39H4VAm+/no3CvAvjUAyOSApcKAlqbYcPnh8Je1HipRyyDcekg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NsI7MtIRMm3p8r3embBBHQwBS3PUGe0KfHSKwgq79s=;
 b=L8C1kS66f4MG1foEPwrtXDrCer0ZUwS67bEiP7Cjy/eWdZdAKFPjSjHmuIU4H9eeEdD2C8BDUq+bIJB8ZjDbw6fhJ82BrKZ66BFCQi2/y/P2jY48GDkEU/SVfZ9OTXa4yLamy6viPP6PhOHyD3xtrW01IYDNMnMw57A9SPstFmup5NMUtdUX1aIx/2YC6KHr3K+A1trJCNm2h1aCHD+4H/yRSljEJwv1fJFUc1PpZU5bBrmJpY7V5rsrForPzcic7GtBQyigQJ7ybjPQONfJxN1K4LtH4RuWVHBpzmqWOUErrTftW6D6ONke81oLxRXJGYnBqSPGE2K1hy3klq54WA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/NsI7MtIRMm3p8r3embBBHQwBS3PUGe0KfHSKwgq79s=;
 b=qzUu2OaU40n9hb+bOgHDRKa2Wn/FxuRulmfhOCv7xaZZmWSUfXyODkEm59mEF9yPLq71e/Hfu+U6v0BenzUQNijpJjEu2XUmIE+Or/zky4sUGIsbCQBD2KReyb7e4fDzf8yMzxn2qNt4noHU4LOzKl+AjpLks2TM1SlSvze0Lck=
Received: from SN6PR16CA0050.namprd16.prod.outlook.com (2603:10b6:805:ca::27)
 by BY5PR02MB6520.namprd02.prod.outlook.com (2603:10b6:a03:1d3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Tue, 27 Apr
 2021 21:01:13 +0000
Received: from SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::4d) by SN6PR16CA0050.outlook.office365.com
 (2603:10b6:805:ca::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21 via Frontend
 Transport; Tue, 27 Apr 2021 21:01:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT028.mail.protection.outlook.com (10.152.72.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 21:01:12 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 14:00:51 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 14:00:51 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52026 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUp9-0000BF-0i; Tue, 27 Apr 2021 14:00:51 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 4FBAB600131; Tue, 27 Apr 2021 13:54:36 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 15/20] fpga: xrt: devctl xrt driver
Date:   Tue, 27 Apr 2021 13:54:26 -0700
Message-ID: <20210427205431.23896-16-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc622e15-7729-41e9-f7f2-08d909bf9742
X-MS-TrafficTypeDiagnostic: BY5PR02MB6520:
X-Microsoft-Antispam-PRVS: <BY5PR02MB65202668B5F434DFCC6C6017A1419@BY5PR02MB6520.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B66+kXdyWOxRdqi/zIfrZEWDkS6M57AnDuvSRS85mYqjhlfamZELisyrs1FYDnZinQgZWpNkbJ9UelSI33Bv9GmgwO77/mZ6IGGANQTa1jokJHj+wytMVZIa9RIodu3NGtrdxgUIjrFwCNeYIPvFyFoFJRBDD2y1BX+LSbxBSy1uiA7c3aU1Mpq4GX+gDxD1JZtbCQYtcg7KpRwStGxpZKwAf6RQScUcaUKOJRShjxfatH9aSRwKG28Jok5WDK1Qsg05F+cXXPpBdL5TxCWmsZd7OaMlChwKpQQ8t+EWnz0nMBSM48zFJ1YpkXFrIY9vlvUs/Vk2GFyMe/l2mTNAVU00yOhGYRaIt93Zyk2t0kkTH/0HlLRTLG4L5Ab13idzWCVF9sR6UR3PoINrqw30OL2O2438QDxU2pV0esTAsy0pyIqo6N+JzrPkXmuMpx9J50UlhcJk+LZ2GxH8pvnewYmRVDqUvf5agyR5guohg8hwrCZkl64t/vixoFgCfxVquLLdsCDrAkfXw7KTCGXTPOi5yRt5FZHYOZRuQBUt7DzcxScOifjXuN5Dka93jadKyHZeS5OOE0MctUPfyMGqn8PzInSO2Vxx10nc2K828qWbxTfisjOL5eVow4ofzT+Pexqvqj1ZeXsg4glE2ged9BxuWqFv3MGGxS0qHx5wNc0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966006)(36840700001)(44832011)(356005)(47076005)(336012)(26005)(42186006)(36906005)(2616005)(107886003)(70586007)(6266002)(82740400003)(6666004)(426003)(54906003)(316002)(8936002)(8676002)(36756003)(478600001)(70206006)(5660300002)(186003)(2906002)(36860700001)(1076003)(6916009)(4326008)(82310400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 21:01:12.9978
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc622e15-7729-41e9-f7f2-08d909bf9742
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6520
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add devctl driver. devctl is a type of hardware function which only has
few registers to read or write. They are discovered by walking firmware
metadata. A xrt device node will be created for them.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/devctl.h |  40 ++++++
 drivers/fpga/xrt/lib/xleaf/devctl.c     | 169 ++++++++++++++++++++++++
 2 files changed, 209 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c

diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
new file mode 100644
index 000000000000..b97f3b6d9326
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/devctl.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Lizhi Hou <Lizhi.Hou@xilinx.com>
+ */
+
+#ifndef _XRT_DEVCTL_H_
+#define _XRT_DEVCTL_H_
+
+#include "xleaf.h"
+
+/*
+ * DEVCTL driver leaf calls.
+ */
+enum xrt_devctl_leaf_cmd {
+	XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+};
+
+enum xrt_devctl_id {
+	XRT_DEVCTL_ROM_UUID = 0,
+	XRT_DEVCTL_DDR_CALIB,
+	XRT_DEVCTL_GOLDEN_VER,
+	XRT_DEVCTL_MAX
+};
+
+struct xrt_devctl_rw {
+	u32	xdr_id;
+	void	*xdr_buf;
+	u32	xdr_len;
+	u32	xdr_offset;
+};
+
+struct xrt_devctl_intf_uuid {
+	u32	uuid_num;
+	uuid_t	*uuids;
+};
+
+#endif	/* _XRT_DEVCTL_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
new file mode 100644
index 000000000000..fb2122be7e56
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA devctl Driver
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
+#include "xleaf/devctl.h"
+
+#define XRT_DEVCTL "xrt_devctl"
+
+struct xrt_name_id {
+	char *ep_name;
+	int id;
+};
+
+static struct xrt_name_id name_id[XRT_DEVCTL_MAX] = {
+	{ XRT_MD_NODE_BLP_ROM, XRT_DEVCTL_ROM_UUID },
+	{ XRT_MD_NODE_GOLDEN_VER, XRT_DEVCTL_GOLDEN_VER },
+};
+
+XRT_DEFINE_REGMAP_CONFIG(devctl_regmap_config);
+
+struct xrt_devctl {
+	struct xrt_device	*xdev;
+	struct regmap		*regmap[XRT_DEVCTL_MAX];
+	ulong			sizes[XRT_DEVCTL_MAX];
+};
+
+static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
+{
+	int i;
+
+	for (i = 0; i < XRT_DEVCTL_MAX && name_id[i].ep_name; i++) {
+		if (!strncmp(name_id[i].ep_name, name, strlen(name_id[i].ep_name) + 1))
+			return name_id[i].id;
+	}
+
+	return -EINVAL;
+}
+
+static int
+xrt_devctl_leaf_call(struct xrt_device *xdev, u32 cmd, void *arg)
+{
+	struct xrt_devctl *devctl;
+	int ret = 0;
+
+	devctl = xrt_get_drvdata(xdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_DEVCTL_READ: {
+		struct xrt_devctl_rw *rw_arg = arg;
+
+		if (rw_arg->xdr_len & 0x3) {
+			xrt_err(xdev, "invalid len %d", rw_arg->xdr_len);
+			return -EINVAL;
+		}
+
+		if (rw_arg->xdr_id >= XRT_DEVCTL_MAX) {
+			xrt_err(xdev, "invalid id %d", rw_arg->xdr_id);
+			return -EINVAL;
+		}
+
+		if (!devctl->regmap[rw_arg->xdr_id]) {
+			xrt_err(xdev, "io not found, id %d",
+				rw_arg->xdr_id);
+			return -EINVAL;
+		}
+
+		ret = regmap_bulk_read(devctl->regmap[rw_arg->xdr_id], rw_arg->xdr_offset,
+				       rw_arg->xdr_buf,
+				       rw_arg->xdr_len / devctl_regmap_config.reg_stride);
+		break;
+	}
+	default:
+		xrt_err(xdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_devctl_probe(struct xrt_device *xdev)
+{
+	struct xrt_devctl *devctl = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int i, id, ret = 0;
+
+	devctl = devm_kzalloc(&xdev->dev, sizeof(*devctl), GFP_KERNEL);
+	if (!devctl)
+		return -ENOMEM;
+
+	devctl->xdev = xdev;
+	xrt_set_drvdata(xdev, devctl);
+
+	xrt_info(xdev, "probing...");
+	for (i = 0, res = xrt_get_resource(xdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = xrt_get_resource(xdev, IORESOURCE_MEM, ++i)) {
+		struct regmap_config config = devctl_regmap_config;
+
+		id = xrt_devctl_name2id(devctl, res->name);
+		if (id < 0) {
+			xrt_err(xdev, "ep %s not found", res->name);
+			continue;
+		}
+		base = devm_ioremap_resource(&xdev->dev, res);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			break;
+		}
+		config.max_register = res->end - res->start + 1;
+		devctl->regmap[id] = devm_regmap_init_mmio(&xdev->dev, base, &config);
+		if (IS_ERR(devctl->regmap[id])) {
+			xrt_err(xdev, "map base failed %pR", res);
+			ret = PTR_ERR(devctl->regmap[id]);
+			break;
+		}
+		devctl->sizes[id] = res->end - res->start + 1;
+	}
+
+	return ret;
+}
+
+static struct xrt_dev_endpoints xrt_devctl_endpoints[] = {
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			/* add name if ep is in same partition */
+			{ .ep_name = XRT_MD_NODE_BLP_ROM },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_dev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GOLDEN_VER },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	/* adding ep bundle generates devctl device instance */
+	{ 0 },
+};
+
+static struct xrt_driver xrt_devctl_driver = {
+	.driver = {
+		.name = XRT_DEVCTL,
+	},
+	.subdev_id = XRT_SUBDEV_DEVCTL,
+	.endpoints = xrt_devctl_endpoints,
+	.probe = xrt_devctl_probe,
+	.leaf_call = xrt_devctl_leaf_call,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(devctl);
-- 
2.27.0

