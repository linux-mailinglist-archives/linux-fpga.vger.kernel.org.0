Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90636CD6E
	for <lists+linux-fpga@lfdr.de>; Tue, 27 Apr 2021 22:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237009AbhD0VAH (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Tue, 27 Apr 2021 17:00:07 -0400
Received: from mail-dm6nam12on2069.outbound.protection.outlook.com ([40.107.243.69]:26593
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S239018AbhD0VAH (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Tue, 27 Apr 2021 17:00:07 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3H6xjikmg2kzTApH7TNVU3nbVxCDTJj1lSYvJT1PrtIOD9tWFRa5kA4hapYSY/QQi6MMfGmY83iRN8aHAlYnNZqzTKNZQafVqNErVoNrb7rYH6N02gdEMdRHAMUPJa5t9rgds7F8OMPBKZzXzF9H6rvmpbRdjGXsxEAqNkRFM8hsJ+aCM+qDDtE44cic49aFQ2wQTLhOBfhABZxrNFsRdymL2KmGYhwqN4mcpxcJQGIfz1nP3phjMOfFP8w0nxTjLVqq9Hn54d7HUPH+2G+Lj4cUKWIdz78JJN+PL6v3IdwWyKUoGV0p4E51mi8E+DCpOtpZ30YbSPcq4l8YLxGIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nTKQK5pYF6++ahqMt59go2dkLZizpLEbx9z7za1gjA=;
 b=aeOqomWnc3LZduvC+mGqLP0jZIsXUdX1e++7Z/3CjRHyUt3iuzvB317hDw1c8Ws7sQay8n+ac069EXggQFHXYC0K97A5T9VswVQ/wpeGUtVZVY6VL5TVMNDYBMzjcwDBmaL9o+dAROMMfIZqJq2Ed2TC/X5kcjEyqy1iEcX2RU6wNuhVfM/2lPrylxyCcLlrJMZNgWtDKD32Q0M47coq+k1tTalJEUUcKSkwI3fknXYeXfnKOM1Qw6vvYuu362dZ4DyS0xAFVkWymAOVG2it2D98eTG6ozsDvelPPfXeiscxqP/Zfh5/0UsADrBqy4dAJiurRN66aZzsjTeLjzcP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nTKQK5pYF6++ahqMt59go2dkLZizpLEbx9z7za1gjA=;
 b=d+LEOGVOgtGEGCaPSXf32ndUgcjQsSj6Y0ulhizcc8cTEONC/P7H4jvRpWLYX+xHuzIpRWmF1K/OrAPXvKZXBzMIm04rMP6ly/glLtzbc6CAYeFROS43WQro5NepO5S6yXoV5/nKzHj1z52IMcCk9nCXkt2s8SwMIycKFAKHSsY=
Received: from BL0PR02CA0035.namprd02.prod.outlook.com (2603:10b6:207:3c::48)
 by CO6PR02MB7779.namprd02.prod.outlook.com (2603:10b6:303:a0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Tue, 27 Apr
 2021 20:59:21 +0000
Received: from BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
 (2603:10b6:207:3c:cafe::c) by BL0PR02CA0035.outlook.office365.com
 (2603:10b6:207:3c::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22 via Frontend
 Transport; Tue, 27 Apr 2021 20:59:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 BL2NAM02FT017.mail.protection.outlook.com (10.152.77.174) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4065.21 via Frontend Transport; Tue, 27 Apr 2021 20:59:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 27 Apr 2021 13:59:02 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 27 Apr 2021 13:59:02 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=52006 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lbUnN-00086H-SE; Tue, 27 Apr 2021 13:59:01 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 77EDA600128; Tue, 27 Apr 2021 13:54:35 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V5 XRT Alveo 06/20] fpga: xrt: char dev node helper functions
Date:   Tue, 27 Apr 2021 13:54:17 -0700
Message-ID: <20210427205431.23896-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210427205431.23896-1-lizhi.hou@xilinx.com>
References: <20210427205431.23896-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4245d14c-b11d-4020-248b-08d909bf547e
X-MS-TrafficTypeDiagnostic: CO6PR02MB7779:
X-Microsoft-Antispam-PRVS: <CO6PR02MB77797B9FCB391562153FD031A1419@CO6PR02MB7779.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MvSXM7yrK81kxQxxgv4oeFOEATv9TpRr1K2U0CbAbGy0s4mtbiaEPVK9MPg2Ia9to3P5dLIZrZYiCUxa9WPElEyHoq8AQd9qsN3yTU2pVnJe/Z/64pbFh6gVkMexYV7I0/xtJB9QPmcZhsbQFh1WaC0KQfDgyqjH4jfhtkba0kNanLCln3Wzf4LfTC3QuCDrbu/9FCaIxUp0FRwXmeNCyv/Buii/H+vEh3Tj1IkvAtPGtlB/VkuqSnkX73kLTwvMBsHWLtdbIp7yGedfWwb8hgkFcthjJ9tQTPVfY7AyL1iDJIusZ7WB7ESuu2VCDC3budXoEzfnoWm+QzpjnQytO7DLyImVKb8izHHG0B7DbAOzJtVy8wOhQW5RhbFugv6S85pHwRjXENlE3VvaZ6HoYbxcSapT8fmo2VNnlaguu0GeY3N1w/W/LEhhZbAgTyIXLcqawoPgUr67AxAHLiUUqOl4GYmzYFiQpq1SBRRYbHutrVlddKV7W+QbyIwP1Sp81wfNxgHsQyRATVWZQDpfm2xwO9LyjIlSBLecUU4h2dGVUfEllAQ6QAFefnTXBlRo1zBNDF3h2p0CFmf3dWGWdNbIvYlnQRLkYf8/ah7HBt/aEt2s33J86uxnthNdyGX6m1b7wBk1fuO/dpzMLqmGo3P7jZFvUNyZDJ7K0N7S6Tk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(136003)(396003)(36840700001)(46966006)(7636003)(107886003)(26005)(426003)(82310400003)(6266002)(2616005)(42186006)(316002)(36906005)(1076003)(356005)(70206006)(70586007)(44832011)(83380400001)(8936002)(5660300002)(36860700001)(6666004)(336012)(8676002)(6916009)(186003)(478600001)(4326008)(82740400003)(47076005)(54906003)(36756003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2021 20:59:20.9133
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4245d14c-b11d-4020-248b-08d909bf547e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2NAM02FT017.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR02MB7779
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Helper functions for char device node creation / removal for xrt
drivers. This is part of xrt driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/cdev.c | 210 ++++++++++++++++++++++++++++++++++++
 1 file changed, 210 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/cdev.c

diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
new file mode 100644
index 000000000000..4edd2c1d459b
--- /dev/null
+++ b/drivers/fpga/xrt/lib/cdev.c
@@ -0,0 +1,210 @@
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
+
+extern struct class *xrt_class;
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

