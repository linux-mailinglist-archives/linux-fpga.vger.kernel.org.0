Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4D031E691
	for <lists+linux-fpga@lfdr.de>; Thu, 18 Feb 2021 08:01:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231230AbhBRG5F (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 18 Feb 2021 01:57:05 -0500
Received: from mail-mw2nam12on2074.outbound.protection.outlook.com ([40.107.244.74]:54657
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231208AbhBRGss (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 18 Feb 2021 01:48:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOeiOahZjPtDa2hzj6riNRUmRxoHldS1oS0BiBXmxlV+SRuA9bxSNvtlB+iFLLihPxJ+6ghdir/Z2y1qU7A/m1/9kKp+iRqVj24j7mzPx7NWRn83SpImZVd7KAXZzCiAWY7yqIByNXW/fzRa3sndPBkmkHKAJ9FJe4aOjosmZHyUu3u0vYsY9idPBPzri7qpRjZWb4ixn7aUWjQWYK7CnXoD6scH5PW7iPpLDl4oDd5ladJVnAoLBPvOt2Yi/umbBB7goSch8xQkceTmxFzw41gY+7KJnBe1w3F+6FID00B/o0OIttHswndiCjR4uO3iAgvRj4vFowslSzJxWhwO/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opoz9l2kxQpDO37rCGk39sXMeyyCo/WAwug4x0FIuVo=;
 b=haOrkcQe0I7jygANzpP97MKIujtiG3ggFhWqu2CE21CR7j42lgFDN4gnpMOS852u4uFW7JrDitYkyWuPkFN2UOXYL2fkiPaYyVoKIp7024G03GaQC7huGIgh9iwwVdWOOTT2FNyRTHXfuByVcsmJjaYoTPivIm67O6a2wM1pItromRfj66hVtTMKdbWLGz42l+N1oLZXuvCJrDisEgP7t7Ia9u0dXKj6zJ46Z/o4WlueC8St1lzkDJlwX7g45vCKvMBXSYJhUFf5MUfN6tdwVMcep6J4rvNKgyf0BKiNokL4AUM0OmoYuES3cTkTKrxb2qqiIoBt8timGtEb6R4f+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=bestguesspass action=none header.from=xilinx.com; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=opoz9l2kxQpDO37rCGk39sXMeyyCo/WAwug4x0FIuVo=;
 b=eQ/TWyFp3V4csAnY0Q8Yylvl8iHfYAvoDX7AYKz7e068DsFUr1FcWbzJvlN3WPg/IBOkbdReyvmRM9LEEkhwVQCioIw703CppJPPdLy4iiw7OFFUptf5dMpFmXW+u95kc2GXXlgXYShPsH/ea98NtxcCYLldCxAhf6DgUhAVfCk=
Received: from DS7PR03CA0062.namprd03.prod.outlook.com (2603:10b6:5:3bb::7) by
 DM5PR02MB3387.namprd02.prod.outlook.com (2603:10b6:4:6a::35) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3846.29; Thu, 18 Feb 2021 06:45:40 +0000
Received: from CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:3bb:cafe::49) by DS7PR03CA0062.outlook.office365.com
 (2603:10b6:5:3bb::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Thu, 18 Feb 2021 06:45:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 CY1NAM02FT033.mail.protection.outlook.com (10.152.75.179) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Thu, 18 Feb 2021 06:45:39 +0000
Received: from xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Wed, 17 Feb 2021 22:45:28 -0800
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server id
 15.1.1913.5 via Frontend Transport; Wed, 17 Feb 2021 22:45:28 -0800
Envelope-to: maxz@xilinx.com,
 max.zhen@xilinx.com,
 michal.simek@xilinx.com,
 sonal.santan@xilinx.com,
 lizhih@xilinx.com,
 stefanos@xilinx.com,
 mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=40186 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lCd44-00023N-1F; Wed, 17 Feb 2021 22:45:28 -0800
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 6CB38600129; Wed, 17 Feb 2021 22:41:06 -0800 (PST)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhih@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V3 XRT Alveo 13/18] fpga: xrt: devctl platform driver
Date:   Wed, 17 Feb 2021 22:40:14 -0800
Message-ID: <20210218064019.29189-14-lizhih@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210218064019.29189-1-lizhih@xilinx.com>
References: <20210218064019.29189-1-lizhih@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce6435f-9d32-4b1a-7973-08d8d3d8ce45
X-MS-TrafficTypeDiagnostic: DM5PR02MB3387:
X-Microsoft-Antispam-PRVS: <DM5PR02MB33878FA2E1E6374920658402A1859@DM5PR02MB3387.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CwZ35hPs1EZ/cN/xqQGb4z+9F0Hx27JnXIUoC5+uDXsIX17mp/sEXK/SEIH3JfacbUPKTue5/ZiGZQxdOENFNA/f91l11Y/AEuW494BLI9xgBwYpD9W9Efy3I2SKCF0RBAxaa7XGZo3KEl1QQ4X3kjYp1cNON/ERi+gCKevmd7fHSIncHeq6kXLEfZqicJF/fiqUpiK9jVjaM5JYvS9Cv6Pqpe5x8nIRhMyh4DtaFv6M88sWYIlAdpuFOArbpX7jfL7mtr+sifxl63GeX83Bhsn5K1c/oePaGT/lscDWOFiyGwI+mT+AsZxO3nH7YTcS4AgSMOscFv54mskeXPVY4DG1v2ax90jF/Ec6zlfMzIWYmtr3ycrQ8bkEO/WIp/94cmtzcrZz41GrsOeebQ8rYGSfyg40M5Gmwnjq3XXJ4gEhgGnFN7W++vivTJ3XG6nXjsUGIeEL5CXtFHjd9Iyw5yteeKZ9trcLoor7+tvm2QqssEpN68bnWpZfraHJbyNomvNVBT8YRfMFXgM0yDL2rfLUWA8t68E/XzE/c6fSBbwF3Ow6PmauYFHlQBdbs1f/3G+zNhWgJs4w5t9BokNKVmo/o7q7og2Iht9ZsOw5fqD3s3RrPbfArPlablwBejShLf3W5MggRFyasFcQ8TQCamjKG7+UgW1KH8ZuuTFud1o=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(376002)(396003)(346002)(39860400002)(136003)(36840700001)(46966006)(26005)(2616005)(6666004)(44832011)(36860700001)(426003)(336012)(186003)(4326008)(54906003)(82740400003)(356005)(1076003)(82310400003)(8936002)(5660300002)(70586007)(7636003)(36906005)(8676002)(6266002)(478600001)(42186006)(107886003)(36756003)(6916009)(316002)(47076005)(2906002)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2021 06:45:39.9351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cce6435f-9d32-4b1a-7973-08d8d3d8ce45
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: CY1NAM02FT033.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3387
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Add devctl driver. devctl is a type of hardware function which only has
few registers to read or write. They are discovered by walking firmware
metadata. A platform device node will be created for them.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhih@xilinx.com>
---
 drivers/fpga/xrt/include/xleaf/devctl.h |  43 +++++
 drivers/fpga/xrt/lib/xleaf/devctl.c     | 206 ++++++++++++++++++++++++
 2 files changed, 249 insertions(+)
 create mode 100644 drivers/fpga/xrt/include/xleaf/devctl.h
 create mode 100644 drivers/fpga/xrt/lib/xleaf/devctl.c

diff --git a/drivers/fpga/xrt/include/xleaf/devctl.h b/drivers/fpga/xrt/include/xleaf/devctl.h
new file mode 100644
index 000000000000..96a40e066f83
--- /dev/null
+++ b/drivers/fpga/xrt/include/xleaf/devctl.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Header file for XRT DEVCTL Leaf Driver
+ *
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
+ * DEVCTL driver IOCTL calls.
+ */
+enum xrt_devctl_ioctl_cmd {
+	XRT_DEVCTL_READ = XRT_XLEAF_CUSTOM_BASE, /* See comments in xleaf.h */
+	XRT_DEVCTL_WRITE,
+};
+
+enum xrt_devctl_id {
+	XRT_DEVCTL_ROM_UUID,
+	XRT_DEVCTL_DDR_CALIB,
+	XRT_DEVCTL_GOLDEN_VER,
+	XRT_DEVCTL_MAX
+};
+
+struct xrt_devctl_ioctl_rw {
+	u32	xgir_id;
+	void	*xgir_buf;
+	u32	xgir_len;
+	u32	xgir_offset;
+};
+
+struct xrt_devctl_ioctl_intf_uuid {
+	u32	xgir_uuid_num;
+	uuid_t	*xgir_uuids;
+};
+
+#endif	/* _XRT_DEVCTL_H_ */
diff --git a/drivers/fpga/xrt/lib/xleaf/devctl.c b/drivers/fpga/xrt/lib/xleaf/devctl.c
new file mode 100644
index 000000000000..caf8c6569f0f
--- /dev/null
+++ b/drivers/fpga/xrt/lib/xleaf/devctl.c
@@ -0,0 +1,206 @@
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
+struct xrt_devctl {
+	struct platform_device	*pdev;
+	void		__iomem *base_addrs[XRT_DEVCTL_MAX];
+	ulong			sizes[XRT_DEVCTL_MAX];
+};
+
+static int xrt_devctl_name2id(struct xrt_devctl *devctl, const char *name)
+{
+	int	i;
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
+xrt_devctl_leaf_ioctl(struct platform_device *pdev, u32 cmd, void *arg)
+{
+	struct xrt_devctl	*devctl;
+	int			ret = 0;
+
+	devctl = platform_get_drvdata(pdev);
+
+	switch (cmd) {
+	case XRT_XLEAF_EVENT:
+		/* Does not handle any event. */
+		break;
+	case XRT_DEVCTL_READ: {
+		struct xrt_devctl_ioctl_rw	*rw_arg = arg;
+		u32				*p_src, *p_dst, i;
+
+		if (rw_arg->xgir_len & 0x3) {
+			xrt_err(pdev, "invalid len %d", rw_arg->xgir_len);
+			return -EINVAL;
+		}
+
+		if (rw_arg->xgir_id >= XRT_DEVCTL_MAX) {
+			xrt_err(pdev, "invalid id %d", rw_arg->xgir_id);
+			return -EINVAL;
+		}
+
+		p_src = devctl->base_addrs[rw_arg->xgir_id];
+		if (!p_src) {
+			xrt_err(pdev, "io not found, id %d",
+				rw_arg->xgir_id);
+			return -EINVAL;
+		}
+		if (rw_arg->xgir_offset + rw_arg->xgir_len >
+		    devctl->sizes[rw_arg->xgir_id]) {
+			xrt_err(pdev, "invalid argument, off %d, len %d",
+				rw_arg->xgir_offset, rw_arg->xgir_len);
+			return -EINVAL;
+		}
+		p_dst = rw_arg->xgir_buf;
+		for (i = 0; i < rw_arg->xgir_len / sizeof(u32); i++) {
+			u32 val = ioread32(p_src + rw_arg->xgir_offset + i);
+
+			memcpy(p_dst + i, &val, sizeof(u32));
+		}
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
+static int xrt_devctl_remove(struct platform_device *pdev)
+{
+	struct xrt_devctl	*devctl;
+	int			i;
+
+	devctl = platform_get_drvdata(pdev);
+
+	for (i = 0; i < XRT_DEVCTL_MAX; i++) {
+		if (devctl->base_addrs[i])
+			iounmap(devctl->base_addrs[i]);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+	devm_kfree(&pdev->dev, devctl);
+
+	return 0;
+}
+
+static int xrt_devctl_probe(struct platform_device *pdev)
+{
+	struct xrt_devctl	*devctl;
+	int			i, id, ret = 0;
+	struct resource		*res;
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
+		id = xrt_devctl_name2id(devctl, res->name);
+		if (id < 0) {
+			xrt_err(pdev, "ep %s not found", res->name);
+			continue;
+		}
+		devctl->base_addrs[id] = ioremap(res->start, res->end - res->start + 1);
+		if (!devctl->base_addrs[id]) {
+			xrt_err(pdev, "map base failed %pR", res);
+			ret = -EIO;
+			goto failed;
+		}
+		devctl->sizes[id] = res->end - res->start + 1;
+	}
+
+failed:
+	if (ret)
+		xrt_devctl_remove(pdev);
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
+		.xsd_ioctl = xrt_devctl_leaf_ioctl,
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
+	.remove = xrt_devctl_remove,
+	.id_table = xrt_devctl_table,
+};
+
+void devctl_leaf_init_fini(bool init)
+{
+	if (init)
+		xleaf_register_driver(XRT_SUBDEV_DEVCTL, &xrt_devctl_driver, xrt_devctl_endpoints);
+	else
+		xleaf_unregister_driver(XRT_SUBDEV_DEVCTL);
+}
-- 
2.18.4

