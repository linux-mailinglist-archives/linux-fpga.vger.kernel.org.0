Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97C2A393A86
	for <lists+linux-fpga@lfdr.de>; Fri, 28 May 2021 02:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbhE1Aw5 (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Thu, 27 May 2021 20:52:57 -0400
Received: from mail-bn8nam12on2046.outbound.protection.outlook.com ([40.107.237.46]:43489
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229761AbhE1Aw4 (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Thu, 27 May 2021 20:52:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gz135K9ChrOZHrMQv+d9VG4tf2O5flLZOW4M2b7lJuY32EygSDhpvrKn5xEFhzclQuK01PXUhW1d8WTgOA+pSYObpQozW+TsZXOuoXCLf6TPI3nf2b8cHQba6OcU3x6PVQwd4hdpBuSBD6XF+T1aQrt3SvzROxrUErHNtJR+B4FuOH0R8L+VQhVA+mWpJLYPKShryebJgopNa9cBHD/7HzV4N4aMMMaV7MhODNXgFKRxxRn5smMcf+IHdNDk2Lc7WUpLgtODqlpRZBhjANhkB3iK+m+9PdwrAy+ZvNtPCkP5Bd7Aek6UxvwT/5vNE/WXepBqloA4GtJak8mIdIB77w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=KFNKHgXvMycTp+8VMW0X/y10mFqu3vaLJ93jsuIadszhNFm+KwFVF7zMZRGYirVOoHV2ICZsIbrEK6N3C/crXHyTa9YLlWUt5Bjhq7yf0DUiePaciQ6g3N9V11fXGcL8cf4N2/YpjKWEU1OR9kamsZVtQcftfRnLEUn6ah+ec8MveEGmHqdoQa2HZ1NRDuTziNzTKw3RTH9FnaZ7xlAA7VQtQgHehlo0SlJFOQ6y6K76L+hCyOaEylzZL+IEbOuMyEGpWt6RztzSQ37moepXuH5JRdWd5ZvkFY5UnA9xBVktHhEZRak32U/5q71eY9/KjxWZKO/Jn0yKrswez7P1vA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=YOmklkY/mgGOMTARglGW/SRRAw5Q21f1tckgU9klKjp3XwBVrBipF1lpOmjmvNDth3776ByD2nkYsZgZyT4QnJ3KxVTomhnpK7rPTWcOEkndAlQUYUOWDwq4awUhCekcmFTUGAoLSNF+z9IJHWRfkvufLhC4X8F57zckKvlG1Vg=
Received: from SA9PR13CA0179.namprd13.prod.outlook.com (2603:10b6:806:28::34)
 by CY4PR02MB2838.namprd02.prod.outlook.com (2603:10b6:903:122::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 28 May
 2021 00:51:20 +0000
Received: from SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:28:cafe::8e) by SA9PR13CA0179.outlook.office365.com
 (2603:10b6:806:28::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4195.10 via Frontend
 Transport; Fri, 28 May 2021 00:51:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0018.mail.protection.outlook.com (10.97.5.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4150.30 via Frontend Transport; Fri, 28 May 2021 00:51:20 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 27 May 2021 17:51:19 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 27 May 2021 17:51:19 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=34016 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lmQid-0007Dx-ON; Thu, 27 May 2021 17:51:19 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 5CAAE6032A8; Thu, 27 May 2021 17:50:06 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V7 XRT Alveo 06/20] fpga: xrt: char dev node helper functions
Date:   Thu, 27 May 2021 17:49:45 -0700
Message-ID: <20210528004959.61354-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210528004959.61354-1-lizhi.hou@xilinx.com>
References: <20210528004959.61354-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d61bb899-59cf-4205-e562-08d92172b572
X-MS-TrafficTypeDiagnostic: CY4PR02MB2838:
X-Microsoft-Antispam-PRVS: <CY4PR02MB28385483849AD29ACFD3902EA1229@CY4PR02MB2838.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s68nETWtjkqQ+hAIslsInrDnAae4WLvYhD6gRa5JD9XCDlEUDdOIBOHSpEBP9o9ZOHSO5tiwNsc1rU0tYOsMGXHX2MjX7djFgKCz+thDMzwo5JZujwA1/8Aa/C82AlZ0e/sQu/f6Eq1Mg27vyJfwUdEpFvhc1gyZ2yKFSiA5ok2+8HLbGU915W884dwEZvRMS9oSkfIoWdbGEChPz2cTxOxA8cGNeAQKCz/GUdiIG5qJfIo8uMwL/TpKTvwK4jTUG4YCMU6auCPbdcpbF4aDyoEicsenJ7L8VqlST85GxKkOe5IXl6lUZO8qvly+5QzQaVY8TbQVVl+IJcPby8fdob/zSEtr7VchL/wp2LvD+SwsbOs4WHJ3yy12JQ5SseUzgF/IMN7q3AHCVFOftGU7nOnl+lL4ffgQUY7Z9dt1zjsbwEcSuVS2GRQ65M7tgklqEfFOlaIhSppHOJISVsbACT9bwkVq/DV642fNzWmmaIT/+vS7bfNf51pw2myWi8ytYlNdOkhO+Kf0HO1kuocpzMA38NmeOTEjWlsvlE4Cj8TO9VDcVEDIBs7ZBHbRt26BXor8anahwmy8Wa3Bv9lJ3jxqi2wye40Ptw8IZjHbOGY4IITnEDAFShqK0IMfue90jUg44vueb4o+MK9E8T2YDbJ8k0vjnvG/tGKXhgMQROk=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(39840400004)(376002)(346002)(396003)(136003)(46966006)(36840700001)(6266002)(1076003)(42186006)(316002)(107886003)(26005)(478600001)(7636003)(36860700001)(5660300002)(47076005)(2906002)(83380400001)(356005)(8676002)(54906003)(8936002)(336012)(6916009)(70586007)(426003)(44832011)(2616005)(36756003)(4326008)(6666004)(82310400003)(186003)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2021 00:51:20.3040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d61bb899-59cf-4205-e562-08d92172b572
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0018.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2838
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

