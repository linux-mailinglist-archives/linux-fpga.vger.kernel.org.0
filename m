Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DC337B3EB
	for <lists+linux-fpga@lfdr.de>; Wed, 12 May 2021 04:00:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbhELCBm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 11 May 2021 22:01:42 -0400
Received: from mail-dm6nam12on2081.outbound.protection.outlook.com ([40.107.243.81]:4193
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230104AbhELCBl (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 11 May 2021 22:01:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lsLuMcUiPMt9P2fdoy6ipXeJNs+KIBkZF50ofaD4zIqpM0+8i/DoLeM+WdWPwWBg/Vf2dVcgM6wHXvZ1kR3ugfkXd/ERlZeXqx9hsy2xrURgXIGLAKcuk0RGOwJ7JvFRVFEobocJ5KXHBxrp8hcQ+7dkWlXlFxKe/Zv3waysI8oATVqDOD1RLAbmQTo6nX6meDOdW9bcuE10haiHX1UDidVArUE3eJRtUVl+kaWyEnVBZ+X9b+tsisMdy2K1SNRIEoL/OJqu3podksOTATS1EX5rR2oc2IoNMER+tluI8mjLqxQCk8esvyiUszYZJMmxOKVUsY9BR1lF5/ghiE5RWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u10gwilFHCTukmuwgnK2AOqu253QrWQEu1f93XxT5PM=;
 b=jNmifTp0y/Tiz/cJU6/8y1vyVsjbkpeJuCBqzxa+AZDojxO3VBnHYJmtOiAXLP7Ik2XavFo7bAtDDo9hfgVvLyLmFeqzAc9QayCGjcpoyeJY2Gf7VQpjTekQtos+Am9rlxoV9KGEZY25E0dGMwK1JTWaJqSrcfF/YNoIhp+Fw+CXsPsmLwOQ1U0BqsjPVvAOhcXBTCd/3PhR5Y6m990j4CnUTs7RCG1e9fZpUB8nwo1PegFX9rnumwCyEyKM+3a7zIbJ+guWCgARRxdZXPYTRczB5QtHyPQxAvWZhRnKS2oIrFPGp05AR+iRiTHVAhiUt5osuTgRtdvsgRVj7xktFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u10gwilFHCTukmuwgnK2AOqu253QrWQEu1f93XxT5PM=;
 b=n++oMxOjxBly9W8+DHrXje3Lv5r1Bj66GDJFv0Iaoz/LKbfac3POvMlWxlLwF3dVhpnnbY7iXcnL5cx7FOTeRGNjjOByi9T9oQVznfTmAPek8QsxjD6p7psSVPyr5b87Iwpt3Mg++j+e7IZKQZoN4Aj8uqgPTeckkQpv6CAZF/k=
Received: from DM6PR18CA0002.namprd18.prod.outlook.com (2603:10b6:5:15b::15)
 by SJ0PR02MB7598.namprd02.prod.outlook.com (2603:10b6:a03:327::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25; Wed, 12 May
 2021 02:00:32 +0000
Received: from DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:15b:cafe::48) by DM6PR18CA0002.outlook.office365.com
 (2603:10b6:5:15b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.25 via Frontend
 Transport; Wed, 12 May 2021 02:00:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT052.mail.protection.outlook.com (10.13.5.134) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Wed, 12 May 2021 02:00:32 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 11 May 2021 19:00:20 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 11 May 2021 19:00:20 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=35742 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lgeAe-00020m-Lz; Tue, 11 May 2021 19:00:20 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D22EE600134; Tue, 11 May 2021 18:53:45 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V6 XRT Alveo 15/20] fpga: xrt: devctl xrt driver
Date:   Tue, 11 May 2021 18:53:34 -0700
Message-ID: <20210512015339.5649-16-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210512015339.5649-1-lizhi.hou@xilinx.com>
References: <20210512015339.5649-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f163618e-5f23-4303-762c-08d914e9b9d9
X-MS-TrafficTypeDiagnostic: SJ0PR02MB7598:
X-Microsoft-Antispam-PRVS: <SJ0PR02MB7598CD6E16A4D2F78F20617CA1529@SJ0PR02MB7598.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nUyWRbw+Ehbz1w2dZamasw2t2nPIutdrNUymu2uvVS4rBCmjZ9cRFohFJpSpjyJ1Ci5jsOqL4iELbpvcaECvtBdJmu4/ja4CQqXL+9JBPcL2dzcUB/ShCRLdX2+EaZ9K8zk2MUn83feKvNqIsufpJlfdPN7gqNj+4WK15CT1YQh8TTEGiVq/J3n+vxCjPEfAqoikHhgl6/ZxeXd4Iyx5+z+G1s/oEJqPilDE4AzjWdhgv3U2fuKI5mW8v69vtRCJpqFT36SBAouhxq/8dD22GO/zLutLK6XFPlOJLQ/2eBQ64mgeA5o7H0ldS9uZWS598DFN3tyRPoCp5TbzmRL/6dFW6q4mewg10JECOXrNxqWxUnk9dljOxwqly9ddlpeGW7kA2PBlAwp2UiNODe+rXj2gBlVT7UobRfBCbcIK5TAwkJr9Iy9j/EDGo/qtxKU/JKfSPRjBE9qVBEb7YvcjInu6kJYplgl3mvtLAoEbyEFkiPc3inuxLRGCrGXhMOOcfNBtdPoLZWq5tz4zWYnsGboCiB6zbMTEVIMUu82/E2FXzI1itdXjjYs4MD0punITQlhDT7wlEDEU4qd8JslciWECEOettK/jfa8M5tlCCT0wkyMaCwF9snc5il1gPERdBfPI/qO4G/kwDz8BiLFqJsYcrA2XOGhxxd7k6lckjV0=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(46966006)(36840700001)(36860700001)(426003)(478600001)(8676002)(7636003)(6266002)(6666004)(5660300002)(356005)(8936002)(2616005)(36756003)(54906003)(6916009)(26005)(336012)(4326008)(2906002)(82740400003)(107886003)(36906005)(70206006)(70586007)(186003)(42186006)(44832011)(316002)(1076003)(82310400003)(47076005);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2021 02:00:32.6708
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f163618e-5f23-4303-762c-08d914e9b9d9
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT052.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR02MB7598
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

