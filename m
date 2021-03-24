Return-Path: <linux-fpga-owner@vger.kernel.org>
X-Original-To: lists+linux-fpga@lfdr.de
Delivered-To: lists+linux-fpga@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A80F3470FB
	for <lists+linux-fpga@lfdr.de>; Wed, 24 Mar 2021 06:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235322AbhCXFeZ (ORCPT <rfc822;lists+linux-fpga@lfdr.de>);
        Wed, 24 Mar 2021 01:34:25 -0400
Received: from mail-bn8nam11on2054.outbound.protection.outlook.com ([40.107.236.54]:59104
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S235293AbhCXFdy (ORCPT <rfc822;linux-fpga@vger.kernel.org>);
        Wed, 24 Mar 2021 01:33:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e/gdB46G7wZ8DRh9TPcMP8yDlmDc+JUMok1jg/NYEUgHtvgTPECfvqsB9LScrC+is2ChwpRdwuW7WboFGHY5If4+lNJ7EO9B+jKkpcGrRKBO4MqiQ/f6bTa7L04G7w5vCuJzrn+nQJcnqtmYDuLv8E2fHu2rcq0k9ZBre3bzpS6GzAhRtbBp0tKum5L0l/7vzLierv2D4LDGkZTzLUZahxxasH5iGFeBXidW2ACM9AhLue+ok6K3LT11GhpI9sW78tN8doedDeluqUDhg5W95zZ24+w3obxZCf5srFVtsDZjpHR8ihpZxLRqcqYK7PmiCDtX6RQF0C8nU8nLts6NWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFXc46KOFg28RMmAOwlf+WAT802d6nzu43fRCR7rwcs=;
 b=hVrtsAqBg/CJAkgwbrryYnUHIrtW8Ga0lqYKuJ2QRkaNxrjQQcLWEwpiSvCJvq+tVvyFoBn6hGcF/XT/lXlCrAw3QhHnXi7SeX3xRFC28JEzx8bBpII/UEbLG2T2FM7Zhm9I/ZKiQdL7mUNOdEFCmB2xYuCjKqBeFaAMfQ0WjIocDXBCPZtq8hyP83YAi4hnvdTx27C5UZ1r+rQ21AXkXfuNTaVPaHGSMiKyPFhxuw+m8NMMm9y3+4Yv1K1gGKVPxzhUjtOBRNt7x7ODZSfi5f0lzJO92eT/OTETbGfjN7rRnJD4WUpxDAKbe3c6nZoYQ/x3Lq9XMgibTxx8sZP8Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZFXc46KOFg28RMmAOwlf+WAT802d6nzu43fRCR7rwcs=;
 b=QcO9VVBLFcTX1aBIMyD+x96g5k/l1wW0ai8IkPJH3jFNZWvLauAmh5P9gCdeCSzrGux5DNwD9//MPW/fjBEpxtR2/jMqSOVK3fB5/czEYYI5yklMxq6VBp0ptyjFRNO66EhS1vhf4ydVgFTKzYV2R0N8eyh6ziQB1kKpaTdBFQQ=
Received: from SN6PR16CA0056.namprd16.prod.outlook.com (2603:10b6:805:ca::33)
 by CY4PR02MB3253.namprd02.prod.outlook.com (2603:10b6:910:80::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3955.18; Wed, 24 Mar
 2021 05:33:51 +0000
Received: from SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
 (2603:10b6:805:ca:cafe::c) by SN6PR16CA0056.outlook.office365.com
 (2603:10b6:805:ca::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24 via Frontend
 Transport; Wed, 24 Mar 2021 05:33:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT025.mail.protection.outlook.com (10.152.72.87) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3977.25 via Frontend Transport; Wed, 24 Mar 2021 05:33:50 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 23 Mar 2021 22:33:34 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2106.2 via Frontend Transport; Tue, 23 Mar 2021 22:33:34 -0700
Envelope-to: mdf@kernel.org,
 robh@kernel.org,
 trix@redhat.com,
 devicetree@vger.kernel.org,
 linux-fpga@vger.kernel.org,
 linux-kernel@vger.kernel.org
Received: from [172.19.72.212] (port=51032 helo=xsj-xw9400.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <lizhi.hou@xilinx.com>)
        id 1lOw98-0005ts-3w; Tue, 23 Mar 2021 22:33:34 -0700
Received: by xsj-xw9400.xilinx.com (Postfix, from userid 21952)
        id 1391C600124; Tue, 23 Mar 2021 22:29:56 -0700 (PDT)
From:   Lizhi Hou <lizhi.hou@xilinx.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Lizhi Hou <lizhi.hou@xilinx.com>, <linux-fpga@vger.kernel.org>,
        <maxz@xilinx.com>, <sonal.santan@xilinx.com>, <yliu@xilinx.com>,
        <michal.simek@xilinx.com>, <stefanos@xilinx.com>,
        <devicetree@vger.kernel.org>, <trix@redhat.com>, <mdf@kernel.org>,
        <robh@kernel.org>, Max Zhen <max.zhen@xilinx.com>
Subject: [PATCH V4 XRT Alveo 06/20] fpga: xrt: char dev node helper functions
Date:   Tue, 23 Mar 2021 22:29:33 -0700
Message-ID: <20210324052947.27889-7-lizhi.hou@xilinx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210324052947.27889-1-lizhi.hou@xilinx.com>
References: <20210324052947.27889-1-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a29ab9d6-6d06-45c9-0237-08d8ee866788
X-MS-TrafficTypeDiagnostic: CY4PR02MB3253:
X-Microsoft-Antispam-PRVS: <CY4PR02MB3253BBC8954AC2E26B074971A1639@CY4PR02MB3253.namprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:67;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n6G0E/8jGs9wGT15oRDlrDcM1dlCB3PsVVyaYypIur1QN61GSijO0vyEkQb42gOT3Edzy3yBD0YObsqXzrmiBHIxANa+fsivT+7P47DsMf/pLBTmOkNYAtann4rfZHRU7WBtmnnkvP8Mz4QNCUROnG+F7TQkD5SBs/pL469mknAQdo32zrNSrz0fyiSrnEJ7Zu9vPFot+gFOV2o8tZBeT5ZnJYBG/mk6bmebLjuM5Pqqgwr1zK1p5PKMXQJfE5Bgb6ZDEZJyLw4HzstLMR8A8dudOOEe3O6u5qlCBcFG+/Gv32kB2Z0ShGt8/Ak9+2yHa4xpG8pPJIEnNb5LkT85K6g46kQ3I8oW2qdiKstE0FWnORCgJSDOiWsWVaqwTOlDfwSfgKp9AWa6X+bDyEfM9bBx5ogpHug8LHOvp0AentZ/6fnxOshZT09m/wAC3mjv9r0xmrzs0rcG++hP9PySiogTwXb+XPmZHQcwf4GjbeDlbb+AgpVtynZKHQOxVlNF/c2qhCPi5cGFOzDZ1npmU/y8eF8jJkDQGJFC8YVclZEsQ4c5y8zyip2eFhmLzwFb9/WhXycIlPDFl5TSLQFoMq1jfCTJ3mXRSd+I9/uZ7DARER9I0Vl/kyPXUpYXTablgzSkWw6Atelu16JaDyVvv7IR0Tk+uZAg4THX6TSP4d4=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(4636009)(396003)(136003)(346002)(376002)(39860400002)(46966006)(36840700001)(70586007)(70206006)(44832011)(478600001)(36860700001)(8676002)(6916009)(47076005)(356005)(42186006)(186003)(54906003)(336012)(4326008)(1076003)(426003)(83380400001)(36756003)(2616005)(82310400003)(6666004)(82740400003)(36906005)(26005)(8936002)(5660300002)(316002)(107886003)(6266002)(2906002)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2021 05:33:50.2120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a29ab9d6-6d06-45c9-0237-08d8ee866788
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT025.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3253
Precedence: bulk
List-ID: <linux-fpga.vger.kernel.org>
X-Mailing-List: linux-fpga@vger.kernel.org

Helper functions for char device node creation / removal for platform
drivers. This is part of platform driver infrastructure.

Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
Signed-off-by: Max Zhen <max.zhen@xilinx.com>
Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
---
 drivers/fpga/xrt/lib/cdev.c | 232 ++++++++++++++++++++++++++++++++++++
 1 file changed, 232 insertions(+)
 create mode 100644 drivers/fpga/xrt/lib/cdev.c

diff --git a/drivers/fpga/xrt/lib/cdev.c b/drivers/fpga/xrt/lib/cdev.c
new file mode 100644
index 000000000000..38efd24b6e10
--- /dev/null
+++ b/drivers/fpga/xrt/lib/cdev.c
@@ -0,0 +1,232 @@
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
+#define XRT_CDEV_DIR		"xfpga"
+#define INODE2PDATA(inode)	\
+	container_of((inode)->i_cdev, struct xrt_subdev_platdata, xsp_cdev)
+#define INODE2PDEV(inode)	\
+	to_platform_device(kobj_to_dev((inode)->i_cdev->kobj.parent))
+#define CDEV_NAME(sysdev)	(strchr((sysdev)->kobj.name, '!') + 1)
+
+/* Allow it to be accessed from cdev. */
+static void xleaf_devnode_allowed(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	/* Allow new opens. */
+	mutex_lock(&pdata->xsp_devnode_lock);
+	pdata->xsp_devnode_online = true;
+	mutex_unlock(&pdata->xsp_devnode_lock);
+}
+
+/* Turn off access from cdev and wait for all existing user to go away. */
+static int xleaf_devnode_disallowed(struct platform_device *pdev)
+{
+	int ret = 0;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	/* Prevent new opens. */
+	pdata->xsp_devnode_online = false;
+	/* Wait for existing user to close. */
+	while (!ret && pdata->xsp_devnode_ref) {
+		int rc;
+
+		mutex_unlock(&pdata->xsp_devnode_lock);
+		rc = wait_for_completion_killable(&pdata->xsp_devnode_comp);
+		mutex_lock(&pdata->xsp_devnode_lock);
+
+		if (rc == -ERESTARTSYS) {
+			/* Restore online state. */
+			pdata->xsp_devnode_online = true;
+			xrt_err(pdev, "%s is in use, ref=%d",
+				CDEV_NAME(pdata->xsp_sysdev),
+				pdata->xsp_devnode_ref);
+			ret = -EBUSY;
+		}
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	return ret;
+}
+
+static struct platform_device *
+__xleaf_devnode_open(struct inode *inode, bool excl)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
+	bool opened = false;
+
+	mutex_lock(&pdata->xsp_devnode_lock);
+
+	if (pdata->xsp_devnode_online) {
+		if (excl && pdata->xsp_devnode_ref) {
+			xrt_err(pdev, "%s has already been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else if (!excl && pdata->xsp_devnode_excl) {
+			xrt_err(pdev, "%s has been opened exclusively",
+				CDEV_NAME(pdata->xsp_sysdev));
+		} else {
+			pdata->xsp_devnode_ref++;
+			pdata->xsp_devnode_excl = excl;
+			opened = true;
+			xrt_info(pdev, "opened %s, ref=%d",
+				 CDEV_NAME(pdata->xsp_sysdev),
+				 pdata->xsp_devnode_ref);
+		}
+	} else {
+		xrt_err(pdev, "%s is offline", CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	pdev = opened ? pdev : NULL;
+	return pdev;
+}
+
+struct platform_device *
+xleaf_devnode_open_excl(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, true);
+}
+
+struct platform_device *
+xleaf_devnode_open(struct inode *inode)
+{
+	return __xleaf_devnode_open(inode, false);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_open);
+
+void xleaf_devnode_close(struct inode *inode)
+{
+	struct xrt_subdev_platdata *pdata = INODE2PDATA(inode);
+	struct platform_device *pdev = INODE2PDEV(inode);
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
+	if (notify) {
+		xrt_info(pdev, "closed %s, ref=%d",
+			 CDEV_NAME(pdata->xsp_sysdev), pdata->xsp_devnode_ref);
+	} else {
+		xrt_info(pdev, "closed %s, notifying waiter",
+			 CDEV_NAME(pdata->xsp_sysdev));
+	}
+
+	mutex_unlock(&pdata->xsp_devnode_lock);
+
+	if (notify)
+		complete(&pdata->xsp_devnode_comp);
+}
+EXPORT_SYMBOL_GPL(xleaf_devnode_close);
+
+static inline enum xrt_subdev_file_mode
+devnode_mode(struct xrt_subdev_drvdata *drvdata)
+{
+	return drvdata->xsd_file_ops.xsf_mode;
+}
+
+int xleaf_devnode_create(struct platform_device *pdev, const char *file_name,
+			 const char *inst_name)
+{
+	struct xrt_subdev_drvdata *drvdata = DEV_DRVDATA(pdev);
+	struct xrt_subdev_file_ops *fops = &drvdata->xsd_file_ops;
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp;
+	struct device *sysdev;
+	int ret = 0;
+	char fname[256];
+
+	mutex_init(&pdata->xsp_devnode_lock);
+	init_completion(&pdata->xsp_devnode_comp);
+
+	cdevp = &DEV_PDATA(pdev)->xsp_cdev;
+	cdev_init(cdevp, &fops->xsf_ops);
+	cdevp->owner = fops->xsf_ops.owner;
+	cdevp->dev = MKDEV(MAJOR(fops->xsf_dev_t), pdev->id);
+
+	/*
+	 * Set pdev as parent of cdev so that when pdev (and its platform
+	 * data) will not be freed when cdev is not freed.
+	 */
+	cdev_set_parent(cdevp, &DEV(pdev)->kobj);
+
+	ret = cdev_add(cdevp, cdevp->dev, 1);
+	if (ret) {
+		xrt_err(pdev, "failed to add cdev: %d", ret);
+		goto failed;
+	}
+	if (!file_name)
+		file_name = pdev->name;
+	if (!inst_name) {
+		if (devnode_mode(drvdata) == XRT_SUBDEV_FILE_MULTI_INST) {
+			snprintf(fname, sizeof(fname), "%s/%s/%s.%u",
+				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				 file_name, pdev->id);
+		} else {
+			snprintf(fname, sizeof(fname), "%s/%s/%s",
+				 XRT_CDEV_DIR, DEV_PDATA(pdev)->xsp_root_name,
+				 file_name);
+		}
+	} else {
+		snprintf(fname, sizeof(fname), "%s/%s/%s.%s", XRT_CDEV_DIR,
+			 DEV_PDATA(pdev)->xsp_root_name, file_name, inst_name);
+	}
+	sysdev = device_create(xrt_class, NULL, cdevp->dev, NULL, "%s", fname);
+	if (IS_ERR(sysdev)) {
+		ret = PTR_ERR(sysdev);
+		xrt_err(pdev, "failed to create device node: %d", ret);
+		goto failed_cdev_add;
+	}
+	pdata->xsp_sysdev = sysdev;
+
+	xleaf_devnode_allowed(pdev);
+
+	xrt_info(pdev, "created (%d, %d): /dev/%s",
+		 MAJOR(cdevp->dev), pdev->id, fname);
+	return 0;
+
+failed_cdev_add:
+	cdev_del(cdevp);
+failed:
+	cdevp->owner = NULL;
+	return ret;
+}
+
+int xleaf_devnode_destroy(struct platform_device *pdev)
+{
+	struct xrt_subdev_platdata *pdata = DEV_PDATA(pdev);
+	struct cdev *cdevp = &pdata->xsp_cdev;
+	dev_t dev = cdevp->dev;
+	int rc;
+
+	rc = xleaf_devnode_disallowed(pdev);
+	if (rc)
+		return rc;
+
+	xrt_info(pdev, "removed (%d, %d): /dev/%s/%s", MAJOR(dev), MINOR(dev),
+		 XRT_CDEV_DIR, CDEV_NAME(pdata->xsp_sysdev));
+	device_destroy(xrt_class, cdevp->dev);
+	pdata->xsp_sysdev = NULL;
+	cdev_del(cdevp);
+	return 0;
+}
-- 
2.27.0

