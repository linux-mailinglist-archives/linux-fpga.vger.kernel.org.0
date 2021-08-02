Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10D3DDD15
	for <lists+linux-fpga@lfdr.de>; Mon,  2 Aug 2021 18:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbhHBQGg (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 2 Aug 2021 12:06:36 -0400
Received: from mail-mw2nam12on2040.outbound.protection.outlook.com ([40.107.244.40]:31968
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229805AbhHBQGg (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 2 Aug 2021 12:06:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV/jCDwRKplks3UPWTxQEu9gMozUeIHRXP1A9QTsD0d2xgzfUHI1cfrlLcPn73RtXsstOTAN70mRZwoijaDp9VCVdiAmBBOQpJql6yUlO+mYM9MH9lYfIu3qyf4U7z3EFO6LDjIZfZpvAGWi/vEKGVxVgSwkqt/KKEjgIgSKCQayfgCEi2XJfIK0Aal+8zbAs8Usg2VKzPORSjPpILWNOTx/cKvskrEDic6YWMPtVpGNWaEoZGHESj4tI1gterlHSsYt+RTN4VSXJI5HUEUmR8fD3t2OyR0clrwUGgXWTRvRE12xvSLGvKhjn/Tcu9f4VALqsIY6XUSBBQlX++Z+Tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=ksv0Q2H/c7smeQG6hdUerUrTsr38CtXp8TFQtYpvr0tfnafSdmJMwPIMNFiMICa944zPAYkN4jvWESKVpkU6TSVj32vDGLfbX43lpwr2Hn/q3k2YqV8zgKqBSopCTl6kI2ikHKTPKdSmtRr3ChxrWK4TM3LjsM+cfLQYq6CvKrbuPFs11gYCCwicVo1xb4oCarK4aolOLIfug2TNOorJiz5nR6kvBXwgXj25Qc2uaPofuLR9ky1CgOXsjSqvm9rpf6dy5aW0tOIQmwYmkhnfb/gDGYeV4jZpqy+C7asoKVr97OM78wf0d5H7aAegHQitrkFe+rmxOKBcWj8bow5z1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=VFUb7h37fZP+pWI4sjmT9FnwseJ7obpmtVPCTvzuzf8WG9orA2o0dUnX/JjGkHwJtdU5gcXBhZXHZnJ0H3xa8jU0aeMKy/F0gLKhgklu609S7nJUyoP6V+guVXXBqmNE9qxueqhgg5rOHqS3uwiX0OiAeP8yL4LjpJCn1fsQMWg=
Received: from DM6PR05CA0056.namprd05.prod.outlook.com (2603:10b6:5:335::25)
 by SN6PR02MB4831.namprd02.prod.outlook.com (2603:10b6:805:94::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.26; Mon, 2 Aug
 2021 16:06:23 +0000
Received: from DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:335:cafe::35) by DM6PR05CA0056.outlook.office365.com
 (2603:10b6:5:335::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.12 via Frontend
 Transport; Mon, 2 Aug 2021 16:06:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT040.mail.protection.outlook.com (10.13.5.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4373.18 via Frontend Transport; Mon, 2 Aug 2021 16:06:23 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 09:06:18 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 2 Aug 2021 09:06:18 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [10.23.145.232] (port=49056 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1mAaSI-0005AZ-53; Mon, 02 Aug 2021 09:06:18 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 5D9D9601B23; Mon,  2 Aug 2021 09:05:30 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V9 XRT Alveo 06/14] fpga: xrt: char dev node helper functions
Date:   Mon, 2 Aug 2021 09:05:13 -0700
Message-ID: <20210802160521.331031-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210802160521.331031-1-lizhi.hou@xilinx.com>
References: <20210802160521.331031-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e7314606-0168-4eba-7f01-08d955cf797d
X-MS-TrafficTypeDiagnostic: SN6PR02MB4831:
X-Microsoft-Antispam-PRVS: <SN6PR02MB4831931B7B1DEED011C731FBA1EF9@SN6PR02MB4831.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X5Gvclhc1fH37WPIQ8JGWYa/NPeOC2X/Q+6E9p7ShpA4ovyLACGb0SG4iYzA60PQbSQXbAZ0lUn/u+SokMZDFheBC+zXm9vmelvCBzcmhBMC9e4IuW14ZQH05ds64Ckp25fZUyhPjvYkTYKyNf3OzlvHiUawvU+foVtmXrRpZ7860qmK+DBbRaPKgfx4c2M2z252vsnYi/qlzhFVCu6vPNDJvjhv7DnyAHmvNuO/pB+2JO60cKaPRWia7UDAZeb1G6fPt6ZmqLahusX6nxN3Hv49Ir0tkSI7wBa21d0BbE7jHZ6GYaOwun3Uanb233qdsI4AYxsa8xNPT4L+hpRZaWknxloH6RVaiutZBoBiY6fFCRssCoh/UAfnEjEAiP2W7sheDKGxdfQPjNKYED5pVf2u+f4urX6K4tUVZQTAxNAH9G24iZmiNoq75TxQ3V9xJgjmDFZc/DM0ByXLFMEw/1ftXhtboRex7nYLapa3UhvqGrXiOAS9nWG4ZvsDKAPVqL/WwEzSNXODk9x0WrTxCjPE39RCg453jJW3E3vvmMtdzWK0jBmF9Kp52zuiSuRtDWPiMrX3WemVgFpb8nBFZfoXoHEP+NFnA0MiUOu0axEshcc3o4rhaKIhLd1OA+P1buia0BP1DI6uoPI1LNW6wH2yINVqb8XCGbYrLXR3PplsTBxk3c6ovn5/sE7eYJ9SYZMVpXh8JL+t7Yvm2hxaqg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(396003)(346002)(136003)(46966006)(36840700001)(8676002)(82740400003)(83380400001)(2906002)(356005)(186003)(6666004)(8936002)(5660300002)(36756003)(336012)(47076005)(26005)(82310400003)(478600001)(4326008)(107886003)(36906005)(316002)(42186006)(6916009)(70586007)(70206006)(54906003)(44832011)(2616005)(7636003)(426003)(1076003)(6266002)(36860700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2021 16:06:23.3585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7314606-0168-4eba-7f01-08d955cf797d
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT040.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4831
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Helper functions for char device node creation / removal for xrt
drivers. This is part of xrt driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
Reviewed-by: Tom Rix <trix@redhat.com>
---
 drivers/fpga/xrt/lib/cdev.c | 209 ++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/cdev.c

diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
new file mode 100644
index 000000000000..3c20adac8c03
--- /dev/null
+++ b/drivers/fpga/xrt/lib/cdev.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx Alveo FPGA device node helper functions.
+ *
+ * Copyright (C) 2020-2021 Xilinx, Inc.
+ *
+ * Authors:
+ *	Cheng Zhen <maxz@xilinx.com>
+ */
+
+#include "xleaf.h"
+#include "lib-drv.h"
+
+#define XRT_CDEV_DIR		"xrt"
+#define INODE2PDATA(inode)	\
+	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
+#define INODE2PDEV(inode)	\
+	to_xrt_dev(kobj_to_dev((inode)->i_cdev->kobj.parent))
+#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
+
+/* Allow it to be accessed from cdev. */
+static void xleaf_devnode_allowed(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+
+	/* Allow new opens. */
+	mutex_lock(&pdata->xsp_devnode_lock);
+	pdata->xsp_devnode_online = true;
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+/* Turn off access from cdev and wait for all existing user to go away. */
+static void xleaf_devnode_disallowed(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	/* Prevent new opens. */
+	pdata->xsp_devnode_online = false;
+	/* Wait for existing user to close. */
+	while (pdata->xsp_devnode_ref) {
+		mutex_unlock(&pdata->xsp_devnode_lock);
+		wait_for_completion(&pdata->xsp_devnode_comp);
+		mutex_lock(&pdata->xsp_devnode_lock);
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+static struct xrt_device *
+__xleaf_devnode_open(struct inode *inode, bool excl)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct xrt_device *xdev = INODE2PDEV(inode);
+	bool opened = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	if (pdata->xsp_devnode_online) {
+		if (excl && pdata->xsp_devnode_ref) {
+			xrt_err(xdev, "%s has already been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else if (!excl && pdata->xsp_devnode_excl) {
+			xrt_err(xdev, "%s has been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else {
+			pdata->xsp_devnode_ref++;
+			pdata->xsp_devnode_excl = excl;
+			opened = true;
+			xrt_info(xdev, "opened %s, ref=%d",
+				 CDEV_NAME(pdata->xsp_sysdev),
+				 pdata->xsp_devnode_ref);
+		}
+	} else {
+		xrt_err(xdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	xdev = opened ? xdev : NULL;
+	return xdev;
+}
+
+struct xrt_device *
+xleaf_devnode_open_excl(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, true);
+}
+
+struct xrt_device *
+xleaf_devnode_open(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, false);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_open);
+
+void xleaf_devnode_close(struct inode *inode)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct xrt_device *xdev = INODE2PDEV(inode);
+	bool notify = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	WARN_ON(pdata->xsp_devnode_ref == 0);
+	pdata->xsp_devnode_ref--;
+	if (pdata->xsp_devnode_ref == 0) {
+		pdata->xsp_devnode_excl = false;
+		notify = true;
+	}
+	if (notify)
+		xrt_info(xdev, "closed %s", CDEV_NAME(pdata->xsp_sysdev));
+	else
+		xrt_info(xdev, "closed %s, notifying waiter", CDEV_NAME(pdata->xsp_sysdev));
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	if (notify)
+		complete(&pdata->xsp_devnode_comp);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_close);
+
+static inline enum xrt_dev_file_mode
+devnode_mode(struct xrt_device *xdev)
+{
+	return DEV_FILE_OPS(xdev)->xsf_mode;
+}
+
+int xleaf_devnode_create(struct xrt_device *xdev, const char *file_name,
+			 const char *inst_name)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+	struct xrt_dev_file_ops *fops = DEV_FILE_OPS(xdev);
+	struct cdev *cdevp;
+	struct device *sysdev;
+	int ret = 0;
+	char fname[256];
+
+	mutex_init(&pdata->xsp_devnode_lock);
+	init_completion(&pdata->xsp_devnode_comp);
+
+	cdevp = &DEV_PDATA(xdev)->xsp_cdev;
+	cdev_init(cdevp, &fops->xsf_ops);
+	cdevp->owner = fops->xsf_ops.owner;
+	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), xdev->instance);
+
+	/*
+	 * Set xdev as parent of cdev so that when xdev (and its platform
+	 * data) will not be freed when cdev is not freed.
+	 */
+	cdev_set_parent(cdevp, &DEV(xdev)->kobj);
+
+	ret = cdev_add(cdevp, cdevp->dev, 1);
+	if (ret) {
+		xrt_err(xdev, "failed to add cdev: %d", ret);
+		goto failed;
+	}
+	if (!file_name)
+		file_name = xdev->name;
+	if (!inst_name) {
+		if (devnode_mode(xdev) == XRT_DEV_FILE_MULTI_INST) {
+			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
+				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
+				 file_name, xdev->instance);
+		} else {
+			snprintf(fname, sizeof(fname), "%s/%s/%s",
+				 XRT_CDEV_DIR, DEV_PDATA(xdev)->xsp_root_name,
+				 file_name);
+		}
+	} else {
+		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
+			 DEV_PDATA(xdev)->xsp_root_name, file_name, inst_name);
+	}
+	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
+	if (IS_ERR(sysdev)) {
+		ret = PTR_ERR(sysdev);
+		xrt_err(xdev, "failed to create device node: %d", ret);
+		goto failed_cdev_add;
+	}
+	pdata->xsp_sysdev = sysdev;
+
+	xleaf_devnode_allowed(xdev);
+
+	xrt_info(xdev, "created (%d, %d): /dev/%s",
+		 MAJOR(cdevp->dev), xdev->instance, fname);
+	return 0;
+
+failed_cdev_add:
+	cdev_del(cdevp);
+failed:
+	cdevp->owner = NULL;
+	return ret;
+}
+
+void xleaf_devnode_destroy(struct xrt_device *xdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(xdev);
+	struct cdev *cdevp = &pdata->xsp_cdev;
+	dev_t dev = cdevp->dev;
+
+	xleaf_devnode_disallowed(xdev);
+
+	xrt_info(xdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
+		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
+	device_destroy(xrt_class, cdevp->dev);
+	pdata->xsp_sysdev = NULL;
+	cdev_del(cdevp);
+}
-- 
2.27.0

