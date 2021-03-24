Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ABED347114
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:36:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235369AbhCXFgD (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:36:03 -0400
Received: from mail-dm6nam12on2050.outbound.protection.outlook.com ([40.107.243.50]:8160
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235379AbhCXFfk (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:35:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6zFI6oxmNBmgBj8T47TAj2zcGxkwLeiX7qiRUpeeUCtHb02uJqYJNENT/E3BJlDC4146JCMhPXYKGwMCGBqaVCEbmEnM/Wb90a1gdKhiIl+UUZiVdMo+64iZFT412OddhavPOtJXMpw0ljBFy3k7BBlbW1ySWNGnSF3w5GPRurV8vvunlLCzl40p1TB37GEaG6ILv0RWjHO7G+tSnMYDy4fUo/arkdc2VeQmDUpqI6Xi8E9pij5MtPcvZwt3sJ0j1Z9rItw9mRVv7oCcJZlEVQh1riPila82yXivZpKqpWUzpJNNreGMTs3h5nWv1mPLOuMzvyGI7fZVqsIlPXLrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Ba4iu7iZfkE5iNCC+snAUjNesqB3Fql7ghLqiBIi8=;
 b=XKp4r+HDnZhQmRDpj70KXf3oGjuAiEk3udlKFeLlBrCXYqySyU4ro4UVVVnnDm9ogGHhbf6HKtLN7psignU/ch4qOn7XwGNpIl/3erDwLZx6KPtTpLZU2/TKP/egEQLu2ux8JxAcH0QASNg193DeAMIqpYiI3E4dNSo7djf1wkwTQXW1CLRmH1CEewpDirzLR4UH+RUB/d3YQuyKgGpTTyEz4EQx9pb6SP4+HtxAyYGmd17THvsG7cX+F60LQwSSEyFOZ85jcGlAtSi8plSra9Rkszm68v7afuDxxLoX41pORmIBDUlKZm/1zpkTboPwxEbjfnCYGWa9m083sSzeag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b5Ba4iu7iZfkE5iNCC+snAUjNesqB3Fql7ghLqiBIi8=;
 b=BcDEbM/B1bzSDbo1QjIkI0+hA33GYV/FSLU+qu3CKVTBAep00Pyt/hV0mDsXVzCP4kMVc3mZ15NMx2Jlv65QQoQzR28FqcLizSMruiIlY26Dmas/pFoQmxGRUBmit88/1+kUSRtF0083+slw2NGxnL7VdZNxGMvMYnkOhc4mTOE=
Received: from SA0PR11CA0191.namprd11.prod.outlook.com (2603:10b6:806:1bc::16)
 by SN6PR02MB4639.namprd02.prod.outlook.com (2603:10b6:805:ab::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Wed, 24 Mar
 2021 05:35:38 +0000
Received: from SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:1bc:cafe::5e) by SA0PR11CA0191.outlook.office365.com
 (2603:10b6:806:1bc::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:35:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT032.mail.protection.outlook.com (10.152.72.126) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:35:38 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:35:22 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:35:22 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51050 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOwAs-0004eh-PN; Tue, 23 Mar 2021 22:35:22 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id D189860012E; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 15/20] fpga: xrt: devctl platform driver
Date:   Tue, 23 Mar 2021 22:29:42 -0700
Message-ID: <20210324052947.27889-16-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f853db6-89fc-4abe-3c9b-08d8ee86a815
X-MS-TrafficTypeDiagnostic: SN6PR02MB4639:
X-Microsoft-Antispam-PRVS: <SN6PR02MB46395AF175366DDB4CF82F62A1639@SN6PR02MB4639.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOYsH9qASyRfvUnsNPAyOZuMBw26EBWXh0gr5FslLFSrIKo8IIuYJartdhr91zFBku8eY6Nd0lPwY3qSLlI1xI5HkSj+D11UMWdk1UUvGHxjCTLGyxXnATZ9/Ef2/jnb4OF2Hsk7xWYdC4+LzELJbW90mLeIR0XDLmEQi9S/L9Ic22B67SeL0z81Zp13v37i76tKqebOCX1xpHOrYjsSBRHUWBEUj6B1k6KKB1OkhdSUweqdyia4qlBacZY1KhPttzgj6Wg7txEs/S8dlVRRK+8EBEA0pJNK8eAQ12ScEdFwIo3Nbi6eACiQNC8LOOYZDAo3am+1IRkJiDLuLgIrJrqwX+B3X9hG3/v8jkXxxfetur37+in4BByvXt9h/Lnfx53q+1hT1yBp2NPN1AH9CdjjbZcCY71bbP8jZ5hLlhgcIitX5Ve8bNHVnoCYnkQsfFvFdC4RsJfXLUBda5TFO7Aa4mtI+arQJ9uvaBurFDzZqLOGqT/+Au+tWuKwsmc8IWbxXlFKL+gd/2SqpSe2jW9EHobcTR6yMWKq4+yBiNITlOAExMeHU+PX+wsEtMbs7E4nAedf8tgweEiH+3/lmrmxAOUshO9km8RMs3feSY/DYrLuBbQPczhYaj/ms4n0OdpfjpNzHzDfPXs+dmJAXOn7LKQ/wVWm9Ts4ShcPyhA=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(346002)(136003)(396003)(376002)(36840700001)(46966006)(36860700001)(1076003)(8676002)(4326008)(8936002)(6666004)(426003)(2616005)(7636003)(107886003)(336012)(6916009)(6266002)(36906005)(82310400003)(36756003)(42186006)(186003)(5660300002)(478600001)(316002)(70586007)(356005)(2906002)(44832011)(47076005)(26005)(70206006)(54906003)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:35:38.5114
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f853db6-89fc-4abe-3c9b-08d8ee86a815
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT032.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4639
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add devctl driver. devctl is a type of hardware function which only has
few registers to read or write. They are discovered by walking firmware
metadata. A platform device node will be created for them.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/devctl.h |  40 ++++++
 drivers/fpga/xrt/lib/xleaf/devctl.c     | 183 ++++++++++++++++++++++++
 2 files changed, 223 insertions(+)
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
index 000000000000..ae086d7c431d
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
@@ -0,0 +1,183 @@
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
+#include <linux/platform_device.h>
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
+static const struct regmap_config devctl_regmap_config = {
+	.reg_bits = 32,
+	.val_bits = 32,
+	.reg_stride = 4,
+};
+
+struct xrt_devctl {
+	struct platform_device	*pdev;
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
+xrt_devctl_leaf_call(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_devctl *devctl;
+	int ret = 0;
+
+	devctl = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_DEVCTL_READ: {
+		struct xrt_devctl_rw *rw_arg = arg;
+
+		if (rw_arg->xdr_len & 0x3) {
+			xrt_err(pdev, "invalid len %d", rw_arg->xdr_len);
+			return -EINVAL;
+		}
+
+		if (rw_arg->xdr_id >= XRT_DEVCTL_MAX) {
+			xrt_err(pdev, "invalid id %d", rw_arg->xdr_id);
+			return -EINVAL;
+		}
+
+		if (!devctl->regmap[rw_arg->xdr_id]) {
+			xrt_err(pdev, "io not found, id %d",
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
+		xrt_err(pdev, "unsupported cmd %d", cmd);
+		return -EINVAL;
+	}
+
+	return ret;
+}
+
+static int xrt_devctl_probe(struct platform_device *pdev)
+{
+	struct xrt_devctl *devctl = NULL;
+	void __iomem *base = NULL;
+	struct resource *res;
+	int i, id, ret = 0;
+
+	devctl = devm_kzalloc(&pdev->dev, sizeof(*devctl), GFP_KERNEL);
+	if (!devctl)
+		return -ENOMEM;
+
+	devctl->pdev = pdev;
+	platform_set_drvdata(pdev, devctl);
+
+	xrt_info(pdev, "probing...");
+	for (i = 0, res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	    res;
+	    res = platform_get_resource(pdev, IORESOURCE_MEM, ++i)) {
+		struct regmap_config config = devctl_regmap_config;
+
+		id = xrt_devctl_name2id(devctl, res->name);
+		if (id < 0) {
+			xrt_err(pdev, "ep %s not found", res->name);
+			continue;
+		}
+		base = devm_ioremap_resource(&pdev->dev, res);
+		if (IS_ERR(base)) {
+			ret = PTR_ERR(base);
+			break;
+		}
+		config.max_register = res->end - res->start + 1;
+		devctl->regmap[id] = devm_regmap_init_mmio(&pdev->dev, base, &config);
+		if (IS_ERR(devctl->regmap[id])) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = PTR_ERR(devctl->regmap[id]);
+			break;
+		}
+		devctl->sizes[id] = res->end - res->start + 1;
+	}
+
+	return ret;
+}
+
+static struct xrt_subdev_endpoints xrt_devctl_endpoints[] = {
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			/* add name if ep is in same partition */
+			{ .ep_name = XRT_MD_NODE_BLP_ROM },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	{
+		.xse_names = (struct xrt_subdev_ep_names[]) {
+			{ .ep_name = XRT_MD_NODE_GOLDEN_VER },
+			{ NULL },
+		},
+		.xse_min_ep = 1,
+	},
+	/* adding ep bundle generates devctl device instance */
+	{ 0 },
+};
+
+static struct xrt_subdev_drvdata xrt_devctl_data = {
+	.xsd_dev_ops = {
+		.xsd_leaf_call = xrt_devctl_leaf_call,
+	},
+};
+
+static const struct platform_device_id xrt_devctl_table[] = {
+	{ XRT_DEVCTL, (kernel_ulong_t)&xrt_devctl_data },
+	{ },
+};
+
+static struct platform_driver xrt_devctl_driver = {
+	.driver = {
+		.name = XRT_DEVCTL,
+	},
+	.probe = xrt_devctl_probe,
+	.id_table = xrt_devctl_table,
+};
+
+XRT_LEAF_INIT_FINI_FUNC(XRT_SUBDEV_DEVCTL, devctl);
-- 
2.27.0

