Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8A7E3CF04C
	for <lists+linux-fpga@lfdr.de>; Tue, 20 Jul 2021 01:54:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbhGSXMm (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Mon, 19 Jul 2021 19:12:42 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:58176
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1388238AbhGSUrL (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Mon, 19 Jul 2021 16:47:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAUoiqXqRThuy1qeFKNsIY+HoRGK/Cqg0Uiq69OOfg/n2fgRoC/qvgXd72gKJTLykZixYq3LXIoy+evoBzTvIJ4KSupe88WgRK9kOV7WQrCdS63fkWKCfOeOVOCpyGwDE0r6I54ob3znyr+juJ0LR9fcCKAyioQv22WV9y0k99fXZN/EdfsFZlmUZSzki2ObYHK2gfNVEfuxzG5QidNQMcQ5aodD9eHLnWCaENE0dP/X8I5uycnjXPG0kjxPn/N7B6kcHBVbJGNzFXSPRl3XhSisxfgGCpSnrXvwahVOjr2SQYYu5Y+apoOsYAlG4S2LB7KRApyF7Nogb3YhkQkJsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=AQgf9/jb74ONMxHEs+xP7wEO/YOS+VuTB9xzNvCwLqKWi/RjOuMaDU4o23BvbOPpHw4j62j4j50gj+V/OQy12O7H+374IAV9Xr2CxMS6NTZvfzRfWFEkAcTk4RdqgmVNLpMrccnwxbLvYzFVRqXPQDis6MRK11Up537OBDVAzPZk/5CFgb67g8urY0GHB+JvLM7S67jhfaoSDlrh6e8t9uzZc/GxpN7QPA2LtOladuvAYQn7nM90yRF7SWvN/DtUCSDng9Lgvno6H2Y2mCIbbBZTz/AeW9oEeWDpPTNPaR0bWxk24Ky/fUtGTFk4g3RCi24E3dflV0w2UaIBxiKOeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FJGnxQJe6FQRgxaRo8LXtiTIBNZmF318AW7uIhkSTbU=;
 b=h/i+burOVdhPs9kQfnx28NH67PklHUATRcL3fSGSZ16ilS/73yNtlcuHbgUYg6zob/c8PpJjVKcvlBNmSuW3IVdwLQNzgu/qmSm8wTtTVcaT6AwXA9MkZV+R8g4IxE81nna1EkaOck6JAhaqU9QPdNKVCyJ1QLoSJ5ko4Wd36oY=
Received: from DM5PR16CA0043.namprd16.prod.outlook.com (2603:10b6:4:15::29) by
 DM5PR02MB3260.namprd02.prod.outlook.com (2603:10b6:4:6c::38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4331.31; Mon, 19 Jul 2021 21:27:45 +0000
Received: from DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
 (2603:10b6:4:15:cafe::19) by DM5PR16CA0043.outlook.office365.com
 (2603:10b6:4:15::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21 via Frontend
 Transport; Mon, 19 Jul 2021 21:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT056.mail.protection.outlook.com (10.13.4.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4331.21 via Frontend Transport; Mon, 19 Jul 2021 21:27:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 19 Jul 2021 14:27:44 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Mon, 19 Jul 2021 14:27:44 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.73.109] (port=38276 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1m5ang-000FAq-69; Mon, 19 Jul 2021 14:27:44 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id BE7056020BD; Mon, 19 Jul 2021 14:26:31 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V8 XRT Alveo 06/14] fpga: xrt: char dev node helper functions
Date:   Mon, 19 Jul 2021 14:26:20 -0700
Message-ID: <20210719212628.134129-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210719212628.134129-1-lizhi.hou@xilinx.com>
References: <20210719212628.134129-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7916b9fe-bd77-461c-5cfe-08d94afc0c75
X-MS-TrafficTypeDiagnostic: DM5PR02MB3260:
X-Microsoft-Antispam-PRVS: <DM5PR02MB3260233BE21CF434A812FB31A1E19@DM5PR02MB3260.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wWYcJ+zwyZha9uRLgfZa4a7LokSuSAZ7hh7mHBDM/+9PD99FHH0+T120IUtw2I8YFXC3RuTyFzkRZWf0HdPz2qA5znUzzTbNZibihqsJPVsSv+SaYfwUzQKj8X2WH9UzUYaYRqL3ZbnZon+zk1j/aGWs2Zf3tbxIfxgNxyjVahaDD6PdnPeUl2sOcOK4NVdja1k3tBOuz0JQgtBxrHVLSyfM8g6ex6KeZhbjTqVUJOegSNrz+ogn/JhQnCCugpXVnnOmivniJv7VKbp0IeLHqlVzvY8r0nLXg3UqaAwfRTJsFMvpvJfHxDlrQN/PNDD70wWCoF3dJPHgpJQF2fZOWCW01kxjx/TsKG/OQ9puyxItlviwZrCmhC+8seq9UuGh3pTLfcScOHTybdv89WlX5PBZvEa2NzzWFKe/S9lx/c2p8DtQXulNOOweQ71P04kCRZbYDVsnhQjFu+fXnRpJaULh+Yxo7jbwxaLf+Zq8Izk6LgzLWC3mo/Sba9euyovCBIJ2HadxMuMgNpMp1LxXLENO9n/fTm/EBgAYrt29icLGJtRgRO+hXan0hgDZlkMZL1zj8QfvswZzHlwpVAAJGDZtUkkokBPCLUNROB7FvFmDj4SxG2xv0KZuhn701k7XwZpuieJSjLzCooIHYvRtYLkW3efRykZZ3MkLlpxfQlOcToLq11Q9FkvXKT0U25ctu9RA4EwMHOGUXH9O3igrEg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(26005)(82310400003)(47076005)(8936002)(36756003)(83380400001)(5660300002)(2616005)(508600001)(2906002)(6666004)(44832011)(70586007)(316002)(7636003)(70206006)(8676002)(186003)(54906003)(356005)(426003)(1076003)(36860700001)(4326008)(42186006)(36906005)(107886003)(6266002)(6916009)(336012);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2021 21:27:44.9958
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7916b9fe-bd77-461c-5cfe-08d94afc0c75
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT056.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR02MB3260
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

