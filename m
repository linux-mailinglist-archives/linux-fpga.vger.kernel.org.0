Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 946EB393AA8
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234278AbhE1Ayt (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:54:49 -0400
Received: from mail-bn8nam11on2080.outbound.protection.outlook.com ([40.107.236.80]:14176
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234783AbhE1Ayt (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:54:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQGRzskNq8/HU1Crlst7xupGlZ/8CNB0RN+5YGFO+ISqn2xWS6YvIIFjQEEL9/7YfjjPrdH8i+BwmHUdyKd4xT0jV+VoEn9xJR2nZnVuK10nsn2G6vEhPViuSxPRvcbrz5yyU01NkQaQ1cDPoCv+c2x7PnfqZcLBQjVaRuBH1S5SvOuRaDm4kI6RIcxcDBKYcqfJWPacJHgXcdRcl99ShnrSZ6NhGSVH4y2PjoBOVWu59miXZdzfSIDyRUlrBmrtGiXA5+ePVoHlYziUakuBM8TNZw0kfYPQJkyKpe51LukUZi3o8QkRoH1YUgLyj55zUr8mJOhD0ZusvzqYrOQt7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u10gwilFHCTukmuwgnK2AOqu253QrWQEu1f93XxT5PM=;
 b=jc9zaQfhYFxu7vnFNPiEHaepr31fOEzUDajcTqm2tRD5sanVo0NURDjhXqvNoh1t1/S4MQyc/iVKNaBf1trrB8RVx81adXMAG3GF64ZKhZNXP5TZPh0t2k8S1PFepbNcT1+r083t0eUENJdKiiCq2uwr6/IzKHOJDAEOFTFqZ+lqziu2+2+B+NUAtCjPoBQkKBMvB3g/F5Vaq4APLayTd2b72+9cZkSRdHGWmJU8RXusRxJqQyVPvjK2diJCajXHlgzHqS0Y10nZZ+JKaLPA1dzHypJgVx0QrqaPzkhOXdHzv3oXCQxX8CFfZD3xxYZSiLYCGSJRanYVaAA07+mTpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u10gwilFHCTukmuwgnK2AOqu253QrWQEu1f93XxT5PM=;
 b=HDgeJqztWGzHI3TssROvJ7fz4GbDFvOUUQAS3ch6OEzrLoq+vIdmvwf59YY7B29v+IDoTwhXDfXJDc8ukEXxm9PIyBSutQIkL7B+sDclQut8DmLiyLWX2mY1QakRNZ4S8lg7kUVxSSM+GQPIOaQM0SPxj4bDucNjLFDePHa/1zk=
Received: from BN6PR17CA0029.namprd17.prod.outlook.com (2603:10b6:405:75::18)
 by BY5PR02MB6017.namprd02.prod.outlook.com (2603:10b6:a03:1f5::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.27; Fri, 28 May
 2021 00:53:12 +0000
Received: from BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::df) by BN6PR17CA0029.outlook.office365.com
 (2603:10b6:405:75::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4173.20 via Frontend
 Transport; Fri, 28 May 2021 00:53:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 BN1NAM02FT016.mail.protection.outlook.com (10.13.2.133) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:53:11 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:53:08 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:53:08 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34036 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQkO-0003fY-66; Thu, 27 May 2021 17:53:08 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 1BAEE6032B1; Thu, 27 May 2021 17:50:07 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 15/20] fpga: xrt: devctl xrt driver
Date:   Thu, 27 May 2021 17:49:54 -0700
Message-ID: <20210528004959.61354-16-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fef0c6bf-03df-44ab-ec04-08d92172f7d8
X-MS-TrafficTypeDiagnostic: BY5PR02MB6017:
X-Microsoft-Antispam-PRVS: <BY5PR02MB60172CB7DA187F933979CB2BA1229@BY5PR02MB6017.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oHyY/IaPXTAGhtCj5mF27wCLXlIQKFdmnJcSaYWRIqINakddWVL/nP7XTlcUOSeBZ8lZdRWxoksjXEm4A9EH0LaV443x8fVfOKicsB1FyxUpyBSlazOXPnqdtFjGSl6Ktxthev4PoMAqxGEcupQBsFGYBzV1TZlehJH5+wUU0ct80cm+opcCdmnuHXRXRGuRRkKJzKhbRjxLQ3psTQEyU9onBYWtiDq5d6RnAqg8mhLLBZPAJjeC34mHHeOGkRhhf1OsEQIXza2AZt3m0OjBlKCOgRYGTCErxHWFW/5BdgbWDZtWulyZxI+eXJTtlmuXcEwoLiEradUs+BGe9kDlfIXhViQmvJ8ROG/wZ0MDkayudIkGBYz2lr+4uO7qj1osmFA1xpsmBSqIMquCHRHTXq2d4jxqXDQ4n+CcnVfbybz91Njopahvsf2c0fgL5XBsuCszFUQiK9tgcsySYjHKrEa5wj84J3mffZenqyTX5zsNLqBhJ3MIulsrCMNrVHTi5OckzvpTlfXZeVpaZAwC03v6fi2l7ce7B6iiY8HX19DA+Q4oNoLxTnFGHeh4OeOxLRbn0mWG9yCoPt47waf31FPS2u0VSmXqtVR3+1lYAgPq+GOog74y/PKq4E9DFnDAGJjeoQDE5oPGCBNAInS/42zklsXTGAi08li/Z2cgwF0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(136003)(396003)(376002)(39840400004)(46966006)(36840700001)(478600001)(6666004)(6266002)(42186006)(316002)(70206006)(8676002)(54906003)(47076005)(44832011)(2906002)(36860700001)(2616005)(82310400003)(1076003)(336012)(356005)(6916009)(186003)(107886003)(4326008)(8936002)(5660300002)(36756003)(26005)(7636003)(70586007)(426003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:53:11.6403
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fef0c6bf-03df-44ab-ec04-08d92172f7d8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1NAM02FT016.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6017
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add devctl driver. devctl is a type of hardware function which only has
few registers to read or write. They are discovered by walking firmware
metadata. A xrt device node will be created for them.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
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

